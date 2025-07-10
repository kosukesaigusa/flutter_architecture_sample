import type { D1Database } from '@cloudflare/workers-types'
import type { DrizzleD1Database } from 'drizzle-orm/d1'
import type { AppLogger } from './util/logger'

/**
 * 環境変数の型定義。
 */
export type EnvironmentVariables = {
  Bindings: {
    DB: D1Database
    FIREBASE_PROJECT_ID: string
  }
  Variables: {
    db: DrizzleD1Database
    logger: AppLogger
    userId: string
  }
}
