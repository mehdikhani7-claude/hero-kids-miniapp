# Hero Kids Mini App — starter

A mobile-first Persian RTL Next.js starter for the Hero Kids Telegram Mini App and website experience.

## Included in this first build
- Responsive parent / coach / admin / child dashboard preview
- Role switcher for reviewing the four experiences
- Bottom mobile navigation
- Initial Supabase client placeholder and SQL data model
- Telegram WebApp client initializer (identity must be verified server-side)
- Environment variable template with no secrets

## Run locally

```bash
npm install
cp .env.example .env.local
npm run dev
```

Open http://localhost:3000. Supabase settings are optional for the UI preview.

## Before production
1. Confirm the current hosting/repository arrangement and whether the existing website should be migrated or only linked.
2. Create Supabase project and apply a reviewed schema with row-level security policies. The included SQL intentionally does not enable public access policies.
3. Implement server-side Telegram `initData` HMAC validation; never trust `initDataUnsafe` for authentication.
4. Implement role assignment through trusted server/admin flows, not user-editable profile fields.
5. Integrate a payment provider only after selecting the provider and implementing server-side payment verification and webhook handling.
6. Add privacy notice, guardian consent, data minimization, retention and deletion procedures for children's data.

## Deployment
Netlify supports Next.js SSR through its current Next.js adapter. Link this project to the intended repository/site and deploy with the standard Next.js build (`next build`). Do not expose secrets with `NEXT_PUBLIC_` variables.
