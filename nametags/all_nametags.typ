// all_nametags.typ

// テンプレートの読み込み
#import "nametag_template.typ": create-nametag

// CSVファイルのパス
#let csv-path = "participants.csv"

// CSVの読み込み
#let csv-data = csv(csv-path)

// ヘッダーを削除しデータ部分だけ抽出
#let participants = csv-data.slice(1)


// ループ処理で全員分のページを出力
#for row in participants {
  // CSVのカラム順序: Name, Affiliation, Role, SNS, Interests
  let name = row.at(0, default: "")
  let affiliation = row.at(1, default: "")
  let role = row.at(2, default: "Attendee")
  let sns = row.at(3, default: none)
  let interests = row.at(4, default: none)

  // テンプレート関数を呼び出し
  create-nametag(
    name: name,
    affiliation: affiliation,
    role: role,
    sns: sns,
    interests: interests
  )

}
