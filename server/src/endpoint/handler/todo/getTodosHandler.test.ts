import { describe, expect, it } from 'vitest'
import { todos } from '../../../schema'
import { mockSetUserAuthMiddleware } from '../../../util/test-util/mockSetUserAuthMiddleware'
import {
  getTestClient,
  getTestDrizzleClient,
} from '../../../util/test-util/testClient'

describe('Test for GET /api/todos', () => {
  // 前提：認証済みユーザーが Todo 一覧を取得する。
  // 期待値：ステータスコード 200 と Todo 一覧が返される。
  it('Successfully get todos', async () => {
    // ユーザー情報をセットする。
    mockSetUserAuthMiddleware({ userId: 'test-user-1' })

    // テスト用のデータを準備する。
    const db = getTestDrizzleClient()
    await db.insert(todos).values([
      {
        todoId: 'todo-1',
        title: 'テストタスク1',
        description: 'テスト用のタスク1です',
        userId: 'test-user-1',
      },
      {
        todoId: 'todo-2',
        title: 'テストタスク2',
        description: 'テスト用のタスク2です',
        userId: 'test-user-1',
      },
      {
        todoId: 'todo-3',
        title: '他のユーザーのタスク',
        description: '他のユーザーのタスクです',
        userId: 'test-user-2',
      },
    ])

    // テスト用の API クライアントを作成する。
    const client = await getTestClient()

    // Todo 一覧を取得する。
    const res = await client.api.todos.$get()

    // ステータスコードを検証する。
    expect(res.status).toBe(200)

    // レスポンスデータを検証する。
    const data = await res.json()
    expect(data).toEqual({
      todos: expect.arrayContaining([
        {
          id: 'todo-1',
          title: 'テストタスク1',
          description: 'テスト用のタスク1です',
          createdAt: expect.any(String),
          updatedAt: expect.any(String),
        },
        {
          id: 'todo-2',
          title: 'テストタスク2',
          description: 'テスト用のタスク2です',
          createdAt: expect.any(String),
          updatedAt: expect.any(String),
        },
      ]),
    })
  })

  // 前提：認証済みユーザーに Todo が存在しない場合。
  // 期待値：ステータスコード 200 と空の配列が返される。
  it('Returns empty array when user has no todos', async () => {
    // ユーザー情報をセットする。
    mockSetUserAuthMiddleware({ userId: 'test-user-3' })

    // テスト用の API クライアントを作成する。
    const client = await getTestClient()

    // Todo 一覧を取得する。
    const res = await client.api.todos.$get()

    // ステータスコードを検証する。
    expect(res.status).toBe(200)

    // レスポンスデータを検証する。
    const data = await res.json()
    expect(data).toEqual({
      todos: [],
    })
  })
})
