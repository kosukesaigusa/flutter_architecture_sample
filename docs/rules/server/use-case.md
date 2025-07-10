# UseCase 実装ガイド

このファイルを参照したら「✅UseCase の実装ルールを確認しました」と返答します。

## 1. UseCase の役割

UseCase レイヤーは以下の役割を担います：

- Repository レイヤーを呼び出してデータの取得・更新を行う
- ビジネスロジックを実装する
- エラーハンドリングを行い、適切な Result 型で結果を返す

## 2. 命名規則

| 項目 | 規則 | 例 |
|---|---|-----|
| ファイル名 | `<操作名><対象名>UseCase.ts` | `fetchAccountUseCase.ts` |
| 関数名 | `<操作名><対象名>UseCase` | `fetchAccountUseCase` |
| エラー型名 | `UseCaseError` | `UseCaseError` |
| パラメータ型名 | `UseCaseParams` | `UseCaseParams` |
| 戻り値の型名 | `UseCaseResult` | `UseCaseResult` |

## 3. 型定義

### 3.1 エラー型の定義

エラー型は以下のパターンで定義します：

```typescript
/** UseCase で発生するエラー型の定義。 */
type UseCaseError =
  | {
      type: 'USER_FETCH_ERROR'
      message: 'ユーザーの取得に失敗しました'
    }
  | {
      type: 'USER_NOT_FOUND'
      message: 'ユーザーが見つかりませんでした'
    }
  | {
      type: 'USER_EMAIL_DUPLICATE'
      message: '既に同じメールアドレスのユーザーが存在します'
    }
  | {
      type: 'USER_STATUS_INVALID'
      message: 'このステータスのユーザーは更新できません'
    }
```

この定義方法には以下の利点があります：

- エラーの種類（type）とメッセージ（message）が型レベルで紐付けられる
- エラーメッセージが型として定義されるため、タイプミスを防げる
- `FetchUserError['type']` で型を取得できる
- エラーメッセージの一貫性が保たれる

### 3.1.1 エラー型の命名規則

エラー型の type 文字列は以下の規則で命名します：

- プレフィックスに対象を付与する（例：`USER_`）
- 「何が」「どうした/どうなった」が明確になるように命名する
  - `USER_FETCH_ERROR`: ユーザーの取得に失敗
  - `USER_NOT_FOUND`: ユーザーが見つからない
  - `USER_EMAIL_DUPLICATE`: ユーザーのメールアドレスが重複
  - `USER_STATUS_INVALID`: ユーザーのステータスが不正
- 実装の詳細（レイヤーなど）は含めず、事象を表現する
  - 良い例：`USER_FETCH_ERROR`
  - 悪い例：`USER_REPOSITORY_ERROR`

### 3.2 パラメータ型の定義

```typescript
/** UseCase のパラメータ型の定義。 */
type UseCaseParams = {
  userId: string
}
```

### 3.3 戻り値の型定義

戻り値の型は必ず `Result<T, Error>` を使用します：

```typescript
Promise<Result<void, FetchUserError>>
// または
Promise<Result<FetchUserResult, FetchUserError>>
```

## 4. エラーハンドリング

### 4.1 基本方針

- エラーは throw ではなく `Result` 型で返す
- エラーは discriminated union として定義する
- エラーメッセージは具体的に記述する
- エラーの種類は `ErrorType` として定義する
- エラーメッセージは日本語で記述する

### 4.2 エラーを返す実装例

```typescript
// Repository からのエラーをハンドリングする。
if (userResult.isErr()) {
  return err({
    type: 'USER_FETCH_ERROR' as const,
    message: 'ユーザーの取得に失敗しました' as const,
  })
}

// 存在チェックを行う。
const user = userResult.value
if (!user) {
  return err({
    type: 'USER_NOT_FOUND' as const,
    message: 'ユーザーが見つかりませんでした' as const,
  })
}
```

## 5. 実装パターン

### 5.1 基本的な実装パターン（void を返す場合）

```typescript
import { type Result, err, ok } from 'neverthrow'
import { deleteUser } from '../../repository/mutation/userMutationRepository'

/** UseCase で発生するエラー型の定義。 */
type UseCaseError =
  | {
      type: 'USER_FETCH_ERROR'
      message: 'ユーザーの取得に失敗しました'
    }
  | {
      type: 'USER_NOT_FOUND'
      message: 'ユーザーが見つかりませんでした'
    }
  | {
      type: 'USER_DELETE_ERROR'
      message: 'ユーザーの削除に失敗しました'
    }

/** UseCase のパラメータ型の定義。 */
type UseCaseParams = {
  userId: string
}

/**
 * ユーザーを削除する。
 * @param params - パラメータ。
 * @returns 削除結果。
 */
export const deleteUserUseCase = async (
  params: DeleteUserParams,
): Promise<Result<void, DeleteUserError>> => {
  // ユーザーを取得する。
  const userResult = await getUserById(params.userId)
  if (userResult.isErr()) {
    return err({
      type: 'USER_FETCH_ERROR' as const,
      message: 'ユーザーの取得に失敗しました' as const,
    })
  }

  // 存在チェックを行う。
  const user = userResult.value
  if (!user) {
    return err({
      type: 'USER_NOT_FOUND' as const,
      message: 'ユーザーが見つかりませんでした' as const,
    })
  }

  // ユーザーを削除する。
  const deleteResult = await deleteUser(params.userId)
  if (deleteResult.isErr()) {
    return err({
      type: 'USER_DELETE_ERROR' as const,
      message: 'ユーザーの削除に失敗しました' as const,
    })
  }

  return ok(undefined)
}
```

### 5.2 戻り値がある実装パターン

```typescript
import { type Result, err, ok } from 'neverthrow'
import { getUserById } from '../../repository/query/userQueryRepository'

/** UseCase で発生するエラー型の定義。 */
type UseCaseError =
  | {
      type: 'USER_FETCH_ERROR'
      message: 'ユーザーの取得に失敗しました'
    }
  | {
      type: 'USER_NOT_FOUND'
      message: 'ユーザーが見つかりませんでした'
    }

/** UseCase のパラメータ型の定義。 */
type UseCaseParams = {
  userId: string
}

/** UseCase の戻り値の型の定義。 */
type UseCaseResult = {
  id: string
  name: string
  email: string
  createdAt: Date
}

/**
 * ユーザーを取得する。
 * @param params - パラメータ。
 * @returns 取得結果。
 */
export const fetchUserUseCase = async (
  params: FetchUserParams,
): Promise<Result<FetchUserResult, FetchUserError>> => {
  // ユーザーを取得する。
  const result = await getUserById(params.userId)
  if (result.isErr()) {
    return err({
      type: 'USER_FETCH_ERROR' as const,
      message: 'ユーザーの取得に失敗しました' as const,
    })
  }

  // 存在チェックを行う。
  const user = result.value
  if (!user) {
    return err({
      type: 'USER_NOT_FOUND' as const,
      message: 'ユーザーが見つかりませんでした' as const,
    })
  }

  return ok({
    id: user.id,
    name: user.name,
    email: user.email,
    createdAt: user.createdAt,
  })
}
```

### 5.3 複数の Repository 呼び出しを含む実装パターン

```typescript
import { type Result, err, ok } from 'neverthrow'
import { createPostComment } from '../../repository/mutation/postCommentMutationRepository'
import { getGroupMemberByUserId } from '../../repository/query/groupMemberQueryRepository'

/** UseCase で発生するエラー型の定義。 */
type UseCaseError =
  | {
      type: 'GROUP_MEMBER_FETCH_ERROR'
      message: 'グループメンバーの取得に失敗しました'
    }
  | {
      type: 'GROUP_MEMBER_NOT_FOUND'
      message: 'グループメンバーが見つかりませんでした'
    }
  | {
      type: 'POST_COMMENT_CREATE_ERROR'
      message: '投稿コメントの作成に失敗しました'
    }

/** UseCase のパラメータ型の定義。 */
type UseCaseParams = {
  groupId: string
  categoryId: string
  postId: string
  userId: string
  comment: string
}

/** UseCase の戻り値の型の定義。 */
type UseCaseResult = {
  commentId: string
  userId: string
  name: string
  comment: string
  createdAt: Date
  updatedAt: Date
}

/**
 * 投稿にコメントを追加する。
 * @param params - パラメータ。
 * @returns コメントの作成結果。
 */
export const postPostCommentUseCase = async (
  params: PostPostCommentParams,
): Promise<Result<PostPostCommentResult, PostPostCommentError>> => {
  // グループメンバーを取得する。
  const groupMemberResult = await getGroupMemberByUserId({
    groupId: params.groupId,
    userId: params.userId,
  })

  // グループメンバーの取得に失敗した場合はエラーを返す。
  if (groupMemberResult.isErr()) {
    return err({
      type: 'GROUP_MEMBER_FETCH_ERROR' as const,
      message: 'グループメンバーの取得に失敗しました' as const,
    })
  }

  // グループメンバーが存在しない場合はエラーを返す。
  if (!groupMemberResult.value) {
    return err({
      type: 'GROUP_MEMBER_NOT_FOUND' as const,
      message: 'グループメンバーが見つかりませんでした' as const,
    })
  }

  // 投稿コメントを作成する。
  const result = await createPostComment({
    groupId: params.groupId,
    categoryId: params.categoryId,
    postId: params.postId,
    userId: params.userId,
    name: groupMemberResult.value.name,
    comment: params.comment,
  })

  if (result.isErr()) {
    return err({
      type: 'POST_COMMENT_CREATE_ERROR' as const,
      message: '投稿コメントの作成に失敗しました' as const,
    })
  }

  return ok({
    commentId: result.value.commentId,
    userId: result.value.userId,
    name: result.value.name,
    comment: result.value.comment,
    createdAt: result.value.createdAt,
    updatedAt: result.value.updatedAt,
  })
}
```

### 5.4 配列を返す実装パターン

```typescript
import { type Result, err, ok } from 'neverthrow'
import { getGroupMembersByGroupId } from '../../repository/query/groupQueryRepository'
import type { GroupMemberRole } from '../../util/groupMemberRole'

/** UseCase で発生するエラー型の定義。 */
type UseCaseError = {
  type: 'GROUP_MEMBER_FETCH_ERROR'
  message: 'メンバー一覧の取得に失敗しました'
}

/** UseCase のパラメータ型の定義。 */
type UseCaseParams = {
  groupId: string
}

/** UseCase の戻り値の型の定義。 */
type UseCaseResult = {
  groupMemberId: string
  name: string
  role: GroupMemberRole
  imageUrl: string | undefined
  createdAt: Date
  updatedAt: Date
}[]

/**
 * 指定したグループのメンバー一覧を取得する。
 * @param params - パラメータ。
 * @returns メンバー一覧。
 */
export const fetchMembersByGroupIdUseCase = async (
  params: FetchMembersByGroupIdParams,
): Promise<Result<FetchMembersByGroupIdResult, FetchMembersByGroupIdError>> => {
  // メンバー一覧を取得する。
  const result = await getGroupMembersByGroupId({ groupId: params.groupId })

  if (result.isErr()) {
    return err({
      type: 'GROUP_MEMBER_FETCH_ERROR' as const,
      message: 'メンバー一覧の取得に失敗しました' as const,
    })
  }

  return ok(
    result.value.map((member) => ({
      groupMemberId: member.groupMemberId,
      name: member.name,
      role: member.role,
      imageUrl: member.imageUrl,
      createdAt: member.createdAt,
      updatedAt: member.updatedAt,
    })),
  )
}
```

### 5.5 void を返す実装パターン

```typescript
import { type Result, err, ok } from 'neverthrow'
import { deletePostFavorite } from '../../repository/mutation/postFavoriteMutationRepository'

/** UseCase で発生するエラー型の定義。 */
type UseCaseError = {
  type: 'POST_FAVORITE_DELETE_ERROR'
  message: '投稿のお気に入り解除に失敗しました'
}

/** UseCase のパラメータ型の定義。 */
type UseCaseParams = {
  groupId: string
  categoryId: string
  postId: string
  userId: string
}

/**
 * 投稿のお気に入りを解除する。
 * @param params - パラメータ。
 * @returns 投稿のお気に入りを解除した結果。
 */
export const deletePostFavoriteUseCase = async (
  params: DeletePostFavoriteParams,
): Promise<Result<void, DeletePostFavoriteError>> => {
  // 投稿のお気に入りを解除する。
  const result = await deletePostFavorite({
    groupId: params.groupId,
    categoryId: params.categoryId,
    postId: params.postId,
    userId: params.userId,
  })

  if (result.isErr()) {
    return err({
      type: 'POST_FAVORITE_DELETE_ERROR' as const,
      message: '投稿のお気に入り解除に失敗しました' as const,
    })
  }

  return ok(undefined)
}
```

## 6. コメント規則

### 6.1 基本ルール

- エラークラスには JSDoc でエラーの説明を記述する
- UseCase 関数には JSDoc で処理の説明、パラメータ、戻り値の説明を記述する
- 処理の各ステップにはインラインコメントで説明を記述する
- インラインコメントは処理の前の行に記述する
- コメントは「。」で、または、半角英数字で終わる場合は「.」で終わる完全な文章で記述する
- コメントは「だ・である」調で統一する

### 6.2 JSDoc コメント

#### エラー型

```typescript
/** UseCase で発生するエラー型の定義。 */
type UseCaseError =
  | {
      type: 'USER_FETCH_ERROR'
      message: 'ユーザーの取得に失敗しました'
    }
  | {
      type: 'USER_NOT_FOUND'
      message: 'ユーザーが見つかりませんでした'
    }
```
