----------------------------------------------------------------------------------------------
--------------------------------------- SETTINGS ---------------------------------------------
----------------------------------------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

----------------------------------------------------------------------------------------------
--------------------------------------- GENERAL ----------------------------------------------
----------------------------------------------------------------------------------------------

-- Set available layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
}

awful.spawn.with_shell('~/.screenlayout/default.sh')     							                -- Load screen layout config on boot
awful.spawn.with_shell('/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh')    	-- Unlock keyring

os.execute("xset r rate 250 40") 		-- Set repeating keys speed (args => delay, times per second)

----------------------------------------------------------------------------------------------
--------------------------------------- WALLPAPER --------------------------------------------
----------------------------------------------------------------------------------------------

-- Set wallpaper
local function set_wallpaper()
    awful.spawn.with_shell('feh --bg-scale ~/wallpapers/sea-002.jpg') 
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Set wallpaper for each screen
awful.screen.connect_for_each_screen(function() 
    set_wallpaper()
end)

----------------------------------------------------------------------------------------------
--------------------------------------- THEME ------------------------------------------------
----------------------------------------------------------------------------------------------

beautiful.init(gears.filesystem.get_configuration_dir() .. "./theme.lua")
beautiful.useless_gap = 10                                                   -- Set window gap
beautiful.gap_single_client = true                                           -- Enable gaps for single window
