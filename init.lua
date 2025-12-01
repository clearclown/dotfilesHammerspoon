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

-- Center window
hs.hotkey.bind(hyper, "C", function()
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
    T = "Terminal",
    B = "Arc",
    F = "Finder",
    S = "Slack",
    V = "Visual Studio Code",
    D = "Discord",
    O = "Obsidian",
    I = "iTerm",
    Z = "zoom.us",
}

for key, app in pairs(appBindings) do
    hs.hotkey.bind(hyper, key, function()
        hs.application.launchOrFocus(app)
    end)
end

-- Application chooser (fuzzy finder)
hs.hotkey.bind(hyper, "A", function()
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
-- 5. WINDOW FOCUS (Vim-style)
-- ============================================================================

-- Focus window in direction
hs.hotkey.bind(hyperShift, "left", function()
    local win = hs.window.focusedWindow()
    if win then win:focusWindowWest(nil, true, true) end
end)

hs.hotkey.bind(hyperShift, "right", function()
    local win = hs.window.focusedWindow()
    if win then win:focusWindowEast(nil, true, true) end
end)

hs.hotkey.bind(hyperShift, "up", function()
    local win = hs.window.focusedWindow()
    if win then win:focusWindowNorth(nil, true, true) end
end)

hs.hotkey.bind(hyperShift, "down", function()
    local win = hs.window.focusedWindow()
    if win then win:focusWindowSouth(nil, true, true) end
end)

-- ============================================================================
-- 6. SPACES / MISSION CONTROL
-- ============================================================================

-- These require System Preferences > Keyboard > Shortcuts > Mission Control
-- to be enabled with matching shortcuts

hs.hotkey.bind(hyper, "left", function()
    hs.eventtap.keyStroke({"ctrl"}, "left")
end)

hs.hotkey.bind(hyper, "right", function()
    hs.eventtap.keyStroke({"ctrl"}, "right")
end)

hs.hotkey.bind(hyper, "up", function()
    hs.eventtap.keyStroke({"ctrl"}, "up")
end)

-- ============================================================================
-- 7. SYSTEM COMMANDS
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

hs.hotkey.bind(hyper, "V", function()
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

local helpText = [[
=== Hammerspoon Keybindings ===

WINDOW MANAGEMENT (Hyper = Ctrl+Alt+Cmd)
  Hyper + H/L/K/J    : Half screen (Left/Right/Top/Bottom)
  Hyper + M          : Maximize
  Hyper + C          : Center
  Hyper + N/P        : Move to Next/Previous screen
  HyperShift + H/L/J/K : Quarter screen (corners)
  Hyper + G          : Show grid

MOUSE MODE (Hyper + Space to enter, ESC to exit)
  H/J/K/L            : Move cursor (normal)
  Shift + H/J/K/L    : Move cursor (fast)
  Ctrl + H/J/K/L     : Move cursor (slow/precise)
  Return/Space       : Left click
  Cmd + Return       : Right click
  D                  : Double click
  U/N                : Scroll up/down
  Y/O                : Scroll left/right
  1/2/3/4            : Jump to corners
  0                  : Jump to center
  W                  : Jump to focused window

APPLICATIONS (Hyper + key)
  T = Terminal, B = Arc, F = Finder
  S = Slack, V = VS Code, D = Discord
  O = Obsidian, I = iTerm, Z = Zoom
  A = Application chooser

NAVIGATION
  Hyper + W          : Window hints (jump to window)
  Hyper + Left/Right : Switch space
  HyperShift + Arrow : Focus window in direction

SYSTEM
  Hyper + ESC        : Lock screen
  Hyper + R          : Reload config
  HyperShift + R     : Toggle console
  Hyper + V          : Clipboard history
  Hyper + U          : Open URL from clipboard
  Hyper + /          : Show this help
]]

hs.hotkey.bind(hyper, "/", function()
    hs.alert.show(helpText, 10)
end)

print("Hammerspoon configuration loaded successfully!")
