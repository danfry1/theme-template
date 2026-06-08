# theme-template

Generate terminal, editor, and CLI color themes from a single `palette.json`.

## Use this template
1. Click **Use this template** (or copy this repo).
2. `bun install`
3. `bun run init-theme <YourThemeName>`   # renames the Neovim module + sets the name
4. Edit `palette.json` — backgrounds, foregrounds, 8 role-based accents, ansi.
5. `bun run generate`                      # writes all targets + validates WCAG contrast
6. `bun run test` and `bash scripts/nvim-smoke.sh` to verify.

## Palette schema
- `backgrounds`: `shadow`, `dim`, `base`, `surface0`, `surface1`, `surface2` (dark → light)
- `foregrounds`: `text`, `subtext`, `overlay`, `comment`
- `accents` (role-based): `keyword`, `func`, `type`, `string`, `number`, `operator`, `tag`, `error`
- `ansi`: 16 standard colors · `special`: `cursor`, `selection`

## Outputs
VS Code, Zed, Neovim, kitty, alacritty, wezterm, iterm2, ghostty, foot, windows-terminal,
fzf, bat, delta, lazygit, tmux, opencode.

## Contrast
`scripts/validate-contrast.ts` enforces WCAG AA (text 4.5:1, accents 4.5:1 on base). `bun run generate` fails if a palette doesn't pass.
