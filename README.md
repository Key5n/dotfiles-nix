# NixOS デスクトップの設定

インストール方法

```sh
sudo nixos-rebuild switch --flake github:Key5n/dotfiles-nix#nixos-desktop
```

## Windows とのデュアルブートの設定

- Linux の ESP に Windows の boot loader をコピーする必要あり
  - すると systemd-boot の auto detection が働く

## VPN 設定

1. まず `/modules/nixos/network.nix` の大学パスワードを変更すること
2. （証明書がない場合）証明書をダウンロードすること

```
# 接続
sudo swanctl --initiate --child net

# 切断
sudo swanctl --terminate --child net

# 接続状況確認（接続されている場合のみ表示）
sudo swanctl --list-sas
```

# Macbook の設定

```sh
cd ~/dotfiles-nix
nix build .#darwinConfigurations."Key5n-MacBook-Pro".system --extra-experimental-features 'nix-command flakes'
./result/sw/bin/darwin-rebuild switch --flake .#Key5n-MacBook-Pro
```

注意
username を key5n にしないとエラーが発生

## 手動でやる必要がある設定

- 日本語のライブ変換の無効化
  1. 右上のキーボードを日本語に切り替えてクリック
  2. "Live Conversion" を無効化
- capslock key を command key に変更
  - Settings > Keyboard > Keyboard Shortcut > Modifier Key
- 入力ソースの切り替え方法を Command + Space に変更
  - Spotlight を無効化
    - デフォルトショートカットが Cmd + Space のためブッキング
    - Settings > Keyboard > Modifier Key
  - Settings > Keyboard > Keyboard Shortcut > Input Source
- GitHub の SSH 設定
  - https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
- Raycast のショートカットの設定
  1. Raycast を手動で起動
     - ログイン時に起動されるようにする
  2. 右上から Raycast のアイコンをクリック
  3. settings を開き Raycast Hotkey を設定
     - デフォルトは Option + Space
- Office のインストール
  - Office のウェブサイトを開く
  - 大学のアカウントでログイン
  - インストール
- Docker のインストール
  - https://docs.docker.com/desktop/install/mac-install/
- 壁紙の設定
- デスクトップをクリックでデスクトップの表示を無効化
  - Settings > Desktop and Dock > Desktop and Stage Manager
- （もしかしたら）App Store からアプリケーションの手動インストール

## インストール方法

1. Macbook に Nix をインストール
   - おすすめ：https://github.com/DeterminateSystems/nix-installer
     - 1 回目はエラーが発生することがある（原因不明）
     - `--determinate` フラグをつけると nix が Determinate によって管理され、`nix-darwin` の一部の機能が使用できなくなるため注意
2. Homebrew を**手動で**インストール
   - https://brew.sh/
3. この dotfiles をもとにビルド

   - `nix build github:Key5n/dotfiles-nix#darwinConfigurations.Key5n-MacBook-Pro.system --extra-experimental-features 'nix-command flakes'`

4. ビルドファイルの適用
   - `./result/sw/bin/darwin-rebuild switch --flake github:Key5n/dotfiles-nix#Key5n-MacBook-Pro`

# 参考

- https://daiderd.com/nix-darwin/manual/index.html
- https://github.com/ryan4yin/nix-darwin-kickstarter/blob/main/minimal/flake.nix
