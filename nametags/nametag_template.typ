// nametag_template.typ

// カラー定義
#let role-colors = (
  "Staff": rgb("#e74754"),
  "Speaker": rgb("#1D2088"),
  "Attendee": rgb("#444444"),
)

// イベント全体のテーマカラー
#let event-brand-color = rgb("#48b8b8")

#let tag-box(content) = box(
  fill: rgb("#f3f3f3"),
  radius: 4pt,
  inset: (x: 8pt, y: 4pt),
  outset: (y: 0pt),
  text(size: 9pt, fill: rgb("#333333"))[#content],
)

#let create-nametag(name: "", affiliation: "", role: "Attendee", sns: none, interests: none) = {
  let role-color = role-colors.at(role, default: black)
  let name-size = 24pt

  page(
    paper: "a6",
    margin: (x: 1.5cm, y: 1.5cm),

    // 背景設定
    background: rect(
      width: 100%,
      height: 100%,
      fill: event-brand-color,
    )[
      // 内側の白いボックス
      #align(center + horizon)[
        #rect(
          width: 100% - 1cm,
          height: 100% - 1cm,
          fill: white,
          radius: 8pt,
          stroke: none,
        )
      ]
    ],
  )[
    #set text(
      font: ("Roboto", "Noto Sans JP"),
      lang: "ja",
    )
    #set align(center)

    // 役割(スタッフ等)
    #block(
      fill: role-color,
      inset: (y: 8pt),
      width: 100%,
      radius: 4pt,
      [#text(fill: white, weight: "bold", size: 14pt, spacing: 2pt)[#upper(role)]],
    )

    #v(0.5fr)

    // 氏名とSNSのハンドルネーム
    #block([
      #text(size: name-size, weight: "black")[#name]

      #if sns != none and sns != "" {
        v(0.3em)
        text(
          size: 11pt,
          weight: "regular",
          fill: gray.darken(20%),
          font: "Roboto Mono",
        )[
          #if sns.starts-with("@") { sns } else { "@" + sns }
        ]
      }
    ])

    #v(2em)

    // 所属
    #text(size: 11pt, fill: gray.darken(30%))[#affiliation]

    #v(1.5fr)

    // 興味タグ
    #if interests != none and interests != "" {
      let tags = interests.split(",").map(s => s.trim())

      align(center)[
        #text(size: 8pt, weight: "bold", fill: gray.darken(10%))[Interested in]
        #v(5pt)
        #block(width: 100%)[
          #for tag in tags {
            tag-box(tag)
            h(4pt)
            v(4pt, weak: true)
          }
        ]
      ]
    }

    #v(1fr)

    // ロゴとイベント名
    #align(bottom)[
      #stack(
        dir: ltr,
        spacing: 1em,
        image("assets/logo.png", height: 1.0cm, fit: "contain"),
        align(horizon)[#text(size: 9pt, fill: gray.darken(20%))[Tech Conference 2025]],
      )
    ]
  ]
}

// プレビュー用
#create-nametag(
  name: "山田 太郎",
  affiliation: "株式会社Typst",
  role: "Speaker",
  sns: "taroyamada",
  interests: "Rust, WebAssembly, Coffee, Photography, Cats",
)
