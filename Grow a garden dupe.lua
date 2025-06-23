-- YexScript Troll: Fake Pet Claim + Fake Hack + Kick

local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_TrollUI"
gui.ResetOnSpawn = false

-- Frame UI
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0.4, 0, 0.3, 0)
frame.Position = UDim2.new(0.3, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Name = "MainFrame"

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Text = "🎁 Claim Any Pet for FREE!"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextSize = 22

-- TextBox for pet name
local input = Instance.new("TextBox", frame)
input.PlaceholderText = "Enter Pet Name (e.g. Raccoon)"
input.Size = UDim2.new(0.8, 0, 0.25, 0)
input.Position = UDim2.new(0.1, 0, 0.45, 0)
input.Font = Enum.Font.Gotham
input.TextSize = 18
input.TextColor3 = Color3.new(1, 1, 1)
input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Claim Button
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.6, 0, 0.25, 0)
btn.Position = UDim2.new(0.2, 0, 0.75, 0)
btn.Text = "Claim Pet"
btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 20
btn.TextColor3 = Color3.new(1, 1, 1)

-- On click...
btn.MouseButton1Click:Connect(function()
	frame:Destroy()

	local fakeLoad = Instance.new("Frame", gui)
	fakeLoad.Size = UDim2.new(1, 0, 1, 0)
	fakeLoad.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

	local msg = Instance.new("TextLabel", fakeLoad)
	msg.Size = UDim2.new(1, 0, 0.3, 0)
	msg.Position = UDim2.new(0, 0, 0.35, 0)
	msg.Text = ""
	msg.TextColor3 = Color3.new(0, 1, 0)
	msg.BackgroundTransparency = 1
	msg.Font = Enum.Font.Code
	msg.TextSize = 20
	msg.TextWrapped = true

	local logs = {
		"[YexScript] Connecting to Roblox servers...",
		"[+] Exploit Injected.",
		"[+] Accessing Pet Database...",
		"[+] Attempting to add pet: " .. input.Text,
		"[×] Security Flag Detected!",
		"[!] Unauthorized use of YexScript!",
		"[×] Account flagged for auto-ban...",
		"[×] Banning in progress..."
	}

	coroutine.wrap(function()
		for _, line in ipairs(logs) do
			msg.Text = msg.Text .. line .. "\n"
			wait(1.2)
		end

		wait(1)
		plr:Kick("⚠️ You have been permanently banned from Grow a Garden for unauthorized exploits.")
	end)()
end)
