import type { Context, Next } from 'hono'
import { requestId } from 'hono/request-id'
import type { EnvironmentVariables } from '../../env'
import { AppLogger } from '../../util/logger'

/**
 * リクエスト ID を生成し、ロガーをコンテキストに設定するミドルウェア。
 * 各リクエストに一意の ID を割り当て、ログにリクエスト ID を含めることで追跡可能にする。
 * @param c - Hono のコンテキスト。
 * @param next - 次のミドルウェアを実行する関数。
 */
export const requestIdMiddleware = async (
  c: Context<EnvironmentVariables>,
  next: Next,
) => {
  // リクエスト ID ミドルウェアを適用する。
  await requestId()(c, async () => {})

  // コンテキストから取得したリクエスト ID でロガーを初期化する。
  const reqId = c.get('requestId')
  const logger = new AppLogger({ requestId: reqId })
  c.set('logger', logger)

  // リクエスト開始ログを出力する。
  logger.info('Request Started', {
    method: c.req.method,
    path: c.req.path,
    url: c.req.url,
  })

  await next()

  // リクエスト終了ログを出力する。
  logger.info('Request Completed', {
    method: c.req.method,
    path: c.req.path,
    status: c.res.status,
    // ユーザー ID がコンテキストに存在する場合はログに出力する。
    userId: c.get('userId'),
  })
}
