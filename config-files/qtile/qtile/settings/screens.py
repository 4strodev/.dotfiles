from libqtile.config import Screen
from libqtile import bar
from settings.widgets import widgets

# Setting the widgets to the top bar
screens = [Screen(top=bar.Bar(widgets, 24, opacity=0.95))]
