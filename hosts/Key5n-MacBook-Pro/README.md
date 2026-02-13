# MacBook Setup

```sh
cd ~/dotfiles-nix
nix build .#darwinConfigurations."Key5n-MacBook-Pro".system --extra-experimental-features 'nix-command flakes'
./result/sw/bin/darwin-rebuild switch --flake .#Key5n-MacBook-Pro
```

Note: If the username is not `key5n`, an error occurs.

## Settings That Must Be Done Manually

- Disable Japanese live conversion. Steps: (1) Switch the keyboard in the top-right to Japanese and click it. (2) Disable “Live Conversion”.
- Change the Caps Lock key to the Command key. Path: Settings > Keyboard > Keyboard Shortcut > Modifier Key.
- Change input source switching to Command + Space. Also disable Spotlight because its default shortcut conflicts with Cmd + Space. Paths: Settings > Keyboard > Modifier Key, and Settings > Keyboard > Keyboard Shortcut > Input Source.
- GitHub SSH setup: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
- Raycast shortcut setup. Steps: (1) Launch Raycast manually and set it to start at login. (2) Click the Raycast icon in the top-right. (3) Open settings and set the Raycast hotkey (default is Option + Space).
- Install Office. Steps: (1) Open the Office website. (2) Log in with your university account. (3) Install.
- Install Docker: https://docs.docker.com/desktop/install/mac-install/
- Set wallpaper.
- Disable “click desktop to show desktop”. Path: Settings > Desktop and Dock > Desktop and Stage Manager.
- (Possibly) manually install applications from the App Store.

## Installation (Mac)

1. Install Nix on the MacBook. Recommended: https://github.com/DeterminateSystems/nix-installer
   Note: The first run may fail for unknown reasons. If you add the `--determinate` flag, Nix will be managed by Determinate and some `nix-darwin` features become unavailable.
2. Install Homebrew manually: https://brew.sh/
3. Build from these dotfiles:
   `nix build github:Key5n/dotfiles-nix#darwinConfigurations.Key5n-MacBook-Pro.system --extra-experimental-features 'nix-command flakes'`
4. Apply the build:
   `./result/sw/bin/darwin-rebuild switch --flake github:Key5n/dotfiles-nix#Key5n-MacBook-Pro`
