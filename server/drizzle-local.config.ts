// https://orm.drizzle.team/docs/kit-overview#how-to-migrate-to-0210
// https://zenn.dev/king/articles/3d5610429811eb
// https://zenn.dev/fjimiz/articles/1946ed01c183ef

import type { Config } from 'drizzle-kit'

export default {
  schema: './src/schema.ts',
  out: './drizzle/migrations',
  dialect: 'sqlite',
  dbCredentials: {
    url: './.wrangler/state/v3/d1/miniflare-D1DatabaseObject/c87f22348204f17f45374088202a3d409e2570cc27eb3dbb78f5ca605f74ab14.sqlite',
  },
} satisfies Config
