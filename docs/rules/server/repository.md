# Repository 実装ガイド

このファイルを参照したら「✅Repository の実装ルールを確認しました」と返答します。

## 1. Repository の役割

Repository レイヤーはデータベースアクセスを担当し、以下の責務を持ちます：

- データベースからのデータ取得
- データベースへのデータ保存・更新・削除
- データベース操作のエラーハンドリング
- 取得結果を適切な形式に変換

## 2. ディレクトリ構成

Repository は用途に応じて以下のディレクトリに配置します：

- **取得系**: `src/repository/query/` ディレクトリ
- **更新系**: `src/repository/mutation/` ディレクトリ

## 3. 命名規則

| 操作 | 接頭辞 | 例 |
|------|--------|-----|
| 取得（単一） | `get` | `getUserById` |
| 取得（複数） | `list` | `listUsersByGroupId` |
| 作成 | `create` | `createUser` |
| 更新 | `update` | `updateUserProfile` |
| 削除 | `delete` | `deleteUser` |
| 存在確認 | `exists` | `existsUserByEmail` |

## 4. 戻り値の型

- すべての Repository 関数は `Promise<Result<T, Error>>` 型を返す
- 成功時は `ok(データ)` を返す
- 失敗時は `err(エラー)` を返す

## 5. 実装パターン

### 5.1 取得系 Repository

```typescript
import { eq } from 'drizzle-orm'
import { asc } from 'drizzle-orm'
import { getContext } from 'hono/context-storage'
import { type Result, err, ok } from 'neverthrow'
import type { EnvironmentVariables } from '../../env'
import { users } from '../../schema'

/** ユーザーを取得する際のパラメータ。 */
type RepositoryParams = {
  userId: string
}

/** ユーザーの取得結果。 */
type RepositoryResult = {
  id: string
  name: string
  email: string
  createdAt: Date
}

/**
 * 指定した ID のユーザーを取得する。
 * @param params - パラメータ。
 * @returns ユーザー情報。
 */
export const getUserById = async (
  params: RepositoryParams,
): Promise<Result<RepositoryResult, Error>> => {
  const c = getContext<EnvironmentVariables>()
  const db = c.var.db
  const logger = c.get('logger')

  try {
    // ユーザーを取得する。
    const result = await db
      .select({
        id: users.id,
        name: users.name,
        email: users.email,
        createdAt: users.createdAt,
      })
      .from(users)
      .where(eq(users.id, params.userId))
      .get()

    // 結果がない場合は失敗を返す。
    if (!result) {
      return err(new Error(`ユーザーの取得に失敗しました: ${params.userId}`))
    }

    // 日付型に変換して返す。
    return ok({
      ...result,
      createdAt: new Date(result.createdAt),
    })
  } catch (e) {
    if (e instanceof Error) {
      logger.error(`Repository Error: ${e}`, e)
      return err(e)
    }
    return err(new Error('ユーザーの取得に失敗しました'))
  }
}

/** ユーザー一覧を取得する際のパラメータ。 */
type RepositoryParams = {
  groupId: string
}

/** ユーザー一覧の取得結果。 */
type RepositoryResult = {
  id: string
  name: string
  email: string
  createdAt: Date
}[]

/**
 * 指定したグループに属するユーザー一覧を取得する。
 * @param params - パラメータ。
 * @returns ユーザー一覧。
 */
export const listUsersByGroupId = async (
  params: RepositoryParams,
): Promise<Result<RepositoryResult, Error>> => {
  const c = getContext<EnvironmentVariables>()
  const db = c.var.db
  const logger = c.get('logger')

  try {
    // ユーザー一覧を取得する。
    const result = await db
      .select({
        id: users.id,
        name: users.name,
        email: users.email,
        createdAt: users.createdAt,
      })
      .from(users)
      .innerJoin(userGroups, eq(users.id, userGroups.userId))
      .where(eq(userGroups.groupId, params.groupId))
      .orderBy(asc(users.createdAt))

    // 日付型に変換して返す。
    return ok(
      result.map((r) => ({
        ...r,
        createdAt: new Date(r.createdAt),
      })),
    )
  } catch (e) {
    if (e instanceof Error) {
      logger.error(`Repository Error: ${e}`, e)
      return err(e)
    }
    return err(new Error('ユーザー一覧の取得に失敗しました'))
  }
}
```

### 5.2 更新系 Repository

```typescript
import { getContext } from 'hono/context-storage'
import { type Result, err, ok } from 'neverthrow'
import { ulid } from 'ulidx'
import type { EnvironmentVariables } from '../../env'
import { users } from '../../schema'

/** ユーザーを作成する際のパラメータ。 */
type RepositoryParams = {
  name: string
  email: string
  password: string
}

/** ユーザーを作成した結果。 */
type RepositoryResult = {
  id: string
  name: string
  email: string
  createdAt: Date
}

/**
 * ユーザーを作成する。
 * @param params - パラメータ。
 * @returns 作成したユーザー情報。
 */
export const createUser = async (
  params: RepositoryParams,
): Promise<Result<RepositoryResult, Error>> => {
  const c = getContext<EnvironmentVariables>()
  const db = c.var.db
  const logger = c.get('logger')

  try {
    // ユーザー ID を生成する。
    const userId = ulid()
    const now = new Date()
    
    // ユーザーを作成する。
    await db.insert(users).values({
      id: userId,
      name: params.name,
      email: params.email,
      password: params.password,
      createdAt: now,
      updatedAt: now,
    })

    // 作成したユーザー情報を返す。
    return ok({
      id: userId,
      name: params.name,
      email: params.email,
      createdAt: now,
    })
  } catch (e) {
    if (e instanceof Error) {
      logger.error(`Repository Error: ${e}`, e)
      return err(e)
    }
    return err(new Error('ユーザーの作成に失敗しました'))
  }
}

/** ユーザーを更新する際のパラメータ。 */
type RepositoryParams = {
  userId: string
  name?: string
  email?: string
}

/** ユーザーを更新した結果。 */
type RepositoryResult = {
  id: string
  name: string
  email: string
  updatedAt: Date
}

/**
 * ユーザー情報を更新する。
 * @param params - 更新パラメータ。
 * @returns 更新したユーザー情報。
 */
export const updateUser = async (
  params: RepositoryParams,
): Promise<Result<RepositoryResult, Error>> => {
  const c = getContext<EnvironmentVariables>()
  const db = c.var.db
  const logger = c.get('logger')

  try {
    // 更新データを準備する。
    const now = new Date()
    const updateData: Record<string, unknown> = {
      updatedAt: now,
    }
    
    if (params.name !== undefined) {
      updateData.name = params.name
    }
    
    if (params.email !== undefined) {
      updateData.email = params.email
    }
    
    // ユーザーを更新する。
    await db
      .update(users)
      .set(updateData)
      .where(eq(users.id, params.userId))

    // 更新後のユーザー情報を取得する。
    const updatedUser = await db
      .select({
        id: users.id,
        name: users.name,
        email: users.email,
      })
      .from(users)
      .where(eq(users.id, params.userId))
      .get()

    // 結果がない場合はエラーを返す。
    if (!updatedUser) {
      return err(new Error(`ユーザーの更新に失敗しました: ${params.userId}`))
    }

    // 更新したユーザー情報を返す。
    return ok({
      ...updatedUser,
      updatedAt: now,
    })
  } catch (e) {
    if (e instanceof Error) {
      logger.error(`Repository Error: ${e}`, e)
      return err(e)
    }
    return err(new Error('ユーザーの更新に失敗しました'))
  }
}
```

## 6. エラーハンドリング

- すべてのデータベース操作は try-catch でエラーをキャッチする
- エラーは適切にログ出力する
- エラーは `Result` 型の `err` で返す
- 特定のエラー条件（存在しないレコードなど）は明示的にチェックする

## 7. コメント規則

### 7.1 基本ルール

- 関数には JSDoc でその目的、パラメータ、戻り値を記述する
- 型定義には必要に応じてコメントを付ける
- 処理の各ステップにはインラインコメントで説明を記述する
- コメントは「。」で、または、半角英数字で終わる場合は「.」で終わる完全な文章で記述する
- コメントは「だ・である」調で統一する
- インラインコメントは処理の前の行に記述する

### 7.2 JSDoc コメント

#### 関数の JSDoc

```typescript
/**
 * 指定した ID のユーザーを取得する。
 * @param params - パラメータ。
 * @returns ユーザー情報。
 */
```

#### 型定義の JSDoc

```typescript
/** ユーザーを取得する際のパラメータ。 */
type RepositoryParams = {
  userId: string
}
```

```typescript
/** ユーザーの取得結果。 */
type RepositoryResult = {
  id: string
  name: string
  email: string
  createdAt: Date
}
```

### 7.3 インラインコメント

#### データベース操作の説明

```typescript
// ユーザーを取得する。
const result = await db.select(...)
```

#### データ加工の説明

```typescript
// 日付型に変換して返す。
return ok({...})
```

#### 条件分岐の説明

```typescript
// 結果がない場合は失敗を返す。
if (!result) {
  return err(new Error(...))
}
```

### 7.4 コメント規則の適用例

コメント規則の適用例については、「5.1 取得系 Repository」と「5.2 更新系 Repository」の実装パターンを参照してください。これらの例では、適切な JSDoc コメントとインラインコメントが記述されています。

## 8. 実装チェックリスト

Repository 実装時は以下の点を確認してください：

- [ ] 命名規則に従っているか
- [ ] 適切なディレクトリに配置されているか
- [ ] 戻り値の型が `Result<T, Error>` になっているか
- [ ] try-catch でエラーをキャッチしているか
- [ ] エラーログが適切に出力されているか
- [ ] 特定のエラー条件が明示的にチェックされているか
- [ ] JSDoc コメントが適切に記述されているか
- [ ] 各処理ステップにインラインコメントが記述されているか
- [ ] コメントが「だ・である」調で統一されているか
- [ ] コメントが「。」で、または、半角英数字で終わる場合は「.」で終わる完全な文章になっているか
- [ ] パラメータ型と戻り値型が関数の直前に定義されているか
- [ ] 型定義に JSDoc コメントが記述されているか
