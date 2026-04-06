local hyper = { "cmd", "ctrl", "alt" }

local wf = hs.window.filter.new()
  :setDefaultFilter({
    visible = true,
    currentSpace = true,
    allowRoles = "AXStandardWindow",
  })

local function moveMouseToWindowCenter(win)
  if win then
    local frame = win:frame()
    local center = hs.geometry.point(frame.x + frame.w / 2, frame.y + frame.h / 2)
    hs.mouse.absolutePosition(center)
    hs.mouse.hide()
  end
end

local function focusDirectional(dir)
  local win = hs.window.focusedWindow()
  if not win then return end
  local candidates = wf:getWindows()
  local method = "focusWindow" .. dir:sub(1, 1):upper() .. dir:sub(2)
  win[method](win, candidates, true, true)
  local newWin = hs.window.focusedWindow()
  if newWin and newWin:id() ~= win:id() then
    moveMouseToWindowCenter(newWin)
  end
end

hs.hotkey.bind(hyper, "H", function() focusDirectional("west") end)
hs.hotkey.bind(hyper, "L", function() focusDirectional("east") end)
hs.hotkey.bind(hyper, "K", function() focusDirectional("north") end)
hs.hotkey.bind(hyper, "J", function() focusDirectional("south") end)
