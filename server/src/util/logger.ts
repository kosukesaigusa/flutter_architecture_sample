import { pino } from 'pino'

/**
 * アプリケーション全体で使用するロガークラス。
 * 構造化ロギングを提供し、リクエスト ID などのコンテキスト情報を含めることができる。
 */
export class AppLogger {
  private logger: pino.Logger
  private requestId?: string

  // ログレベルごとの絵文字。
  private static readonly LOG_EMOJI = {
    debug: '🐛',
    info: '💡',
    warn: '⚠️',
    error: '⛔',
  } as const

  // 区切り線。
  private static readonly SEPARATOR_LINE = '─'.repeat(10)

  /**
   * AppLogger のコンストラクタ。
   * @param options - ロガーのオプション。
   */
  constructor(options?: { requestId?: string }) {
    this.requestId = options?.requestId
    this.logger = pino({
      level: process.env.NODE_ENV === 'production' ? 'info' : 'debug',
      timestamp: pino.stdTimeFunctions.isoTime,
    })
  }

  /**
   * カスタムフォーマットでログを出力する。
   * @param level - ログレベル。
   * @param message - ログメッセージ。
   * @param data - 追加のデータオブジェクト。
   */
  private log(
    level: 'debug' | 'info' | 'warn' | 'error',
    message: string,
    data?: Record<string, unknown>,
  ): void {
    // 絵文字付きメッセージを作成する。
    const emoji = AppLogger.LOG_EMOJI[level]
    const messageWithEmoji = `${emoji} ${message}`

    // メッセージとリクエスト ID を含むデータオブジェクトを作成する。
    const logData = {
      ...(this.requestId ? { requestId: this.requestId } : {}),
      ...(data || {}),
    }

    // データを JSON 文字列に変換する。
    const dataJson =
      Object.keys(logData).length > 0 ? JSON.stringify(logData, null, 2) : ''

    // 区切り線で囲まれたログメッセージを作成する。
    const formattedLog = [
      AppLogger.SEPARATOR_LINE,
      messageWithEmoji,
      dataJson,
      AppLogger.SEPARATOR_LINE,
    ]
      .filter(Boolean)
      .join('\n')

    // ログを出力する。
    this.logger[level](formattedLog)
  }

  /**
   * デバッグレベルのログを出力する。
   * @param message - ログメッセージ。
   * @param data - 追加のデータオブジェクト。
   */
  debug(message: string, data?: Record<string, unknown>): void {
    this.log('debug', message, data)
  }

  /**
   * 情報レベルのログを出力する。
   * @param message - ログメッセージ。
   * @param data - 追加のデータオブジェクト。
   */
  info(message: string, data?: Record<string, unknown>): void {
    this.log('info', message, data)
  }

  /**
   * 警告レベルのログを出力する。
   * @param message - ログメッセージ。
   * @param data - 追加のデータオブジェクト。
   */
  warn(message: string, data?: Record<string, unknown>): void {
    this.log('warn', message, data)
  }

  /**
   * エラーレベルのログを出力する。
   * @param message - ログメッセージ。
   * @param error - エラーオブジェクト。
   * @param data - 追加のデータオブジェクト。
   */
  error(message: string, error?: Error, data?: Record<string, unknown>): void {
    const errorData = error
      ? {
          error: {
            message: error.message,
            stack: error.stack,
            name: error.name,
          },
        }
      : {}

    this.log('error', message, {
      ...(data || {}),
      ...errorData,
    })
  }
}
