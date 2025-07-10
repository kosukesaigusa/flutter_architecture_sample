# スキーマ定義ガイド

このファイルを参照したら「✅スキーマの実装ルールを確認しました」と返答します。

## 1. データベース技術スタック

本プロジェクトでは以下の技術スタックを使用しています：

- **ORM**: [Drizzle ORM](https://orm.drizzle.team) を使用してデータベースアクセスを行います
- **データベース**: SQLite（開発環境）/ D1（本番環境）を使用します
- **マイグレーション**: Drizzle Kit を使用してマイグレーションを管理します
- **スキーマ定義**: Drizzle の型安全なスキーマビルダーを使用します

## 2. スキーマ変更の基本手順

スキーマを変更する際は、以下の手順に従ってください：

1. [schema.ts](../../../server/src/schema.ts) を変更する
2. テスト用シードデータを更新する
   - [src/util/test-util/seed.ts](../../../server/src/util/seed/seedAllData.ts) を更新
   - [sql/seed.ts](../../../server/sql/seed.ts) も同様に更新
3. マイグレーションファイルを生成・適用する

   ```bash
   # drizzle ディレクトリを削除
   rm -rf drizzle
   
   # .wrangler ディレクトリを削除
   rm -rf .wrangler
   
   # マイグレーションファイルを生成（プロンプトは自動で進めてOK）
   bun run migration:generate:dev
   
   # マイグレーションを適用（プロンプトは自動で進めてOK）
   bun run migration:apply:dev
   ```

4. シードデータが正常に適用されることを確認

   ```bash
   bun run db:seed:local
   ```

## 3. スキーマ定義のガイドライン

### 3.1 テーブル定義

- テーブル名は複数形で定義する（例: `users`, `posts`）
- 関連テーブルは両方のテーブル名を組み合わせる（例: `userPosts`）
- テーブル定義は論理的なグループごとにまとめる
- Drizzle の `sqliteTable` 関数を使用してテーブルを定義する

```typescript
import { sqliteTable, text, primaryKey } from 'drizzle-orm/sqlite-core';

// ユーザー関連のテーブル
export const users = sqliteTable('users', {
  id: text('id').primaryKey(),
  name: text('name').notNull(),
  email: text('email').notNull().unique(),
  password: text('password').notNull(),
  createdAt: text('created_at').notNull(),
  updatedAt: text('updated_at').notNull(),
});

// グループ関連のテーブル
export const groups = sqliteTable('groups', {
  id: text('id').primaryKey(),
  name: text('name').notNull(),
  description: text('description'),
  createdAt: text('created_at').notNull(),
  updatedAt: text('updated_at').notNull(),
});

// ユーザーとグループの関連テーブル
export const userGroups = sqliteTable('user_groups', {
  userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
  groupId: text('group_id').notNull().references(() => groups.id, { onDelete: 'cascade' }),
  role: text('role').notNull(),
  createdAt: text('created_at').notNull(),
  updatedAt: text('updated_at').notNull(),
}, (table) => ({
  pk: primaryKey({ columns: [table.userId, table.groupId] }),
}));
```

### 3.2 カラム定義

- ID カラムは `id` という名前で定義し、主キーとする
- 作成日時・更新日時は `createdAt`/`updatedAt` という名前で定義する
- 外部キーは `<テーブル名の単数形>Id` という名前で定義する（例: `userId`, `groupId`）
- 必須項目には `.notNull()` を付ける
- ユニーク制約が必要な項目には `.unique()` を付ける
- 外部キー制約には適切な削除ポリシーを設定する（例: `{ onDelete: 'cascade' }`）
- SQLite では日付型がないため、日付は text 型で保存し、アプリケーション側で変換する

### 3.3 インデックス定義

- 検索条件としてよく使われるカラムにはインデックスを設定する
- 複合インデックスは関連する検索パターンに合わせて設定する
- Drizzle の `index` 関数を使用してインデックスを定義する

```typescript
import { sqliteTable, text, index } from 'drizzle-orm/sqlite-core';

export const posts = sqliteTable('posts', {
  id: text('id').primaryKey(),
  title: text('title').notNull(),
  content: text('content').notNull(),
  authorId: text('author_id').notNull().references(() => users.id),
  categoryId: text('category_id').references(() => categories.id),
  publishedAt: text('published_at'),
  createdAt: text('created_at').notNull(),
  updatedAt: text('updated_at').notNull(),
}, (table) => ({
  // 著者IDと公開日でのフィルタリング用インデックス
  authorPublishedIdx: index('author_published_idx').on(table.authorId, table.publishedAt),
  // カテゴリIDと公開日でのフィルタリング用インデックス
  categoryPublishedIdx: index('category_published_idx').on(table.categoryId, table.publishedAt),
}));
```

## 4. シードデータの作成

テスト用のシードデータは以下のガイドラインに従って作成してください：

- 各テーブルに最低限必要なデータを用意する
- テスト用のデータは現実的な値を使用する
- 関連するデータ間の整合性を保つ
- ID は予測可能な値を使用する（例: `user-1`, `group-1`）
- Drizzle の insert 構文を使用してデータを挿入する

```typescript
// src/util/test-util/db/seed.ts の例
import { DrizzleD1Database } from 'drizzle-orm/d1';
import { users, groups, userGroups } from '../../../schema';

export const seedDatabase = async (db: DrizzleD1Database) => {
  const now = new Date().toISOString();
  
  // ユーザーデータの挿入
  await db.insert(users).values([
    {
      id: 'user-1',
      name: 'テストユーザー1',
      email: 'user1@example.com',
      password: 'hashed_password',
      createdAt: now,
      updatedAt: now,
    },
    {
      id: 'user-2',
      name: 'テストユーザー2',
      email: 'user2@example.com',
      password: 'hashed_password',
      createdAt: now,
      updatedAt: now,
    },
  ]);
  
  // グループデータの挿入
  await db.insert(groups).values([
    {
      id: 'group-1',
      name: 'テストグループ1',
      description: 'テスト用のグループ1です',
      createdAt: now,
      updatedAt: now,
    },
  ]);
  
  // ユーザーとグループの関連データの挿入
  await db.insert(userGroups).values([
    {
      userId: 'user-1',
      groupId: 'group-1',
      role: 'admin',
      createdAt: now,
      updatedAt: now,
    },
    {
      userId: 'user-2',
      groupId: 'group-1',
      role: 'member',
      createdAt: now,
      updatedAt: now,
    },
  ]);
};
```

## 5. マイグレーション管理

- マイグレーションファイルは Drizzle Kit によって自動生成される
- マイグレーションファイルは `drizzle` ディレクトリに保存される
- マイグレーションファイルを手動で編集しない
- 本番環境へのデプロイ前に必ずマイグレーションをテスト環境で検証する
- マイグレーションコマンドは `package.json` に定義されている

```json
{
  "scripts": {
    "migration:generate:dev": "drizzle-kit generate:sqlite",
    "migration:apply:dev": "bun run src/util/db/applyMigrations.ts"
  }
}
```

## 6. スキーマ変更チェックリスト

スキーマ変更時は以下の点を確認してください：

- [ ] テーブル名・カラム名が命名規則に従っているか
- [ ] 適切な制約（NOT NULL, UNIQUE など）が設定されているか
- [ ] 外部キー制約が適切に設定されているか
- [ ] 必要なインデックスが設定されているか
- [ ] シードデータが更新されているか
- [ ] マイグレーションが正常に生成・適用できるか
- [ ] 既存のクエリに影響がないか確認したか
- [ ] Repository レイヤーの対応するコードを更新したか
