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

create table if not exists public.game_presets_treasure_hunt (
  preset_id text primary key,
  preset_name text not null,
  clues jsonb not null,
  is_active boolean not null default false,
  created_at bigint not null default 0,
  updated_at bigint not null default 0
);

alter table public.leaderboard_treasure_hunt enable row level security;
alter table public.team_progress_treasure_hunt enable row level security;
alter table public.game_presets_treasure_hunt enable row level security;

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

drop policy if exists "game_presets_treasure_hunt read" on public.game_presets_treasure_hunt;
create policy "game_presets_treasure_hunt read" on public.game_presets_treasure_hunt for select to anon using (true);

drop policy if exists "game_presets_treasure_hunt insert" on public.game_presets_treasure_hunt;
create policy "game_presets_treasure_hunt insert" on public.game_presets_treasure_hunt for insert to anon with check (true);

drop policy if exists "game_presets_treasure_hunt update" on public.game_presets_treasure_hunt;
create policy "game_presets_treasure_hunt update" on public.game_presets_treasure_hunt for update to anon using (true) with check (true);

drop policy if exists "game_presets_treasure_hunt delete" on public.game_presets_treasure_hunt;
create policy "game_presets_treasure_hunt delete" on public.game_presets_treasure_hunt for delete to anon using (true);

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
      and c.relname = 'game_presets_treasure_hunt'
  ) then
    alter publication supabase_realtime add table public.game_presets_treasure_hunt;
  end if;
end $$;

insert into public.team_progress_treasure_hunt
  (team_id, team_name, sequence, progress_index, completed, scanned_tokens, used_hints, next_hint_at, finished, started_at, last_updated_at, map_enabled)
values
  ('__settings__', 'Shared Settings', '[]'::jsonb, 0, '[]'::jsonb, '[]'::jsonb, 0, null, false, 0, 0, false)
on conflict (team_id) do nothing;

insert into public.game_presets_treasure_hunt
  (preset_id, preset_name, clues, is_active, created_at, updated_at)
values
  (
    'preset-default',
    'Default Hunt',
    $json$
    {
      "1": { "title": "Your first checkpoint waits where visitors usually arrive.", "location": "Front entrance", "hint": "Start near the main way in.", "zone": { "x": 18, "y": 18 } },
      "2": { "title": "Search the place where people gather for quick updates.", "location": "Common table", "hint": "Think about the busiest surface in the space.", "zone": { "x": 33, "y": 26 } },
      "3": { "title": "The next clue is hiding near something that opens and closes all day.", "location": "Supply cabinet", "hint": "Look for a door with shared tools inside.", "zone": { "x": 48, "y": 20 } },
      "4": { "title": "Check the spot that lights up the room when the sun is gone.", "location": "Floor lamp", "hint": "Find a warm glow.", "zone": { "x": 63, "y": 18 } },
      "5": { "title": "Head to the place where teams pause between missions.", "location": "Lounge corner", "hint": "Look for a good place to sit and regroup.", "zone": { "x": 77, "y": 26 } },
      "6": { "title": "Your next checkpoint is near something cold and useful.", "location": "Kitchen fridge", "hint": "Search where drinks and snacks stay chilled.", "zone": { "x": 72, "y": 44 } },
      "7": { "title": "Find the clue hiding close to the clean-up station.", "location": "Sink area", "hint": "Water, soap, and hand towels.", "zone": { "x": 58, "y": 52 } },
      "8": { "title": "The next clue sits near a place built for storing the extras.", "location": "Storage shelf", "hint": "Look where backup supplies live.", "zone": { "x": 41, "y": 58 } },
      "9": { "title": "Search the edge of the room where people usually line up gear.", "location": "Wall hooks", "hint": "Think bags, coats, or keys.", "zone": { "x": 26, "y": 68 } },
      "10": { "title": "The final regular checkpoint is waiting near a place with fresh air.", "location": "Patio door", "hint": "Look where inside meets outside.", "zone": { "x": 82, "y": 66 } },
      "11": { "title": "Final clue: look where winners would leave proof they made it.", "location": "Prize table", "hint": "You can't use a hint for this clue.", "noHint": true, "zone": { "x": 50, "y": 80 } }
    }
    $json$::jsonb,
    true,
    0,
    0
  )
on conflict (preset_id) do nothing;

-- Reset script
-- delete from public.team_progress_treasure_hunt where team_id <> '__settings__';
-- delete from public.leaderboard_treasure_hunt;
-- update public.team_progress_treasure_hunt set map_enabled = false where team_id = '__settings__';
