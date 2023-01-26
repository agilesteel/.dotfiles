local wezterm = require 'wezterm'

local wsl_domains = wezterm.default_wsl_domains()

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

for _, domain in ipairs(wsl_domains) do
  domain.default_cwd = "~"
end

return {
  adjust_window_size_when_changing_font_size = false,
  audible_bell = 'Disabled',
  colors = {
    foreground = '#C0C5CE',
    background = '#2B303B',

    ansi = {
      '#4C4C4C', -- black
      '#FF3C3C', -- red
      '#0DBC79', -- green
      '#E5E510', -- yellow
      '#3B8EEA', -- blue
      '#BC3FBC', -- magenta
      '#11A8CD', -- cyan
      '#E5E5E5', -- white
    },

    brights = {
      '#666666', -- black
      '#F14C4C', -- red
      '#23D18B', -- green
      '#F5F543', -- yellow
      '#3B8EEA', -- blue
      '#D670D6', -- magenta
      '#29B8DB', -- cyan
      '#E5E5E5', -- white
    }
  },
  background = {
    {
      source = {
        File = 'D:\\BTSync\\shared\\ricki\\Illustrations\\ricki-do-not-delete-this-one.png',
      },
    },
    {
      source = {
        File = 'D:\\BTSync\\shared\\ricki\\Illustrations\\Illustration_02_1920x1080.png',
      },
      horizontal_align = 'Center',
      vertical_align = 'Middle',
      height = 'Contain',
      width = 'Contain',
      repeat_x = 'NoRepeat',
      repeat_y = 'NoRepeat',
      opacity = 0.1
    },
  },
  color_scheme = 'SpaceGray',
  disable_default_key_bindings = true,
  exit_behavior = 'Close',
  font = wezterm.font {
    family = 'FiraCode NFM',
    weight = 'Light',
    stretch = 'Normal',
    style = 'Normal',
    harfbuzz_features = { 'cv29', 'cv30', 'ss01', 'ss03', 'ss06', 'ss07', 'ss09' },
  },
  font_size = 17.1,
  force_reverse_video_cursor = true,
  hide_tab_bar_if_only_one_tab = true,
  keys = {
    { action = wezterm.action.CopyTo 'Clipboard', mods = 'CTRL|SHIFT', key = 'C' },
    { action = wezterm.action.DecreaseFontSize, mods = 'CTRL', key = '-' },
    { action = wezterm.action.IncreaseFontSize, mods = 'CTRL', key = '=' },
    { action = wezterm.action.Nop, mods = 'ALT', key = 'Enter' },
    { action = wezterm.action.PasteFrom 'Clipboard', mods = 'CTRL|SHIFT', key = 'V' },
    { action = wezterm.action.ResetFontSize, mods = 'CTRL', key = '0' },
    { action = wezterm.action.ToggleFullScreen, key = 'F11' },
  },
  scrollback_lines = 10000,
  show_update_window = true,
  use_dead_keys = false,
  unicode_version = 14,
  window_close_confirmation = 'NeverPrompt',
  window_padding = {
    left = 0,
    right = 0,
    top = '0.2cell',
    bottom = 0,
  },
  wsl_domains = wsl_domains,
}
