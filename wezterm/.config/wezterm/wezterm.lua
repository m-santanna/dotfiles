local wezterm = require("wezterm")
local config = {}
local wallpapers = {
	{ path = "/Users/matheusss03/Pictures/wallpapers/wallpaper1.jpg", brightness = 0.08 },
	{ path = "/Users/matheusss03/Pictures/wallpapers/wallpaper2.jpg", brightness = 0.12 },
	{ path = "/Users/matheusss03/Pictures/wallpapers/wallpaper3.jpg", brightness = 0.07 },
	{ path = "/Users/matheusss03/Pictures/wallpapers/wallpaper4.jpg", brightness = 0.07 },
	{ path = "/Users/matheusss03/Pictures/wallpapers/wallpaper5.jpg", brightness = 0.3 },
}
-- local randomWallpaper = wallpapers[math.random(1, #wallpapers)]
local randomWallpaper = wallpapers[5]

config.send_composed_key_when_left_alt_is_pressed = true
config.use_dead_keys = false
config.font_size = 17
config.color_scheme = "Catppuccin Mocha"
config.window_background_image = randomWallpaper.path
config.use_fancy_tab_bar = false
config.tab_max_width = 30
config.window_background_image_hsb = {
	brightness = randomWallpaper.brightness,
	hue = 1.0,
	saturation = 0.65,
}
return config
