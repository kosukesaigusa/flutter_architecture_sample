/**
 * Zod のバリデーションエラーのレスポンスの型。
 */
export type ZodValidationErrorResponse = {
  success: boolean
  error: {
    name: string
    issues: unknown[]
  }
}
