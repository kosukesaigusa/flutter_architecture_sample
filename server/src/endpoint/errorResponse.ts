import type { OpenAPIV3 } from 'openapi-types'

/**
 * エラーコードの型定義。
 */
export type ErrorCode = {
  /** エラーコード。 */
  code: string

  /** OpenAPI ドキュメントに記述するためのエラーコードの説明。 */
  descriptionForOpenAPISpec: string
}

/**
 * エラーコードのマップの型定義。
 */
export type ErrorCodesMap<T extends string = string> = {
  [K in T]: ErrorCode
}

/**
 * API エラーを表すカスタムエラークラス。
 */
export class AppHTTPException extends Error {
  /**
   * エラーコード。
   */
  readonly code: string

  /**
   * コンストラクタ。
   *
   * @param code エラーコード。
   */
  constructor(code: string) {
    super(`API Error: ${code}`)
    this.code = code
    this.name = 'AppHTTPException'
  }
}

/**
 * OpenAPI ドキュメントに記述するエラーレスポンスを返す。
 *
 * @param errorCodes エラーコードと説明のマッピング。
 * @returns OpenAPI ドキュメントに記述するエラーレスポンス。
 */
export function getErrorResponseForOpenAPISpec(
  errorCodes: ErrorCodesMap,
): OpenAPIV3.ResponseObject {
  // エラーコードの説明を生成する。
  const errorCodeDescription = Object.entries(errorCodes)
    .map(
      ([key, errorCode]) =>
        `- ${errorCode.code}: ${key} - ${errorCode.descriptionForOpenAPISpec}`,
    )
    .join('\n')

  return {
    description: 'エラー',
    content: {
      'application/json': {
        schema: {
          type: 'object',
          properties: {
            error: {
              type: 'object',
              properties: {
                code: {
                  type: 'string',
                  enum: Object.values(errorCodes).map(
                    (errorCode) => errorCode.code,
                  ),
                  description: `エラーコード。以下の値が使用されます：\n${errorCodeDescription}`,
                },
              },
              required: ['code'],
            },
          },
          required: ['error'],
        },
      },
    },
  }
}
