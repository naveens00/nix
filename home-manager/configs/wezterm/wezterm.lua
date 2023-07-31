local wezterm = require("wezterm")

return {
    window_decorations = "INTEGRATED_BUTTONS|RESIZE",
    integrated_title_button_alignment = "Right",
    font_size = 13.0,
    color_scheme = "Ef-Spring",
    enable_tab_bar = true,	
    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    send_composed_key_when_left_alt_is_pressed = true,
    send_composed_key_when_right_alt_is_pressed = true,
    window_padding = {
        left = 10,
        right = 10,
        top = 50,
        bottom = 10
    },
}
