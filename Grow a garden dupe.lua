-- ✅ YEXSCRIPT HUB - Auto Plant (Beta) + Teleport Tab GUI
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_Hub"

-- UI LIB SETUP (basic tab system)
local tabs = {}
local currentTab

-- Create main frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 350, 0, 300)
main.Position = UDim2.new(0.5, -175, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

-- Tab buttons container
local tabBtnFrame = Instance.new("Frame", main)
tabBtnFrame.Size = UDim2.new(1, 0, 0, 30)
tabBtnFrame.Position = UDim2.new(0, 0, 0, 0)
tabBtnFrame.BackgroundTransparency = 1

-- Content container
local contentFrame = Instance.new("Frame", main)
contentFrame.Size = UDim2.new(1, 0, 1, -30)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", contentFrame).CornerRadius = UDim.new(0, 8)

-- Function to add new tab
local function createTab(name)
	local tab = Instance.new("Frame", contentFrame)
	tab.Name = name
	tab.Size = UDim2.new(1, 0, 1, 0)
	tab.Visible = false
	tab.BackgroundTransparency = 1
	tabs[name] = tab

	local btn = Instance.new("TextButton", tabBtnFrame)
	btn.Size = UDim2.new(0, 100, 1, 0)
	btn.Position = UDim2.new(#tabBtnFrame:GetChildren() * 0.25, 0, 0, 0)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14

	btn.MouseButton1Click:Connect(function()
		if currentTab then tabs[currentTab].Visible = false end
		tab.Visible = true
		currentTab = name
	end)

	if not currentTab then
		tab.Visible = true
		currentTab = name
	end

	return tab
end

-- 🏠 Main Tab
local mainTab = createTab("Main")

-- ✅ Auto Plant (Beta)
local toggleBtn = Instance.new("TextButton", mainTab)
toggleBtn.Size = UDim2.new(0, 300, 0, 40)
toggleBtn.Position = UDim2.new(0.5, -150, 0, 20)
toggleBtn.Text = "🔁 Auto Plant (Beta)"
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 60)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14

getgenv().YexAutoPlant = false

toggleBtn.MouseButton1Click:Connect(function()
	getgenv().YexAutoPlant = not getgenv().YexAutoPlant
	toggleBtn.Text = getgenv().YexAutoPlant and "✅ Auto Plant: ON" or "🔁 Auto Plant (Beta)"

	if getgenv().YexAutoPlant then
		spawn(function()
			while getgenv().YexAutoPlant do
				local seed = nil
				for _, item in pairs(plr.Backpack:GetChildren()) do
					if item:IsA("Tool") and item.Name:lower():find("seed") then
						seed = item
						break
					end
				end

				if seed then
					plr.Character.Humanoid:EquipTool(seed)
					wait(0.5)
					-- Move to plot or plantable spot
					local plot = workspace:FindFirstChild("Plot") or workspace:FindFirstChildWhichIsA("Part")
					if plot then
						char:MoveTo(plot.Position + Vector3.new(0, 2, 0))
						wait(0.5)
						mouse1click()
					end
				end
				wait(3)
			end
		end)
	end
end)

-- 🌍 Teleport Tab
local teleportTab = createTab("Teleport")

local function makeTPBtn(name, targetName, posY)
	local btn = Instance.new("TextButton", teleportTab)
	btn.Size = UDim2.new(0, 300, 0, 30)
	btn.Position = UDim2.new(0.5, -150, 0, posY)
	btn.Text = "Teleport to " .. name
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14

	btn.MouseButton1Click:Connect(function()
		local dest = workspace:FindFirstChild(targetName)
		if dest then
			char:MoveTo(dest.Position + Vector3.new(0, 2, 0))
		end
	end)
end

makeTPBtn("Gear", "Gear", 20)
makeTPBtn("Summer Event NPC", "SummerEvent", 60)
makeTPBtn("Egg Shop", "EggShop", 100)
makeTPBtn("Honey Creator", "HoneyMachine", 140) -- fixed name
