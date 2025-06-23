-- 💻 YEXSCRIPT - FULL MOD HUB UI
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_ModHub"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 330)
frame.Position = UDim2.new(0, 10, 0.4, -150)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Draggable
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "⚙️ YEXSCRIPT MOD HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local y = 35

-- WalkSpeed Input
local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Position = UDim2.new(0, 10, 0, y)
speedLabel.Size = UDim2.new(0, 100, 0, 25)
speedLabel.Text = "WalkSpeed:"
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.BackgroundTransparency = 1
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 14

local speedInput = Instance.new("TextBox", frame)
speedInput.Position = UDim2.new(0, 110, 0, y)
speedInput.Size = UDim2.new(0, 60, 0, 25)
speedInput.Text = "16"
speedInput.Font = Enum.Font.Gotham
speedInput.TextSize = 14
speedInput.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
speedInput.TextColor3 = Color3.new(1,1,1)

local applySpeed = Instance.new("TextButton", frame)
applySpeed.Position = UDim2.new(0, 180, 0, y)
applySpeed.Size = UDim2.new(0, 60, 0, 25)
applySpeed.Text = "Apply"
applySpeed.Font = Enum.Font.Gotham
applySpeed.TextSize = 14
applySpeed.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
applySpeed.TextColor3 = Color3.new(1,1,1)

applySpeed.MouseButton1Click:Connect(function()
	local value = tonumber(speedInput.Text)
	if value then
		char:FindFirstChildOfClass("Humanoid").WalkSpeed = value
	end
end)

-- Fly Toggle
y += 35
local flyToggle = Instance.new("TextButton", frame)
flyToggle.Position = UDim2.new(0, 10, 0, y)
flyToggle.Size = UDim2.new(1, -20, 0, 30)
flyToggle.Text = "🛫 Toggle Fly"
flyToggle.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
flyToggle.TextColor3 = Color3.new(1,1,1)
flyToggle.Font = Enum.Font.Gotham
flyToggle.TextSize = 14

local flying = false
local vel = Instance.new("BodyVelocity")
vel.MaxForce = Vector3.new()

flyToggle.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		vel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		vel.Velocity = Vector3.zero
		vel.Parent = char:WaitForChild("HumanoidRootPart")
	else
		vel.Parent = nil
	end
end)

-- Noclip
y += 35
local noclip = false
local noclipBtn = Instance.new("TextButton", frame)
noclipBtn.Position = UDim2.new(0, 10, 0, y)
noclipBtn.Size = UDim2.new(1, -20, 0, 30)
noclipBtn.Text = "🚶 Toggle NoClip"
noclipBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.Font = Enum.Font.Gotham
noclipBtn.TextSize = 14

noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
end)

game:GetService("RunService").Stepped:Connect(function()
	if noclip then
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- Fake Sheckles
y += 40
local sheckInput = Instance.new("TextBox", frame)
sheckInput.Position = UDim2.new(0, 10, 0, y)
sheckInput.Size = UDim2.new(0, 120, 0, 25)
sheckInput.Text = "1000000"
sheckInput.Font = Enum.Font.Gotham
sheckInput.TextSize = 14
sheckInput.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
sheckInput.TextColor3 = Color3.new(1,1,1)

local applySheck = Instance.new("TextButton", frame)
applySheck.Position = UDim2.new(0, 140, 0, y)
applySheck.Size = UDim2.new(0, 45, 0, 25)
applySheck.Text = "Set"
applySheck.Font = Enum.Font.Gotham
applySheck.TextSize = 14
applySheck.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
applySheck.TextColor3 = Color3.new(1,1,1)

local randomSheck = Instance.new("TextButton", frame)
randomSheck.Position = UDim2.new(0, 190, 0, y)
randomSheck.Size = UDim2.new(0, 45, 0, 25)
randomSheck.Text = "🎲"
randomSheck.Font = Enum.Font.Gotham
randomSheck.TextSize = 14
randomSheck.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
randomSheck.TextColor3 = Color3.new(1,1,1)

-- Change sheckles (visual)
local stats = plr:WaitForChild("leaderstats")
local sheckles = stats:WaitForChild("Sheckles")

applySheck.MouseButton1Click:Connect(function()
	local value = tonumber(sheckInput.Text)
	if value then
		sheckles.Value = value
	end
end)

randomSheck.MouseButton1Click:Connect(function()
	local rand = math.random(50000, 99999999)
	sheckles.Value = rand
	sheckInput.Text = tostring(rand)
end)
