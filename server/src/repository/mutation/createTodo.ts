import { getContext } from 'hono/context-storage'
import { type Result, err, ok } from 'neverthrow'
import { ulid } from 'ulidx'
import type { EnvironmentVariables } from '../../env'
import { todos } from '../../schema'
import { eq } from 'drizzle-orm'

/** Todo を作成する際のパラメータ。 */
type RepositoryParams = {
  title: string
  description: string
  userId: string
}

/** Todo の作成結果。 */
type RepositoryResult = {
  id: string
  title: string
  description: string
  userId: string
  createdAt: Date
  updatedAt: Date
}

/**
 * 新しい Todo を作成する。
 * @param params - パラメータ。
 * @returns 作成された Todo の情報。
 */
export const createTodo = async (
  params: RepositoryParams,
): Promise<Result<RepositoryResult, Error>> => {
  const c = getContext<EnvironmentVariables>()
  const db = c.var.db
  const logger = c.get('logger')

  try {
    // 新しい ID を生成する。
    const id = ulid()

    // Todo を作成する。
    await db.insert(todos).values({
      todoId: id,
      title: params.title,
      description: params.description,
      userId: params.userId,
    })

    // 作成した Todo を取得する。
    const createdTodo = await db
      .select()
      .from(todos)
      .where(eq(todos.todoId, id))
      .get()

    // 作成に失敗した場合はエラーを返す。
    if (!createdTodo) {
      return err(new Error(`Todo の作成に失敗しました: ${params.title}`))
    }

    // 作成した Todo の情報を返す。
    const result: RepositoryResult = {
      id: createdTodo.todoId,
      title: createdTodo.title,
      description: createdTodo.description,
      userId: createdTodo.userId,
      createdAt: new Date(createdTodo.createdAt),
      updatedAt: new Date(createdTodo.updatedAt),
    }

    return ok(result)
  } catch (error) {
    // エラーログを出力する。
    logger.error(`Todo の作成に失敗しました: ${error}`)
    return err(new Error(`Todo の作成に失敗しました: ${params.title}`))
  }
}
