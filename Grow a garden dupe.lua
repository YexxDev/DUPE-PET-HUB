-- 🧠 YEXSCRIPT - Player Mod Hub (Fly, Speed, NoClip, Visual FX)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_ModHub"
gui.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 270)
frame.Position = UDim2.new(0, 10, 0.4, -120)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0.2
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "👾 YEXSCRIPT MOD HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- Spacer for buttons
local btnY = 35

-- WalkSpeed
local speedBtn = Instance.new("TextButton", frame)
speedBtn.Size = UDim2.new(1, -20, 0, 30)
speedBtn.Position = UDim2.new(0, 10, 0, btnY)
speedBtn.Text = "🏃 WalkSpeed +50"
speedBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
speedBtn.TextColor3 = Color3.new(1, 1, 1)
speedBtn.Font = Enum.Font.Gotham
speedBtn.TextSize = 14
speedBtn.MouseButton1Click:Connect(function()
	char:FindFirstChildOfClass("Humanoid").WalkSpeed = 50
end)

-- Fly Toggle
btnY += 35
local flying = false
local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(1, -20, 0, 30)
flyBtn.Position = UDim2.new(0, 10, 0, btnY)
flyBtn.Text = "🛫 Toggle Fly"
flyBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
flyBtn.TextColor3 = Color3.new(1, 1, 1)
flyBtn.Font = Enum.Font.Gotham
flyBtn.TextSize = 14

local UIS = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local bp = Instance.new("BodyVelocity")
bp.MaxForce = Vector3.new()

flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		bp.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bp.Velocity = Vector3.zero
		bp.Parent = char.HumanoidRootPart
	else
		bp.Parent = nil
	end
end)

-- Noclip
btnY += 35
local noclip = false
local clipBtn = Instance.new("TextButton", frame)
clipBtn.Size = UDim2.new(1, -20, 0, 30)
clipBtn.Position = UDim2.new(0, 10, 0, btnY)
clipBtn.Text = "🚶 Toggle NoClip"
clipBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
clipBtn.TextColor3 = Color3.new(1, 1, 1)
clipBtn.Font = Enum.Font.Gotham
clipBtn.TextSize = 14

clipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
end)

rs.Stepped:Connect(function()
	if noclip then
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide == true then
				v.CanCollide = false
			end
		end
	end
end)

-- Fake Sheckles Costume
btnY += 35
local sheckBtn = Instance.new("TextButton", frame)
sheckBtn.Size = UDim2.new(1, -20, 0, 30)
sheckBtn.Position = UDim2.new(0, 10, 0, btnY)
sheckBtn.Text = "💰 Spawn Fake Sheckles"
sheckBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
sheckBtn.TextColor3 = Color3.new(1, 1, 1)
sheckBtn.Font = Enum.Font.Gotham
sheckBtn.TextSize = 14

sheckBtn.MouseButton1Click:Connect(function()
	local part = Instance.new("Part")
	part.Anchored = false
	part.CanCollide = false
	part.Size = Vector3.new(1, 1, 1)
	part.Shape = Enum.PartType.Ball
	part.Material = Enum.Material.Neon
	part.Color = Color3.fromRGB(255, 223, 0)
	part.Name = "YexSheckles"
	part.Parent = workspace

	local weld = Instance.new("WeldConstraint", part)
	weld.Part0 = part
	weld.Part1 = char:WaitForChild("Head")

	local gui = Instance.new("BillboardGui", part)
	gui.Size = UDim2.new(0, 80, 0, 20)
	gui.AlwaysOnTop = true
	local label = Instance.new("TextLabel", gui)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Text = "💰 Sheckles (Fake)"
	label.TextColor3 = Color3.new(1, 1, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	gui.Parent = part

	-- Weld it to the head
	part.CFrame = char.Head.CFrame + Vector3.new(0, 1.5, 0)
end)
