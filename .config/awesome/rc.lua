-- Core
pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

require("awful.autofocus")
require('keys')

-- Widgets
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local weather_widget = require("awesome-wm-widgets.weather-widget.weather")


-- Handle runtime errors after startup
do
    local in_error = false

    awesome.connect_signal("debug::error", function (error)
        if in_error then 
            return
        end

        in_error = true

        naughty.notify({ 
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(error)
        })

        in_error = false
    end)
end

--  Set theme
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Set modkey
modkey = "Mod4"

-- Available layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.floating,
}
-- }}}

local colors = {
    transparent = '#2f282829'
}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
    mymainmenu = freedesktop.menu.build({
        before = { menu_awesome },
        after =  { menu_terminal }
    })
else
    mymainmenu = awful.menu({
        items = {
                  menu_awesome,
                  { "Debian", debian.menu.Debian_menu.Debian },
                  menu_terminal,
                }
    })
end


-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape  = gears.shape.rounded_bar,
            bg_normal = colors.transparent,
            bg_focus = colors.transparent,
        },
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, bg = beautiful.bg_normal .. "00"  })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            weather_widget({
                api_key='d8ec854f0c75c3d11b05badeda7346f6',
                coordinates = { 45.774867,  15.996309 },
                time_format_12h = true,
                units = 'metric',
                show_hourly_forecast = true,
            }),
            mytextclock,
            s.mylayoutbox,
            logout_menu_widget(),
        },
    }
end)
-- }}}

-- Open menu with right click
root.buttons(awful.button({ }, 3, function () mymainmenu:toggle() end))

local clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = 0,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    c.shape = function(corner_radius, width, height)
        gears.shape.rounded_rect(corner_radius, width, height, 5)
    end

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Window titlebar
client.connect_signal("request::titlebars", function(client)
    local left_mouse_button = 1
    local right_mouse_button = 3

    local drag_button = awful.button(
        {},
        left_mouse_button,
        function()
            client:emit_signal(
                "request::activate",
                "titlebar",
                { raise = true }
            )

            awful.mouse.client.move(client)
        end
    )

    local resize_button = awful.button(
        {},
        right_mouse_button,
        function()
            client:emit_signal(
                "request::activate",
                "titlebar",
                { raise = true }
            )

            awful.mouse.client.resize(client)
        end
    )

    local buttons = gears.table.join(drag_button, resize_button)

    local left_section = { 
        layout  = wibox.layout.fixed.horizontal,
        buttons = buttons
    }

    local midddle_section = { 
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
    }

    local right_section = {
        layout = wibox.layout.fixed.horizontal(),
        awful.titlebar.widget.floatingbutton(client),
        awful.titlebar.widget.maximizedbutton(client),
        awful.titlebar.widget.stickybutton(client),
        awful.titlebar.widget.ontopbutton(client),
        awful.titlebar.widget.closebutton(client),
    }

    local style = {
        bg_normal = colors.transparent,
        bg_focus = colors.transparent,
        size = 20,
    }

    awful.titlebar(client, style) : setup {
        left_section,
        midddle_section,
        right_section,
        layout = wibox.layout.align.horizontal
    }
end)

-- Focus follows mouse across the screens
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

----------------------------------------------------------------------
--------------------------- CUSTOM CONFIG ----------------------------
----------------------------------------------------------------------
terminal = "alacritty"                              -- Set terminal
editor = "nvim"                                     -- Set editor
modkey = "Mod4"                                     -- Set modkey to super key(windows key)

awful.spawn.with_shell('~/.screenlayout/default.sh')     							                -- Load screen layout config on boot
awful.spawn.with_shell('feh --bg-scale ~/wallpapers/forest.jpg')     	                       		-- Set wallpaper
awful.spawn.with_shell('/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh')    	-- Unlock keyring

os.execute("xset r rate 150 40") 		-- Set repeating keys speed (args => delay, times per second)
