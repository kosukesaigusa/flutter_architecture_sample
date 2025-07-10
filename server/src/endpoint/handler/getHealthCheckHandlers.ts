import z from 'zod'
import 'zod-openapi/extend'
import { describeRoute } from 'hono-openapi'
import { resolver } from 'hono-openapi/zod'
import { createFactory } from 'hono/factory'
import type { EnvironmentVariables } from '../../env'

/** レスポンスデータのスキーマ。 */
const responseSchema = z
  .object({
    message: z.string(),
  })
  .openapi({ example: { message: 'Hello, World!' } })

/**
 * アプリケーションの疎通確認用のハンドラ。
 * @returns アプリケーションの疎通確認用のハンドラ。
 */
export const getHealthCheckHandlers =
  createFactory<EnvironmentVariables>().createHandlers(
    describeRoute({
      tags: [],
      summary: 'アプリケーションの疎通確認用のハンドラ',
      security: [],
      responses: {
        200: {
          description: 'アプリケーションの疎通確認用のハンドラ',
          content: {
            'application/json': {
              schema: resolver(responseSchema),
            },
          },
        },
      },
    }),
    async (c) => {
      return c.json({ message: 'Hello, World!' })
    },
  )
