require("hs.ipc")

hs.window.timeout(0.5)

local hyper = { "cmd", "ctrl", "alt" }

local function moveMouseToCenter(frame)
  hs.mouse.absolutePosition(hs.geometry.point(frame.x + frame.w / 2, frame.y + frame.h / 2))
end

local axes = {
  west = function(dx, dy) return -dx, dy end,
  east = function(dx, dy) return dx, dy end,
  north = function(dx, dy) return -dy, dx end,
  south = function(dx, dy) return dy, dx end,
}

local function covers(a, b)
  return a.x <= b.x and a.y <= b.y and a.x + a.w >= b.x + b.w and a.y + a.h >= b.y + b.h
end

-- Uses the CoreGraphics window list rather than hs.window: some apps (e.g. Slack) reject
-- accessibility queries, which hides their windows from hs.window entirely.
local function focusDirectional(dir)
  local frontPid = hs.application.frontmostApplication():pid()
  local selfPid = hs.processInfo.processID
  local wins = {}
  for _, w in ipairs(hs.window.list() or {}) do
    local b = w.kCGWindowBounds
    if w.kCGWindowLayer == 0 and w.kCGWindowOwnerPID ~= selfPid and b and b.Width > 50 and b.Height > 50 then
      table.insert(wins, { id = w.kCGWindowNumber, pid = w.kCGWindowOwnerPID, frame = { x = b.X, y = b.Y, w = b.Width, h = b.Height } })
    end
  end

  local from
  for _, w in ipairs(wins) do
    if w.pid == frontPid then from = w break end
  end
  if not from then return end
  local cx, cy = from.frame.x + from.frame.w / 2, from.frame.y + from.frame.h / 2

  local best, bestScore
  for z, w in ipairs(wins) do
    local hidden = false
    for i = 1, z - 1 do
      if covers(wins[i].frame, w.frame) then hidden = true break end
    end
    if not hidden and w ~= from then
      local f = w.frame
      local along, across = axes[dir](f.x + f.w / 2 - cx, f.y + f.h / 2 - cy)
      if along > math.abs(across) then
        local score = math.sqrt(along * along + across * across) + z
        if not bestScore or score < bestScore then best, bestScore = w, score end
      end
    end
  end
  if not best then return end

  local app = hs.application.applicationForPID(best.pid)
  if app then
    local target
    for _, w in ipairs(app:allWindows()) do
      if w:id() == best.id then target = w break end
    end
    if not (target and target:focus()) then app:activate() end
  end
  moveMouseToCenter(best.frame)
end

hs.hotkey.bind(hyper, "H", function() focusDirectional("west") end)
hs.hotkey.bind(hyper, "L", function() focusDirectional("east") end)
hs.hotkey.bind(hyper, "K", function() focusDirectional("north") end)
hs.hotkey.bind(hyper, "J", function() focusDirectional("south") end)
