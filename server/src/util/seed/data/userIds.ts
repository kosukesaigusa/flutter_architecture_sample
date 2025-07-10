/**
 * ユーザー ID 関連のデータ定義。
 * Firebase Auth との連携に使用するユーザー ID とマッピングを定義する。
 */
import type * as schema from '../../../schema'

/**
 * デフォルトユーザー ID。
 * 環境固有の設定がない場合に使用される ID。
 */
export const DEFAULT_USER_IDS = {
  /** テストユーザー 1 */
  USER_1: 'test-user-1',
  /** テストユーザー 2 */
  USER_2: 'test-user-2',
  /** テストユーザー 3 */
  USER_3: 'test-user-3',
} as const

/**
 * テストユーザーの Firebase Auth ユーザー ID の定義。
 */
export const FIREBASE_USER = {
  /** テストユーザー 1 */
  USER_1: '7pcTGaMRqDXbfZou56sIApBPMy12',
  /** テストユーザー 2 */
  USER_2: 'duT1f9s3ppVGEv75zrujwsCoUOm2',
  /** テストユーザー 3 */
  USER_3: '6awjEFSORPMOTaE3fI9Y9WmJClq2',
} as const

/**
 * ユーザー ID のマッピング。
 * シードデータ内で使用されるユーザー ID と実際の Firebase Auth ユーザー ID の対応関係。
 */
export const USER_ID_MAP: Record<string, string | undefined> = {
  [DEFAULT_USER_IDS.USER_1]: FIREBASE_USER.USER_1,
  [DEFAULT_USER_IDS.USER_2]: FIREBASE_USER.USER_2,
  [DEFAULT_USER_IDS.USER_3]: FIREBASE_USER.USER_3,
}

/**
 * ユーザー ID を取得するためのパラメータ。
 */
type GetUserIdParam = {
  defaultId: string
  overrideUserId: boolean
}

/**
 * 実際に使用するユーザー ID を取得する。
 *
 * @param param デフォルトのユーザー ID とマッピングを使用するかどうか。
 * @param param.defaultId デフォルトのユーザー ID.
 * @param param.overrideUserId マッピングを使用してユーザー ID を上書きするかどうか。
 * @returns 使用するユーザー ID. overrideUserId が true かつマッピングが存在する場合はマッピングされた ID、
 * それ以外の場合はデフォルトの ID を返す。
 */
export const getUserId = (param: GetUserIdParam): string => {
  // マッピングを使用しない場合はデフォルト値をそのまま返す。
  if (!param.overrideUserId) {
    return param.defaultId
  }

  // マッピングからユーザー ID を取得する。
  const firebaseAuthUserId = USER_ID_MAP[param.defaultId]

  // Firebase Auth ユーザー ID が設定されていなければデフォルト値を使用する。
  return firebaseAuthUserId || param.defaultId
}

/**
 * 共通ユーザーデータ。
 * Firebase Authentication のユーザーと 1:1 で紐づく。
 */
export const USER_SEED_DATA: Array<typeof schema.users.$inferInsert> = [
  {userId: DEFAULT_USER_IDS.USER_1},
  {userId: DEFAULT_USER_IDS.USER_2},
  {userId: DEFAULT_USER_IDS.USER_3},
]
