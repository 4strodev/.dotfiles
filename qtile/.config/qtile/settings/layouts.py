from libqtile import layout

layout_conf = {
    'border_width': 2,
    'margin': 3
}

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2, **layout_conf),
    # Try more layouts by unleashing below layouts.
    layout.Bsp(**layout_conf),
    layout.Columns(**layout_conf),
    layout.Matrix(columns=2, **layout_conf),
    layout.MonadTall(**layout_conf),
    layout.MonadWide(**layout_conf),
    layout.Zoomy(**layout_conf),
    # layout.RatioTile(**layout_conf),
    # layout.Tile(**layout_conf),
    # # layout.TreeTab(**layout_conf),
    # layout.VerticalTile(**layout_conf),
]

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
