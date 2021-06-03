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

-- Custom Config
local keys = require('keys')

require('utils.catch_errors')
require('menu')
require('sets')
require('top_bar')

root.keys(keys.global_keys)

awful.rules.rules = {
    { 
        rule = { },
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.client_keys,
            buttons = keys.client_buttons,
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
        gears.shape.rounded_rect(corner_radius, width, height, 10)
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
    local left_section = { 
        layout  = wibox.layout.fixed.horizontal,
        buttons = keys.client_toolbar_buttons(client)
    }

    local midddle_section = { 
        buttons = keys.client_toolbar_buttons(client),
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
        bg_normal = '#1a1a1b85',
        bg_focus = '#1a1a1bab',
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
awful.spawn.with_shell('~/.screenlayout/default.sh')     							                -- Load screen layout config on boot
awful.spawn.with_shell('/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh')    	-- Unlock keyring

os.execute("xset r rate 150 40") 		-- Set repeating keys speed (args => delay, times per second)

