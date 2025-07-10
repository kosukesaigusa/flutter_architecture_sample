import { eq } from 'drizzle-orm'
import { describe, expect, it } from 'vitest'
import { todos } from '../../../schema'
import { mockSetUserAuthMiddleware } from '../../../util/test-util/mockSetUserAuthMiddleware'
import {
  getTestClient,
  getTestDrizzleClient,
} from '../../../util/test-util/testClient'
import { ZodValidationErrorResponse } from '../../../util/test-util/zodValidationErrorResponse'

describe('Test for POST /api/todos', () => {
  // 前提：認証済みユーザーが有効なデータで Todo を作成する。
  // 期待値：ステータスコード 201 と作成された Todo データが返される。
  it('Successfully create todo', async () => {
    // ユーザー情報をセットする。
    mockSetUserAuthMiddleware({ userId: 'test-user-1' })

    // テスト用の API クライアントを作成する。
    const client = await getTestClient()

    // Todo を作成する。
    const res = await client.api.todos.$post({
      json: {
        title: 'テストタスク',
        description: 'テスト用のタスクです',
      },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(201)

    // レスポンスデータを検証する。
    const data = await res.json()
    expect(data).toStrictEqual({
      id: expect.any(String),
      title: 'テストタスク',
      description: 'テスト用のタスクです',
      createdAt: expect.any(String),
      updatedAt: expect.any(String),
    })

    // DB の状態を検証する。
    const db = getTestDrizzleClient()
    const todoRecords = await db
      .select()
      .from(todos)
      .where(eq(todos.userId, 'test-user-1'))
      .all()

    // 新しく作成された Todo が存在することを確認する。
    expect(todoRecords.length).toBeGreaterThan(0)
    const newTodo = todoRecords[todoRecords.length - 1]
    expect(newTodo.title).toBe('テストタスク')
    expect(newTodo.description).toBe('テスト用のタスクです')
    expect(newTodo.userId).toBe('test-user-1')
  })

  // 前提：必須フィールドが不足している場合。
  // 期待値：ステータスコード 400 とエラーコードが返される。
  it('Returns 400 when required field is missing', async () => {
    // ユーザー情報をセットする。
    mockSetUserAuthMiddleware({ userId: 'test-user-1' })

    // テスト用の API クライアントを作成する。
    const client = await getTestClient()

    // 必須フィールドが不足した Todo を作成する。
    const res = await client.api.todos.$post({
      json: {
        title: '',  // 空文字
        description: 'テスト用のタスクです',
      },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(400)

    // Zod バリデーションエラーが返されることを確認する。
    const errorResponse = (await res.json()) as ZodValidationErrorResponse
    expect(errorResponse.success).toBe(false)
    expect(errorResponse.error.name).toBe('ZodError')
  })

  // 前提：タイトルが最大文字数を超えている場合。
  // 期待値：ステータスコード 400 とエラーコードが返される。
  it('Returns 400 when title exceeds maximum length', async () => {
    // ユーザー情報をセットする。
    mockSetUserAuthMiddleware({ userId: 'test-user-1' })

    // テスト用の API クライアントを作成する。
    const client = await getTestClient()

    // 101文字のタイトルを作成する。
    const longTitle = 'a'.repeat(101)

    // 最大文字数を超えたタイトルで Todo を作成する。
    const res = await client.api.todos.$post({
      json: {
        title: longTitle,
        description: 'テスト用のタスクです',
      },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(400)

    // Zod バリデーションエラーが返されることを確認する。
    const errorResponse = (await res.json()) as ZodValidationErrorResponse
    expect(errorResponse.success).toBe(false)
    expect(errorResponse.error.name).toBe('ZodError')
  })

  // 前提：説明が最大文字数を超えている場合。
  // 期待値：ステータスコード 400 とエラーコードが返される。
  it('Returns 400 when description exceeds maximum length', async () => {
    // ユーザー情報をセットする。
    mockSetUserAuthMiddleware({ userId: 'test-user-1' })

    // テスト用の API クライアントを作成する。
    const client = await getTestClient()

    // 501文字の説明を作成する。
    const longDescription = 'a'.repeat(501)

    // 最大文字数を超えた説明で Todo を作成する。
    const res = await client.api.todos.$post({
      json: {
        title: 'テストタスク',
        description: longDescription,
      },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(400)

    // Zod バリデーションエラーが返されることを確認する。
    const errorResponse = (await res.json()) as ZodValidationErrorResponse
    expect(errorResponse.success).toBe(false)
    expect(errorResponse.error.name).toBe('ZodError')
  })
}) 
