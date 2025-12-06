Project: lua-love2d-pong

Short purpose
- Single-file LÖVE (Love2D) Pong demo. Primary entry point: `main.lua`.

Big picture
- Architecture: tiny procedural game in one file. Uses LÖVE callbacks: `love.load`, `love.update(dt)`, `love.draw` for initialization, per-frame updates, and rendering. Example: `love.graphics.rectangle("fill", 100, 100, 100, 100)` (see `main.lua`).
- Data flow: input polled in `love.update(dt)` (uses `love.keyboard.isDown`), game state mutated directly in globals/local variables, and rendered in `love.draw()`.

Developer workflows
- Run locally with the LÖVE runtime from the project root:
  - In PowerShell: ``love .`` (ensure Love2D is installed and `love` is on PATH). Running from terminal shows `print()` output for debugging.
- Debugging: this project uses `print()` for console output. Prefer launching via terminal to capture stdout/stderr (double-clicking the executable may hide logs on Windows).

Project-specific conventions & patterns
- Single-file procedural style — expect all game logic in `main.lua`. When making changes, update `main.lua` and run `love .`.
- Input polling: the code polls keys in `love.update(dt)` with `love.keyboard.isDown("up")` / `love.keyboard.isDown("down")`. For single key events, add `love.keypressed(key)` handlers instead of polling.
- Rendering: immediate-mode rendering via `love.graphics.*` inside `love.draw()`; no retained scene graph or entity system.
- No external dependencies or build steps detected — repository is runnable directly with LÖVE.

Notable code observations (useful for edits)
- `main.lua` contains both `love.KeyBoard.isDown("down")` and `love.keyboard.isDown("up")` — Lua is case-sensitive; prefer `love.keyboard.isDown`. Search-and-fix this pattern when adjusting input handling.
- Coordinates and sizes are in pixels; the project uses `love.graphics.rectangle("fill", x, y, w, h)` directly.

Integration points
- No external services or libraries detected. Integration surface is limited to the LÖVE runtime and the host OS (for running the game).

If you are an AI assistant contributing code
- Keep changes small and focused: modify `main.lua` and re-run `love .` to validate behavior.
- Prefer using existing LÖVE callbacks rather than adding heavy frameworks: keep the procedural style consistent.
- When adding new files, mention them in this guidance and keep the root runnable with `love .`.

Where to look first
- `main.lua`: primary code to change and inspect.

What I changed
- Added this guidance file to root `.github/` to document repo-specific patterns and run/debug steps.

Questions for maintainers
- Which LÖVE version should contributors assume? (Please add version to README or this file.)
