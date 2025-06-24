-- ✅ YEXSCRIPT HUB - Fixed Auto Plant + Teleport Bypass (Delta-Ready)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_Hub"

-- Loading Screen
local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
loadingFrame.ZIndex = 10

local loadingLabel = Instance.new("TextLabel", loadingFrame)
loadingLabel.Size = UDim2.new(1, 0, 0, 50)
loadingLabel.Position = UDim2.new(0, 0, 0.5, -25)
loadingLabel.Text = "YexScript Loading..."
loadingLabel.TextColor3 = Color3.new(1,1,1)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Font = Enum.Font.GothamBold
loadingLabel.TextSize = 28

wait(2)
loadingFrame:Destroy()

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 370, 0, 320)
main.Position = UDim2.new(0.5, -185, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

-- Tabs Container
local tabs = Instance.new("Frame", main)
tabs.Size = UDim2.new(0, 100, 1, 0)
tabs.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", tabs).CornerRadius = UDim.new(0, 8)

-- Content Frame
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0, 100, 0, 0)
content.Size = UDim2.new(1, -100, 1, 0)
content.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)

local tabPages = {}
local currentTab = nil

local function createTab(name)
	local tabBtn = Instance.new("TextButton", tabs)
	tabBtn.Size = UDim2.new(1, 0, 0, 40)
	tabBtn.Position = UDim2.new(0, 0, #tabs:GetChildren() * 0.1, 0)
	tabBtn.Text = name
	tabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	tabBtn.TextColor3 = Color3.new(1, 1, 1)
	tabBtn.Font = Enum.Font.Gotham
	tabBtn.TextSize = 14
	Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

	local page = Instance.new("Frame", content)
	page.Size = UDim2.new(1, 0, 1, 0)
	page.Visible = false
	page.BackgroundTransparency = 1
	tabBtn.MouseButton1Click:Connect(function()
		if currentTab then currentTab.Visible = false end
		page.Visible = true
		currentTab = page
	end)

	if not currentTab then
		page.Visible = true
		currentTab = page
	end

	tabPages[name] = page
	return page
end

-- MAIN TAB
local mainTab = createTab("Main")
local label = Instance.new("TextLabel", mainTab)
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "🌱 Auto Plant Options"
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1, 1, 1)
label.Font = Enum.Font.GothamBold
label.TextSize = 16

-- Auto Plant Seed Spam
local spamBtn = Instance.new("TextButton", mainTab)
spamBtn.Size = UDim2.new(0, 200, 0, 30)
spamBtn.Position = UDim2.new(0, 20, 0, 50)
spamBtn.Text = "🌾 Auto Plant Seed Spam"
spamBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 60)
spamBtn.TextColor3 = Color3.new(1,1,1)
spamBtn.Font = Enum.Font.GothamBold
spamBtn.TextSize = 14
Instance.new("UICorner", spamBtn).CornerRadius = UDim.new(0, 6)

-- Full Plant
local fullBtn = Instance.new("TextButton", mainTab)
fullBtn.Size = UDim2.new(0, 200, 0, 30)
fullBtn.Position = UDim2.new(0, 20, 0, 90)
fullBtn.Text = "🌻 Full Plant All Seeds"
fullBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 140)
fullBtn.TextColor3 = Color3.new(1,1,1)
fullBtn.Font = Enum.Font.GothamBold
fullBtn.TextSize = 14
Instance.new("UICorner", fullBtn).CornerRadius = UDim.new(0, 6)

-- Logic
getgenv().YexSpamPlant = false
spamBtn.MouseButton1Click:Connect(function()
	getgenv().YexSpamPlant = not getgenv().YexSpamPlant
	spamBtn.Text = getgenv().YexSpamPlant and "✅ Spam Planting ON" or "🌾 Auto Plant Seed Spam"
	if getgenv().YexSpamPlant then
		spawn(function()
			while getgenv().YexSpamPlant do
				local tool = plr.Character:FindFirstChildOfClass("Tool") or plr.Backpack:FindFirstChildOfClass("Tool")
				if tool then
					plr.Character.Humanoid:EquipTool(tool)
					wait(0.3)
					firetouchinterest(tool.Handle, char.HumanoidRootPart, 0)
					firetouchinterest(tool.Handle, char.HumanoidRootPart, 1)
				end
				wait(1)
			end
		end)
	end
end)

fullBtn.MouseButton1Click:Connect(function()
	spawn(function()
		for _, tool in pairs(plr.Backpack:GetChildren()) do
			if tool:IsA("Tool") and tool.Name:lower():find("seed") then
				plr.Character.Humanoid:EquipTool(tool)
				wait(0.3)
				firetouchinterest(tool.Handle, char.HumanoidRootPart, 0)
				firetouchinterest(tool.Handle, char.HumanoidRootPart, 1)
				wait(0.5)
			end
		end
	end)
end)

-- TELEPORT TAB
local tpTab = createTab("Teleport")
local teleportList = {
	{"Gear", "Gear"},
	{"Summer Event NPC", "SummerEvent"},
	{"Egg Shop", "EggShop"},
	{"Honey Creator", "HoneyMachine"},
}

for i, pair in ipairs(teleportList) do
	local btn = Instance.new("TextButton", tpTab)
	btn.Size = UDim2.new(0, 200, 0, 30)
	btn.Position = UDim2.new(0, 20, 0, i * 40 - 30)
	btn.Text = "Teleport to " .. pair[1]
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 120)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	btn.MouseButton1Click:Connect(function()
		local target = workspace:FindFirstChild(pair[2]) or workspace:FindFirstChildWhichIsA("Part")
		if target then
			char.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
		end
	end)
end
