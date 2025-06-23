-- 📲 YEXSCRIPT HUB LOADING + GUI + FLY SYSTEM
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

-- 🟣 Loading Screen
local loadingGui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
loadingGui.Name = "Yex_Loading"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true

local bg = Instance.new("Frame", loadingGui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

local loadingText = Instance.new("TextLabel", bg)
loadingText.AnchorPoint = Vector2.new(0.5, 0.5)
loadingText.Position = UDim2.new(0.5, 0, 0.5, 0)
loadingText.Size = UDim2.new(0, 300, 0, 40)
loadingText.BackgroundTransparency = 1
loadingText.Text = "🔧 Loading YEXSCRIPT..."
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 24
loadingText.TextColor3 = Color3.new(1, 1, 1)

-- Wait 3 seconds before UI appears
task.wait(3)
loadingGui:Destroy()

-- 🔳 Main GUI
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_Hub"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 320)
frame.Position = UDim2.new(0, 20, 0.4, -160)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "⚙️ YEXSCRIPT HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1

local y = 40

-- WalkSpeed Setting
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
speedInput.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
speedInput.TextColor3 = Color3.new(1,1,1)
speedInput.Font = Enum.Font.Gotham
speedInput.TextSize = 14

local applySpeed = Instance.new("TextButton", frame)
applySpeed.Position = UDim2.new(0, 180, 0, y)
applySpeed.Size = UDim2.new(0, 60, 0, 25)
applySpeed.Text = "Apply"
applySpeed.BackgroundColor3 = Color3.fromRGB(80, 0, 130)
applySpeed.TextColor3 = Color3.new(1,1,1)
applySpeed.Font = Enum.Font.Gotham
applySpeed.TextSize = 14

applySpeed.MouseButton1Click:Connect(function()
	local value = tonumber(speedInput.Text)
	if value then
		char:FindFirstChildOfClass("Humanoid").WalkSpeed = value
	end
end)

-- ✅ Universal Fly (Mobile + PC)
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
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HRP = char:WaitForChild("HumanoidRootPart")
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
bv.Velocity = Vector3.zero

local bg = Instance.new("BodyGyro")
bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
bg.P = 9e4
bg.CFrame = HRP.CFrame

local keys = {W=false,A=false,S=false,D=false,Q=false,E=false}
UIS.InputBegan:Connect(function(i,g)
	if g then return end
	if keys[i.KeyCode.Name] ~= nil then keys[i.KeyCode.Name] = true end
end)
UIS.InputEnded:Connect(function(i)
	if keys[i.KeyCode.Name] ~= nil then keys[i.KeyCode.Name] = false end
end)

RunService.RenderStepped:Connect(function()
	if flying then
		local cam = workspace.CurrentCamera
		local move = Vector3.zero
		if UIS.TouchEnabled then
			move = cam.CFrame.LookVector -- Mobile auto forward
		else
			if keys.W then move += cam.CFrame.LookVector end
			if keys.S then move -= cam.CFrame.LookVector end
			if keys.A then move -= cam.CFrame.RightVector end
			if keys.D then move += cam.CFrame.RightVector end
			if keys.Q then move -= cam.CFrame.UpVector end
			if keys.E then move += cam.CFrame.UpVector end
		end
		bv.Velocity = move.Unit * 50
		bg.CFrame = cam.CFrame
	end
end)

flyToggle.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		bv.Parent = HRP
		bg.Parent = HRP
		flyToggle.Text = "🛫 Fly: ON"
	else
		bv.Parent = nil
		bg.Parent = nil
		HRP.Velocity = Vector3.zero
		flyToggle.Text = "🛫 Fly: OFF"
	end
end)
