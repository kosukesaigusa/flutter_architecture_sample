import { desc, eq } from 'drizzle-orm'
import { getContext } from 'hono/context-storage'
import { type Result, err, ok } from 'neverthrow'
import type { EnvironmentVariables } from '../../env'
import { todos } from '../../schema'

/** Todo を取得する際のパラメータ。 */
type RepositoryParams = {
  userId: string
}

/** Todo の取得結果。 */
type RepositoryResult = {
  id: string
  title: string
  description: string
  userId: string
  createdAt: Date
  updatedAt: Date
}

/**
 * 指定したユーザー ID の Todo 一覧を取得する。
 * @param params - パラメータ。
 * @returns Todo 一覧。
 */
export const getTodosByUserId = async (
  params: RepositoryParams,
): Promise<Result<RepositoryResult[], Error>> => {
  const c = getContext<EnvironmentVariables>()
  const db = c.var.db
  const logger = c.get('logger')

  try {
    // Todo 一覧を取得する（作成日時の降順）。
    const result = await db
      .select({
        id: todos.todoId,
        title: todos.title,
        description: todos.description,
        userId: todos.userId,
        createdAt: todos.createdAt,
        updatedAt: todos.updatedAt,
      })
      .from(todos)
      .where(eq(todos.userId, params.userId))
      .orderBy(desc(todos.createdAt))
      .all()

    // ISO 8601 文字列を Date 型に変換して返す。
    const convertedResult = result.map((todo) => ({
      ...todo,
      createdAt: new Date(todo.createdAt),
      updatedAt: new Date(todo.updatedAt),
    }))

    return ok(convertedResult)
  } catch (error) {
    // エラーログを出力する。
    logger.error(`Todo 一覧の取得に失敗しました: ${error}`)
    return err(new Error(`Todo 一覧の取得に失敗しました: ${params.userId}`))
  }
}
