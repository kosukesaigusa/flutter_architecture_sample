import { z } from 'zod'
import 'zod-openapi/extend'
import { describeRoute } from 'hono-openapi'
import { resolver, validator } from 'hono-openapi/zod'
import { createFactory } from 'hono/factory'
import { match } from 'ts-pattern'
import type { EnvironmentVariables } from '../../../env'
import { createTodoUseCase } from '../../../use-case/todo/createTodoUseCase'
import { ENDPOINT_ERROR_CODES } from '../../errorCode'
import {
  AppHTTPException,
  getErrorResponseForOpenAPISpec,
} from '../../errorResponse'

/** リクエストボディのスキーマ。 */
const requestSchema = z
  .object({
    title: z.string().min(1).max(100),
    description: z.string().max(500),
  })
  .openapi({
    example: {
      title: '買い物リスト作成',
      description: '週末の買い物で必要なものをまとめる',
    },
  })

/** レスポンスデータのスキーマ。 */
const responseSchema = z
  .object({
    id: z.string(),
    title: z.string(),
    description: z.string(),
    createdAt: z.string(),
    updatedAt: z.string(),
  })
  .openapi({
    example: {
      id: '01HZXT7CQZK1XJ9Q8VXXX7MXXX',
      title: '買い物リスト作成',
      description: '週末の買い物で必要なものをまとめる',
      createdAt: '2024-07-01T12:00:00.000Z',
      updatedAt: '2024-07-01T12:00:00.000Z',
    },
  })

/**
 * Todo を作成する Handler.
 *
 * @returns 作成された Todo の情報を返却する。
 */
export const createTodoHandlers =
  createFactory<EnvironmentVariables>().createHandlers(
    describeRoute({
      description: 'Todo を作成する',
      tags: ['todos'],
      responses: {
        200: {
          description: 'Todo の作成に成功',
          content: {
            'application/json': {
              schema: resolver(responseSchema),
            },
          },
        },
        400: getErrorResponseForOpenAPISpec(ENDPOINT_ERROR_CODES.CREATE_TODO),
      },
    }),
    validator('json', requestSchema),
    async (c) => {
      // 認証済みユーザー ID を取得する。
      const userId = c.get('userId')

      // バリデーション済みのリクエストボディを取得する。
      const data = c.req.valid('json')

      // UseCase を呼び出す。
      const result = await createTodoUseCase({
        userId,
        title: data.title,
        description: data.description,
      })

      // エラーが発生した場合は、エラーの種類を網羅的にマッチングし、
      // 対応するエラーコード AppHTTPException に設定してスローする。
      if (result.isErr()) {
        const error = result.error
        match(error)
          .with({ type: 'TODO_CREATE_FAILED' }, () => {
            throw new AppHTTPException(
              ENDPOINT_ERROR_CODES.CREATE_TODO.FAILED.code,
            )
          })
          .with({ type: 'TODO_VALIDATION_ERROR' }, () => {
            throw new AppHTTPException(
              ENDPOINT_ERROR_CODES.CREATE_TODO.VALIDATION_ERROR.code,
            )
          })
          .exhaustive()
        return
      }

      // レスポンスデータをバリデーションする。
      const validatedResponse = responseSchema.parse(result.value)

      // レスポンスを生成する。
      return c.json(validatedResponse, 201)
    },
  )
