import type { Context, Next } from 'hono'
import { AppHTTPException } from '../../endpoint/errorResponse'
import { ERROR_CODES } from '../../endpoint/errorCode'

// モジュールレベルでモックを初期化する（一度だけ実行される）。
const { mockSetUserAuthMiddleware: mockModule } = (() => {
  // ユーザー認証ミドルウェアのモックを vi.hoisted で定義する。
  const mockSetUserAuthMiddleware = vi.hoisted(() => {
    const mock = vi.fn(async (c: Context, next: Next): Promise<void> => {
      // モックの実装を上書きしないと利用できないようにしておく。
      throw new Error('Unimplemented')
    })
    return { setUserAuthMiddleware: mock }
  })

  vi.mock(
    '../../endpoint/middleware/setUserAuthMiddleware',
    () => mockSetUserAuthMiddleware,
  )

  return { mockSetUserAuthMiddleware }
})()

/** ユーザー認証ミドルウェアのモックの設定。 */
type MockConfig = {
  /** ユーザー ID. */
  userId?: string

  /** Firebase Auth の認証を失敗させるかどうか. */
  shouldFailAuth?: boolean

  /** ID トークンの取得を失敗させるかどうか. */
  shouldFailIdToken?: boolean
}

/**
 * ユーザー認証ミドルウェアのモックを設定する。
 * @param config - モックの設定。
 * @param config.userId - ユーザー ID.
 * @param config.shouldFailAuth - Firebase Auth の認証を失敗させるかどうか。
 * @param config.shouldFailIdToken - ID トークンの取得を失敗させるかどうか。
 */
export const mockSetUserAuthMiddleware = ({
  userId,
  shouldFailAuth = false,
  shouldFailIdToken = false,
}: MockConfig = {}) => {
  // モックの実装をリセットする（モジュール自体はリセットしない）。
  mockModule.setUserAuthMiddleware.mockReset()

  mockModule.setUserAuthMiddleware.mockImplementation(
    async (c: Context, next: Next) => {
      const logger = c.get('logger')

      // Firebase Auth の認証失敗をシミュレートする。
      if (shouldFailAuth) {
        if (logger) {
          logger.error('failed to verify firebase auth')
        }
        // エラーをスローする。
        // このエラーは app.onError で設定されたハンドラによって捕捉される。
        throw new AppHTTPException(ERROR_CODES.AUTH.USER_AUTH_ERROR.code)
      }

      // ID トークンの取得失敗をシミュレートする。
      if (shouldFailIdToken) {
        if (logger) {
          logger.error('failed to get firebase token')
        }
        // エラーをスローする。
        throw new AppHTTPException(ERROR_CODES.AUTH.USER_AUTH_ERROR.code)
      }

      // ユーザー ID が与えられていない場合は認証エラーをスローする。
      if (!userId) {
        if (logger) {
          logger.error('userId is not provided')
        }
        // エラーをスローする。
        throw new AppHTTPException(ERROR_CODES.AUTH.USER_AUTH_ERROR.code)
      }

      // ユーザー ID を Context にセットする。
      c.set('userId', userId)
      await next()
    },
  )
}
