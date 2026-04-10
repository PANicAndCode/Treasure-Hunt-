# Treasure Hunt

This package is a reusable QR-based hunt site with unlimited custom teams, join-or-create team flow, mascot selection, shared live progress, named game presets, and a random clue order for each team. Clues 1 through 10 are shuffled once per team, and clue 11 stays last for everyone.

## What is included
- Website files (`index.html`, `styles.css`, `config.js`, `supabase-config.js`)
- Split runtime files (`script-part-1.js` through `script-part-4.js`) for deployment
- `treasure_hunt_setup.sql` for a brand-new Supabase setup
- `leaderboard_and_progress_setup.sql` as an alternate full setup file
- `dynamic_teams_migration.sql` for upgrading an older fixed-team database
- `supabase-config.js` for your project URL and anon key

## Setup
1. Upload the website files to your `Treasure-Hunt-` repo.
2. Put your real Supabase URL and anon key into `supabase-config.js`.
3. Run `treasure_hunt_setup.sql` in Supabase.
4. If you are upgrading an older fixed-team install, run `dynamic_teams_migration.sql` once after the main setup file.
5. Hard refresh phones after publishing.

## Notes
- This build remembers the same team on the same device after the first join.
- Players can either create a new team or join an existing team that was already created.
- The admin view is available from the opening screen and the top bar.
- `Leave this device` is admin-only.
- The admin panel can reset one team or wipe the full game.
- The admin panel can save multiple named game presets, switch the live preset, and delete old custom presets.
- Each preset can edit clue text, location, and hints for clues 1 through 10. Clue 11 stays the final clue, but its clue text and location are editable.
- Map features are intentionally disabled in this generic build.
- The first three finishers can be sent to the host for the 1st, 2nd, and 3rd place prizes.
- Change `ADMIN_PASSCODE` in the runtime files before using this for a real event.
