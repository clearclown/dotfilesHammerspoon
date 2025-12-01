# dotfilesHammerspoon

macOS をマウス・トラックパッドなしでキーボードのみで操作するための Hammerspoon 設定ファイル。

## インストール

```bash
# Hammerspoon をインストール
brew install --cask hammerspoon

# このリポジトリをクローン
git clone https://github.com/ablaze/dotfilesHammerspoon.git ~/dotfilesHammerspoon

# シンボリックリンクを作成
ln -sf ~/dotfilesHammerspoon ~/.hammerspoon

# Hammerspoon を起動
open -a Hammerspoon
```

## キーバインド一覧

### 修飾キー
- **Hyper** = `Ctrl + Alt + Cmd`
- **HyperShift** = `Ctrl + Alt + Cmd + Shift`

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

## 必要な権限

Hammerspoon を初回起動時に以下の権限を許可してください：

1. **システム設定 > プライバシーとセキュリティ > アクセシビリティ**
   - Hammerspoon を許可

2. **システム設定 > プライバシーとセキュリティ > 入力監視**
   - Hammerspoon を許可

## カスタマイズ

`init.lua` の以下のセクションを編集してカスタマイズ可能：

- `appBindings`: アプリケーションのキーバインドを変更
- `mouseSpeed`, `mouseSpeedFast`, `mouseSpeedSlow`: マウス移動速度を調整
- `textExpansions`: テキスト展開ルールを追加

## ライセンス

MIT
