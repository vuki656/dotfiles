local watch = require("awful.widget.watch")
local json = require("json")
local wibox = require("wibox")
local gears = require("gears")

local colors = require("utils.colors")
local env_vars = require("env_vars")

local api_call = (
        "https://api.openweathermap.org/data/2.5/onecall"
        .. "?lat="
        .. env_vars.coords.lat
        .. "&lon="
        .. env_vars.coords.long
        .. "&appid="
        .. env_vars.weather_api_key
        .. "&units=metric"
        .. "&exclude=minutely"
    )

local weather_widget = {}

local function worker()
    -- Setup widget GUI
    weather_widget = wibox.widget({
        {
            {
                {
                    {
                        id = "txt",
                        widget = wibox.widget.textbox,
                        font = "Montserrat Bold 10",
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left = 5,
                right = 5,
                widget = wibox.container.margin,
            },
            layout = wibox.container.background,
            bg = colors.blue_dark_transparent,
            fg = colors.white,
            shape = function(cairo, width, height)
                gears.shape.rounded_rect(cairo, width, height, 3)
            end,
        },
        set_text = function(self, text)
            self:get_children_by_id("txt")[1].text = text
        end,
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
        layout = wibox.container.margin,
    })

    -- Parse results and set temperature text
    local function update_widget(widget, stdout)
        local temperature = json.decode(stdout).current.temp

        if temperature == nil then
            widget:set_text("ERR")
        end

        local formatter_string = string.format("%.0f", temperature) .. "°" .. "C"

        widget:set_text(formatter_string)
    end

    -- Reload API call and GUI display every 5 minutes
    watch(string.format([[bash -c "curl -s --show-error -X GET '%s'"]], api_call), 900, update_widget, weather_widget)

    return weather_widget
end

return setmetatable(weather_widget, {
    __call = function()
        return worker()
    end,
})
