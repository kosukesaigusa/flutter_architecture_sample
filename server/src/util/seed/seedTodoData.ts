import * as schema from '../../schema'
import { TODO_DATA } from './data/todoData'
import { getUserId } from './data/userIds'
import type { DatabaseForSeed } from './databaseForSeed'

/**
 * Todo データをシードするためのパラメータ。
 */
type SeedTodoDataParam = {
  /** データベースインスタンス。 */
  db: DatabaseForSeed
  /** ユーザー ID を Firebase Auth に存在するユーザーで上書きするかどうか。 */
  overrideUserId: boolean
}

/**
 * Todo データをシードする。
 *
 * @param param.db データベースインスタンス。
 * @param param.overrideUserId ユーザー ID を Firebase Auth に存在するユーザーで上書きするかどうか。
 */
export const seedTodoData = async (param: SeedTodoDataParam) => {
  const { db, overrideUserId } = param

  // Todo データを作成する。
  const todoData = TODO_DATA.map((todo) => ({
    todoId: todo.todoId,
    title: todo.title,
    description: todo.description,
    userId: getUserId({ defaultId: todo.userId, overrideUserId }),
  }))

  // 一度に挿入すると D1 の変数制限に抵触するため、1件ずつ挿入する。
  for (const todo of todoData) {
    await db.insert(schema.todos).values(todo)
  }
}
