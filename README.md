# Laravel + Vue + PostgreSQL 開発環境構築（Docker Compose）

このプロジェクトは、**Laravel + Vue 3 + PostgreSQL** を使用したモダンなWebアプリケーションの開発環境を Docker Compose により構築するテンプレートです。

---

## 📦 プロジェクト構成

```
├── backend/                # Laravel アプリケーション
│   └── larabelproject/     # Laravel プロジェクトルート
├── frontend/               # Vite + Vue3 アプリケーション
├── postgres/
│   └── init/01-init.sql    # 初期データ投入用SQL
├── docker-compose.yml      # Docker定義ファイル
└── README.md
```

---

## 🐳 使用技術

- Laravel 11
- Vue 3 + Vite
- PostgreSQL 15
- Docker / Docker Compose

---

## 🔧 セットアップ手順

1. リポジトリをクローン

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

2. Laravel プロジェクトの作成（初回のみ）

```bash
cd backend/larabelproject
composer create-project laravel/laravel .
```

3. `.env` 設定の確認（DB接続情報）

```env
DB_CONNECTION=pgsql
DB_HOST=db
DB_PORT=5432
DB_DATABASE=postgres_sample
DB_USERNAME=postgres
DB_PASSWORD=postgres
```

4. Laravel キー生成・マイグレーション・セッションテーブル作成

```bash
docker compose exec backend php artisan key:generate
docker compose exec backend php artisan session:table
docker compose exec backend php artisan migrate
```

5. フロントエンド依存解決（初回）

```bash
docker compose exec frontend npm install
```

6. Docker 起動

```bash
docker compose up -d --build
```

---

## 🌐 アクセス

- Laravel (API): [http://localhost:8000](http://localhost:8000)
- Vue (開発サーバー): [http://localhost:5173](http://localhost:5173)
- PostgreSQL: `localhost:5432`（GUIクライアントから接続可能）

---

## 🗃️ データベース初期化

- `postgres/init/01-init.sql` により以下が作成・挿入されます:
  - カテゴリマスタ（小説、技術書など）
  - 書籍テーブル（UUID）
  - 書籍詳細、状態マスタ、貸出状態

---

## よく使うコマンド一覧

```bash
# 全コンテナ起動・停止
docker compose up -d
docker compose down

# Laravel artisanコマンド
docker compose exec backend php artisan migrate
docker compose exec backend php artisan tinker

# Vue開発サーバー
docker compose exec frontend npm run dev
```

---

## 🧑‍💻 作者・ライセンス

MIT License  
(c) 2025 あなたの名前または GitHub ID
