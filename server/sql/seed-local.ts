import Database from 'better-sqlite3'
import { drizzle } from 'drizzle-orm/better-sqlite3'
import config from '../drizzle-local.config'
import { seedAllData } from '../src/util/seed/seedAllData'

/**
 * ローカル環境で SQLite にシードデータを挿入する。
 *
 * データベースに各種シードデータを投入する。
 * データは論理的なグループごとに分割されたファイルから読み込まれる。
 */
const main = async () => {
  const sqlite = new Database(config.dbCredentials.url)
  const db = drizzle(sqlite)

  try {
    // シードデータの投入を行う。
    // userId を Firebase Auth に存在するユーザーで上書きする。
    await seedAllData({ db, overrideUserId: true })
  } catch (e) {
    console.error('❌ シードデータの挿入に失敗しました:', e)
    process.exit(1)
  } finally {
    sqlite.close()
  }
}

// トップレベルの await を削除し、Promise をハンドリングする。
main().catch((error) => {
  console.error('❌ 未処理のエラー:', error)
  process.exit(1)
})
