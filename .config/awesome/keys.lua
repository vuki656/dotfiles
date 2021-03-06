----------------------------------------------------------------------------------------------
--------------------------------- BUTTONS AND REMAPS -----------------------------------------
----------------------------------------------------------------------------------------------

local gears = require("gears")
local awful = require("awful")
local popup = require("awful.hotkeys_popup")

local M = {}

M.mouse_buttons = {
    left = 1,
    middle = 2,
    right = 3,
    up = 4,
    down = 5,
}
M.modkey = "Mod4"

M.key_groups = {
    apps = "Applications",
    awesome = "Awesome",
    current_screen = "Current Screen",
    current_window = "Current Window",
    tag = "Tag",
    screen = "Screen",
    prompts = "Prompts",
    audio = "Audio",
    other = "Other",
}

----------------------------------------------------------------------------------------------
-------------------------------------- TASKLIST BUTTONS ----------------------------------------
----------------------------------------------------------------------------------------------

M.tasklist_buttons = gears.table.join(
    -- Toggle visible/minimized on click
    awful.button({}, M.mouse_buttons.left, function(current_client)
        if current_client == client.focus then
            current_client.minimized = true
        else
            current_client:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),

    -- Open menu for task
    awful.button({}, M.mouse_buttons.right, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),

    -- Focus next task on scroll up
    awful.button({}, M.mouse_buttons.up, function()
        awful.client.focus.byidx(1)
    end),

    -- Focus previous task on scroll down
    awful.button({}, M.mouse_buttons.down, function()
        awful.client.focus.byidx(-1)
    end)
)

----------------------------------------------------------------------------------------------
-------------------------------------- CLIENT BUTTONS ----------------------------------------
----------------------------------------------------------------------------------------------

M.client_buttons = gears.table.join(
    -- Focus and or toggle clicked client
    awful.button({}, M.mouse_buttons.left, function(client)
        client:emit_signal("request::activate", "mouse_click", { raise = true })
    end),

    -- Move client on click & drag anywhere in client
    awful.button({ M.modkey }, M.mouse_buttons.left, function(client)
        client:emit_signal("request::activate", "mouse_click", { raise = true })

        awful.mouse.client.move(client)
    end),

    -- Resize client on click & drag anywhere in client
    awful.button({ M.modkey }, M.mouse_buttons.right, function(client)
        client:emit_signal("request::activate", "mouse_click", { raise = true })

        awful.mouse.client.resize(client)
    end)
)

----------------------------------------------------------------------------------------------
-------------------------------- CLIENT TOOLBAR BUTTONS --------------------------------------
----------------------------------------------------------------------------------------------
M.client_toolbar_buttons = function(client)
    return gears.table.join(
        -- Move client on click & drag in toolbar
        awful.button({}, M.mouse_buttons.left, function()
            client:emit_signal("request::activate", "titlebar", { raise = true })

            awful.mouse.client.move(client)
        end),

        -- Resize client on click & drag in toolbar
        awful.button({}, M.mouse_buttons.right, function()
            client:emit_signal("request::activate", "titlebar", { raise = true })

            awful.mouse.client.resize(client)
        end)
    )
end

----------------------------------------------------------------------------------------------
------------------------------------- TAG LIST BUTTONS ---------------------------------------
----------------------------------------------------------------------------------------------

M.taglist_buttons = gears.table.join(
    -- Switch to clicked tag
    awful.button({}, M.mouse_buttons.left, function(tag)
        tag:view_only()
    end),

    -- Move focuses window to clicked tag
    awful.button({ M.modkey }, M.mouse_buttons.left, function(tag)
        if client.focus then
            client.focus:move_to_tag(tag)
        end
    end),

    -- Display windows from clicked tag in current screen on rmb click
    awful.button({}, M.mouse_buttons.right, awful.tag.viewtoggle),

    -- TODO: Description of what it does
    awful.button({ M.modkey }, M.mouse_buttons.right, function(tag)
        if client.focus then
            client.focus:toggle_tag(tag)
        end
    end),

    -- Go to next tag on scroll up
    awful.button({}, M.mouse_buttons.up, function(tag)
        awful.tag.viewnext(tag.screen)
    end),

    -- Go to previous tag on scroll down
    awful.button({}, M.mouse_buttons.down, function(tag)
        awful.tag.viewprev(tag.screen)
    end)
)

----------------------------------------------------------------------------------------------
--------------------------------------- CLIENT KEY -------------------------------------------
----------------------------------------------------------------------------------------------

M.client_keys = gears.table.join(
    awful.key({ M.modkey }, "g", function()
        awful.spawn.with_shell("~/scripts/lock.sh")
    end, {
        description = "Lock screen",
        group = M.key_groups.other,
    }),

    awful.key({ M.modkey }, "f", function(client)
        client.fullscreen = not client.fullscreen
        client:raise()
    end, {
        description = "Toggle currently selected window fullscreen",
        group = M.key_groups.current_window,
    }),

    awful.key(
        {
            M.modkey,
        },
        "r",
        function(client)
            client:kill()
        end,
        {
            description = "Close currently selected window",
            group = M.key_groups.current_window,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
        },
        "space",
        awful.client.floating.toggle,
        {
            description = "Toggle currently selected window to floating",
            group = M.key_groups.current_window,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
        },
        "Return",
        function(client)
            client:swap(awful.client.getmaster())
        end,
        {
            description = "Make currently selected window master",
            group = M.key_groups.current_window,
        }
    ),

    awful.key({ M.modkey }, "o", function(client)
        client:move_to_screen()
    end, {
        description = "Move currently selected window to next screen",
        group = M.key_groups.current_window,
    }),

    awful.key({ M.modkey }, "t", function(client)
        client.ontop = not client.ontop
    end, {
        description = "Toggle current selected window on top",
        group = M.key_groups.current_window,
    }),

    awful.key({ M.modkey }, "n", function(client)
        client.minimized = true
    end, {
        description = "Minimize currently selected window",
        group = M.key_groups.current_window,
    }),

    awful.key({ M.modkey }, "m", function(client)
        client.maximized = not client.maximized
        client:raise()
    end, {
        description = "Un/Maximize currently selected window",
        group = M.key_groups.current_window,
    }),

    awful.key(
        {
            M.modkey,
            "Control",
        },
        "m",
        function(client)
            client.maximized_vertical = not client.maximized_vertical
            client:raise()
        end,
        {
            description = "Un/Maximize currently selected window vertically",
            group = M.key_groups.current_window,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Shift",
        },
        "m",
        function(client)
            client.maximized_horizontal = not client.maximized_horizontal
            client:raise()
        end,
        {
            description = "Un/Maximize currently selected window horizontally",
            group = M.key_groups.current_window,
        }
    )
)

----------------------------------------------------------------------------------------------
--------------------------------------- GLOBAL KEYS ------------------------------------------
----------------------------------------------------------------------------------------------

M.global_keys = gears.table.join(
    awful.key({ M.modkey }, "p", function()
        awful.util.spawn_with_shell("rofi -show drun")
    end, {
        description = "Open dmenu",
        group = M.key_groups.other,
    }),

    awful.key({ M.modkey }, ";", function()
        awful.util.spawn_with_shell("~/scripts/rofi-google.sh")
    end, {
        description = "Open dmenu for google search",
        group = M.key_groups.other,
    }),

    awful.key({ M.modkey }, "c", function()
        awful.util.spawn_with_shell("google-chrome --profile-directory=Default --password-store=gnome")
    end, {
        description = "Start chrome - PERSONAL",
        group = M.key_groups.apps,
    }),

    awful.key({ M.modkey }, "v", function()
        awful.util.spawn_with_shell("google-chrome --profile-directory='Profile 1' --password-store=gnome")
    end, {
        description = "Start chrome - WORK",
        group = M.key_groups.apps,
    }),

    awful.key({ M.modkey }, "b", function()
        awful.util.spawn_with_shell(
            "/usr/bin/google-chrome --profile-directory=Default --password-store=gnome --app-id=cinhimbnkkaeohfgghhklpknlkffjgod"
        )
    end, {
        description = "Start chrome - YOUTUBE MUSIC",
        group = M.key_groups.apps,
    }),

    awful.key({ M.modkey }, "s", popup.show_help, {
        description = "Open key combo help",
        group = M.key_groups.other,
    }),

    awful.key({ M.modkey }, "Left", awful.tag.viewprev, {
        description = "Go to previous desktop",
        group = M.key_groups.tag,
    }),

    awful.key({ M.modkey }, "Right", awful.tag.viewnext, {
        description = "Go to next tag",
        group = M.key_groups.tag,
    }),

    awful.key({ M.modkey }, "Escape", awful.tag.history.restore, {
        description = "Go to last visited tag",
        group = M.key_groups.tag,
    }),

    awful.key({ M.modkey }, "j", function()
        awful.client.focus.byidx(-1)
    end, {
        description = "Focus previous window in current screen",
        group = M.key_groups.current_screen,
    }),

    awful.key({ M.modkey }, "k", function()
        awful.client.focus.byidx(1)
    end, {
        description = "Focus next window in current screen",
        group = M.key_groups.current_screen,
    }),

    awful.key(
        {
            M.modkey,
            "Shift",
        },
        "j",
        function()
            awful.client.swap.byidx(-1)
        end,
        {
            description = "Swap with previous window in current screen",
            group = M.key_groups.current_screen,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Shift",
        },
        "k",
        function()
            awful.client.swap.byidx(1)
        end,
        {
            description = "Swap with next window in current screen",
            group = M.key_groups.current_screen,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
        },
        "j",
        function()
            awful.screen.focus_relative(-1)
        end,
        {
            description = "Focus previous screen",
            group = M.key_groups.screen,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
        },
        "k",
        function()
            awful.screen.focus_relative(1)
        end,
        {
            description = "Focus next screen",
            group = M.key_groups.screen,
        }
    ),

    awful.key({ M.modkey }, "u", awful.client.urgent.jumpto, {
        description = "Jump to urgent client",
        group = M.key_groups.other,
    }),

    awful.key({ M.modkey }, "Tab", function()
        awful.client.focus.history.previous()

        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "Switch between windows in current screen",
        group = M.key_groups.current_screen,
    }),

    awful.key({ M.modkey }, "Return", function()
        awful.spawn("alacritty")
    end, {
        description = "Start terminal",
        group = M.key_groups.apps,
    }),

    awful.key(
        {
            M.modkey,
            "Control",
        },
        "r",
        awesome.restart,
        {
            description = "Restart awesome",
            group = M.key_groups.awesome,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Shift",
        },
        "q",
        awesome.quit,
        {
            description = "Quit awesome",
            group = M.key_groups.awesome,
        }
    ),

    awful.key({ M.modkey }, "l", function()
        awful.tag.incmwfact(0.05)
    end, {
        description = "Increase current window width",
        group = M.key_groups.current_window,
    }),

    awful.key({ M.modkey }, "h", function()
        awful.tag.incmwfact(-0.05)
    end, {
        description = "Decrease current window width",
        group = M.key_groups.current_window,
    }),

    awful.key(
        {
            M.modkey,
            "Shift",
        },
        "h",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {
            description = "Increase the number of master clients",
            group = M.key_groups.current_screen,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Shift",
        },
        "l",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {
            description = "Decrease the number of master clients",
            group = M.key_groups.current_screen,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
        },
        "h",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {
            description = "Increase the number of columns",
            group = M.key_groups.current_screen,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
        },
        "l",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {
            description = "Decrease the number of columns",
            group = M.key_groups.current_screen,
        }
    ),

    awful.key({ M.modkey }, "space", function()
        awful.layout.inc(1)
    end, {
        description = "Make selected window only one on the screen",
        group = M.key_groups.current_window,
    }),

    awful.key(
        {
            M.modkey,
            "Shift",
        },
        "space",
        function()
            awful.layout.inc(-1)
        end,
        {
            description = "Return window from being the only one on desktop to that desktop layout",
            group = M.key_groups.current_window,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
        },
        "n",
        function()
            local client = awful.client.restore()

            if client then
                client:emit_signal("request::activate", "key.unminimize", { raise = true })
            end
        end,
        {
            description = "Restore minimized window",
            group = M.key_groups.current_screen,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
            "Shift",
        },
        "y",
        function()
            awful.spawn.with_shell("playerctl previous")
        end,
        {
            description = "Previous track",
            group = M.key_groups.audio,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
            "Shift",
        },
        "u",
        function()
            awful.spawn.with_shell("playerctl next")
        end,
        {
            description = "Next track",
            group = M.key_groups.audio,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
            "Shift",
        },
        "i",
        function()
            awful.spawn.with_shell("playerctl play-pause")
        end,
        {
            description = "Play/Pause",
            group = M.key_groups.audio,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
            "Shift",
        },
        "o",
        function()
            awful.spawn.with_shell("amixer -D pulse sset Master 1%-")
        end,
        {
            description = "Volume Down",
            group = M.key_groups.audio,
        }
    ),

    awful.key(
        {
            M.modkey,
            "Control",
            "Shift",
        },
        "p",
        function()
            awful.spawn.with_shell("amixer -D pulse sset Master 1%+")
        end,
        {
            description = "Volume Up",
            group = M.key_groups.audio,
        }
    )
)

-- Bind key numbers to tags
for i = 1, 9 do
    M.global_keys = gears.table.join(
        M.global_keys,

        awful.key({ M.modkey }, "#" .. i + 9, function()
            for screen = 1, screen.count() do
                local tag = awful.tag.gettags(screen)[i]

                if tag then
                    awful.tag.viewonly(tag)
                end
            end
        end, {
            description = "Go to tag #" .. i,
            group = M.key_groups.tag,
        }),

        awful.key(
            {
                M.modkey,
                "Control",
            },
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]

                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {
                description = "Display tag #" .. i .. " in current tag",
                group = M.key_groups.tag,
            }
        ),

        awful.key(
            {
                M.modkey,
                "Shift",
            },
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]

                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {
                description = "Move focused window to tag #" .. i,
                group = M.key_groups.tag,
            }
        ),

        awful.key(
            {
                M.modkey,
                "Control",
                "Shift",
            },
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]

                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {
                description = "Make currently selected window sticky on tag #" .. i,
                group = M.key_groups.tag,
            }
        )
    )
end

-- Register global keys
root.keys(M.global_keys)

return M
