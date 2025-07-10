# Handler テスト実装ガイド

このファイルを参照したら「✅Handler のテストの実装ルールを確認しました」と返答します。

## 1. テストの実行方法

```sh
bun run test:run
```

で watch せずに一度だけ実行します。

## 2. テストの基本構造

Handler のテストは `src/endpoint/handler/**/*Handler.test.ts` に実装します。各テストケースは以下の 3 つのステップで構成し、それぞれにコメントを記述します:

### 2.1 Arrange（準備）

- テストデータの準備
- モックの設定
- テストクライアントの作成

```typescript
// ユーザー情報をセットする。
mockSetUserAuthMiddleware({ userId: 'test-user-id' })

// テスト用の API クライアントを作成する。
const client = await getTestClient()
```

### 2.2 Act（実行）

- API リクエストの実行

```typescript
// リクエストを送信する。
const res = await client.api.bar[':barId'].foos.$get({
  param: { barId: 'test-bar-id' },
})
```

### 2.3 Assert（検証）

- ステータスコードの検証
- レスポンスデータの検証
- DB の状態変更の検証（必要な場合）

```typescript
// ステータスコードを検証する。
expect(res.status).toBe(200)

// レスポンスデータを検証する。
const data = await res.json()
expect(data).toStrictEqual({
  items: [
    {
      id: 'test-foo-1',
      name: 'Foo 1',
      createdAt: expect.any(String),
      updatedAt: expect.any(String),
    },
  ],
})
```

## 3. テストの命名規則

### 3.1 テストの description と補足コメント

テストの description は英語で記述し、各テストの前に日本語のコメントで前提条件と期待値を記述します：

```typescript
  // 前提：認証済みユーザーがグループ一覧を取得する。
  // 期待値：ステータスコード 200 とグループ一覧が返される。
  it('Successfully request GET /groups', async () => {
  // テストコード
})
```

### 3.2 description の命名規則

#### 成功ケース

- `Successfully request [HTTP Method] [endpoint]`
- `Successfully create a new [resource]`
- `Successfully update [resource]`

#### エラーケース

- `Returns [status code] with error code [error code] when [condition]`
- `Fails with [status code] when [condition]`
- `Rejects request with [status code] for [reason]`

## 4. テストケースの実装

### 4.1 取得系の Handler のテスト

取得系の Handler のテストは以下のパターンで実装します：

```typescript
import { describe, expect, it } from 'vitest'
import { ERROR_CODES } from '../../../endpoint/errorCode'
import { mockSetUserAuthMiddleware } from '../../../util/test-util/mockMiddleware'
import { getTestClient } from '../../../util/test-util/testClient'

describe('Test for GET /bar/:barId/foos', () => {
  // 前提：認証済みユーザーが有効なリソースにアクセスする。
  // 期待値：ステータスコード 200 とリソース一覧が返される。
  it('Successfully request GET /bar/:barId/foos', async () => {
    // ユーザー情報をセットする。
    mockSetUserAuthMiddleware({ userId: 'test-user-id' })

    // テスト用の API クライアントを作成する。
    const client = await getTestClient()

    // リクエストを送信する。
    const res = await client.api.bar[':barId'].foos.$get({
      param: { barId: 'test-bar-id' },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(200)
    
    // レスポンスデータを検証する。
    const data = await res.json()
    expect(data).toStrictEqual({
      items: [
        {
          id: 'test-foo-1',
          name: 'Foo 1',
          createdAt: expect.any(String),
          updatedAt: expect.any(String),
        },
      ],
    })
  })

  // 前提：存在しないリソースにアクセスする。
  // 期待値：ステータスコード 400 とエラーコード get.foo.1 が返される。
  it('Returns 400 with error code get.foo.1 when resource does not exist', async () => {
    // ユーザー情報をセットする。
    mockSetUserAuthMiddleware({ userId: 'test-user-id' })

    // テスト用の API クライアントを作成する。
    const client = await getTestClient()

    // リクエストを送信する。
    const res = await client.api.bar[':barId'].foos.$get({
      param: { barId: 'non-existent-bar' },
    })

    // Assert: 検証
    // ステータスコードを検証する。
    expect(res.status).toBe(400)

    // エラーレスポンスを検証する。
    const error = await res.json()
    expect(error).toEqual({
      error: {
        code: 'get.foo.1',
      },
    })
  })

  // 前提：未認証ユーザーがリソースにアクセスする。
  // 期待値：ステータスコード 400 とエラーコード middleware.auth.1 が返される。
  it('Returns 400 with error code middleware.auth.1 when user authentication fails', async () => {
    // ユーザー情報をセットする。
    mockSetUserAuthMiddleware({ userId: undefined })

    // テスト用の API クライアントを作成する。
    const client = await getTestClient()

    // リクエストを送信する。
    const res = await client.api.bar[':barId'].foos.$get({
      param: { barId: 'test-bar-id' },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(400)

    // エラーレスポンスを検証する。
    const error = await res.json()
    expect(error).toEqual({
      error: {
        code: 'middleware.auth.1',
      },
    })
  })
})
```

### 4.2 作成・更新系の Handler のテスト

作成・更新系の Handler のテストは以下のパターンで実装します：

```typescript
import { asc, eq } from 'drizzle-orm'
import { describe, expect, it } from 'vitest'
import { ERROR_CODES } from '../../../endpoint/errorCode'
import { bars, barFoos } from '../../../schema'
import { mockSetUserAuthMiddleware } from '../../../util/test-util/mockMiddleware'
import {
  getTestClient,
  getTestDrizzleClient,
} from '../../../util/test-util/testClient'

describe('Test for POST /bar', () => {
  // 前提：認証済みユーザーが有効なデータでリソースを作成する。
  // 期待値：ステータスコード 200 と作成されたリソース情報が返される。
  it('Successfully create a new bar', async () => {
    // ユーザー情報をセットする。
    mockSetUserAuthMiddleware({ userId: 'test-user-id' })

    // テスト用の API クライアントを作成する。
    const client = await getTestClient()

    // リクエストを送信する。
    const res = await client.api.bar.$post({
      json: {
        name: 'New Bar',
        description: 'This is a new bar',
        attributes: ['attr1', 'attr2'],
      },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(200)
    
    // レスポンスデータを検証する。
    const data = await res.json()
    expect(data).toHaveProperty('id')
    expect(data).toHaveProperty('createdAt')

    // DB の状態を検証する。
    const db = getTestDrizzleClient()
    const results = await db
      .select({ bar: bars })
      .from(bars)
      .innerJoin(barFoos, eq(bars.id, barFoos.barId))
      .where(eq(barFoos.userId, 'test-user-id'))
      .orderBy(asc(bars.createdAt))
      .all()

    // 新しく作成されたリソースが存在することを確認する。
    expect(results.length).toBeGreaterThan(0)
    const newBar = results[results.length - 1].bar
    expect(newBar.name).toBe('New Bar')
    expect(newBar.description).toBe('This is a new bar')
  })

  // 前提：無効なデータでリソースを作成しようとする。
  // 期待値：ステータスコード 400 とエラーコード validation.invalid-request.1 が返される。
  it('Returns 400 with error code validation.invalid-request.1 for invalid data', async () => {
    // ユーザー情報をセットする。
    mockSetUserAuthMiddleware({ userId: 'test-user-id' })

    // テスト用の API クライアントを作成する。
    const client = await getTestClient()

    // リクエストを送信する。 
    const res = await client.api.bar.$post({
      json: {
        // name が必須だが省略する。
        description: 'Invalid bar data',
      },
    })

    // ステータスコードを検証する。
    expect(res.status).toBe(400)

    // エラーレスポンスを検証する。
    const error = await res.json()
    expect(error).toEqual({
      error: {
        code: 'validation.invalid-request.1',
      },
    })
  })
})
```

## 5. エラーケースのテスト

エラーケースのテストでは、以下の点を必ず検証します：

1. HTTP ステータスコード（基本的に 400）
2. エラーレスポンスの形式

   ```typescript
   {
     error: {
       code: string  // ERROR_CODES から適切なコードを使用
     }
   }
   ```

3. エラーコードの値が正しいこと

### 5.1 Zod バリデーションエラーのテスト

リクエストのパラメータやボディが Zod スキーマのバリデーションに失敗した場合は、通常のエラーコードとは異なる形式のレスポンスが返されます。この場合のテストは以下のパターンで実装します：

#### 5.1.1 import の追加

```typescript
import type { ZodValidationErrorResponse } from '../../../util/test-util/zodValidationErrorResponse'
```

#### 5.1.2 テストケースの実装

```typescript
// 前提：認証済みユーザーが無効なパラメータでリクエストを送信する。
// 期待値：ステータスコード 400 と Zod バリデーションエラーが返される。
it('Returns 400 with Zod validation error when invalid parameter is provided', async () => {
  // ユーザー情報をセットする。
  mockSetUserAuthMiddleware({ userId: 'test-user-id' })

  // テスト用の API クライアントを作成する。
  const client = await getTestClient()

  // リクエストを送信する。
  const res = await client.api.bar[':barId'].foos.$get({
    param: { barId: 'test-bar-id' },
    query: {
      limit: '101', // 最大値を超える limit
    },
  })

  // ステータスコードを検証する。
  expect(res.status).toBe(400)

  // Zod バリデーションエラーが返されることを確認する。
  const errorResponse = (await res.json()) as ZodValidationErrorResponse
  expect(errorResponse.success).toBe(false)
  expect(errorResponse.error.name).toBe('ZodError')
})
```

#### 5.1.3 Zod バリデーションエラーの検証項目

Zod バリデーションエラーのテストでは、以下の項目を検証します：

1. HTTP ステータスコード (400)
2. レスポンスの `success` プロパティが `false` であること
3. レスポンスの `error.name` プロパティが `'ZodError'` であること

通常のエラーレスポンス（`error.code` を持つ形式）とは異なる形式であることに注意してください。

## 6. テストケースの網羅

各 Handler のテストでは、以下のようなケースを考慮してテストを実装します：

### 6.1 正常系テスト

- **基本的な成功ケース**: 標準的な入力での正常動作
- **境界値での成功ケース**: 最小/最大値など境界値での正常動作
- **オプショナルパラメータ**: オプショナルなパラメータの有無による動作の違い

### 6.2 エラー系テスト

#### バリデーションエラー

- 必須パラメータの欠落
- 不正な値（型、範囲、形式など）

#### 認証エラー

- 未認証
- 権限不足

#### リソースエラー

- 存在しないリソース
- 重複するリソース

#### ビジネスロジックエラー

- ストレージ制限超過
- その他のビジネスルール違反

## 7. テストデータの準備

テストデータは以下の方法で準備します：

### 7.1 シードデータの利用

- [seed.ts](../../../server/src/util/test-util/db/seed.ts) に定義されたシードデータを使用
- テストケースで必要なデータがない場合は、シードデータに追加

### 7.2 モックの設定

- [mockMiddleware.ts](../../../server/src/util/test-util/mockMiddleware.ts) を使用
- 認証情報や権限の設定に利用

```typescript
// 認証済みユーザーとしてテストする場合
mockSetUserAuthMiddleware({ userId: 'test-user-id' })

// 未認証ユーザーとしてテストする場合
mockSetUserAuthMiddleware({ userId: undefined })
```

### 7.3 テストクライアントの利用

- [testClient.ts](../../../server/src/util/test-util/testClient.ts) の `getTestClient` を使用
- API リクエストの実行に利用

```typescript
const client = await getTestClient()
```

### 7.4 DB クライアントの利用

- [testClient.ts](../../../server/src/util/test-util/testClient.ts) の `getTestDrizzleClient` を使用
- DB の状態確認に利用

```typescript
const db = getTestDrizzleClient()
```

## 8. モックの適用方針

Handler のテストは **統合テスト** の性質を持つため、モックの適用範囲を適切に制限する必要がある。以下の方針に従ってモックを適用する：

### 8.1 モックを行うべきレイヤー

以下のレイヤーでは、制御できない外部要因や非決定的な要素をモック化する：

#### 8.1.1 外部システム・サービス層

- **認証システム（Firebase Auth）**: `mockSetUserAuthMiddleware` で認証情報をモック
- **外部ストレージ（R2）**: ファイルアップロード/ダウンロードの処理をモック
- **外部 API**: サードパーティサービスとの通信をモック

#### 8.1.2 インフラストラクチャ層の境界

- **時間依存処理**: 現在時刻、タイムスタンプの固定
- **ランダム値生成**: UUID 生成などの非決定的処理をモック
- **環境変数**: テスト環境固有の設定値をモック

### 8.2 モックを行うべきでないレイヤー

以下のレイヤーでは、実際の動作を通じて統合的な検証を行う：

#### 8.2.1 ビジネスロジック層（UseCase）

- Handler のテストでは UseCase の実際の動作を検証すべき
- ビジネスルールが正しく適用されているかを確認する必要がある
- UseCase をモック化すると、ビジネスロジックの統合性が検証できない

#### 8.2.2 データアクセス層（Repository）

- DB への実際のクエリ実行を通じて、データの整合性を検証すべき
- Repository の実装が正しく動作するかを確認する必要がある
- Repository をモック化すると、SQL クエリの正確性が検証できない

#### 8.2.3 ミドルウェア層（認証以外）

- リクエスト処理、エラーハンドリング、バリデーションなどの内部処理
- これらは Handler の統合テストとして実際に動作させるべき
- ミドルウェアの動作確認も統合テストの重要な要素である

#### 8.2.4 データベース

- テスト用 DB（in-memory DB など）を使用して実際のクエリを実行
- DB の状態変更を検証することで、データの整合性を確保
- DB をモック化すると、実際のデータ操作の検証ができない

### 8.3 モック適用の理由

#### 8.3.1 統合テストとしての役割

Handler のテストは以下の統合的な動作確認を目的とする：

1. **エンドツーエンドの動作確認**: HTTP リクエストから DB への永続化まで一連の流れを検証
2. **ビジネスロジックの検証**: UseCase で実装されたビジネスルールが正しく動作するかを確認
3. **データ整合性の検証**: 実際の DB 操作を通じて、データの状態変更を検証

#### 8.3.2 テストの信頼性確保

- **制御できない外部要因** や **非決定的な要素** のみをモック化
- **アプリケーション内部のロジック** は実際に動作させることで、より信頼性の高いテストを実現
- モック範囲を最小限に抑えることで、実際の本番環境での動作により近いテストが可能

### 8.4 モック適用の具体例

#### 8.4.1 適切なモック例

```typescript
// test-user-id のユーザーで認証する。
mockSetUserAuthMiddleware({ userId: 'test-user-id' })

// uploadCategoryPostToR2 のモックを成功に設定する。
mockUploadCategoryPostToR2.mockResolvedValueOnce(ok(undefined))
```

#### 8.4.2 避けるべきモック例

```typescript
// ❌ UseCase のモック（ビジネスロジック層）
vi.mocked(createFamilyUseCase).mockResolvedValue({ id: 'test-id' })

// ❌ Repository のモック（データアクセス層）
vi.mocked(createFamilyMember).mockResolvedValue(ok({ familyMemberId: 'test-member-id' }))

// ❌ DB のモック（永続化層）
vi.mocked(db.insert).mockResolvedValue([{ id: 'test-id' }])
```

## 9. コメント規則

### 9.1 基本ルール

- テストケースの前に前提条件と期待値を日本語のコメントで記述する
- 各テストステップ（Arrange, Act, Assert）にコメントを記述する
- 各処理にインラインコメントで説明を記述する
- コメントは例外なく、必ず「。」で、または、半角英数字で終わる場合は「.」で終わる完全な文章で記述する
- コメントは「だ・である」調で統一する

### 9.2 テストケース前のコメント

テストケースの前に、前提条件と期待値を記述します：

```typescript
// 前提：認証済みユーザーが有効なリソースにアクセスする。
// 期待値：ステータスコード 200 とリソース一覧が返される。
it('Successfully request GET /bar/:barId/foos', async () => {
  // ...
})
```

### 9.3 インラインコメント

#### 準備ステップの説明

準備ステップの各処理の前に、その処理が何をするのかを説明するコメントを記述します：

```typescript
// ユーザー情報をセットする。
mockSetUserAuthMiddleware({ userId: 'test-user-id' })

// テスト用の API クライアントを作成する。
const client = await getTestClient()
```

#### 実行ステップの説明

実行ステップの処理の前に、その処理が何をするのかを説明するコメントを記述します：

```typescript
// リクエストを送信する。
const res = await client.api.bar[':barId'].foos.$get({
  param: { barId: 'test-bar-id' },
})
```

#### 検証ステップの説明

検証ステップの各検証の前に、何を検証するのかを説明するコメントを記述します：

```typescript
// ステータスコードを検証する。
expect(res.status).toBe(200)

// レスポンスデータを検証する。
const data = await res.json()
expect(data).toStrictEqual({
  // ...
})
```

### 9.4 コメント規則の適用例

コメント規則の適用例については、「4.1 取得系の Handler のテスト」と「4.2 作成・更新系の Handler のテスト」の実装パターンを参照してください。これらの例では、適切なコメントが記述されています。

## 10. テスト実装チェックリスト

Handler のテスト実装時は以下の点を確認してください：

- [ ] 正常系のテストケースが実装されているか
- [ ] エラー系のテストケースが実装されているか
- [ ] 各テストケースに前提条件と期待値のコメントが記述されているか
- [ ] Arrange-Act-Assert パターンに従っているか
- [ ] 各テストステップにコメントが記述されているか
- [ ] 各処理にインラインコメントが記述されているか
- [ ] レスポンスのステータスコードとデータが適切に検証されているか
- [ ] エラーケースではエラーコードが適切に検証されているか
- [ ] 必要に応じて DB の状態変更が検証されているか
- [ ] コメントが「だ・である」調で統一されているか
- [ ] コメントが「。」で、または、半角英数字で終わる場合は「.」で終わる完全な文章になっているか
