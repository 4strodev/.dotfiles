# Neovim config
This is my personal daily work neovim config if you would like contribute be free to make a pr.
Or you can copy this config.

## Dev mode
I use this mode to test plugins that I'm working on. To run neovim with dev mode execute neovim as usually
but the last argument must be dev.

    $ nvim . dev


## Themes
To set themes you'll need to set an environment variable named `EDITOR_THEME`.
Then neovim will load the theme and if it not exists will set the `default` theme.

```sh
EDITOR_THEME="nightfox"
```
