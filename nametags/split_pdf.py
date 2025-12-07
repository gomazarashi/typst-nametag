# split_pdf.py
import csv
import os
from pathlib import Path
from pypdf import PdfReader, PdfWriter

# パス設定
CSV_FILE = "participants.csv"
INPUT_PDF = "output/all_nametags.pdf"
OUTPUT_DIR = "output/single_nametags"

def main():
    # 出力先ディレクトリが存在しない場合は作成
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    # CSVから参加者名リストを取得
    participants = []
    try:
        with open(CSV_FILE, encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                # CSVのヘッダー名 "Name" に合わせて取得
                participants.append(row["Name"])
    except FileNotFoundError:
        print(f"Error: {CSV_FILE} not found.")
        return

    # PDFファイルを読み込む
    try:
        reader = PdfReader(INPUT_PDF)
    except FileNotFoundError:
        print(f"Error: {INPUT_PDF} not found. Run typst compile first.")
        return

    # ページ数と参加者数の整合性チェック
    if len(reader.pages) != len(participants):
        print(f"Error: Page count ({len(reader.pages)}) does not match participant count ({len(participants)}).")
        return

    print(f"Splitting {len(participants)} pages...")

    # ページごとに分割して保存
    for i, name in enumerate(participants):
        writer = PdfWriter()
        # i番目のページを取得して追加
        writer.add_page(reader.pages[i])

        # ファイル名に使えない文字を置換（簡易的なサニタイズ）
        safe_name = name.replace("/", "_").replace("\\", "_").replace(" ", "_")
        
        # 連番 + 名前でファイル名を決定 (例: 001_山田_太郎.pdf)
        output_filename = os.path.join(OUTPUT_DIR, f"{i+1:03d}_{safe_name}.pdf")

        with open(output_filename, "wb") as f:
            writer.write(f)

    print(f"Done! Saved to {OUTPUT_DIR}/")

if __name__ == "__main__":
    main()
