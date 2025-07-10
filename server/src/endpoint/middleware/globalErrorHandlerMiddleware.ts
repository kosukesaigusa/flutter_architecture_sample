import type { Context } from 'hono'
import type { EnvironmentVariables } from '../../env'
import { AppHTTPException } from '../errorResponse'

/**
 * グローバルなエラーハンドリングを行う ミドルウェア。
 * @param error 発生したエラー。
 * @param c コンテキスト。
 * @returns レスポンス。
 */
export const globalErrorHandlerMiddleware = async (
  error: Error,
  c: Context<EnvironmentVariables>,
) => {
  const logger = c.get('logger')

  // AppHTTPException の場合は、エラーコードを含む 400 レスポンスを返す。
  if (error instanceof AppHTTPException) {
    logger.error('API Error handled in errorHandlerMiddleware', error, {
      code: error.code,
      message: error.message,
    })
    return c.json({ error: { code: error.code } }, 400)
  }

  // その他のエラーは 500 レスポンスを返す。
  logger.error('Unexpected error handled in errorHandlerMiddleware', error, {
    message: error.message,
  })
  return c.json({ error: { message: 'Internal Server Error' } }, 500)
}
