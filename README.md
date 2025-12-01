# dotfilesHammerspoon

macOS をマウス・トラックパッドなしでキーボードのみで操作するための設定ファイル。

## 構成

- **Hammerspoon** - ウィンドウ管理、マウスカーソル操作、アプリランチャー
- **Karabiner-Elements** - Caps Lock → Hyper キー変換
- **Vimium** - ブラウザの Vim 風キーボード操作

## クイックインストール

```bash
# リポジトリをクローン
git clone https://github.com/clearclown/dotfilesHammerspoon.git ~/dotfilesHammerspoon

# セットアップスクリプトを実行
chmod +x ~/dotfilesHammerspoon/setup.sh
~/dotfilesHammerspoon/setup.sh
```

## 手動インストール

```bash
# 1. Hammerspoon & Karabiner-Elements をインストール
brew install --cask hammerspoon karabiner-elements

# 2. シンボリックリンクを作成
ln -sf ~/dotfilesHammerspoon ~/.hammerspoon
mkdir -p ~/.config/karabiner
ln -sf ~/dotfilesHammerspoon/karabiner/karabiner.json ~/.config/karabiner/karabiner.json

# 3. アプリを起動
open -a Hammerspoon
open -a "Karabiner-Elements"
```

## Vimium インストール

ブラウザ拡張機能をインストール：

| ブラウザ | リンク |
|----------|--------|
| Arc / Chrome | [Chrome Web Store](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb) |
| Firefox | [Firefox Add-ons](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/) |

### Vimium 主要キーバインド

| キー | 動作 |
|------|------|
| `j/k` | 下/上にスクロール |
| `d/u` | 半ページ下/上 |
| `gg/G` | ページ先頭/末尾 |
| `f` | リンクヒント表示（クリック） |
| `F` | リンクを新しいタブで開く |
| `o` | URL/履歴/ブックマーク検索 |
| `t` | 新しいタブ |
| `J/K` | 前/次のタブ |
| `x` | タブを閉じる |
| `X` | 閉じたタブを復元 |
| `r` | ページリロード |
| `yy` | 現在のURLをコピー |
| `gi` | 最初のテキスト入力にフォーカス |
| `?` | ヘルプ表示 |

---

## Hyper キー

**Caps Lock** を押すと **Hyper キー** (`Ctrl + Alt + Cmd`) として機能します。

- **Caps Lock + 他のキー** → Hyper + そのキー
- **Caps Lock 単押し** → Escape

---

## キーバインド一覧

### ウィンドウ管理

| キー | 動作 |
|------|------|
| `Hyper + H` | ウィンドウを左半分に |
| `Hyper + L` | ウィンドウを右半分に |
| `Hyper + K` | ウィンドウを上半分に |
| `Hyper + J` | ウィンドウを下半分に |
| `Hyper + M` | ウィンドウを最大化 |
| `Hyper + C` | ウィンドウを中央に配置 |
| `Hyper + N` | 次のモニターに移動 |
| `Hyper + P` | 前のモニターに移動 |
| `HyperShift + H` | 左上 1/4 |
| `HyperShift + L` | 右上 1/4 |
| `HyperShift + J` | 左下 1/4 |
| `HyperShift + K` | 右下 1/4 |
| `Hyper + G` | グリッド表示 |

### マウスモード

`Hyper + Space` でマウスモードに入る（`ESC` で終了）

| キー | 動作 |
|------|------|
| `H/J/K/L` | カーソル移動（通常速度） |
| `Shift + H/J/K/L` | カーソル移動（高速） |
| `Ctrl + H/J/K/L` | カーソル移動（精密） |
| `Return` / `Space` | 左クリック |
| `Cmd + Return` | 右クリック |
| `D` | ダブルクリック |
| `U/N` | 上下スクロール |
| `Y/O` | 左右スクロール |
| `1/2/3/4` | 画面の四隅にジャンプ |
| `0` | 画面中央にジャンプ |
| `W` | フォーカス中のウィンドウ中央にジャンプ |

### アプリケーション起動

| キー | アプリケーション |
|------|------------------|
| `Hyper + T` | Terminal |
| `Hyper + B` | Arc (ブラウザ) |
| `Hyper + F` | Finder |
| `Hyper + S` | Slack |
| `Hyper + V` | Visual Studio Code |
| `Hyper + D` | Discord |
| `Hyper + O` | Obsidian |
| `Hyper + I` | iTerm |
| `Hyper + Z` | Zoom |
| `Hyper + A` | アプリ選択（ファジーファインダー） |

### ナビゲーション

| キー | 動作 |
|------|------|
| `Hyper + W` | ウィンドウヒント（任意のウィンドウにジャンプ） |
| `Hyper + Left/Right` | Spaces を切り替え |
| `HyperShift + 矢印` | 指定方向のウィンドウにフォーカス |

### システム

| キー | 動作 |
|------|------|
| `Hyper + ESC` | 画面ロック |
| `Hyper + R` | 設定リロード |
| `HyperShift + R` | コンソール表示 |
| `Hyper + V` | クリップボード履歴 |
| `Hyper + U` | クリップボードのURLを開く |
| `Hyper + /` | ヘルプ表示 |

---

## 必要な権限

**システム設定 > プライバシーとセキュリティ** で以下を許可：

1. **アクセシビリティ**
   - Hammerspoon
   - Karabiner-Elements
   - karabiner_grabber

2. **入力監視**
   - Hammerspoon
   - Karabiner-Elements
   - karabiner_grabber

---

## ファイル構成

```
~/dotfilesHammerspoon/
├── init.lua              # Hammerspoon メイン設定
├── karabiner/
│   └── karabiner.json    # Karabiner-Elements 設定
├── setup.sh              # セットアップスクリプト
└── README.md
```

## カスタマイズ

`init.lua` の以下のセクションを編集してカスタマイズ可能：

- `appBindings`: アプリケーションのキーバインドを変更
- `mouseSpeed`, `mouseSpeedFast`, `mouseSpeedSlow`: マウス移動速度を調整
- `textExpansions`: テキスト展開ルールを追加

## ライセンス

MIT
