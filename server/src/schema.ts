import { sql } from 'drizzle-orm'
import { index, sqliteTable, text } from 'drizzle-orm/sqlite-core'

/**
 * システムテーブル一覧。
 */
export const SYSTEM_TABLES = ['__drizzle_migrations', 'd1_migrations'] as const

/**
 * テーブル削除順序の明示的な定義。
 *
 * 外部キー制約を考慮し、子テーブル（外部キーを持つ）から親テーブル（参照される）の順で削除する。
 */
export const TABLE_DELETE_ORDER = ['todos', 'users'] as const

/**
 * テーブル名の型定義。
 */
export type TableName = (typeof TABLE_DELETE_ORDER)[number]

/**
 * User テーブル。
 *
 * @property {string} userId - ユーザーの ID. 主キー。Firebase Auth の UID。
 * @property {string} createdAt - 作成日時。
 * @property {string} updatedAt - 更新日時。
 */
export const users = sqliteTable(
  'users',
  {
    userId: text('user_id').primaryKey(),
    createdAt: text('created_at').notNull().default(sql`CURRENT_TIMESTAMP`),
    updatedAt: text('updated_at').notNull().default(sql`CURRENT_TIMESTAMP`),
  },
  (table) => [
    // 作成日時によるインデックス（降順）。
    index('idx_users_created_at').on(table.createdAt),
  ],
)

/**
 * Todo テーブル。
 *
 * @property {string} todoId - Todo の ID. 主キー。ULID 形式。
 * @property {string} title - Todo のタイトル。
 * @property {string} description - Todo の説明。
 * @property {string} userId - 作成者のユーザー ID。
 * @property {string} createdAt - 作成日時。
 * @property {string} updatedAt - 更新日時。
 */
export const todos = sqliteTable(
  'todos',
  {
    todoId: text('todo_id').primaryKey(),
    title: text('title').notNull(),
    description: text('description').notNull(),
    userId: text('user_id')
      .notNull()
      .references(() => users.userId, { onDelete: 'cascade' }),
    createdAt: text('created_at').notNull().default(sql`CURRENT_TIMESTAMP`),
    updatedAt: text('updated_at').notNull().default(sql`CURRENT_TIMESTAMP`),
  },
  (table) => [
    // ユーザー ID によるインデックス。
    index('idx_todos_user_id').on(table.userId),
    // 作成日時によるインデックス（降順）。
    index('idx_todos_created_at').on(table.createdAt),
  ],
)
