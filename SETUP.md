# METHOD · Cycle — setup (do these in order)

## 1. Supabase project (10 min)
1. supabase.com → New project. Region: **West EU (London)**. Save the DB password somewhere.
2. Left menu → **SQL Editor** → New query → paste all of `supabase/schema.sql` → Run.
3. Left menu → **Authentication → Providers → Email**: turn **Confirm email OFF** (otherwise Holly has to click a confirmation link before she can sign in — fine later, friction now).
4. Left menu → **Project Settings → API**. Copy **Project URL** and **anon public** key.
5. Open `index.html` in a text editor. Top of file, `METHOD_CONFIG`: paste those two values into `SUPABASE_URL` and `SUPABASE_ANON_KEY`. Save.

That's the link. The page now shows a sign-in screen; her logs save to your database.

## 2. Coach AI (optional, 5 min, needs a terminal)
```
npm i -g supabase
supabase login
supabase link --project-ref <ref from your project URL>
supabase secrets set ANTHROPIC_API_KEY=sk-ant-...
supabase functions deploy coach
```
Skip this and the chat still works with built-in offline replies.

## 3. Put it online (5 min)
app.netlify.com/drop → drag the `holly-cycle` folder on → copy the URL → send it to Holly.
She opens it in Safari → Share → Add to Home Screen → creates her account.

## Coach view (you)
Supabase → Table Editor → `coach_cycle_logs` (email + every log). Export CSV from there.

## Rules of the road
- Health data: UK GDPR special category. One athlete who's said yes is fine. Beyond that, write a one-paragraph privacy notice into the sign-up screen.
- She can wipe everything herself: Settings → Delete my data.
- To preview without Supabase, leave `SUPABASE_URL` empty — no login, data stays on that device.
