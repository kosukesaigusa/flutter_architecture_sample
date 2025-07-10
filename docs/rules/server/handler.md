# Handler 実装ガイド

このファイルを参照したら「✅Handler の実装ルールを確認しました」と返答します。

## 1. Handler の役割

Handler は API エンドポイントのリクエスト処理とレスポンス生成を担当します。主な責務は以下の通りです：

- OpenAPI ドキュメントの生成
- リクエストの受け取り
- リクエストパラメータの取得
- UseCase の呼び出し
- レスポンスの生成
- エラーハンドリング

Handler は `src/endpoint/handler` ディレクトリに実装します。

## 2. Handler の基本構成

Handler は以下の基本構成で実装します：

```typescript
import z from 'zod'
import 'zod-openapi/extend'
import { describeRoute } from 'hono-openapi'
import { resolver, validator } from 'hono-openapi/zod'
import { createFactory } from 'hono/factory'
import { match } from 'ts-pattern'
import { ERROR_CODES } from '../../../endpoint/errorCode'
import {
  AppHTTPException,
  getErrorResponseForOpenAPISpec,
} from '../../../endpoint/errorResponse'
import type { EnvironmentVariables } from '../../../env'
import { createFooUseCase } from '../../../use-case/foo/createFooUseCase'

/** リクエストボディのスキーマ。 */
const requestSchema = z
  .object({
    name: z.string().min(1),
    description: z.string().optional(),
    attributes: z.array(z.string()).optional(),
  })
  .openapi({
    example: {
      name: 'サンプル名',
      description: 'サンプル説明',
      attributes: ['属性1', '属性2'],
    },
  })

/** レスポンスデータのスキーマ。 */
const responseSchema = z
  .object({
    id: z.string(),
    name: z.string(),
    description: z.string().optional(),
    attributes: z.array(z.string()).optional(),
    createdAt: z.string(),
    updatedAt: z.string(),
  })
  .openapi({
    example: {
      id: 'foo-1',
      name: 'サンプル名',
      description: 'サンプル説明',
      attributes: ['属性1', '属性2'],
      createdAt: '2023-01-01T00:00:00.000Z',
      updatedAt: '2023-01-01T00:00:00.000Z',
    },
  })

/**
 * Foo リソースを作成する Handler.
 * 
 * @returns 作成された Foo リソースの情報を返却する。
 */
export const createFooHandlers = 
  createFactory<EnvironmentVariables>().createHandlers(
    describeRoute({
      tags: ['foo'],
      summary: 'Foo リソースを作成する',
      description: ENDPOINT_DEVELOPMENT_STATUS.IMPLEMENTED.displayText,
      responses: {
        200: {
          description: 'Foo リソースの作成に成功',
          content: {
            'application/json': {
              schema: resolver(responseSchema),
            },
          },
        },
        400: getErrorResponseForOpenAPISpec(ERROR_CODES.CREATE_FOO),
      },
    }),
    validator('param', z.object({ barId: z.string() })),
    validator('json', requestSchema),
    async (c) => {
      // バリデーション済みのリクエストパラメータを取得する。
      const userId = c.get('userId')
      const { barId } = c.req.valid('param')

      // バリデーション済みのリクエストボディを取得する。
      const data = c.req.valid('json')
      
      // UseCase を呼び出す。
      const result = await createFooUseCase({
        userId,
        barId,
        name: data.name,
        description: data.description,
        attributes: data.attributes,
      })
      
      // エラーが発生した場合は、エラーの種類を網羅的にマッチングし、
      // 対応するエラーコード AppHTTPException に設定してスローする。
      if (result.isErr()) {
        const error = result.error
        match(error)
          .with({ type: 'USER_FETCH_ERROR' }, () => {
            throw new AppHTTPException(ERROR_CODES.CREATE_FOO.FETCH_ERROR.code)
          })
          .with({ type: 'USER_NOT_FOUND' }, () => {
            throw new AppHTTPException(ERROR_CODES.CREATE_FOO.NOT_FOUND.code)
          })
          .with({ type: 'USER_VALIDATION_ERROR' }, () => {
            throw new AppHTTPException(ERROR_CODES.CREATE_FOO.VALIDATION_ERROR.code)
          })
          .exhaustive()
        return
      }
      
      // レスポンスデータをバリデーションする。
      const validatedResponse = responseSchema.parse(result.value)
      
      // レスポンスを生成する。
      return c.json(validatedResponse)
    },
  )
```

## 3. Handler の実装パターン

### 3.1 取得系の Handler

取得系の Handler は以下のパターンで実装します：

```typescript
import z from 'zod'
import 'zod-openapi/extend'
import { describeRoute } from 'hono-openapi'
import { resolver, validator } from 'hono-openapi/zod'
import { createFactory } from 'hono/factory'
import { match } from 'ts-pattern'
import { ERROR_CODES } from '../../../endpoint/errorCode'
import {
  AppHTTPException,
  getErrorResponseForOpenAPISpec,
} from '../../../endpoint/errorResponse'
import type { EnvironmentVariables } from '../../../env'
import { getFoosUseCase } from '../../../use-case/foo/getFoosUseCase'

/** レスポンスデータのスキーマ。 */
const responseSchema = z
  .object({
    items: z.array(
      z.object({
        id: z.string(),
        name: z.string(),
        description: z.string().optional(),
        attributes: z.array(z.string()).optional(),
        createdAt: z.string(),
        updatedAt: z.string(),
      }),
    ),
  })
  .openapi({
    example: {
      items: [
        {
          id: 'foo-1',
          name: 'サンプル名',
          description: 'サンプル説明',
          attributes: ['属性1', '属性2'],
          createdAt: '2023-01-01T00:00:00.000Z',
          updatedAt: '2023-01-01T00:00:00.000Z',
        },
      ],
    },
  })

/**
 * Foo リソース一覧を取得する Handler.
 * 
 * @returns Foo リソース一覧を返却する。
 */
export const getFoosHandlers = 
  createFactory<EnvironmentVariables>().createHandlers(
    describeRoute({
      tags: ['foo'],
      summary: 'Foo リソース一覧を取得する',
      description: ENDPOINT_DEVELOPMENT_STATUS.IMPLEMENTED.displayText,
      responses: {
        200: {
          description: 'Foo リソース一覧の取得に成功',
          content: {
            'application/json': {
              schema: resolver(responseSchema),
            },
          },
        },
        400: getErrorResponseForOpenAPISpec(ERROR_CODES.GET_FOOS),
      },
    }),
    validator('param', z.object({ barId: z.string() })),
    async (c) => {
      // バリデーション済みのリクエストパラメータを取得する。
      const userId = c.get('userId')
      const { barId } = c.req.valid('param')
      
      // UseCase を呼び出す。
      const result = await getFoosUseCase({
        userId,
        barId,
      })
      
      // エラーが発生した場合は、エラーの種類を網羅的にマッチングし、
      // 対応するエラーコード AppHTTPException に設定してスローする。
      if (result.isErr()) {
        const error = result.error
        match(error)
          .with({ type: 'USER_FETCH_ERROR' }, () => {
            throw new AppHTTPException(ERROR_CODES.GET_FOOS.FETCH_ERROR.code)
          })
          .with({ type: 'USER_NOT_FOUND' }, () => {
            throw new AppHTTPException(ERROR_CODES.GET_FOOS.NOT_FOUND.code)
          })
          .exhaustive()
        return
      }

      // レスポンスデータを作成する。
      const responseData = {
        items: result.value,
      }
      
      // レスポンスデータをバリデーションする。
      const validatedResponse = responseSchema.parse(responseData)

      // レスポンスを生成する。
      return c.json(validatedResponse)
    },
  )
```

### 3.2 作成・更新系の Handler

作成・更新系の Handler は以下のパターンで実装します：

```typescript
import z from 'zod'
import 'zod-openapi/extend'
import { describeRoute } from 'hono-openapi'
import { resolver, validator } from 'hono-openapi/zod'
import { createFactory } from 'hono/factory'
import { match } from 'ts-pattern'
import { ERROR_CODES } from '../../../endpoint/errorCode'
import {
  AppHTTPException,
  getErrorResponseForOpenAPISpec,
} from '../../../endpoint/errorResponse'
import type { EnvironmentVariables } from '../../../env'
import { createFooUseCase } from '../../../use-case/foo/createFooUseCase'

/** リクエストボディのスキーマ。 */
const requestSchema = z
  .object({
    name: z.string().min(1),
    description: z.string().optional(),
    attributes: z.array(z.string()).optional(),
  })
  .openapi({
    example: {
      name: 'サンプル名',
      description: 'サンプル説明',
      attributes: ['属性1', '属性2'],
    },
  })

/** レスポンスデータのスキーマ。 */
const responseSchema = z
  .object({
    id: z.string(),
    name: z.string(),
    description: z.string().optional(),
    attributes: z.array(z.string()).optional(),
    createdAt: z.string(),
    updatedAt: z.string(),
  })
  .openapi({
    example: {
      id: 'foo-1',
      name: 'サンプル名',
      description: 'サンプル説明',
      attributes: ['属性1', '属性2'],
      createdAt: '2023-01-01T00:00:00.000Z',
      updatedAt: '2023-01-01T00:00:00.000Z',
    },
  })

/**
 * Foo リソースを作成する Handler.
 * 
 * @returns 作成された Foo リソースの情報を返却する。
 */
export const createFooHandlers = 
  createFactory<EnvironmentVariables>().createHandlers(
    describeRoute({
      tags: ['foo'],
      summary: 'Foo リソースを作成する',
      description: ENDPOINT_DEVELOPMENT_STATUS.IMPLEMENTED.displayText,
      responses: {
        200: {
          description: 'Foo リソースの作成に成功',
          content: {
            'application/json': {
              schema: resolver(responseSchema),
            },
          },
        },
        400: getErrorResponseForOpenAPISpec(ERROR_CODES.CREATE_FOO),
      },
    }),
    validator('param', z.object({ barId: z.string() })),
    validator('json', requestSchema),
    async (c) => {
      // バリデーション済みのリクエストパラメータを取得する。
      const userId = c.get('userId')
      const { barId } = c.req.valid('param')

      // バリデーション済みのリクエストボディを取得する。
      const data = c.req.valid('json')
      
      // UseCase を呼び出す。
      const result = await createFooUseCase({
        userId,
        barId,
        name: data.name,
        description: data.description,
        attributes: data.attributes,
      })
      
      // エラーが発生した場合は、エラーの種類を網羅的にマッチングし、
      // 対応するエラーコード AppHTTPException に設定してスローする。
      if (result.isErr()) {
        const error = result.error
        match(error)
          .with({ type: 'USER_FETCH_ERROR' }, () => {
            throw new AppHTTPException(ERROR_CODES.CREATE_FOO.FETCH_ERROR.code)
          })
          .with({ type: 'USER_NOT_FOUND' }, () => {
            throw new AppHTTPException(ERROR_CODES.CREATE_FOO.NOT_FOUND.code)
          })
          .with({ type: 'USER_VALIDATION_ERROR' }, () => {
            throw new AppHTTPException(ERROR_CODES.CREATE_FOO.VALIDATION_ERROR.code)
          })
          .exhaustive()
        return
      }
      
      // レスポンスデータをバリデーションする。
      const validatedResponse = responseSchema.parse(result.value)
      
      // レスポンスを生成する。
      return c.json(validatedResponse)
    },
  )
```

## 4. エラーハンドリング

Handler でのエラーハンドリングは `ts-pattern` の `match` を使用して、以下のパターンで実装します：

```typescript
import { match } from 'ts-pattern'

// エラーが発生した場合は、エラーの種類を網羅的にマッチングし、
// 対応するエラーコード AppHTTPException に設定してスローする。
if (result.isErr()) {
  const error = result.error
  match(error)
    .with({ type: 'USER_FETCH_ERROR' }, () => {
      throw new AppHTTPException(ERROR_CODES.CREATE_FOO.FETCH_ERROR.code)
    })
    .with({ type: 'USER_NOT_FOUND' }, () => {
      throw new AppHTTPException(ERROR_CODES.CREATE_FOO.NOT_FOUND.code)
    })
    .with({ type: 'USER_VALIDATION_ERROR' }, () => {
      throw new AppHTTPException(ERROR_CODES.CREATE_FOO.VALIDATION_ERROR.code)
    })
    .exhaustive()
  return
}
```

### 4.1 エラーハンドリングの特徴

- `ts-pattern` の `match` を使用して、UseCase から返却されるエラーを網羅的にハンドリングする
- `.exhaustive()` を使用することで、すべてのエラーケースを網羅していることを型レベルで保証する
- UseCase のエラー型と HTTP エラーコードの対応関係を視覚的に分かりやすく表現する
- エラーハンドリングのロジックを集約し、保守性を高める

### 4.2 エラーレスポンス

エラーレスポンスは、ミドルウェアによって自動的に以下の形式で生成されます：

```typescript
{
  error: {
    code: string  // ERROR_CODES から適切なコードを使用する。
  }
}
```

## 5. Handler のテスト実装

### 5.1 テストの基本方針

Handler のテストは以下の方針で実装します：

- **UseCase はモックしない**: 実際のビジネスロジックを通してテストする
- **外部依存のみモック**: R2 アップロード、外部 API 呼び出しなどの外部依存のみをモックする
- **DB の状態も検証**: テスト後にデータベースの状態を確認して、期待通りのデータが保存されているかを検証する
- **エンドツーエンドテスト**: リクエストからレスポンスまでの一連の流れをテストする

### 5.2 基本的なテスト構成

```typescript
import { eq } from 'drizzle-orm'
import { err, ok } from 'neverthrow'
import { describe, expect, it, vi, beforeEach } from 'vitest'
import { mockSetUserAuthMiddleware } from '../../../util/test-util/mockSetUserAuthMiddleware'
import {
  getTestClient,
  getTestDrizzleClient,
} from '../../../util/test-util/testClient'

// 外部依存関数をモック化する。
vi.mock('../../../repository/mutation/externalFunction', () => ({
  externalFunction: vi.fn(),
}))

// モック関数として型を指定する。
const mockExternalFunction = vi.mocked(externalFunction)

describe('Test for POST /api/example', () => {
  beforeEach(() => {
    // 各テストの前にモックをリセットする。
    mockExternalFunction.mockReset()
  })

  // 前提：正常なリクエストでリソースを作成する。
  // 期待値：ステータスコード 200 と作成されたリソース ID が返される。
  it('Successfully create resource', async () => {
    // 外部依存のモックを成功に設定する。
    mockExternalFunction.mockResolvedValueOnce(ok(undefined))

    // 認証ユーザーを設定する。
    mockSetUserAuthMiddleware({ userId: 'user-1' })

    // テストクライアントを作成する。
    const client = await getTestClient()

    // リソースを作成する。
    const res = await client.api.example.$post({
      json: {
        name: 'テストリソース',
        description: 'テスト用のリソース',
      },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(200)

    // レスポンスデータを検証する。
    const data = await res.json()
    expect(data).toStrictEqual({
      id: expect.any(String),
      name: 'テストリソース',
      description: 'テスト用のリソース',
      createdAt: expect.any(String),
      updatedAt: expect.any(String),
    })

    // DB の状態を検証する。
    const db = getTestDrizzleClient()
    const records = await db
      .select()
      .from(resources)
      .where(eq(resources.name, 'テストリソース'))
      .all()

    // 新しく作成されたリソースが存在することを確認する。
    expect(records.length).toBe(1)
    const newRecord = records[0]
    expect(newRecord.name).toBe('テストリソース')
    expect(newRecord.description).toBe('テスト用のリソース')

    // 外部依存が適切なパラメータで呼び出されたことを確認する。
    expect(mockExternalFunction).toHaveBeenCalledWith({
      param1: expect.any(String),
      param2: expect.any(String),
    })
  })
})
```

### 5.3 R2 アップロード関数のモック

R2 アップロードを使用する Handler のテストでは、以下のパターンでモックします：

#### 5.3.1 カテゴリ投稿アップロードのテスト例

```typescript
import { eq } from 'drizzle-orm'
import { err, ok } from 'neverthrow'
import { describe, expect, it, vi, beforeEach } from 'vitest'
import { uploadCategoryPostToR2 } from '../../../repository/mutation/uploadFileToR2'
import { groups, posts } from '../../../schema'
import { mockSetUserAuthMiddleware } from '../../../util/test-util/mockSetUserAuthMiddleware'
import {
  getTestClient,
  getTestDrizzleClient,
} from '../../../util/test-util/testClient'

// uploadCategoryPostToR2 関数をモック化する。
vi.mock('../../../repository/mutation/uploadFileToR2', () => ({
  uploadCategoryPostToR2: vi.fn(),
}))

// モック関数として型を指定する。
const mockUploadCategoryPostToR2 = vi.mocked(uploadCategoryPostToR2)

describe('Test for POST /api/groups/:groupId/categories/:categoryId/posts', () => {
  beforeEach(() => {
    // 各テストの前にモックをリセットする。
    mockUploadCategoryPostToR2.mockReset()
  })

  // 前提：認証済みユーザーが有効なパラメータで投稿をアップロードする。
  // 期待値：ステータスコード 200 とアップロードされた投稿 ID が返される。
  it('Successfully upload post to category', async () => {
    // uploadCategoryPostToR2 のモックを成功に設定する。
    mockUploadCategoryPostToR2.mockResolvedValueOnce(ok(undefined))

    // 認証ユーザーを設定する。
    mockSetUserAuthMiddleware({ userId: 'family-1-admin-1' })

    // テストクライアントを作成する。
    const client = await getTestClient()

    // テスト用の画像ファイルを作成する。
    const imageData = new Uint8Array([
      0xff, 0xd8, 0xff, 0xe0, 0x00, 0x10, 0x4a, 0x46, 0x49, 0x46,
    ])
    const file = new File([imageData], 'test-image.jpg', {
      type: 'image/jpeg',
    })

    // メディアをアップロードする。
    const res = await client.api.families[':familyId'].folders[
      ':folderId'
    ].medias.$post({
      param: {
        familyId: 'family-1',
        folderId: 'family-1-folder-1',
      },
      form: {
        file: file,
        takenAt: '2024-01-01T00:00:00.000Z',
        duration: '30',
      },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(200)

    // レスポンスデータを検証する。
    const data = await res.json()
    expect(data).toStrictEqual({
      postId: expect.any(String),
    })

    // DB の状態を検証する。
    const db = getTestDrizzleClient()
    const postRecords = await db
      .select()
      .from(posts)
      .where(eq(posts.categoryId, 'group-1-category-1'))
      .all()

    // 新しく作成された投稿が存在することを確認する。
    expect(postRecords.length).toBeGreaterThan(0)
    const newPost = postRecords[postRecords.length - 1]
    expect(newPost.groupId).toBe('group-1')
    expect(newPost.categoryId).toBe('group-1-category-1')
    expect(newPost.contentType).toBe('image/jpeg')

    // uploadCategoryPostToR2 が適切なパラメータで呼び出されたことを確認する。
    expect(mockUploadCategoryPostToR2).toHaveBeenCalledWith({
      groupId: 'group-1',
      categoryId: 'group-1-category-1',
      r2Filename: expect.any(String),
      fileData: expect.any(ArrayBuffer),
      contentType: 'image/jpeg',
    })
  })

  // 前提：R2 アップロードに失敗する場合。
  // 期待値：ステータスコード 400 とエラーコードが返される。
  it('Returns 400 when R2 upload fails', async () => {
    // uploadFolderMediaToR2 のモックを失敗に設定する。
    mockUploadFolderMediaToR2.mockResolvedValueOnce(
      err(new Error('R2 upload failed')),
    )

    // 認証ユーザーを設定する。
    mockSetUserAuthMiddleware({ userId: 'family-1-admin-1' })

    // テストクライアントを作成する。
    const client = await getTestClient()

    // テスト用の画像ファイルを作成する。
    const imageData = new Uint8Array([
      0xff, 0xd8, 0xff, 0xe0, 0x00, 0x10, 0x4a, 0x46, 0x49, 0x46,
    ])
    const file = new File([imageData], 'test-image.jpg', {
      type: 'image/jpeg',
    })

    // メディアをアップロードする。
    const res = await client.api.families[':familyId'].folders[
      ':folderId'
    ].medias.$post({
      param: {
        familyId: 'family-1',
        folderId: 'family-1-folder-1',
      },
      form: {
        file: file,
        takenAt: '2024-01-01T00:00:00.000Z',
      },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(400)

    // エラーレスポンスを検証する。
    const error = await res.json()
    expect(error).toEqual({
      error: {
        code: 'post.family.folder-media.8',
      },
    })
  })

  // 前提：ストレージ制限を超える場合。
  // 期待値：ステータスコード 400 とエラーコードが返される。
  it('Returns 400 when storage limit exceeded', async () => {
    // uploadFolderMediaToR2 のモックを成功に設定する。
    mockUploadFolderMediaToR2.mockResolvedValueOnce(ok(undefined))

    // 認証ユーザーを設定する。
    mockSetUserAuthMiddleware({ userId: 'family-1-admin-1' })

    // テストクライアントを作成する。
    const client = await getTestClient()

    // ストレージ制限を超える状況を作成する。
    const db = getTestDrizzleClient()
    await db
      .update(families)
      .set({ storageUsage: 10737418240 - 500000 }) // 500KB の余裕を残す
      .where(eq(families.familyId, 'family-1'))

    // 大きなファイルを作成する。
    const largeImageData = new Uint8Array(1000000) // 1MB のファイル
    const file = new File([largeImageData], 'large-image.jpg', {
      type: 'image/jpeg',
    })

    // メディアをアップロードする。
    const res = await client.api.families[':familyId'].folders[
      ':folderId'
    ].medias.$post({
      param: {
        familyId: 'family-1',
        folderId: 'family-1-folder-1',
      },
      form: {
        file: file,
        takenAt: '2024-01-01T00:00:00.000Z',
      },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(400)

    // エラーレスポンスを検証する。
    const error = await res.json()
    expect(error).toEqual({
      error: {
        code: 'post.family.folder-media.3',
      },
    })
  })
})
```

#### 5.3.2 子ども AI 参照画像アップロードのテスト例

```typescript
import { eq } from 'drizzle-orm'
import { err, ok } from 'neverthrow'
import { describe, expect, it, vi, beforeEach } from 'vitest'
import { uploadChildAiReferenceImageToR2 } from '../../../repository/mutation/uploadFileToR2'
import { childAiReferenceImages } from '../../../schema'
import { mockSetUserAuthMiddleware } from '../../../util/test-util/mockSetUserAuthMiddleware'
import {
  getTestClient,
  getTestDrizzleClient,
} from '../../../util/test-util/testClient'

// uploadChildAiReferenceImageToR2 関数をモック化する。
vi.mock('../../../repository/mutation/uploadFileToR2', () => ({
  uploadChildAiReferenceImageToR2: vi.fn(),
}))

// モック関数として型を指定する。
const mockUploadChildAiReferenceImageToR2 = vi.mocked(uploadChildAiReferenceImageToR2)

describe('Test for POST /api/families/:familyId/children/:childId/ai-reference-images', () => {
  beforeEach(() => {
    // 各テストの前にモックをリセットする。
    mockUploadChildAiReferenceImageToR2.mockReset()
  })

  // 前提：認証済みユーザーが有効なパラメータで AI 参照画像をアップロードする。
  // 期待値：ステータスコード 200 とアップロードされた画像 ID が返される。
  it('Successfully upload AI reference image', async () => {
    // uploadChildAiReferenceImageToR2 のモックを成功に設定する。
    mockUploadChildAiReferenceImageToR2.mockResolvedValueOnce(ok(undefined))

    // 認証ユーザーを設定する。
    mockSetUserAuthMiddleware({ userId: 'family-1-admin-1' })

    // テストクライアントを作成する。
    const client = await getTestClient()

    // テスト用の画像ファイルを作成する。
    const imageData = new Uint8Array([
      0xff, 0xd8, 0xff, 0xe0, 0x00, 0x10, 0x4a, 0x46, 0x49, 0x46,
    ])
    const file = new File([imageData], 'child-photo.jpg', {
      type: 'image/jpeg',
    })

    // AI 参照画像をアップロードする。
    const res = await client.api.families[':familyId'].children[
      ':childId'
    ]['ai-reference-images'].$post({
      param: {
        familyId: 'family-1',
        childId: 'family-1-child-1',
      },
      form: {
        file: file,
        takenAt: '2024-01-01T00:00:00.000Z',
      },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(200)

    // レスポンスデータを検証する。
    const data = await res.json()
    expect(data).toStrictEqual({
      childAiReferenceImageId: expect.any(String),
    })

    // DB の状態を検証する。
    const db = getTestDrizzleClient()
    const imageRecords = await db
      .select()
      .from(childAiReferenceImages)
      .where(eq(childAiReferenceImages.childId, 'family-1-child-1'))
      .all()

    // 新しく作成された画像が存在することを確認する。
    expect(imageRecords.length).toBeGreaterThan(0)
    const newImage = imageRecords[imageRecords.length - 1]
    expect(newImage.familyId).toBe('family-1')
    expect(newImage.childId).toBe('family-1-child-1')
    expect(newImage.contentType).toBe('image/jpeg')

    // uploadChildAiReferenceImageToR2 が適切なパラメータで呼び出されたことを確認する。
    expect(mockUploadChildAiReferenceImageToR2).toHaveBeenCalledWith({
      familyId: 'family-1',
      childId: 'family-1-child-1',
      r2Filename: expect.any(String),
      fileData: expect.any(ArrayBuffer),
      contentType: 'image/jpeg',
    })
  })
})
```

### 5.4 FormData を使用するテストの注意点

FormData を使用する Handler のテストでは、以下の点に注意してください：

- **File オブジェクトの作成**: `new File([arrayBuffer], filename, { type: contentType })` を使用してファイルオブジェクトを作成する
- **バイナリデータの作成**: `new Uint8Array([...])` を使用してテスト用のバイナリデータを作成する
- **適切な Content-Type**: ファイルの Content-Type が適切に設定されているかを確認する
- **スキーマの検証**: FormData のスキーマが適切に定義されているかを確認する

### 5.5 テストのベストプラクティス

#### 5.5.1 モックの管理

- `beforeEach` でモックをリセットする
- 各テストケースで期待する動作を明示的に設定する
- モック関数の呼び出し回数や引数も検証する

#### 5.5.2 テストデータの管理

- テスト用のファイルデータは適切なサイズで作成する
- 実際のファイル形式に近いバイナリデータを使用する
- テストケースごとに異なるデータを使用する

#### 5.5.3 エラーケースのテスト

- 正常系だけでなく異常系もテストする
- 各エラーコードに対応するテストケースを作成する
- エラーレスポンスの形式も検証する

#### 5.5.4 データベース状態の検証

- テスト後にデータベースの状態を確認する
- 期待する値が正しく保存されているかを検証する
- 関連するテーブルの状態も確認する

## 6. コメント規則

### 6.1 基本ルール

- 各 Handler の実装には JSDoc コメントを記述する
- 各処理ブロックにはインラインコメントで説明を記述する
- コメントは「。」で、または、半角英数字で終わる場合は「.」で終わる完全な文章で記述する
- コメントは「だ・である」調で統一する

### 6.2 JSDoc コメント

Handler の実装には JSDoc コメントを記述します：

```typescript
/**
 * Foo リソースを作成する Handler.
 * 
 * @returns 作成された Foo リソースの情報を返却する。
 */
```

### 6.3 処理ブロックのコメント

Handler の実装内の各処理ブロックには、その処理が何をするのかを説明するコメントを記述します：

```typescript
// リクエストパラメータを取得する。
const userId = c.get('userId')
const barId = c.req.param('barId')

// バリデーション済みのリクエストボディを取得する。
const data = c.req.valid('json')

// UseCase を呼び出す。
const result = await createFooUseCase({...})

// エラーハンドリングを行う。
if (result.isErr()) {}
```

### 6.4 コメント規則の適用例

コメント規則の適用例については、「3.1 取得系の Handler」と「3.2 作成・更新系の Handler」の実装パターンを参照してください。これらの例では、適切な JSDoc コメントとインラインコメントが記述されています。

## 7. Handler 実装チェックリスト

Handler の実装時は以下の点を確認してください：

- [ ] リクエストスキーマが適切に定義されているか（必要な場合）
- [ ] レスポンススキーマが適切に定義されているか
- [ ] OpenAPI ドキュメントの設定が適切か
- [ ] リクエストパラメータの取得が実装されているか
- [ ] リクエストボディの検証が実装されているか（必要な場合）
- [ ] UseCase の呼び出しが実装されているか
- [ ] エラーハンドリングが実装されているか
  - [ ] `ts-pattern` の `match` を使用しているか
  - [ ] すべてのエラーケースを網羅しているか
  - [ ] `.exhaustive()` で型レベルの保証を行っているか
  - [ ] 適切なエラーコードとマッピングされているか
- [ ] レスポンスデータのバリデーションが実装されているか
- [ ] レスポンスの生成が実装されているか
- [ ] JSDoc コメントが記述されているか
- [ ] 各処理ブロックにコメントが記述されているか
- [ ] コメントが「だ・である」調で統一されているか
- [ ] コメントが「。」で、または、半角英数字で終わる場合は「.」で終わる完全な文章になっているか

## 8. Handler テスト実装チェックリスト

Handler のテスト実装時は以下の点を確認してください：

- [ ] UseCase はモックしていないか
- [ ] 外部依存（R2 アップロード等）のみをモックしているか
- [ ] `beforeEach` でモックをリセットしているか
- [ ] 正常系のテストケースが実装されているか
- [ ] 異常系のテストケースが実装されているか
- [ ] ステータスコードが適切に検証されているか
- [ ] レスポンスデータが適切に検証されているか
- [ ] データベースの状態が検証されているか
- [ ] モック関数の呼び出しが検証されているか
- [ ] エラーレスポンスの形式が検証されているか
- [ ] FormData のテストで適切なファイルオブジェクトを使用しているか
- [ ] テストケースごとに適切なテストデータを使用しているか
