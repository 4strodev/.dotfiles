from libqtile.config import Group, Key
from libqtile.lazy import lazy
from settings.keys import keys, mod

group_names = "爵     辶   ".split()
groups = [Group(name, layout="bsp") for name in group_names]
for i, name in enumerate(group_names):
    indx = str(i + 1)
    keys += [
        Key([mod], indx, lazy.group[name].toscreen()),
        Key([mod, "shift"], indx, lazy.window.togroup(name)),
    ]
