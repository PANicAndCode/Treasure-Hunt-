-- Treasure Hunt setup
create table if not exists public.leaderboard_treasure_hunt (
  team_id text primary key,
  team_name text not null,
  found integer not null default 0,
  finished boolean not null default false,
  last_updated_at bigint not null
);

create table if not exists public.team_progress_treasure_hunt (
  team_id text primary key,
  team_name text not null,
  sequence jsonb not null default '[]'::jsonb,
  progress_index integer not null default 0,
  completed jsonb not null default '[]'::jsonb,
  scanned_tokens jsonb not null default '[]'::jsonb,
  used_hints integer not null default 0,
  next_hint_at bigint,
  finished boolean not null default false,
  started_at bigint not null default 0,
  last_updated_at bigint not null default 0,
  map_enabled boolean
);

alter table public.leaderboard_treasure_hunt enable row level security;
alter table public.team_progress_treasure_hunt enable row level security;

drop policy if exists "leaderboard_treasure_hunt read" on public.leaderboard_treasure_hunt;
create policy "leaderboard_treasure_hunt read" on public.leaderboard_treasure_hunt for select to anon using (true);

drop policy if exists "leaderboard_treasure_hunt insert" on public.leaderboard_treasure_hunt;
create policy "leaderboard_treasure_hunt insert" on public.leaderboard_treasure_hunt for insert to anon with check (true);

drop policy if exists "leaderboard_treasure_hunt update" on public.leaderboard_treasure_hunt;
create policy "leaderboard_treasure_hunt update" on public.leaderboard_treasure_hunt for update to anon using (true) with check (true);

drop policy if exists "leaderboard_treasure_hunt delete" on public.leaderboard_treasure_hunt;
create policy "leaderboard_treasure_hunt delete" on public.leaderboard_treasure_hunt for delete to anon using (true);

drop policy if exists "progress_treasure_hunt read" on public.team_progress_treasure_hunt;
create policy "progress_treasure_hunt read" on public.team_progress_treasure_hunt for select to anon using (true);

drop policy if exists "progress_treasure_hunt insert" on public.team_progress_treasure_hunt;
create policy "progress_treasure_hunt insert" on public.team_progress_treasure_hunt for insert to anon with check (true);

drop policy if exists "progress_treasure_hunt update" on public.team_progress_treasure_hunt;
create policy "progress_treasure_hunt update" on public.team_progress_treasure_hunt for update to anon using (true) with check (true);

drop policy if exists "progress_treasure_hunt delete" on public.team_progress_treasure_hunt;
create policy "progress_treasure_hunt delete" on public.team_progress_treasure_hunt for delete to anon using (true);

do $$
begin
  if not exists (
    select 1
    from pg_publication p
    join pg_publication_rel pr on pr.prpubid = p.oid
    join pg_class c on c.oid = pr.prrelid
    join pg_namespace n on n.oid = c.relnamespace
    where p.pubname = 'supabase_realtime'
      and n.nspname = 'public'
      and c.relname = 'leaderboard_treasure_hunt'
  ) then
    alter publication supabase_realtime add table public.leaderboard_treasure_hunt;
  end if;
end $$;

do $$
begin
  if not exists (
    select 1
    from pg_publication p
    join pg_publication_rel pr on pr.prpubid = p.oid
    join pg_class c on c.oid = pr.prrelid
    join pg_namespace n on n.oid = c.relnamespace
    where p.pubname = 'supabase_realtime'
      and n.nspname = 'public'
      and c.relname = 'team_progress_treasure_hunt'
  ) then
    alter publication supabase_realtime add table public.team_progress_treasure_hunt;
  end if;
end $$;

insert into public.team_progress_treasure_hunt
  (team_id, team_name, sequence, progress_index, completed, scanned_tokens, used_hints, next_hint_at, finished, started_at, last_updated_at, map_enabled)
values
  ('__settings__', 'Shared Settings', '[]'::jsonb, 0, '[]'::jsonb, '[]'::jsonb, 0, null, false, 0, 0, false)
on conflict (team_id) do nothing;

-- Reset script
-- delete from public.team_progress_treasure_hunt where team_id <> '__settings__';
-- delete from public.leaderboard_treasure_hunt;
-- update public.team_progress_treasure_hunt set map_enabled = false where team_id = '__settings__';
