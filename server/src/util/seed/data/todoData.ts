import { ulid } from 'ulidx'
import { DEFAULT_USER_IDS } from './userIds'

/**
 * Todo のシードデータ。
 */
export const TODO_DATA = [
  // USER_1 の Todo
  {
    todoId: ulid(),
    title: '牛乳を買いに行く',
    description: '冷蔵庫の牛乳がなくなったので、帰りにスーパーで買って帰る。',
    userId: DEFAULT_USER_IDS.USER_1,
    createdAt: new Date('2024-01-01T09:00:00Z').toISOString(),
    updatedAt: new Date('2024-01-01T09:00:00Z').toISOString(),
  },
  {
    todoId: ulid(),
    title: '歯医者の予約を取る',
    description: '定期検診のため、来週の歯医者の予約を電話で取る。',
    userId: DEFAULT_USER_IDS.USER_1,
    createdAt: new Date('2024-01-02T10:30:00Z').toISOString(),
    updatedAt: new Date('2024-01-02T10:30:00Z').toISOString(),
  },
  {
    todoId: ulid(),
    title: '本を図書館に返す',
    description: '先週借りた小説3冊を返却期限までに図書館に返しに行く。',
    userId: DEFAULT_USER_IDS.USER_1,
    createdAt: new Date('2024-01-03T14:15:00Z').toISOString(),
    updatedAt: new Date('2024-01-03T14:15:00Z').toISOString(),
  },
  {
    todoId: ulid(),
    title: 'ジムに行く',
    description: '今週は運動不足なので、土曜日にジムに行って1時間運動する。',
    userId: DEFAULT_USER_IDS.USER_1,
    createdAt: new Date('2024-01-04T11:00:00Z').toISOString(),
    updatedAt: new Date('2024-01-04T11:00:00Z').toISOString(),
  },
  {
    todoId: ulid(),
    title: '洗濯機を掃除する',
    description: '洗濯機の掃除をしていないので、洗濯槽クリーナーで清掃する。',
    userId: DEFAULT_USER_IDS.USER_1,
    createdAt: new Date('2024-01-05T13:45:00Z').toISOString(),
    updatedAt: new Date('2024-01-05T13:45:00Z').toISOString(),
  },

  // USER_2 の Todo
  {
    todoId: ulid(),
    title: '友達と映画を見る',
    description: '来週の日曜日に友達と新作映画を見る約束をしているので、チケットを予約する。',
    userId: DEFAULT_USER_IDS.USER_2,
    createdAt: new Date('2024-01-06T08:30:00Z').toISOString(),
    updatedAt: new Date('2024-01-06T08:30:00Z').toISOString(),
  },
  {
    todoId: ulid(),
    title: '部屋の掃除をする',
    description: '週末に部屋の掃除機をかけて、机の周りも整理整頓する。',
    userId: DEFAULT_USER_IDS.USER_2,
    createdAt: new Date('2024-01-07T16:20:00Z').toISOString(),
    updatedAt: new Date('2024-01-07T16:20:00Z').toISOString(),
  },
  {
    todoId: ulid(),
    title: '家計簿をつける',
    description: '今月の支出をまとめて家計簿アプリに記録する。',
    userId: DEFAULT_USER_IDS.USER_2,
    createdAt: new Date('2024-01-08T09:15:00Z').toISOString(),
    updatedAt: new Date('2024-01-08T09:15:00Z').toISOString(),
  },
] as const
