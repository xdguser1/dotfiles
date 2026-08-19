# Description
Personal dotfiles repo. Everything is configured declaratively, so there should not be anything missing. This uses [nix](https://nixos.org/).

For personal use, you should add your own [hardware-configuration.nix](./hardware-configuration.nix), since this is relative to your own hardware. You can also add or remove programs which you do not use. These are found in directories `packages` for simple binaries and `progs` for services.

Before using, I would recommend making a fork of this repo, but you may use it _as is_ and even contribute. Whatever you prefer.

This repo has the `stateVersion` variable set to 26.05. [As it has been said multiple times before](https://discourse.nixos.org/t/when-should-i-change-system-stateversion/1433), you should not use the version in this repo, but actually use your own `stateVersion` which was already set up when you installed NixOS (just like `./hardware-configuration.nix`). I have tried switching it once, by mistake, ended up 6 months behind updates and woke up from Hyprland 0.52 to Hyprland 0.55 where I needed to migrate my whole config to [Lua](https://www.lua.org/).

Obviously, you should already have experience with NixOS before installing this.

# Features
This repo uses [home-manager](https://github.com/nix-community/home-manager). I have chosen home-manager because [it seems to be better integrated with NixOS](https://search.nixos.org/options?channel=26.05&query=For%20example%20options%20are%20with%20home-manager&source=home_manager&type=options), but this may change in the future for another one, such as [hjem](https://github.com/feel-co/hjem).

It also uses the unstable version of NixOS with both **nix-command** and **flakes**.

Finally, there is the very much not so clear distinction between _system programs_ and _user programs_. For me, I configured it such that if I were to add a new user to my computer, the _system programs_ would install binaries that seem essential or widely used. Note though, this is absolutely not necessary and is, by definition itself, bloatware. Feel free to remove those programs from your dotfiles.

# Binaries
This uses the [Hyprland](https://hypr.land/) window manager / compositor. The configuration and keybindings are found [here](./home/admin/hyprland), written in a weird nix-lua semilanguage. Obviously this is not optimal, and I should probably do a PR to modify the nix service, since it has become very weird since Hyprland 0.55.

This also uses [neovim](https://neovim.io/) for pretty much everything else (e.g. file manager, editor, versioning, etc.). All plugins are managed by nix itself. Bindings are found [here](./home/admin/progs/neovim).

Finally, the bootloader is [grub](https://www.gnu.org/software/grub/) with [sddm](https://wiki.archlinux.org/title/SDDM) as a display manager. Images are manually added in `/share/images` with `bg-desktop.jpg` and `bg-sddm.jpg` the backgrounds of both the desktop and sddm. You can find screenshots [here](./docs), but images will not be shared, as it may infringe on copyright.

# Todos
There are a few things left to do in this config. Most of them are because I have specific ideas on how this config should evolve, and it takes time to code them. So, here are the known tasks:

[] Install notification daemon
[] Install app launcher
[] Change hyprland setup for scroll operations
[] Solve issue with zen on startup

For the notification daemon, I am currently working on [notifs-piper](https://github.com/xdguser1/notifs-piper) which is a replacement for [statnot](https://github.com/xdguser1/notifs-piper). This is done so to leave the possibility of a classical, graphical, notification server, while making it also possible to only show the notification in the [ags bar](./home/admin/progs/ags/).

As for the app launcher, I have tried [albert](https://github.com/albertlauncher/albert), which is quite nice except for the unfree license. Moreover, since the move away from Gtk-CSS, I have been having difficulties trying to replicate my old setup, and I did not have the courage to fiddle with the internals to make it work again. I plan on doing my own, simple, launcher, since all the other options leave a weird taste when I tried them.

Now, for Hyprland, since the move to Lua and the rewriting of the composition to support scrolling, there is much to do. However, the current method for scrolling and hyprexpo do not fit what I imagined for infinite scroll. I will probably rewrite a few things in Lua, and maybe contribute a plugin, to make it to my taste. That, though, will take a certain amount of time.

Finally, there is a known issue with [zen](https://zen-browser.app/) not moving to workspace 2 on startup. This is because flatpak will run the command, but won't actually spawn the window once the command is completed. That means, if you are not patient, zen will stay on workspace 1, or the command line will move to workspace 2 with zen. This is a minimal issue, but may take a large amount of work to solve, as the startup process finishes before zen is spawn, making it very difficult to know which window was the first zen instance.
