local wezterm = require("wezterm")
local config = require("config")
local cyberdream_theme = require("cyberdream")
require("events")

-- Apply color scheme based on the WEZTERM_THEME environment variable
local themes = {
	onedark = "One Dark (Gogh)",
	nord = "Nord (Gogh)",
}
local success, stdout, stderr = wezterm.run_child_process({ os.getenv("SHELL"), "-c", "printenv WEZTERM_THEME" })
local selected_theme = stdout:gsub("%s+", "") -- Remove all whitespace characters including newline
-- config.color_scheme = themes[selected_theme]
config.colors = cyberdream_theme

-- Blurry blurry vision
config.window_background_opacity = 0.5
config.macos_window_background_blur = 40

return config
