import Database from 'better-sqlite3'
import { drizzle } from 'drizzle-orm/better-sqlite3'
import { reset } from 'drizzle-seed'
import config from '../drizzle-local.config'
import * as schema from '../src/schema'

/**
 * ローカル環境用のデータベースリセットするスクリプト。
 * SQLite データベースをリセットし、スキーマを再適用する。
 * リモート環境では使用できない。
 */
const main = async () => {
  const sqlite = new Database(config.dbCredentials.url)
  const db = drizzle(sqlite)

  try {
    await reset(db, schema)
    console.log('✨ Reset successfully!')
  } catch (e) {
    console.error('❌ Failed to reset:', e)
    process.exit(1)
  } finally {
    sqlite.close()
  }
}

// トップレベルの await を削除し、Promise をハンドリングする。
main().catch((error) => {
  console.error('❌ Unhandled error:', error)
  process.exit(1)
})
