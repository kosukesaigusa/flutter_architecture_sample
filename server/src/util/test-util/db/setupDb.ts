import { env } from 'cloudflare:test'
import { applyD1Migrations } from 'cloudflare:test'
import { drizzle } from 'drizzle-orm/d1'

import { seedAllData } from '../../seed/seedAllData'
import { dropTables } from './dropTables'

const main = async () => {
  try {
    // 既存のテーブルを削除する。
    await dropTables(env.DB)

    // マイグレーションを適用する。
    await applyD1Migrations(env.DB, env.TEST_MIGRATIONS)

    // Drizzle の D1 データベースインスタンスを作成する。
    const drizzleD1Database = drizzle(env.DB)

    // テストデータを投入する。
    // テストでは、userId を Firebase Auth に存在するユーザーで上書きしない。
    await seedAllData({ db: drizzleD1Database })
  } catch (error) {
    // マイグレーションエラーは無視する（すでに適用されている場合）
    if (error instanceof Error && error.message.includes('already exists')) {
      console.log('⚠️ マイグレーションはすでに適用されています。')
      // Drizzle の D1 データベースインスタンスを作成する。
      const drizzleD1Database = drizzle(env.DB)
      // テストデータを投入する。
      await seedAllData({ db: drizzleD1Database })
    } else {
      throw error
    }
  }
}

// トップレベルの await を削除し、Promise をハンドリングする。
main().catch((error) => {
  console.error('❌ 未処理のエラー:', error)
  process.exit(1)
})
