-- ✅ YEXSCRIPT HUB - ADVANCED EDITION
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TS = game:GetService("TeleportService")

-- GUI Setup (Loading, Toggle, Mini Button already added previously)
-- Existing code retained for GUI, toggle, loading screen

-- 🌱 Auto Farm System
local function autoFarm()
	while getgenv().YexAutoFarm do
		for _, seed in pairs(plr.Backpack:GetChildren()) do
			if seed:IsA("Tool") and seed.Name:lower():find("seed") then
				plr.Character.Humanoid:EquipTool(seed)
				local plot = workspace:FindFirstChild("Plot") or workspace:FindFirstChildWhichIsA("Part")
				if plot then
					char:MoveTo(plot.Position)
					wait(1)
					mouse1click()
				end
			end
		end
		wait(3)
	end
end

getgenv().YexAutoFarm = false
local autoFarmBtn = Instance.new("TextButton", frame)
autoFarmBtn.Size = UDim2.new(0, 240, 0, 30)
autoFarmBtn.Position = UDim2.new(0, 10, 0, 40)
autoFarmBtn.Text = "Toggle Auto Farm"
autoFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 60)
autoFarmBtn.TextColor3 = Color3.new(1,1,1)
autoFarmBtn.Font = Enum.Font.GothamBold
autoFarmBtn.TextSize = 14

autoFarmBtn.MouseButton1Click:Connect(function()
	getgenv().YexAutoFarm = not getgenv().YexAutoFarm
	if getgenv().YexAutoFarm then
		spawn(autoFarm)
	end
end)

-- 🌀 Infinite Seed (Visual)
local fakeSeedBtn = Instance.new("TextButton", frame)
fakeSeedBtn.Size = UDim2.new(0, 240, 0, 30)
fakeSeedBtn.Position = UDim2.new(0, 10, 0, 80)
fakeSeedBtn.Text = "Fake Infinite Seed"
fakeSeedBtn.BackgroundColor3 = Color3.fromRGB(90, 30, 150)
fakeSeedBtn.TextColor3 = Color3.new(1,1,1)
fakeSeedBtn.Font = Enum.Font.GothamBold
fakeSeedBtn.TextSize = 14

fakeSeedBtn.MouseButton1Click:Connect(function()
	local tool = Instance.new("Tool")
	tool.Name = "🌱 Candy Blossom Seed (Visual)"
	tool.RequiresHandle = false
	tool.Parent = plr.Backpack
end)

-- 🔍 ESP (Tools, Fruits)
getgenv().ESP_Enabled = true
spawn(function()
	while getgenv().ESP_Enabled do
		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("Tool") and not obj:FindFirstChild("YexESP") then
				local label = Instance.new("BillboardGui", obj)
				label.Name = "YexESP"
				label.Size = UDim2.new(0, 100, 0, 40)
				label.AlwaysOnTop = true
				label.StudsOffset = Vector3.new(0, 3, 0)
				local text = Instance.new("TextLabel", label)
				text.Size = UDim2.new(1, 0, 1, 0)
				text.Text = obj.Name
				text.TextColor3 = Color3.new(1, 1, 0)
				text.BackgroundTransparency = 1
				text.Font = Enum.Font.SourceSansBold
				text.TextSize = 14
			end
		end
		wait(2)
	end
end)

-- 📦 Teleport Tab (basic)
local tpBtn = Instance.new("TextButton", frame)
tpBtn.Size = UDim2.new(0, 240, 0, 30)
tpBtn.Position = UDim2.new(0, 10, 0, 120)
tpBtn.Text = "Teleport to Garden"
tpBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 120)
tpBtn.TextColor3 = Color3.new(1,1,1)
tpBtn.Font = Enum.Font.GothamBold
tpBtn.TextSize = 14

tpBtn.MouseButton1Click:Connect(function()
	local target = workspace:FindFirstChild("Garden") or workspace:FindFirstChildWhichIsA("Part")
	if target then
		char:MoveTo(target.Position)
	end
end)

-- 🔄 Server Hop (basic)
local function serverHop()
	local servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
	for _, s in pairs(servers.data) do
		if s.playing < s.maxPlayers then
			TS:TeleportToPlaceInstance(game.PlaceId, s.id)
			break
		end
	end
end

local hopBtn = Instance.new("TextButton", frame)
hopBtn.Size = UDim2.new(0, 240, 0, 30)
hopBtn.Position = UDim2.new(0, 10, 0, 160)
hopBtn.Text = "Server Hop"
hopBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 100)
hopBtn.TextColor3 = Color3.new(1,1,1)
hopBtn.Font = Enum.Font.GothamBold
hopBtn.TextSize = 14

hopBtn.MouseButton1Click:Connect(serverHop)

-- ✅ Finished loading all advanced features
