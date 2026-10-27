# METHOD · Cycle

Menstrual-cycle tracking alongside training, for METHOD. athletes.

- `index.html` — the whole app (React, single file). Deployed by Netlify on every push to `main`.
- `supabase/schema.sql` — database tables + row-level security. Run once in Supabase → SQL Editor.
- `supabase/functions/coach/index.ts` — the M. coach proxy. Holds the Anthropic key and the full Garibaldi v1.0 framework. Deploy via Supabase → Edge Functions.
- `SETUP.md` — setup notes.

Private repo: `index.html` carries the Supabase project URL and anon key (safe to be public per Supabase, but no reason to advertise it).
