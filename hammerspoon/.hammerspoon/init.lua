local hyper = { "cmd", "ctrl", "alt" }

-- Media Controls
hs.hotkey.bind({ "cmd" }, "F8", function()
	hs.eventtap.event.newSystemKeyEvent("PLAY", true):post()
end)
hs.hotkey.bind({ "cmd" }, "F7", function()
	hs.spotify.previous()
end)
hs.hotkey.bind({ "cmd" }, "F9", function()
	hs.spotify.next()
end)
hs.hotkey.bind({ "cmd" }, "F10", function()
	local device = hs.audiodevice.defaultOutputDevice()
	device:setMuted(not device:muted())
end)
hs.hotkey.bind({ "cmd" }, "F11", function()
	hs.audiodevice.defaultOutputDevice():setVolume(hs.audiodevice.defaultOutputDevice():volume() - 5)
end)
hs.hotkey.bind({ "cmd" }, "F12", function()
	hs.audiodevice.defaultOutputDevice():setVolume(hs.audiodevice.defaultOutputDevice():volume() + 5)
end)

-- Helper function to move mouse to center of window
local function moveMouseToWindowCenter(win)
	if win then
		local frame = win:frame()
		local center = hs.geometry.point(frame.x + frame.w / 2, frame.y + frame.h / 2)
		hs.mouse.absolutePosition(center)
		hs.mouse.hide()
	end
end

hs.hotkey.bind(hyper, "H", function()
	local win = hs.window.focusedWindow()
	if win then
		local left = (win:windowsToWest())[1]
		if left then
			left:focus()
			moveMouseToWindowCenter(left)
		end
	end
end)

hs.hotkey.bind(hyper, "L", function()
	local win = hs.window.focusedWindow()
	if win then
		local right = (win:windowsToEast())[1]
		if right then
			right:focus()
			moveMouseToWindowCenter(right)
		end
	end
end)

hs.hotkey.bind(hyper, "J", function()
	local win = hs.window.focusedWindow()
	if win then
		local down = (win:windowsToSouth())[1]
		if down then
			down:focus()
			moveMouseToWindowCenter(down)
		end
	end
end)

hs.hotkey.bind(hyper, "K", function()
	local win = hs.window.focusedWindow()
	if win then
		local up = (win:windowsToNorth())[1]
		if up then
			up:focus()
			moveMouseToWindowCenter(up)
		end
	end
end)
