import { createApp } from './util/factory'
import { getHealthCheckHandlers } from './endpoint/handler/getHealthCheckHandlers'
import { createTodoHandlers } from './endpoint/handler/todo/createTodoHandler'
import { getTodosHandlers } from './endpoint/handler/todo/getTodosHandler'

const app = createApp()

const routes = app
  // アプリケーションの疎通確認用のハンドラ。
  .get('/', ...getHealthCheckHandlers)
  // ファビコンのリクエストに対しては 204 を返す。
  .get('/favicon.ico', () => new Response(null, { status: 204 }))
  // Todo 一覧を取得する。
  .get('/api/todos', ...getTodosHandlers)
  // Todo を作成する。
  .post('/api/todos', ...createTodoHandlers)

  export default routes
