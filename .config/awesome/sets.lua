local awful = require("awful")

-- Set available layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.floating,
}
