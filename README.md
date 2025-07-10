# flutter_architecture_sample

## server

### 環境構築

bun CLI をインストールします。

```sh
curl -fsSL https://bun.sh/install | bash
```

依存関係をインストールします。

```sh
bun install
```

### VS Code の拡張機能のインストール

`extensions.json` に従って VS Code や Cursor エディタで利用する拡張機能をインストールします。

### 開発の方法

#### ローカルサーバを起動する

ローカルでマイグレーションを実行します。

```sh
bun run migration:apply:dev
```

ローカルサーバを起動するには、`bun run dev` を実行します。

```sh
$ bun run dev

... 省略

[wrangler:inf] Ready on http://localhost:8787
```

Open API ドキュメントを確認するためには、上記で立ち上がったローカルサーバ（例：`http://localhost:8787`）に対して、`http://localhost:8787/docs` にアクセスします。

#### テストを実行する

テスト (vitest) を実行するには、下記のコマンドを実行します。

```sh
# watch する必要がない場合:
bun run test:run

# watch する場合:
bun run test
```

#### その他

その他については、`package.json` の scripts や関連ファイルを適宜参照して利用してください。

### スキーマ

`src/schema.ts` に従います。

まだ全く完全なものではないので、タスクを進めるにつれてどんどん更新されていくことが想定されます。

### アーキテクチャ・設計

アーキテクチャや設計については、下記の箇条書きリストの内容に従います（リストの順序と主な処理順序が一致しています）。

- `index.ts`：hono アプリのエントリポイントおよびエンドポイント一覧。各エンドポイントでの処理は `endpoint/` 以下に委譲する。
- `endpoint/`：`index.ts` から委譲される書くエンドポイントの処理を記述する。
  - `middleware/`：各エンドポイントで利用されるミドルウェア（主に権限関係など）を記述する。
  - `handler/`：各エンドポイントでの処理を記述する。
- `use-case/`：各エンドポイントが利用するビジネスロジックを記述する。
- `repository/`：主に drizzle を通じて D1 との通信を行い、データの読み書きを行う。
  - `query/`：主に SELECT 文によるデータの取得を行う。
  - `mutation/`：主に INSERT 文などによるデータの更新・書き込みを行う。
- `service/`：Hono や D1 以外の外部モジュール（R2 など）に依存する処理を記述する。

#### エラーハンドリング

Repository 層および UseCase 層では `neverthrow` による `Result` 型を用いて、いわゆる throw, try-catch 形式ではなく、`Result` 型のオブジェクトによるエラーハンドリングを行います。

一方、Handler 層では、UseCase 層から得られる `Result` 型のオブジェクトを下記のようにハンドリングして、エラー発生時には `AppHTTPException` に適切なエラーコードを与えてスローします。

エラーコードは `src/endpoint/errorCode.ts` に定義して、このサーバサイドアプリケーションを利用するクライアントアプリにとってのドキュメントとしても利用されます。

```ts
const result = await doSomething();

if (result.isErr()) {
  throw new AppHTTPException(ERROR_CODES.FOO_ENDPOINT.BAR_ERROR.code)
}

// 以下成功 Result の場合の処理は省略。
```

スローした `AppHTTPException` は、ミドルウェアとして実装したグローバルエラーハンドラーである `globalErrorHandlerMiddleware` で捕捉します。

本サーバサイドアプリでは、400 系のエラーレスポンスはすべてステータスコード 400 として統一し、そのエラーの内容は下記のような形式のエラーレスポンスのエラーコードから識別することとしています。

```ts
{
  error: {
    code: 'method.foo.bar.1'
  }
}
```
