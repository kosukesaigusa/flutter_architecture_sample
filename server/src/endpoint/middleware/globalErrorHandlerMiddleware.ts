import type { ErrorHandler } from 'hono'
import { HTTPException } from 'hono/http-exception'
import type { EnvironmentVariables } from '../../env'

/**
 * グローバルエラーハンドラーミドルウェア。
 *
 * アプリケーション全体で発生したエラーを統一的に処理する。
 */
export const globalErrorHandlerMiddleware: ErrorHandler<
  EnvironmentVariables
> = (err, c) => {
  const logger = c.get('logger')

  // HTTPException の場合はそのままレスポンスを返す。
  if (err instanceof HTTPException) {
    logger.warn(`HTTP Exception: ${err.message}`)
    return err.getResponse()
  }

  // その他のエラーの場合は 500 エラーを返す。
  logger.error(`Unexpected error: ${err.message}`, err)
  return c.json(
    {
      error: {
        code: 'internal.server.error.1',
      },
    },
    500,
  )
}
