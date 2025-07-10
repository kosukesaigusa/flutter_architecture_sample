import { type Result, err, ok } from 'neverthrow'
import { createTodo } from '../../repository/mutation/createTodo'

/** UseCase のパラメータ型の定義。 */
type UseCaseParams = {
  userId: string
  title: string
  description: string
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
type UseCaseError =
  | {
      type: 'TODO_CREATE_FAILED'
      message: 'Todo の作成に失敗しました'
    }
  | {
      type: 'TODO_VALIDATION_ERROR'
      message: 'Todo のデータが不正です'
    }

/**
 * Todo を作成する UseCase.
 * @param params - パラメータ。
 * @returns 作成された Todo の情報。
 */
export const createTodoUseCase = async (
  params: UseCaseParams,
): Promise<Result<UseCaseResult, UseCaseError>> => {
  // 入力値のバリデーションを行う。
  if (!params.title.trim()) {
    return err({
      type: 'TODO_VALIDATION_ERROR',
      message: 'Todo のデータが不正です',
    })
  }

  if (params.title.length > 100) {
    return err({
      type: 'TODO_VALIDATION_ERROR',
      message: 'Todo のデータが不正です',
    })
  }

  if (params.description.length > 500) {
    return err({
      type: 'TODO_VALIDATION_ERROR',
      message: 'Todo のデータが不正です',
    })
  }

  // Repository を呼び出してデータを作成する。
  const repositoryResult = await createTodo({
    title: params.title.trim(),
    description: params.description.trim(),
    userId: params.userId,
  })

  // Repository のエラーを UseCase のエラーに変換する。
  if (repositoryResult.isErr()) {
    return err({
      type: 'TODO_CREATE_FAILED',
      message: 'Todo の作成に失敗しました',
    })
  }

  // データを UseCase の戻り値形式に変換する。
  const todo = repositoryResult.value
  const result: UseCaseResult = {
    id: todo.id,
    title: todo.title,
    description: todo.description,
    createdAt: todo.createdAt.toISOString(),
    updatedAt: todo.updatedAt.toISOString(),
  }

  return ok(result)
}
