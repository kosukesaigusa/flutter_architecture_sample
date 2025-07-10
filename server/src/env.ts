import type { D1Database } from '@cloudflare/workers-types'
import { AppLogger } from './util/logger'
import { DrizzleD1Database } from 'drizzle-orm/d1'

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
