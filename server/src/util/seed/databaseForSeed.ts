import type { BetterSQLite3Database } from 'drizzle-orm/better-sqlite3'
import type { DrizzleD1Database } from 'drizzle-orm/d1'

/**
 * シードデータを挿入するデータベースの型。
 * ローカル環境では BetterSQLite3Database 型、
 * リモート環境では DrizzleD1Database 型を使用する。
 */
export type DatabaseForSeed = BetterSQLite3Database | DrizzleD1Database
