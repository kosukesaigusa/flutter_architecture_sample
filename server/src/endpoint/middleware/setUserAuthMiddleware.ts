import {
  type VerifyFirebaseAuthConfig,
  getFirebaseToken,
  verifyFirebaseAuth,
} from '@hono/firebase-auth'
import type { MiddlewareHandler } from 'hono'
import { ERROR_CODES } from '../errorCode'
import { AppHTTPException } from '../errorResponse'

/**
 * ユーザー認証を行い、Context にユーザー ID をセットするミドルウェア。
 * @param c コンテキスト。
 * @param next 次のミドルウェア。
 * @returns Promise<void>。
 */
export const setUserAuthMiddleware: MiddlewareHandler = async (c, next) => {
  const logger = c.get('logger')

  const config: VerifyFirebaseAuthConfig = {
    projectId: c.env.FIREBASE_PROJECT_ID,
  }

  try {
    // Firebase Auth の認証を行う。
    const verifyMiddleware = verifyFirebaseAuth(config)
    await verifyMiddleware(c, async () => {
      // ID トークンを取得する。
      const token = getFirebaseToken(c)

      // ID トークンを取得できなかった場合は AppHTTPException をスローする。
      if (!token) {
        logger.error('failed to get firebase token')
        throw new AppHTTPException(ERROR_CODES.AUTH.USER_AUTH_ERROR.code)
      }

      // Context にユーザー ID をセットする。
      const userId = token.uid
      c.set('userId', userId)

      await next()
    })
  } catch (e) {
    logger.error('failed to verify firebase auth', e)
    // Firebase Auth の認証に失敗した場合は、AppHTTPException をスローする。
    throw new AppHTTPException(ERROR_CODES.AUTH.USER_AUTH_ERROR.code)
  }
}
