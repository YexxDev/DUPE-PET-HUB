-- 📜 YEXSCRIPT: Fake Dupe Pet Troll UI with Loading Screen
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScriptFakeDupe"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

-- Transparent Background Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundTransparency = 1

-- Dupe Box UI
local dupeBox = Instance.new("Frame", mainFrame)
dupeBox.Size = UDim2.new(0.4, 0, 0.3, 0)
dupeBox.Position = UDim2.new(0.3, 0, 0.35, 0)
dupeBox.BackgroundColor3 = Color3.fromRGB(30, 0, 50)
dupeBox.BackgroundTransparency = 0.2
Instance.new("UICorner", dupeBox).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", dupeBox)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.BackgroundTransparency = 1
title.Text = "YEXSCRIPT"
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Dupe Button
local dupeBtn = Instance.new("TextButton", dupeBox)
dupeBtn.Size = UDim2.new(0.5, 0, 0.25, 0)
dupeBtn.Position = UDim2.new(0.25, 0, 0.55, 0)
dupeBtn.Text = "Dupe Pet"
dupeBtn.Font = Enum.Font.GothamBold
dupeBtn.TextSize = 20
dupeBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 255)
dupeBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", dupeBtn).CornerRadius = UDim.new(0, 8)

-- On Click = Show fake loading
dupeBtn.MouseButton1Click:Connect(function()
	dupeBox.Visible = false

	-- Loading Screen
	local loadBox = Instance.new("Frame", gui)
	loadBox.Size = UDim2.new(0.45, 0, 0.25, 0)
	loadBox.Position = UDim2.new(0.275, 0, 0.38, 0)
	loadBox.BackgroundColor3 = Color3.fromRGB(20, 0, 40)
	Instance.new("UICorner", loadBox).CornerRadius = UDim.new(0, 14)

	local loadTitle = Instance.new("TextLabel", loadBox)
	loadTitle.Size = UDim2.new(1, 0, 0.3, 0)
	loadTitle.BackgroundTransparency = 1
	loadTitle.Text = "🔁 Duplicating Pet..."
	loadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	loadTitle.Font = Enum.Font.GothamBold
	loadTitle.TextSize = 20

	local barBG = Instance.new("Frame", loadBox)
	barBG.Size = UDim2.new(0.85, 0, 0.2, 0)
	barBG.Position = UDim2.new(0.075, 0, 0.5, 0)
	barBG.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Instance.new("UICorner", barBG).CornerRadius = UDim.new(0, 10)

	local bar = Instance.new("Frame", barBG)
	bar.Size = UDim2.new(0, 0, 1, 0)
	bar.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
	Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 10)

	local result = Instance.new("TextLabel", loadBox)
	result.Size = UDim2.new(1, 0, 0.3, 0)
	result.Position = UDim2.new(0, 0, 0.75, 0)
	result.BackgroundTransparency = 1
	result.Text = ""
	result.Font = Enum.Font.Gotham
	result.TextSize = 18
	result.TextColor3 = Color3.fromRGB(255, 255, 255)

	status.Text = "❌ Dupe Failed: Server blocked duplication!"
	bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	wait(2)

	plr:Kick("❌ You have been banned from Grow a Garden for trying to dupe using YexScript.")
end)
