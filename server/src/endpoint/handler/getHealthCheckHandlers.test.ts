import { getTestClient } from '../../util/test-util/testClient'

describe('Test for GET /', () => {
  it('GET / のリクエストに成功する', async () => {
    // テストクライアントを作成する。
    const client = await getTestClient()

    // API の疎通確認用をする。
    const res = await client.index.$get()

    // ステータスコードを検証する。
    expect(res.status).toBe(200)

    // レスポンスデータを検証する。
    const data = await res.json()
    expect(data).toStrictEqual({ message: 'Hello, World!' })
  })
})
