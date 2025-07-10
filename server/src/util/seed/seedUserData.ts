import * as schema from '../../schema'
import { USER_SEED_DATA, getUserId } from "./data/userIds"
import { DatabaseForSeed } from "./databaseForSeed"

/**
 * ユーザーデータをシードするためのパラメータ。
 */
type SeedUserDataParam = {
  /** シードデータを挿入するデータベース。 */
  db: DatabaseForSeed

  /** マッピングを使用してユーザー ID を上書きするかどうか。 */
  overrideUserId: boolean
}

/**
 * ユーザーデータをシードする。
 *
 * 家族のメンバーに対応するユーザーアカウントを作成する。
 * Firebase Auth のユーザー ID と連携させる場合は getUserId() を使用して
 * 実際のユーザー ID を取得する。
 *
 * @param param.defaultId デフォルトのユーザー ID.
 * @param param.overrideUserId マッピングを使用してユーザー ID を上書きするかどうか。
 */
export const seedUserData = async (param: SeedUserDataParam) => {
  const { db, overrideUserId } = param

  // ユーザーデータを作成する。
  const userData = USER_SEED_DATA.map((user) => ({
    userId: getUserId({ defaultId: user.userId, overrideUserId }),
  }))

  await db.insert(schema.users).values(userData)
}
