from libqtile import widget
from .theme import colors

# import datetime

##77ff88


def base_config(fg="text", bg="dark"):
    return {
        "foreground": colors[fg],
        "background": colors[bg],
    }


def separator():
    return widget.Sep(
        **base_config(),
        linewidth=0,
        padding=10,
    )


def icon(fg="text", bg="dark", fontsize=16, text="?"):
    return widget.TextBox(
        **base_config(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3,
    )


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base_config(fg, bg),
        text="",
        fontsize=37,
        padding=-5,  # Icon: nf-oct-triangle_left
    )


def workspaces():
    return [
        widget.GroupBox(
            **base_config(fg="light"),
            fontsize=18,
            borderwidth=3,
            active=colors["active"],
            inactive=colors["inactive"],
            highlight_method="block",
            urgent_alert_method="block",
            urgent_border=colors["urgent"],
            this_current_screen_border=colors["focus"],
            this_screen_border=colors["grey"],
            other_current_screen_border=colors["dark"],
            other_screen_border=colors["dark"],
            padding=10,
            disable_drag=True,
        ),
        separator(),
        # widget.Prompt(),
        widget.WindowName(
            **base_config(fg="light"),
            fontsize=16,
        ),
        separator(),
    ]


widgets = [
    *workspaces(),
    powerline("color3", "dark"),
    icon(bg="color3", text=" "),  # Icon: nf-fa-download
    widget.CheckUpdates(
        background=colors["color3"],
        colour_have_updates=colors["text"],
        colour_no_updates=colors["text"],
        no_update_string="0",
        display_format="{updates}",
        update_interval=1800,
        padding=5,
    ),
    powerline("color2", "color3"),
    widget.CurrentLayoutIcon(
        **base_config(bg="color2"),
        scale=0.65,
    ),
    widget.CurrentLayout(
        **base_config(bg="color2"),
        padding=5,
    ),
    powerline("color1", "color2"),
    icon(bg="color1", fontsize=17, text=" "),  # Icon: nf-mdi-calendar_clock
    widget.Clock(
        **base_config(bg="color1"),
        format="%d/%m/%Y => %H:%M ",
    ),
    powerline("dark", "color1"),
    widget.Systray(
        background=colors["dark"],
        padding=5,
    ),
]

widget_defaults = dict(
    font="CaskaydiaCove Nerd Font",
    fontsize=14,
    padding=1,
)
extension_defaults = widget_defaults.copy()
