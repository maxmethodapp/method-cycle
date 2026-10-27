-- METHOD · Cycle tracking — run once in Supabase → SQL Editor
-- Access model: Supabase Auth (email + password). Every row belongs to the
-- signed-in user (auth.uid()); row-level security hides everyone else's.

create table if not exists public.cycle_logs (
  id          uuid primary key default gen_random_uuid(),
  athlete_id  uuid not null default auth.uid() references auth.users (id) on delete cascade,
  log_date    date not null,
  period      boolean not null default false,
  flow        text check (flow in ('light','medium','heavy') or flow is null),
  energy      smallint check (energy between 1 and 5),
  motivation  smallint check (motivation between 1 and 5),
  mood        smallint check (mood between 1 and 5),
  symptoms    text[] not null default '{}',
  note        text not null default '',
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now(),
  unique (athlete_id, log_date)
);

create table if not exists public.athlete_settings (
  athlete_id    uuid primary key default auth.uid() references auth.users (id) on delete cascade,
  cycle_length  smallint not null default 28 check (cycle_length between 20 and 45),
  period_length smallint not null default 5  check (period_length between 2 and 10),
  updated_at    timestamptz not null default now()
);

alter table public.cycle_logs       enable row level security;
alter table public.athlete_settings enable row level security;

drop policy if exists "own logs" on public.cycle_logs;
create policy "own logs" on public.cycle_logs
  for all to authenticated
  using (athlete_id = auth.uid()) with check (athlete_id = auth.uid());

drop policy if exists "own settings" on public.athlete_settings;
create policy "own settings" on public.athlete_settings
  for all to authenticated
  using (athlete_id = auth.uid()) with check (athlete_id = auth.uid());

-- Coach view (you): Table Editor → cycle_logs. Who is who: Authentication → Users.
-- Handy view that joins the email on:
create or replace view public.coach_cycle_logs as
  select u.email, l.* from public.cycle_logs l join auth.users u on u.id = l.athlete_id;
revoke all on public.coach_cycle_logs from anon, authenticated;  -- dashboard only

-- v1.1 — explicit period start / end markers (run this block if the tables already exist)
alter table public.cycle_logs add column if not exists period_start boolean not null default false;
alter table public.cycle_logs add column if not exists period_end   boolean not null default false;
