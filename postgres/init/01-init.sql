-- 拡張機能：UUID生成
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 書籍カテゴリーマスタ
CREATE TABLE book_categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 書籍テーブル
CREATE TABLE book (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  display_id VARCHAR(20) NOT NULL UNIQUE,
  title VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 書籍詳細テーブル
CREATE TABLE book_details (
  id SERIAL PRIMARY KEY,
  book_id UUID NOT NULL REFERENCES book(id) ON DELETE CASCADE,
  category_id INTEGER NOT NULL REFERENCES book_categories(id),
  description TEXT,
  author VARCHAR(255),
  publisher VARCHAR(255),
  publish_date DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 状態マスタ
CREATE TABLE book_statuses (
  id SERIAL PRIMARY KEY,
  code VARCHAR(20) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 貸出状態テーブル
CREATE TABLE book_loans (
  id SERIAL PRIMARY KEY,
  book_id UUID NOT NULL REFERENCES book(id) ON DELETE CASCADE,
  status_id INTEGER NOT NULL REFERENCES book_statuses(id),
  status_note TEXT,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 初期データ投入
INSERT INTO book_categories (name) VALUES 
('小説'),
('技術書'),
('漫画'),
('写真集');

INSERT INTO book (display_id, title) VALUES
('BK-0001', 'はじめてのPostgreSQL'),
('BK-0002', 'Docker入門'),
('BK-0003', 'ファンタジーの世界');

INSERT INTO book_details (book_id, category_id, description, author, publisher, publish_date)
SELECT b.id, 2, 'PostgreSQLの基礎から実践まで', '山田 太郎', '技術出版社', '2022-05-01'
FROM book b WHERE b.display_id = 'BK-0001';

INSERT INTO book_details (book_id, category_id, description, author, publisher, publish_date)
SELECT b.id, 2, 'Dockerの基礎を学ぶ入門書', '佐藤 花子', 'インフラ出版', '2021-12-10'
FROM book b WHERE b.display_id = 'BK-0002';

INSERT INTO book_details (book_id, category_id, description, author, publisher, publish_date)
SELECT b.id, 1, '冒険と成長のファンタジー小説', '加藤 一郎', '物語舎', '2023-03-15'
FROM book b WHERE b.display_id = 'BK-0003';

INSERT INTO book_statuses (code, name) VALUES
('available', '貸出可'),
('loaned', '貸出中'),
('reserved', '予約中'),
('unavailable', '利用不可');

INSERT INTO book_loans (book_id, status_id, status_note)
SELECT b.id, s.id, ''
FROM book b
JOIN book_statuses s ON s.code = 'available'
WHERE b.display_id = 'BK-0001';

INSERT INTO book_loans (book_id, status_id, status_note)
SELECT b.id, s.id, '2024/9返却予定'
FROM book b
JOIN book_statuses s ON s.code = 'loaned'
WHERE b.display_id = 'BK-0002';

INSERT INTO book_loans (book_id, status_id, status_note)
SELECT b.id, s.id, '予約あり'
FROM book b
JOIN book_statuses s ON s.code = 'reserved'
WHERE b.display_id = 'BK-0003';
