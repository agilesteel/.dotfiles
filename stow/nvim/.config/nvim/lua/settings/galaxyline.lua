--https://github.com/glepnir/galaxyline.nvim
local M = {}
local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = { "LuaTree", "vista" }

local colors = {
  bg = "#282c34", -- black
  line_bg = "#353644",
  fg = "#abb2bf", -- white

  dark_red = "#be5046",
  dark_yellow = "#d19a66",
  gutter_grey = "#4b5263",
  comment_grey = "#5c6370",

  yellow = "#e5c07b", -- light yellow
  cyan = "#56b6c2", -- cyan
  green = "#98c379", -- green
  orange = "#be5046",
  purple = "#5d4d7a",
  magenta = "#c678dd", -- magenta
  blue = "#61afef", -- blue
  red = "#e06c75", -- light red
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end

M.setup = function()
  gls.left[1] = {
    ViMode = {
      provider = function()
        local mode_color = {
          n = colors.blue,
          i = colors.green,
          [""] = colors.magenta, -- visual block
          v = colors.magenta,
          [""] = colors.magenta,
          V = colors.magenta,
          c = colors.red,
          no = colors.magenta,
          s = colors.orange,
          S = colors.orange,
          [""] = colors.orange, -- select block
          ic = colors.yellow,
          R = colors.purple,
          Rv = colors.purple,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red,
        }
        vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
        return "▊ "
      end,
      highlight = { colors.red, colors.line_bg },
    },
  }
  gls.left[2] = {
    FileIcon = {
      provider = "FileIcon",
      condition = buffer_not_empty,
      highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.line_bg },
    },
  }
  gls.left[3] = {
    FileName = {
      provider = { "FileName" },
      condition = buffer_not_empty,
      highlight = { colors.fg, colors.line_bg },
    },
  }
  gls.left[4] = {
    GitIcon = {
      provider = function()
        return "  "
      end,
      condition = require("galaxyline.provider_vcs").check_git_workspace,
      highlight = { colors.orange, colors.line_bg },
    },
  }
  gls.left[5] = {
    GitBranch = {
      provider = "GitBranch",
      condition = require("galaxyline.provider_vcs").check_git_workspace,
      highlight = { colors.fg, colors.line_bg },
    },
  }
  gls.left[6] = {
    LeftEnd = {
      provider = function()
        return ""
      end,
      separator = "",
      separator_highlight = { colors.line_bg, colors.line_bg },
      highlight = { colors.bg, colors.line_bg },
    },
  }
  gls.left[7] = {
    DiagnosticError = {
      provider = "DiagnosticError",
      icon = " ",
      highlight = { colors.red, colors.bg },
    },
  }
  gls.left[8] = {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = " ",
      highlight = { colors.yellow, colors.bg },
    },
  }
  gls.left[9] = {
    MetalsStatus = {
      provider = function()
        return "  " .. (vim.g["metals_status"] or "")
      end,
      highlight = { colors.line_bg, colors.bg },
    },
  }
  gls.right[1] = {
    FileFormat = {
      provider = "FileFormat",
      separator = " ",
      separator_highlight = { colors.bg, colors.line_bg },
      highlight = { colors.fg, colors.line_bg },
    },
  }
  gls.right[2] = {
    LineInfo = {
      provider = "LineColumn",
      separator = " | ",
      separator_highlight = { colors.blue, colors.line_bg },
      highlight = { colors.fg, colors.line_bg },
    },
  }
  gls.right[3] = {
    ScrollBar = {
      provider = "ScrollBar",
      separator = " | ",
      separator_highlight = { colors.blue, colors.line_bg },
      highlight = { colors.blue, colors.purple },
    },
  }
  gls.short_line_left[1] = {
    BufferType = {
      provider = "FileTypeName",
      separator = "",
      separator_highlight = { colors.purple, colors.bg },
      highlight = { colors.fg, colors.purple },
    },
  }
  gls.short_line_right[1] = {
    BufferIcon = {
      provider = "BufferIcon",
      separator = "",
      separator_highlight = { colors.purple, colors.bg },
      highlight = { colors.fg, colors.purple },
    },
  }
end

return M
