import { env } from 'cloudflare:test'
import { drizzle } from 'drizzle-orm/d1'
import { testClient } from 'hono/testing'
import routes from '../..'

/**
 * テスト用の API クライアントを取得する。
 * @returns テスト用の API クライアント
 */
export const getTestClient = async () => testClient(routes, env)

/**
 * テスト用の Drizzle クライアントを取得する。
 * @returns テスト用の Drizzle クライアント
 */
export const getTestDrizzleClient = () => drizzle(env.DB)
