# from libqtile.lazy import lazy
from settings.groups import groups
from settings.keys import keys, mod
from settings.layouts import floating_layout, layouts
from settings.mouse import mouse
from settings.path import qtile_path
from settings.screens import screens
from settings.widgets import extension_defaults, widget_defaults
from settings.startup import startup_path
import os
from os import path

dgroups_key_binder = None
dgroups_app_rules = []
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = False
focus_on_window_activation = "smart"
wmname = "LG3D"

startup_command = "sh " + startup_path

os.system(startup_command)
