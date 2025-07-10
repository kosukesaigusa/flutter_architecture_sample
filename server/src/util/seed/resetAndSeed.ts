import type { D1Database } from '@cloudflare/workers-types'
import { drizzle } from 'drizzle-orm/d1'
import { TABLE_DELETE_ORDER } from '../../schema'
import { seedAllData } from './seedAllData'

/**
 * データベースをリセットしてシードデータを投入するためのパラメータ。
 */
type ResetAndSeedParam = {
  /** D1データベースインスタンス。 */
  db: D1Database

  /** ユーザー ID を Firebase Auth に存在するユーザーで上書きするかどうか。 */
  overrideUserId?: boolean
}

/**
 * データベースをリセット（全テーブルのデータをクリア）してシードデータを投入する。
 *
 * この関数は clearTables と seedAllData を組み合わせたもので、
 * 常にセットで実行される処理を一つの関数にまとめている。
 *
 * @param param.db D1データベースインスタンス。
 * @param param.overrideUserId ユーザー ID を Firebase Auth に存在するユーザーで上書きするかどうか。
 */
export const resetAndSeed = async (param: ResetAndSeedParam) => {
  const { db, overrideUserId = false } = param

  console.log('🚀 データベースのリセット・シードを開始...')

  try {
    // 1. データベースをクリア
    console.log('🗑️  テーブルをクリア中...')
    await clearTables(db)

    // 2. シードデータを投入
    console.log('🌱 シードデータを投入中...')
    const drizzleDb = drizzle(db)
    await seedAllData({ db: drizzleDb, overrideUserId })

    console.log('✅ データベースのリセット・シードが完了しました！')
  } catch (error) {
    console.error('❌ データベースのリセット・シードに失敗しました:', error)
    throw error
  }
}

/**
 * テストデータベースのすべてのテーブルからデータを削除する関数。
 * テーブル構造は保持したまま、データのみを削除する。
 * @param db D1データベースインスタンス。
 */
const clearTables = async (db: D1Database) => {
  const d1 = drizzle(db)

  // 外部キー制約を一時的に無効化する。
  await d1.run('PRAGMA foreign_keys = OFF;')

  try {
    // すべてのテーブルからデータを削除する。
    // 外部キー制約があるため、削除順序に注意する。
    for (const tableName of TABLE_DELETE_ORDER) {
      await d1.run(`DELETE FROM ${tableName};`)
    }

    // SQLite では auto_increment カウンタをリセットするには
    // sqlite_sequence テーブルを操作する必要がある。
    await d1.run('DELETE FROM sqlite_sequence;')
  } finally {
    // 外部キー制約を再度有効化する。
    await d1.run('PRAGMA foreign_keys = ON;')
  }
}
