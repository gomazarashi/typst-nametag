import csv
import random

# 設定
OUTPUT_FILE = "participants.csv"
COUNT = 1000

# ダミーデータの素材
LAST_NAMES = ["佐藤", "鈴木", "高橋", "田中", "伊藤", "渡辺", "山本", "中村", "小林", "加藤"]
FIRST_NAMES = ["太郎", "花子", "一郎", "次郎", "さくら", "健太", "結衣", "陽菜", "大輔", "美咲"]
AFFILIATIONS = ["株式会社Typst", "Rust Corp.", "Design Inc.", "Freelance", "University of Tech", "Open Source Org"]
ROLES = ["Attendee", "Attendee", "Attendee", "Speaker", "Staff"] # Attendeeの比率を高めに
INTERESTS_LIST = ["Rust", "Typst", "Python", "WebAssembly", "UI/UX", "Cloud", "Security", "AI", "Blockchain"]

def generate_random_person():
    name = f"{random.choice(LAST_NAMES)} {random.choice(FIRST_NAMES)}"
    affiliation = random.choice(AFFILIATIONS)
    role = random.choice(ROLES)
    sns = f"user_{random.randint(1000, 9999)}"
    
    # 興味タグをランダムに1~4個選ぶ
    interests_count = random.randint(1, 4)
    interests = ",".join(random.sample(INTERESTS_LIST, interests_count))
    
    return {
        "Name": name,
        "Affiliation": affiliation,
        "Role": role,
        "SNS": sns,
        "Interests": interests
    }

def main():
    print(f"Generating {COUNT} dummy records...")
    
    with open(OUTPUT_FILE, 'w', encoding='utf-8', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=["Name", "Affiliation", "Role", "SNS", "Interests"])
        writer.writeheader()
        
        for _ in range(COUNT):
            writer.writerow(generate_random_person())
            
    print(f"Done! Saved to {OUTPUT_FILE}")

if __name__ == "__main__":
    main()
