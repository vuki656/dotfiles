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
            title = "Error",
            text = tostring(error)
        })

        in_error = false
    end)
end
