import { drizzle } from 'drizzle-orm/d1'
import { Hono } from 'hono'
import { contextStorage } from 'hono/context-storage'
import { cors } from 'hono/cors'
import { prettyJSON } from 'hono/pretty-json'
import { globalErrorHandlerMiddleware } from '../endpoint/middleware/globalErrorHandlerMiddleware'
import { requestIdMiddleware } from '../endpoint/middleware/requestIdMiddleware'
import { setUserAuthMiddleware } from '../endpoint/middleware/setUserAuthMiddleware'
import type { EnvironmentVariables } from '../env'

/**
 * Hono アプリケーションインスタンスを作成する。
 *
 * @returns Hono アプリケーションインスタンス。
 */
export const createApp = () => {
  const app = new Hono<EnvironmentVariables>()

  app
    // ミドルウェアを設定する。
    .use(prettyJSON())
    .use(requestIdMiddleware)
    // NOTE: サンプルコードのため、CORS を有効化している。
    .use('*', cors())
    .use(contextStorage())
    // グローバルエラーハンドラを設定する。
    .onError(globalErrorHandlerMiddleware)
    // Drizzle クライアントを Context にセットする。
    .use(async (c, next) => {
      c.set('db', drizzle(c.env.DB))
      await next()
    })
    // 認証関係のミドルウェアを適用する。
    .use('/api/*', setUserAuthMiddleware)

  return app
}
