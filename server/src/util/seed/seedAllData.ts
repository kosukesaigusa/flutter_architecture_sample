import type { DatabaseForSeed } from './databaseForSeed'
import { seedTodoData } from './seedTodoData'
import { seedUserData } from './seedUserData'

/**
 * 一通りのシードデータを挿入するためのパラメータ。
 */
type SeedAllDataParam = {
  /** データベースインスタンス。 */
  db: DatabaseForSeed

  /** ユーザー ID を Firebase Auth に存在するユーザーで上書きするかどうか。 */
  overrideUserId?: boolean
}

/**
 * 一通りのシードデータを挿入する。
 *
 * @param param.db データベースインスタンス。
 * @param param.overrideUserId ユーザー ID を Firebase Auth に存在するユーザーで上書きするかどうか。
 */
export const seedAllData = async (param: SeedAllDataParam) => {
  const { db, overrideUserId } = param
  try {
    // ユーザーデータをシードする。
    await seedUserData({ db, overrideUserId: overrideUserId ?? false })

    // Todo データをシードする。
    await seedTodoData({ db, overrideUserId: overrideUserId ?? false })
  } catch (e) {
    console.error('❌ シードデータの挿入に失敗しました:', e)
    throw e
  }
}
