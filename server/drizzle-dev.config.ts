// https://orm.drizzle.team/docs/kit-overview#how-to-migrate-to-0210

import type { Config } from 'drizzle-kit'

export default {
  schema: './src/schema.ts',
  out: './drizzle/migrations',
  driver: 'd1-http',
  dialect: 'sqlite',
  dbCredentials: {
    accountId: '4f29a10957e4205c8c867e6b0f4fc924',
    databaseId: 'c170714c-a73c-40d9-9564-db5f507fccee',
    token: '',
  },
} satisfies Config 
