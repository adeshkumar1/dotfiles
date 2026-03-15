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

local function centerOf(win)
  local f = win:frame()
  return hs.geometry.point(f.x + f.w/2, f.y + f.h/2)
end

local function pickDirectional(fromWin, dir)
  local fromC = centerOf(fromWin)
  local best, bestScore = nil, math.huge

  for _, w in ipairs(wf:getWindows()) do
    if w:id() ~= fromWin:id() then
      local c = centerOf(w)
      local score

      if dir == "west" then score = fromC.x - c.x
      elseif dir == "east" then score = c.x - fromC.x
      elseif dir == "north" then score = fromC.y - c.y
      elseif dir == "south" then score = c.y - fromC.y
      end

      if score and score > 0 and score < bestScore then
        best = w
        bestScore = score
      end
    end
  end

  return best
end

local function focusDirectional(dir)
  local win = hs.window.focusedWindow()
  if not win then return end
  local target = pickDirectional(win, dir)
  if target then
    target:focus()
    moveMouseToWindowCenter(target)
  end
end

hs.hotkey.bind(hyper, "H", function() focusDirectional("west") end)
hs.hotkey.bind(hyper, "L", function() focusDirectional("east") end)
hs.hotkey.bind(hyper, "K", function() focusDirectional("north") end)
hs.hotkey.bind(hyper, "J", function() focusDirectional("south") end)

