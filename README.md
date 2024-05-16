# Macbook の設定

```sh
cd ~/nix-dotfiles
nix build .#darwinConfigurations."Key5n-MacBook-Pro".system --extra-experimental-features 'nix-command flakes'
./result/sw/bin/darwin-rebuild switch --flake .#Key5n-MacBook-Pro
```

## 手動でやる必要がある設定

- 日本語のライブ変換の無効化
  1. 右上のキーボードを日本語に切り替えてクリック
  2. "Live Conversion" を無効化
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
- 壁紙の設定
- Spotlight を無効化
  - デフォルトは Cmd + Space
- （もしかしたら）App Store からアプリケーションの手動インストール

## インストール方法

1. Macbook に Nix をインストール
  - おすすめ：https://github.com/DeterminateSystems/nix-installer
    - なぜか 1 回目はエラーが起こる
2. Homebrew を**手動で**インストール
  - https://brew.sh/
3. この dotfiles をもとにビルド
  - `nix build github:Key5n/nix-dotfiles#darwinConfigurations.Key5n-MacBook-Pro.system --extra-experimental-features 'nix-command flakes'`
4. ビルドファイルの適用
  - `./result/sw/bin/darwin-rebuild switch --flake github:Key5n/nix-dotfiles#Key5n-MacBook-Pro`

# 参考
https://daiderd.com/nix-darwin/manual/index.html
https://github.com/ryan4yin/nix-darwin-kickstarter/blob/main/minimal/flake.nix