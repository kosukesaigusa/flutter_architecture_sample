/** ミドルウェアのエラーコード。 */
const MIDDLEWARE_ERROR_CODES = {
  AUTH: {
    /** ユーザー認証（ID トークンの取得・検証）に失敗した場合のエラーコード。 */
    USER_AUTH_ERROR: {
      code: 'middleware.auth.1',
      descriptionForOpenAPISpec: 'ユーザー認証に失敗しました。',
    },
  },
  /** ミドルウェアが要求するパラメータが設定されていない場合のエラーコード。 */
  PARAMETER: {
    /** パラメータが設定されていない場合のエラーコード。 */
    MIDDLEWARE: {
      code: 'middleware.parameter.1',
      descriptionForOpenAPISpec:
        'ミドルウェアが要求するパラメータが設定されていません。',
    },
  },
} as const

/** エンドポイントのエラーコード。 */
export const ENDPOINT_ERROR_CODES = {
  /** GET /api/todos のエラーコード。 */
  GET_TODOS: {
    /** Todo 一覧の取得に失敗した場合のエラーコード。 */
    FETCH_FAILED: {
      code: 'endpoint.getTodos.fetchFailed.1',
      descriptionForOpenAPISpec: 'Todo 一覧の取得に失敗しました。',
    },
  },
  /** POST /api/todos のエラーコード。 */
  CREATE_TODO: {
    /** Todo の作成に失敗した場合のエラーコード。 */
    FAILED: {
      code: 'endpoint.createTodo.failed.1',
      descriptionForOpenAPISpec: 'Todo の作成に失敗しました。',
    },
    /** Todo のデータが不正である場合のエラーコード。 */
    VALIDATION_ERROR: {
      code: 'endpoint.createTodo.validationError.1',
      descriptionForOpenAPISpec: 'Todo のデータが不正です。',
    },
  },
} as const

/** システム全体のエラーコード定義。 */
export const ERROR_CODES = {
  ...MIDDLEWARE_ERROR_CODES,
  ...ENDPOINT_ERROR_CODES,
} as const

/** エラーコードの型を生成。 */
type ErrorCodes = typeof ERROR_CODES

/** 各ハンドラーで使用するエラーコードの型を取得するユーティリティ型。 */
export type HandlerErrorCodes<T extends keyof ErrorCodes> = ErrorCodes[T]
