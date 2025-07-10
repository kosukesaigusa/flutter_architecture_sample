import type { D1Database } from '@cloudflare/workers-types'
import { drizzle } from 'drizzle-orm/d1'
import { SYSTEM_TABLES, TABLE_DELETE_ORDER } from '../../../schema'

/**
 * テストデータベースのテーブルを全て削除する。
 * @param db D1データベースインスタンス。
 */
export const dropTables = async (db: D1Database) => {
  const d1 = drizzle(db)

  // 外部キー制約を一時的に無効化する。
  await d1.run('PRAGMA foreign_keys = OFF;')

  try {
    // 外部キー制約があるため、削除順序に注意する。
    for (const tableName of TABLE_DELETE_ORDER) {
      await d1.run(`DROP TABLE IF EXISTS ${tableName};`)
    }

    // システムテーブルを削除する。
    for (const tableName of SYSTEM_TABLES) {
      await d1.run(`DROP TABLE IF EXISTS ${tableName};`)
    }
  } finally {
    // 外部キー制約を再度有効化する。
    await d1.run('PRAGMA foreign_keys = ON;')
  }
}
