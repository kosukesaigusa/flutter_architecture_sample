import { type Result, err, ok } from 'neverthrow'
import { getTodosByUserId } from '../../repository/query/getTodosByUserId'

/** UseCase のパラメータ型の定義。 */
type UseCaseParams = {
  userId: string
}

/** UseCase の戻り値型の定義。 */
type UseCaseResult = {
  id: string
  title: string
  description: string
  createdAt: string
  updatedAt: string
}

/** UseCase で発生するエラー型の定義。 */
type UseCaseError = {
  type: 'TODO_FETCH_FAILED'
  message: 'Todo の取得に失敗しました'
}

/**
 * Todo 一覧を取得する UseCase.
 * @param params - パラメータ。
 * @returns Todo 一覧。
 */
export const fetchTodosUseCase = async (
  params: UseCaseParams,
): Promise<Result<UseCaseResult[], UseCaseError>> => {
  // Repository を呼び出してデータを取得する。
  const repositoryResult = await getTodosByUserId({ userId: params.userId })

  // Repository のエラーを UseCase のエラーに変換する。
  if (repositoryResult.isErr()) {
    return err({
      type: 'TODO_FETCH_FAILED',
      message: 'Todo の取得に失敗しました',
    })
  }

  // データを UseCase の戻り値形式に変換する。
  const todos = repositoryResult.value.map((todo) => ({
    id: todo.id,
    title: todo.title,
    description: todo.description,
    createdAt: todo.createdAt.toISOString(),
    updatedAt: todo.updatedAt.toISOString(),
  }))

  return ok(todos)
}
