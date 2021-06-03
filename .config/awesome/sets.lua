local awful = require("awful")

----------------------------------------------------------------------------------------------
--------------------------------------- GENERAL ----------------------------------------------
----------------------------------------------------------------------------------------------

-- Set available layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.floating,
}

----------------------------------------------------------------------------------------------
--------------------------------------- WALLPAPER --------------------------------------------
----------------------------------------------------------------------------------------------

-- Set wallpaper
local function set_wallpaper()
    awful.spawn.with_shell('feh --bg-scale ~/wallpapers/forest.jpg') 
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Set wallpaper for each screen
awful.screen.connect_for_each_screen(function(s) 
    set_wallpaper()
end)

