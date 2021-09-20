# Installation

1. Setup weather widget

   - Grab an API key [HERE](https://home.openweathermap.org/api_keys)
   - Grab lat/long [HERE](https://www.maps.ie/coordinates.html)
   - Put the following in `~/.config/awesome/env_vars.lua`

   ```lua
       local module = {}

       module.weather_api_key = "key"
       module.coords = {
           lat = 22.2222,
           long = 22.22222
       }

       return module
   ```

2. Install GRUB theme from [HERE](https://github.com/vinceliuice/grub2-themes)
3. Install tmux plugin manager from [HERE](https://github.com/tmux-plugins/tpm)
