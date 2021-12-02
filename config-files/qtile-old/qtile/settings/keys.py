from libqtile.config import Key
from libqtile.lazy import lazy

mod = "mod4"
mod1 = "mod1"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "j", lazy.layout.down(), desc="Move focus down in stack pane"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up in stack pane"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus left in stack pane"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus right in stack pane"),
    # Move windows up or down in current stack
    Key(
        [mod, "control"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down in current stack ",
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.shuffle_up(),
        desc="Move window up in current stack ",
    ),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window left in current stack ",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window right in current stack ",
    ),
    # Switch window focus to other pane(s) of stack
    Key(
        [mod],
        "space",
        lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack",
    ),
    # Swap panes of split stack
    Key(
        [mod, "shift"], "space", lazy.layout.rotate(), desc="Swap panes of split stack"
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn("alacritty"), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Go to next layout"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Go to previous layout"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod, "shift"],
        "f",
        lazy.window.toggle_floating(),
        desc="Toggle floating layout",
    ),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Keybindings for applications
    Key([mod1], "space", lazy.spawn("rofi -show combi"), desc="Launch rofi"),
    Key([mod], "e", lazy.spawn("nemo"), desc="launch file explorer"),
    Key([mod, mod1], "l", lazy.spawn("dm-tool lock"), "launch i3lock a screen saver"),
    Key([mod, mod1], "s", lazy.spawn("flameshot launcher"), "run flameshot launcher"),
    Key([mod, "shift"], "s", lazy.spawn("flameshot gui"), desc="run flameshot gui"),
    Key(
        [mod],
        "s",
        lazy.spawn("flameshot full --clipboard"),
        desc="run flameshot screen",
    ),
]
