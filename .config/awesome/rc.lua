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
            shape_border_width = 1,
            shape_border_color = '#777777',
            shape  = gears.shape.rounded_bar,
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

local key_groups = {
    apps = "Applications",
    awesome = "Awesome",
    current_screen = "Current Screen",
    current_window = "Current Window",
    tag = "Tag",
    screen = "Screen",
    prompts = "Prompts",
    other = "Other",
}

-- Key bindings
local globalkeys = gears.table.join(
    awful.key(
        { modkey },
        "c",
        function () 
            awful.util.spawn_with_shell("google-chrome --password-store=gnome")
        end,
        { 
            description = "Start chrome",
            group = key_groups.apps
        }
    ),

    awful.key(
        { modkey },
        "s",
        hotkeys_popup.show_help,
        { 
            description="Open key combo help",
            group = key_groups.other
        }
    ),

    awful.key(
        { modkey },
        "Left",
        awful.tag.viewprev,
        { 
            description = "Go to previous desktop",
            group = key_groups.tag
        }
    ),

    awful.key(
        { modkey },
        "Right",
        awful.tag.viewnext,
       { 
           description = "Go to next tag",
           group = key_groups.tag
       }
    ),

    awful.key(
        { modkey }, 
        "Escape",
        awful.tag.history.restore,
        { 
            description = "Go to last visited tag",
            group = key_groups.tag
        }
    ),

    awful.key(
        { modkey },
        "j",
        function ()
            awful.client.focus.byidx(-1)
        end,
        { 
            description = "Focus previous window in current screen",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { modkey },
        "k",
        function ()
            awful.client.focus.byidx(1)
        end,
        { 
            description = "Focus next window in current screen",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "j",
        function () 
            awful.client.swap.byidx(-1)
        end,
        { 
            description = "Swap with previous window in current screen",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "k",
        function () 
            awful.client.swap.byidx(1)
        end,
        { 
            description = "Swap with next window in current screen",
            group = key_groups.current_screen
        }
     ),

    awful.key(
        { 
            modkey,
            "Control"
        },
        "j",
        function () 
            awful.screen.focus_relative(-1)
        end,
        { 
            description = "Focus previous screen",
            group = key_groups.screen
        }
    ),

    awful.key(
        {
            modkey,
            "Control"
        },
        "k",
        function () 
            awful.screen.focus_relative(1)
        end,
        { 
            description = "Focus next screen",
            group = key_groups.screen
        }
    ),

    awful.key(
        { modkey },
        "u",
        awful.client.urgent.jumpto,
        { 
            description = "Jump to urgent client",
            group = key_groups.other
        }
    ),

    awful.key(
        { modkey },
        "Tab",
        function ()
            awful.client.focus.history.previous()

            if client.focus then
                client.focus:raise()
            end
        end,
        {
            description = "Switch between windows in current screen",
            group = key_groups.current_screen
        }
     ),


    awful.key(
        { modkey },
        "Return",
        function () 
            awful.spawn(terminal) 
        end,
        { 
            description = "Start terminal",
            group = key_groups.apps
        }
    ),

    awful.key(
       { 
           modkey,
           "Control"
       },
       "r",
       awesome.restart,
       { 
           description = "Restart awesome",
           group = key_groups.awesome
       }
     ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "q",
        awesome.quit,
        { 
            description = "Quit awesome",
            group = key_groups.awesome
        }
     ),

    awful.key(
        { modkey },
        "l",
        function () 
            awful.tag.incmwfact(0.05)          
        end,
        { 
            description = "Increase current window width",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { modkey },
        "h",
        function () 
            awful.tag.incmwfact(-0.05)          
        end,
        { 
            description = "Decrease current window width",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "h",
        function () 
            awful.tag.incnmaster(1, nil, true) 
        end,
        { 
            description = "Increase the number of master clients",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "l",
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        { 
            description = "Decrease the number of master clients",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { 
            modkey,
            "Control"
        },
        "h",
        function () 
            awful.tag.incncol(1, nil, true)    
        end,
        { 
            description = "Increase the number of columns",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { 
            modkey, 
            "Control"
        },
        "l",     
        function () 
            awful.tag.incncol(-1, nil, true)    
        end,
        { 
            description = "Decrease the number of columns",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { modkey },
        "space",
        function () 
            awful.layout.inc(1)                
        end,
        { 
            description = "Make selected window only one on the screen",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { 
            modkey, 
            "Shift"   
        },
        "space",
        function () 
            awful.layout.inc(-1)                
        end,
        { 
            description = "Return window from being the only one on desktop to that desktop layout",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { 
            modkey,
            "Control"
        }, 
        "n",
        function ()
            local client = awful.client.restore()

             if client then
                client:emit_signal(
                    "request::activate",
                    "key.unminimize",
                    { raise = true }
                )
           end
        end,
        { 
            description = "Restore minimized window",
            group = key_groups.current_screen
        }
    ),

    awful.key(
        { modkey },
        "r",
        function () 
            awful.screen.focused().mypromptbox:run()
        end,
        { 
            description = "Open run prompt",
            group = key_groups.prompts
        }
    ),

    awful.key(
        { modkey },
        "x",
        function ()
            awful.prompt.run {
                prompt = "Run Lua Code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        { 
            description = "Open lua execute prompt",
            group = key_groups.prompts
        }
    ),

    awful.key(
        { modkey },
        "p",
        function() 
            menubar.show() 
        end,
        { 
            description = "Open menubar",
            group = key_groups.other
        }
    )
)

clientkeys = gears.table.join(
    awful.key(
        { modkey },
        "f",
        function (client)
            client.fullscreen = not client.fullscreen
            client:raise()
        end,
        { 
            description = "Toggle currently selected window fullscreen",
            group = key_groups.current_window
        }
     ),

    awful.key(
        { 
            modkey,
            "Shift"   
        },
        "c",
        function (client) 
            client:kill()                         
        end,
        { 
            description = "Close currently selected window",
            group = key_groups.current_window
        }
    ),

    awful.key(
        {
            modkey,
            "Control"
        },
        "space",
        awful.client.floating.toggle,
        { 
            description = "Toggle currently selected window to floating",
            group = key_groups.current_window
        }
    ),

    awful.key(
        {
            modkey,
            "Control"
        },
        "Return",
        function (client) 
            client:swap(awful.client.getmaster())
        end,
        { 
            description = "Make currently selected window master",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { modkey },
        "o",
        function (client) 
            client:move_to_screen()               
        end,
        { 
            description = "Move currently selected window to next screen",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { modkey },
        "t",
        function (client) 
            client.ontop = not client.ontop
        end,
        { 
            description = "Toggle current selected window on top",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { modkey },
        "n",
        function (client)
            client.minimized = true
        end,
        { 
            description = "Minimize currently selected window",
            group = key_groups.current_window
        }
     ),

    awful.key(
        { modkey },
        "m",
        function (client)
            client.maximized = not client.maximized
            client:raise()
        end,
        { 
            description = "Un/Maximize currently selected window",
            group = key_groups.current_window
        }
    ),

    awful.key(
        {
            modkey,
            "Control" 
        },
        "m",
        function (client)
            client.maximized_vertical = not client.maximized_vertical
            client:raise()
        end,
        { 
            description = "Un/Maximize currently selected window vertically",
            group = key_groups.current_window
        }
    ),

    awful.key(
        { 
            modkey,
            "Shift"
        },
        "m",
        function (client)
            client.maximized_horizontal = not client.maximized_horizontal
            client:raise()
        end,
        { 
            description = "Un/Maximize currently selected window horizontally",
            group = key_groups.current_window
        }
    )
)

-- Bind key numbers to tags
for i = 1, 9 do
    globalkeys = gears.table.join(
        globalkeys,

        awful.key(
            { modkey },
            "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]

                if tag then
                    tag:view_only()
                end
            end,
            { 
                description = "Go to tag #" .. i,
                group = key_groups.tag
            }
        ),

        awful.key(
            { 
                modkey,
                "Control" 
            },
            "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
    
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {
                description = "Display tag #" .. i .. " in current tag",
                group = key_groups.tag
            }
        ),
    
        awful.key(
            {
                modkey,
                "Shift"
            },
            "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
    
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {
                description = "Move focused window to tag #"..i,
                group = key_groups.tag
            }
        ),
    
        awful.key(
            {
                modkey,
                "Control",
                "Shift"
            },
            "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
    
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {
                description = "Make currently selected window sticky on tag #" .. i,
                group = key_groups.tag
            }
        )
    )
end

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
        awful.titlebar.widget.titlewidget(client),
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
    }

    local right_section = {
        layout = wibox.layout.fixed.horizontal(),
        awful.titlebar.widget.floatingbutton (client),
        awful.titlebar.widget.maximizedbutton(client),
        awful.titlebar.widget.stickybutton(client),
        awful.titlebar.widget.ontopbutton(client),
        awful.titlebar.widget.closebutton(client),
    }

    local style = {
        bg_normal = '#2f282829',
        bg_focus = '#2f2828a1',
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
awful.spawn.with_shell('feh --bg-scale ~/wallpapers/mojave/mojave_dynamic_15.jpeg')     			-- Set wallpaper
awful.spawn.with_shell('/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh')    	-- Unlock keyring

os.execute("xset r rate 150 40") 		-- Set repeating keys speed (args => delay, times per second)
