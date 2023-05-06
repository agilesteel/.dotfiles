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
  background = {
    {
      source = {
        -- File = 'd:\\btsync\\shared\\ricki\\illustrations\\ricki-do-not-delete-this-one.png',
        File = 'D:\\BTSync\\agilenet\\nodes\\common\\WezTerm\\themes\\catpuccin\\frappe\\background.png',
        -- File = 'D:\\BTSync\\agilenet\\nodes\\common\\WezTerm\\themes\\catpuccin\\mocha\\background.png',
      },
    },
    -- {
    --   source = {
    --     -- File = 'D:\\BTSync\\shared\\ricki\\Illustrations\\Illustration_02_1920x1080.png',
    --     -- File = 'D:\\BTSync\\shared\\ricki\\Illustrations\\Illustration_02_1920x1080_v02.png',
    --     -- File = 'D:\\BTSync\\shared\\ricki\\Illustrations\\Illustration_02_3840x2160_v02.png',
    --     -- File = 'D:\\BTSync\\shared\\ricki\\i4.png',
    --     -- File = 'D:\\BTSync\\shared\\ricki\\i5.png',
    --     -- File = 'D:\\test.png',
    --     File = 'D:\\elephant.png',
    --   },
    --   horizontal_align = 'Center',
    --   vertical_align = 'Middle',
    --   height = 'Contain',
    --   width = 'Contain',
    --   repeat_x = 'NoRepeat',
    --   repeat_y = 'NoRepeat',
    --   opacity = 0.1
    -- },
  },
  color_scheme = 'Catppuccin Frappe',
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
  hide_mouse_cursor_when_typing = true,
  hide_tab_bar_if_only_one_tab = true,
  keys = {
    { action = wezterm.action.ActivateCommandPalette, mods = 'CTRL|SHIFT', key =     'P' },
    { action = wezterm.action.CopyTo    'Clipboard' , mods = 'CTRL|SHIFT', key =     'C' },
    { action = wezterm.action.DecreaseFontSize      , mods =       'CTRL', key =     '-' },
    { action = wezterm.action.IncreaseFontSize      , mods =       'CTRL', key =     '=' },
    { action = wezterm.action.Nop                   , mods =        'ALT', key = 'Enter' },
    { action = wezterm.action.PasteFrom 'Clipboard' , mods = 'CTRL|SHIFT', key =     'V' },
    { action = wezterm.action.ResetFontSize         , mods =       'CTRL', key =     '0' },
    { action = wezterm.action.ToggleFullScreen      ,                      key =   'F11' },
  },
  scrollback_lines = 10000,
  show_update_window = true,
  use_dead_keys = false,
  unicode_version = 15,
  window_close_confirmation = 'NeverPrompt',
  window_padding = {
    left = 0,
    right = 0,
    top = '0.2cell',
    bottom = 0,
  },
  wsl_domains = wsl_domains,
}
