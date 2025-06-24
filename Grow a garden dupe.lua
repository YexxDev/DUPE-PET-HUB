
-- YEXSCRIPT HUB - Grow a Garden [Working Auto Plant + Real Teleport]
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

-- UI Setup
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScriptHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 350, 0, 300)
frame.Position = UDim2.new(0.5, -175, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🌱 YexScript Hub - Grow a Garden"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.TextSize = 16

-- Auto Plant Button
local autoPlant = Instance.new("TextButton", frame)
autoPlant.Size = UDim2.new(0, 300, 0, 30)
autoPlant.Position = UDim2.new(0, 25, 0, 50)
autoPlant.Text = "🌾 Auto Plant Seed Spam"
autoPlant.TextColor3 = Color3.new(1, 1, 1)
autoPlant.BackgroundColor3 = Color3.fromRGB(30, 120, 30)
Instance.new("UICorner", autoPlant)

-- Full Plant Button
local fullPlant = Instance.new("TextButton", frame)
fullPlant.Size = UDim2.new(0, 300, 0, 30)
fullPlant.Position = UDim2.new(0, 25, 0, 90)
fullPlant.Text = "🌻 Full Plant All Seeds"
fullPlant.TextColor3 = Color3.new(1, 1, 1)
fullPlant.BackgroundColor3 = Color3.fromRGB(30, 90, 120)
Instance.new("UICorner", fullPlant)

-- Teleport Section
local locations = {
    ["Gear"] = Vector3.new(41, 6, -110),
    ["Summer Event NPC"] = Vector3.new(-33, 6, 90),
    ["Egg Shop"] = Vector3.new(0, 6, -42),
    ["Honey Machine"] = Vector3.new(67, 6, -11)
}

local y = 140
for name, pos in pairs(locations) do
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 300, 0, 30)
    btn.Position = UDim2.new(0, 25, 0, y)
    btn.Text = "📍 Teleport: " .. name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        root.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
    end)
    y += 40
end

-- Auto Plant Logic
getgenv().YEX_AUTO = false
autoPlant.MouseButton1Click:Connect(function()
    getgenv().YEX_AUTO = not getgenv().YEX_AUTO
    autoPlant.Text = getgenv().YEX_AUTO and "✅ Auto Plant: ON" or "🌾 Auto Plant Seed Spam"
    if getgenv().YEX_AUTO then
        task.spawn(function()
            while getgenv().YEX_AUTO do
                local tool = plr.Character:FindFirstChildOfClass("Tool") or plr.Backpack:FindFirstChildOfClass("Tool")
                if tool and tool:FindFirstChild("Handle") then
                    plr.Character.Humanoid:EquipTool(tool)
                    wait(0.2)
                    tool:Activate()
                end
                wait(1)
            end
        end)
    end
end)

-- Full Plant All Seeds
fullPlant.MouseButton1Click:Connect(function()
    for _, tool in pairs(plr.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name:lower():find("seed") then
            plr.Character.Humanoid:EquipTool(tool)
            wait(0.3)
            tool:Activate()
            wait(0.5)
        end
    end
end)
