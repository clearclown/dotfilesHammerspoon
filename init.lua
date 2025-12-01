-- ============================================================================
-- Hammerspoon Configuration for Mouse-Free macOS Operation
-- ============================================================================
-- Author: ablaze
-- Repository: https://github.com/ablaze/dotfilesHammerspoon
-- ============================================================================

-- Reload config automatically on save
local function reloadConfig(files)
    local doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

local configWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
configWatcher:start()

hs.alert.show("Hammerspoon Config Loaded")

-- ============================================================================
-- Modifier Keys
-- ============================================================================
local hyper = {"ctrl", "alt", "cmd"}          -- Main modifier
local hyperShift = {"ctrl", "alt", "cmd", "shift"}  -- Extended modifier

-- ============================================================================
-- 1. WINDOW MANAGEMENT
-- ============================================================================

-- Move window to left half
hs.hotkey.bind(hyper, "H", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen():frame()
    f.x = screen.x
    f.y = screen.y
    f.w = screen.w / 2
    f.h = screen.h
    win:setFrame(f)
end)

-- Move window to right half
hs.hotkey.bind(hyper, "L", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen():frame()
    f.x = screen.x + screen.w / 2
    f.y = screen.y
    f.w = screen.w / 2
    f.h = screen.h
    win:setFrame(f)
end)

-- Move window to top half
hs.hotkey.bind(hyper, "K", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen():frame()
    f.x = screen.x
    f.y = screen.y
    f.w = screen.w
    f.h = screen.h / 2
    win:setFrame(f)
end)

-- Move window to bottom half
hs.hotkey.bind(hyper, "J", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen():frame()
    f.x = screen.x
    f.y = screen.y + screen.h / 2
    f.w = screen.w
    f.h = screen.h / 2
    win:setFrame(f)
end)

-- Maximize window
hs.hotkey.bind(hyper, "M", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    win:maximize()
end)

-- Copy (Hyper + C) - triggers on key RELEASE to avoid modifier interference
hs.hotkey.bind(hyper, "C", nil, function()
    hs.eventtap.keyStroke({"cmd"}, "c")
end)

-- Paste (Hyper + V) - triggers on key RELEASE to avoid modifier interference
hs.hotkey.bind(hyper, "V", nil, function()
    hs.eventtap.keyStroke({"cmd"}, "v")
end)

-- Cut (Hyper + X) - triggers on key RELEASE to avoid modifier interference
hs.hotkey.bind(hyper, "X", nil, function()
    hs.eventtap.keyStroke({"cmd"}, "x")
end)

-- Select All (Hyper + A) - triggers on key RELEASE to avoid modifier interference
hs.hotkey.bind(hyper, "A", nil, function()
    hs.eventtap.keyStroke({"cmd"}, "a")
end)

-- Center window (moved to HyperShift + C)
hs.hotkey.bind(hyperShift, "C", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    win:centerOnScreen()
end)

-- Quarter windows (corners)
hs.hotkey.bind(hyperShift, "H", function()  -- Top-left
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen():frame()
    f.x = screen.x
    f.y = screen.y
    f.w = screen.w / 2
    f.h = screen.h / 2
    win:setFrame(f)
end)

hs.hotkey.bind(hyperShift, "L", function()  -- Top-right
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen():frame()
    f.x = screen.x + screen.w / 2
    f.y = screen.y
    f.w = screen.w / 2
    f.h = screen.h / 2
    win:setFrame(f)
end)

hs.hotkey.bind(hyperShift, "J", function()  -- Bottom-left
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen():frame()
    f.x = screen.x
    f.y = screen.y + screen.h / 2
    f.w = screen.w / 2
    f.h = screen.h / 2
    win:setFrame(f)
end)

hs.hotkey.bind(hyperShift, "K", function()  -- Bottom-right
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local screen = win:screen():frame()
    f.x = screen.x + screen.w / 2
    f.y = screen.y + screen.h / 2
    f.w = screen.w / 2
    f.h = screen.h / 2
    win:setFrame(f)
end)

-- ============================================================================
-- WINDOW RESIZE (Incremental)
-- ============================================================================

local resizeStep = 50  -- pixels to resize by

-- Grow window (all directions) - Hyper + Shift + - (same key as =)
hs.hotkey.bind(hyperShift, "-", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    f.x = f.x - resizeStep
    f.y = f.y - resizeStep
    f.w = f.w + (resizeStep * 2)
    f.h = f.h + (resizeStep * 2)
    win:setFrame(f)
end)

-- Shrink window (all directions) - Hyper + -
hs.hotkey.bind(hyper, "-", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    f.x = f.x + resizeStep
    f.y = f.y + resizeStep
    f.w = f.w - (resizeStep * 2)
    f.h = f.h - (resizeStep * 2)
    win:setFrame(f)
end)

-- Expand right
hs.hotkey.bind(hyperShift, "right", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    f.w = f.w + resizeStep
    win:setFrame(f)
end)

-- Shrink from right
hs.hotkey.bind(hyperShift, "left", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    f.w = f.w - resizeStep
    win:setFrame(f)
end)

-- Expand down
hs.hotkey.bind(hyperShift, "down", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    f.h = f.h + resizeStep
    win:setFrame(f)
end)

-- Shrink from bottom
hs.hotkey.bind(hyperShift, "up", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    f.h = f.h - resizeStep
    win:setFrame(f)
end)

-- Toggle Full Screen
hs.hotkey.bind(hyper, "return", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    win:toggleFullScreen()
end)

-- Close window (Hyper + Q)
hs.hotkey.bind(hyper, "Q", nil, function()
    hs.eventtap.keyStroke({"cmd"}, "w")
end)

-- Move window to next/previous screen
hs.hotkey.bind(hyper, "N", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind(hyper, "P", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    win:moveToScreen(win:screen():previous())
end)

-- ============================================================================
-- 2. MOUSE CURSOR CONTROL (Keyboard-driven mouse)
-- ============================================================================

local mouseSpeed = 20
local mouseSpeedFast = 80
local mouseSpeedSlow = 5

-- Mouse movement with arrow keys (Hyper + Arrow)
local mouseModal = hs.hotkey.modal.new(hyper, "space")

function mouseModal:entered()
    hs.alert.show("Mouse Mode: ON (ESC to exit)")
end

function mouseModal:exited()
    hs.alert.show("Mouse Mode: OFF")
end

mouseModal:bind("", "escape", function() mouseModal:exit() end)

-- Normal speed movement
mouseModal:bind("", "h", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x - mouseSpeed, y = pos.y})
end)

mouseModal:bind("", "l", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x + mouseSpeed, y = pos.y})
end)

mouseModal:bind("", "k", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x, y = pos.y - mouseSpeed})
end)

mouseModal:bind("", "j", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x, y = pos.y + mouseSpeed})
end)

-- Fast movement (Shift + HJKL)
mouseModal:bind("shift", "h", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x - mouseSpeedFast, y = pos.y})
end)

mouseModal:bind("shift", "l", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x + mouseSpeedFast, y = pos.y})
end)

mouseModal:bind("shift", "k", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x, y = pos.y - mouseSpeedFast})
end)

mouseModal:bind("shift", "j", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x, y = pos.y + mouseSpeedFast})
end)

-- Slow/precise movement (Ctrl + HJKL)
mouseModal:bind("ctrl", "h", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x - mouseSpeedSlow, y = pos.y})
end)

mouseModal:bind("ctrl", "l", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x + mouseSpeedSlow, y = pos.y})
end)

mouseModal:bind("ctrl", "k", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x, y = pos.y - mouseSpeedSlow})
end)

mouseModal:bind("ctrl", "j", nil, function()
    local pos = hs.mouse.absolutePosition()
    hs.mouse.absolutePosition({x = pos.x, y = pos.y + mouseSpeedSlow})
end)

-- Mouse clicks
mouseModal:bind("", "return", function()  -- Left click
    hs.eventtap.leftClick(hs.mouse.absolutePosition())
end)

mouseModal:bind("", "space", function()  -- Left click (alternative)
    hs.eventtap.leftClick(hs.mouse.absolutePosition())
end)

mouseModal:bind("cmd", "return", function()  -- Right click
    hs.eventtap.rightClick(hs.mouse.absolutePosition())
end)

mouseModal:bind("", "d", function()  -- Double click
    hs.eventtap.leftClick(hs.mouse.absolutePosition(), 2)
end)

-- Jump cursor to screen corners/center
mouseModal:bind("", "1", function()  -- Top-left
    local screen = hs.screen.mainScreen():frame()
    hs.mouse.absolutePosition({x = screen.x + 50, y = screen.y + 50})
end)

mouseModal:bind("", "2", function()  -- Top-right
    local screen = hs.screen.mainScreen():frame()
    hs.mouse.absolutePosition({x = screen.x + screen.w - 50, y = screen.y + 50})
end)

mouseModal:bind("", "3", function()  -- Bottom-left
    local screen = hs.screen.mainScreen():frame()
    hs.mouse.absolutePosition({x = screen.x + 50, y = screen.y + screen.h - 50})
end)

mouseModal:bind("", "4", function()  -- Bottom-right
    local screen = hs.screen.mainScreen():frame()
    hs.mouse.absolutePosition({x = screen.x + screen.w - 50, y = screen.y + screen.h - 50})
end)

mouseModal:bind("", "0", function()  -- Center
    local screen = hs.screen.mainScreen():frame()
    hs.mouse.absolutePosition({x = screen.x + screen.w / 2, y = screen.y + screen.h / 2})
end)

-- Move cursor to focused window center
mouseModal:bind("", "w", function()
    local win = hs.window.focusedWindow()
    if win then
        local f = win:frame()
        hs.mouse.absolutePosition({x = f.x + f.w / 2, y = f.y + f.h / 2})
    end
end)

-- Scroll
mouseModal:bind("", "u", nil, function()  -- Scroll up
    hs.eventtap.scrollWheel({0, 3}, {})
end)

mouseModal:bind("", "n", nil, function()  -- Scroll down
    hs.eventtap.scrollWheel({0, -3}, {})
end)

mouseModal:bind("", "y", nil, function()  -- Scroll left
    hs.eventtap.scrollWheel({3, 0}, {})
end)

mouseModal:bind("", "o", nil, function()  -- Scroll right
    hs.eventtap.scrollWheel({-3, 0}, {})
end)

-- ============================================================================
-- 3. APPLICATION LAUNCHER / SWITCHER
-- ============================================================================

local appBindings = {
    T = "Alacritty",
    B = "Vivaldi Browser",
    D = "Discord",
    E = "Finder",
}

for key, app in pairs(appBindings) do
    hs.hotkey.bind(hyper, key, function()
        hs.application.launchOrFocus(app)
    end)
end

-- Open Alacritty at current Finder path (HyperShift + T)
hs.hotkey.bind(hyperShift, "T", function()
    local script = [[
        tell application "Finder"
            if (count of windows) > 0 then
                set currentPath to POSIX path of (target of front window as alias)
            else
                set currentPath to POSIX path of (path to home folder)
            end if
        end tell
        return currentPath
    ]]
    local ok, path = hs.osascript.applescript(script)
    if ok and path then
        hs.task.new("/usr/bin/open", nil, {"-a", "Alacritty", "--args", "--working-directory", path}):start()
    else
        hs.application.launchOrFocus("Alacritty")
    end
end)

-- Application chooser (fuzzy finder) - moved to HyperShift + A
hs.hotkey.bind(hyperShift, "A", function()
    local chooser = hs.chooser.new(function(choice)
        if choice then
            hs.application.launchOrFocus(choice.text)
        end
    end)

    local apps = {}
    for _, app in ipairs(hs.application.runningApplications()) do
        if app:title() ~= "" and app:kind() == 1 then
            table.insert(apps, {
                text = app:title(),
                subText = app:bundleID(),
                image = hs.image.imageFromAppBundle(app:bundleID())
            })
        end
    end

    chooser:choices(apps)
    chooser:show()
end)

-- ============================================================================
-- 4. WINDOW HINTS (Jump to any window)
-- ============================================================================

hs.hotkey.bind(hyper, "W", function()
    hs.hints.windowHints()
end)

-- Custom window hints style
hs.hints.hintChars = {"A", "S", "D", "F", "G", "H", "J", "K", "L", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"}
hs.hints.showTitleThresh = 4
hs.hints.titleMaxSize = 10
hs.hints.fontSize = 20


-- ============================================================================
-- 6. SYSTEM COMMANDS
-- ============================================================================

-- Lock screen
hs.hotkey.bind(hyper, "escape", function()
    hs.caffeinate.lockScreen()
end)

-- Reload Hammerspoon config
hs.hotkey.bind(hyper, "R", function()
    hs.reload()
end)

-- Show Hammerspoon console
hs.hotkey.bind(hyperShift, "R", function()
    hs.toggleConsole()
end)

-- ============================================================================
-- 8. CLIPBOARD MANAGER
-- ============================================================================

local clipboardHistory = {}
local maxClipboardHistory = 20

local clipboardWatcher = hs.pasteboard.watcher.new(function(content)
    if content then
        -- Remove duplicate if exists
        for i, item in ipairs(clipboardHistory) do
            if item == content then
                table.remove(clipboardHistory, i)
                break
            end
        end
        -- Add to front
        table.insert(clipboardHistory, 1, content)
        -- Trim if needed
        while #clipboardHistory > maxClipboardHistory do
            table.remove(clipboardHistory)
        end
    end
end)
clipboardWatcher:start()

-- Clipboard history (HyperShift + V)
hs.hotkey.bind(hyperShift, "V", function()
    local chooser = hs.chooser.new(function(choice)
        if choice then
            hs.pasteboard.setContents(choice.text)
            hs.eventtap.keyStroke({"cmd"}, "v")
        end
    end)

    local choices = {}
    for i, item in ipairs(clipboardHistory) do
        local displayText = item:gsub("\n", " "):sub(1, 80)
        if #item > 80 then displayText = displayText .. "..." end
        table.insert(choices, {
            text = displayText,
            subText = "Item " .. i,
            fullText = item
        })
    end

    chooser:choices(choices)
    chooser:show()
end)

-- ============================================================================
-- 9. QUICK TEXT EXPANSION
-- ============================================================================

-- Example text expansions (customize as needed)
local textExpansions = {
    ["@@"] = "your.email@example.com",
    ["##"] = os.date("%Y-%m-%d"),
    ["!!!"] = os.date("%Y-%m-%d %H:%M:%S"),
}

-- Note: For full text expansion, consider using hs.eventtap

-- ============================================================================
-- 10. WINDOW GRID
-- ============================================================================

hs.grid.setGrid("6x4")
hs.grid.setMargins({0, 0})

hs.hotkey.bind(hyper, "G", function()
    hs.grid.show()
end)

-- ============================================================================
-- 11. URL HANDLER / QUICK OPEN
-- ============================================================================

hs.hotkey.bind(hyper, "U", function()
    local url = hs.pasteboard.getContents()
    if url and url:match("^https?://") then
        hs.urlevent.openURL(url)
        hs.alert.show("Opening URL")
    else
        hs.alert.show("No valid URL in clipboard")
    end
end)

-- ============================================================================
-- HELP: Show all keybindings
-- ============================================================================

-- ============================================================================
-- VISUAL KEYMAP (Full Screen Overlay)
-- ============================================================================

local keymapWebview = nil

local function showKeymap()
    if keymapWebview then
        keymapWebview:delete()
        keymapWebview = nil
        return
    end

    local screen = hs.screen.mainScreen():frame()

    local html = [[
<!DOCTYPE html>
<html>
<head>
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    background: rgba(30, 30, 30, 0.95);
    color: #fff;
    padding: 30px;
    overflow: auto;
}
h1 {
    text-align: center;
    color: #4FC3F7;
    margin-bottom: 20px;
    font-size: 28px;
}
.hint {
    text-align: center;
    color: #888;
    margin-bottom: 25px;
    font-size: 14px;
}
.container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
    max-width: 1400px;
    margin: 0 auto;
}
.section {
    background: rgba(255,255,255,0.05);
    border-radius: 12px;
    padding: 15px;
}
.section h2 {
    color: #81C784;
    font-size: 16px;
    margin-bottom: 12px;
    padding-bottom: 8px;
    border-bottom: 1px solid rgba(255,255,255,0.1);
}
.key-row {
    display: flex;
    align-items: center;
    margin: 8px 0;
}
.key {
    background: linear-gradient(180deg, #555 0%, #333 100%);
    border: 1px solid #666;
    border-radius: 6px;
    padding: 4px 10px;
    font-size: 12px;
    font-weight: bold;
    color: #fff;
    margin-right: 5px;
    min-width: 28px;
    text-align: center;
    box-shadow: 0 2px 0 #222;
}
.key.hyper {
    background: linear-gradient(180deg, #7B1FA2 0%, #4A148C 100%);
    border-color: #9C27B0;
}
.key.shift {
    background: linear-gradient(180deg, #1565C0 0%, #0D47A1 100%);
    border-color: #1976D2;
}
.key.special {
    background: linear-gradient(180deg, #E65100 0%, #BF360C 100%);
    border-color: #FF6D00;
}
.plus {
    color: #888;
    margin: 0 3px;
    font-size: 11px;
}
.action {
    color: #ccc;
    font-size: 13px;
    margin-left: 10px;
}
.divider {
    height: 1px;
    background: rgba(255,255,255,0.1);
    margin: 10px 0;
}
</style>
</head>
<body>
<h1>⌨️ Hammerspoon Keybindings</h1>
<p class="hint">Hyper = Caps Lock (Ctrl+Alt+Cmd) ｜ Press <span style="color:#4FC3F7">Hyper + /</span> or <span style="color:#4FC3F7">ESC</span> to close</p>

<div class="container">
    <!-- CLIPBOARD -->
    <div class="section">
        <h2>📋 Clipboard</h2>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">C</span><span class="action">Copy</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">V</span><span class="action">Paste</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">X</span><span class="action">Cut</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">A</span><span class="action">Select All</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key shift">Shift</span><span class="plus">+</span><span class="key">V</span><span class="action">Clipboard History</span></div>
    </div>

    <!-- WINDOW MANAGEMENT -->
    <div class="section">
        <h2>🪟 Window Management</h2>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">H</span><span class="action">Left Half</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">L</span><span class="action">Right Half</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">K</span><span class="action">Top Half</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">J</span><span class="action">Bottom Half</span></div>
        <div class="divider"></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">M</span><span class="action">Maximize</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">Q</span><span class="action">Close Window</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key special">Return</span><span class="action">Full Screen</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key shift">Shift</span><span class="plus">+</span><span class="key">C</span><span class="action">Center</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">G</span><span class="action">Grid</span></div>
    </div>

    <!-- WINDOW RESIZE -->
    <div class="section">
        <h2>📐 Window Resize</h2>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">-</span><span class="action">Shrink</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key shift">Shift</span><span class="plus">+</span><span class="key">-</span><span class="action">Grow</span></div>
        <div class="divider"></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key shift">Shift</span><span class="plus">+</span><span class="key">→</span><span class="action">Expand Right</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key shift">Shift</span><span class="plus">+</span><span class="key">←</span><span class="action">Shrink Width</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key shift">Shift</span><span class="plus">+</span><span class="key">↓</span><span class="action">Expand Down</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key shift">Shift</span><span class="plus">+</span><span class="key">↑</span><span class="action">Shrink Height</span></div>
    </div>

    <!-- APPLICATIONS -->
    <div class="section">
        <h2>🚀 Applications</h2>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">T</span><span class="action">Alacritty</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">B</span><span class="action">Arc</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">E</span><span class="action">Finder</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">S</span><span class="action">Slack</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">D</span><span class="action">Discord</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">O</span><span class="action">Obsidian</span></div>
        <div class="divider"></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key shift">Shift</span><span class="plus">+</span><span class="key">T</span><span class="action">Terminal at Finder Path</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key shift">Shift</span><span class="plus">+</span><span class="key">A</span><span class="action">App Chooser</span></div>
    </div>

    <!-- NAVIGATION -->
    <div class="section">
        <h2>🧭 Navigation</h2>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">W</span><span class="action">Window Hints</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">N</span><span class="action">Next Screen</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">P</span><span class="action">Previous Screen</span></div>
        <div class="divider"></div>
        <h2 style="margin-top:10px">🔧 System</h2>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key special">ESC</span><span class="action">Lock Screen</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">R</span><span class="action">Reload Config</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key shift">Shift</span><span class="plus">+</span><span class="key">R</span><span class="action">Console</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">U</span><span class="action">Open URL</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">/</span><span class="action">This Help</span></div>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key">;</span><span class="action">UI Hints (Vimium)</span></div>
    </div>

    <!-- MOUSE MODE -->
    <div class="section">
        <h2>🖱️ Mouse Mode</h2>
        <div class="key-row"><span class="key hyper">Hyper</span><span class="plus">+</span><span class="key special">Space</span><span class="action">Enter Mouse Mode</span></div>
        <div class="key-row"><span class="key special">ESC</span><span class="action">Exit Mouse Mode</span></div>
        <div class="divider"></div>
        <div class="key-row"><span class="key">H/J/K/L</span><span class="action">Move Cursor</span></div>
        <div class="key-row"><span class="key shift">Shift</span><span class="plus">+</span><span class="key">H/J/K/L</span><span class="action">Fast Move</span></div>
        <div class="key-row"><span class="key">Return</span><span class="action">Click</span></div>
        <div class="key-row"><span class="key">D</span><span class="action">Double Click</span></div>
        <div class="key-row"><span class="key">U/N</span><span class="action">Scroll Up/Down</span></div>
        <div class="key-row"><span class="key">0-4</span><span class="action">Jump to Position</span></div>
    </div>
</div>

<script>
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        window.location.href = 'hammerspoon://closeKeymap';
    }
});
</script>
</body>
</html>
]]

    keymapWebview = hs.webview.new({
        x = screen.x + 50,
        y = screen.y + 50,
        w = screen.w - 100,
        h = screen.h - 100
    })

    keymapWebview:windowStyle({"borderless", "closable"})
    keymapWebview:level(hs.drawing.windowLevels.overlay)
    keymapWebview:html(html)
    keymapWebview:allowTextEntry(true)
    keymapWebview:show()
end

-- URL handler for closing keymap
hs.urlevent.bind("closeKeymap", function()
    if keymapWebview then
        keymapWebview:delete()
        keymapWebview = nil
    end
end)

hs.hotkey.bind(hyper, "/", showKeymap)

-- ============================================================================
-- UI ELEMENT HINTS (Vimium-style for macOS)
-- ============================================================================

local hintCanvas = nil
local hintElements = {}
local hintChars = "ASDFGHJKLQWERTYUIOPZXCVBNM"
local hintMode = false
local hintInput = ""

local function generateHintStrings(count)
    local hints = {}
    local len = 1
    while #hints < count do
        if len == 1 then
            for i = 1, #hintChars do
                table.insert(hints, hintChars:sub(i, i))
                if #hints >= count then break end
            end
        else
            local prev = hints
            hints = {}
            for _, p in ipairs(prev) do
                for i = 1, #hintChars do
                    table.insert(hints, p .. hintChars:sub(i, i))
                    if #hints >= count then break end
                end
                if #hints >= count then break end
            end
        end
        len = len + 1
        if len > 3 then break end
    end
    return hints
end

local function getClickableElements(element, elements, depth)
    if depth > 10 then return end
    depth = depth or 0
    elements = elements or {}

    local role = element:attributeValue("AXRole")
    local clickable = {
        "AXButton", "AXLink", "AXMenuItem", "AXMenuButton",
        "AXPopUpButton", "AXCheckBox", "AXRadioButton",
        "AXTextField", "AXTextArea", "AXComboBox", "AXTab",
        "AXCell", "AXImage", "AXStaticText"
    }

    for _, r in ipairs(clickable) do
        if role == r then
            local pos = element:attributeValue("AXPosition")
            local size = element:attributeValue("AXSize")
            if pos and size and size.w > 5 and size.h > 5 then
                local title = element:attributeValue("AXTitle") or
                              element:attributeValue("AXDescription") or
                              element:attributeValue("AXValue") or ""
                table.insert(elements, {
                    element = element,
                    x = pos.x,
                    y = pos.y,
                    w = size.w,
                    h = size.h,
                    title = title:sub(1, 20)
                })
            end
            break
        end
    end

    local children = element:attributeValue("AXChildren")
    if children then
        for _, child in ipairs(children) do
            getClickableElements(child, elements, depth + 1)
        end
    end

    return elements
end

local function showUIHints()
    if hintMode then
        hideUIHints()
        return
    end

    local app = hs.application.frontmostApplication()
    if not app then return end

    local axApp = hs.axuielement.applicationElement(app)
    if not axApp then
        hs.alert.show("Cannot access UI elements")
        return
    end

    hintElements = getClickableElements(axApp, {}, 0)

    if #hintElements == 0 then
        hs.alert.show("No clickable elements found")
        return
    end

    -- Limit elements
    if #hintElements > 100 then
        local temp = {}
        for i = 1, 100 do table.insert(temp, hintElements[i]) end
        hintElements = temp
    end

    local hints = generateHintStrings(#hintElements)
    local screen = hs.screen.mainScreen():frame()

    hintCanvas = hs.canvas.new(screen)
    hintCanvas:level(hs.canvas.windowLevels.overlay + 1)

    for i, el in ipairs(hintElements) do
        el.hint = hints[i]

        -- Background
        hintCanvas:appendElements({
            type = "rectangle",
            frame = {x = el.x - screen.x, y = el.y - screen.y - 2, w = #el.hint * 12 + 8, h = 18},
            fillColor = {red = 1, green = 0.8, blue = 0, alpha = 0.95},
            strokeColor = {red = 0.8, green = 0.6, blue = 0, alpha = 1},
            strokeWidth = 1,
            roundedRectRadii = {xRadius = 3, yRadius = 3}
        })

        -- Text
        hintCanvas:appendElements({
            type = "text",
            frame = {x = el.x - screen.x + 4, y = el.y - screen.y - 2, w = #el.hint * 12, h = 18},
            text = el.hint,
            textColor = {red = 0, green = 0, blue = 0, alpha = 1},
            textSize = 13,
            textFont = "Menlo-Bold"
        })
    end

    hintCanvas:show()
    hintMode = true
    hintInput = ""

    hs.alert.show("Type hint to click (ESC to cancel)", 1)
end

local function hideUIHints()
    if hintCanvas then
        hintCanvas:delete()
        hintCanvas = nil
    end
    hintMode = false
    hintInput = ""
    hintElements = {}
end

local function processHintInput(char)
    if not hintMode then return false end

    hintInput = hintInput .. char:upper()

    -- Find matching element
    for _, el in ipairs(hintElements) do
        if el.hint == hintInput then
            hideUIHints()
            -- Click the element
            local clickPoint = {x = el.x + el.w / 2, y = el.y + el.h / 2}
            hs.mouse.absolutePosition(clickPoint)
            hs.timer.doAfter(0.05, function()
                hs.eventtap.leftClick(clickPoint)
            end)
            return true
        end
    end

    -- Check if any hints start with input
    local hasMatch = false
    for _, el in ipairs(hintElements) do
        if el.hint:sub(1, #hintInput) == hintInput then
            hasMatch = true
            break
        end
    end

    if not hasMatch then
        hideUIHints()
        hs.alert.show("No match", 0.5)
    end

    return true
end

-- Hint mode key handler
hintKeyWatcher = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    if not hintMode then return false end

    local char = event:characters()
    local keyCode = event:getKeyCode()

    -- ESC to cancel
    if keyCode == 53 then
        hideUIHints()
        return true
    end

    -- Letter keys
    if char and char:match("^[a-zA-Z]$") then
        processHintInput(char)
        return true
    end

    return true
end)
hintKeyWatcher:start()

-- Activate UI hints (Hyper + ;)
hs.hotkey.bind(hyper, ";", showUIHints)

print("Hammerspoon configuration loaded successfully!")
