-- ✅ YexScript Hub with Swipeable Tabs for Delta Mobile
-- Full Feature Version: Auto Plant, Teleport, ESP, Movement, Server Hop

local plr = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TS = game:GetService("TeleportService")
local Http = game:GetService("HttpService")

local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScriptHub"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 360, 0, 420)
main.Position = UDim2.new(0.5, -180, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 0
main.Active, main.Draggable = true, true
Instance.new("UICorner", main)

local tabContainer = Instance.new("Frame", main)
tabContainer.Size = UDim2.new(1, 0, 1, 0)
tabContainer.Position = UDim2.new(0, 0, 0, 0)
tabContainer.BackgroundTransparency = 1

local tabNames = {"Main", "Teleport", "ESP", "Movement", "Server"}
local tabFrames = {}
local currentTab = 1

for i, name in ipairs(tabNames) do
    local tab = Instance.new("Frame", tabContainer)
    tab.Name = name
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.Position = UDim2.new((i - 1), 0, 0, 0)
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tab.BorderSizePixel = 0
    Instance.new("UICorner", tab)

    tabFrames[i] = tab
end

local function switchToTab(index)
    for i, tab in ipairs(tabFrames) do
        tab:TweenPosition(UDim2.new(i - index, 0, 0, 0), "Out", "Sine", 0.3, true)
    end
    currentTab = index
end

local swipeStart = nil
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        swipeStart = input.Position
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and swipeStart then
        local delta = input.Position.X - swipeStart.X
        if math.abs(delta) > 100 then
            if delta < 0 and currentTab < #tabFrames then
                switchToTab(currentTab + 1)
            elseif delta > 0 and currentTab > 1 then
                switchToTab(currentTab - 1)
            end
        end
        swipeStart = nil
    end
end)

switchToTab(1)

-- MAIN TAB FEATURES
local spam = false
local f = tabFrames[1]
local y = 10
local function addBtn(txt, callback)
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0, 330, 0, 30)
    b.Position = UDim2.new(0, 15, 0, y)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(70, 70, 120)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(callback)
    y += 35
end

addBtn("🌾 Auto Plant Spam", function()
    spam = not spam
    if spam then
        task.spawn(function()
            while spam do
                local t = plr.Character:FindFirstChildOfClass("Tool") or plr.Backpack:FindFirstChildOfClass("Tool")
                if t and t:FindFirstChild("Handle") then
                    plr.Character.Humanoid:EquipTool(t)
                    wait(0.1)
                    t:Activate()
                end
                wait(0.5)
            end
        end)
    end
end)

addBtn("🌻 Full Plant All Seeds", function()
    for _, tool in pairs(plr.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name:lower():find("seed") then
            plr.Character.Humanoid:EquipTool(tool)
            wait(0.3)
            tool:Activate()
            wait(0.3)
        end
    end
end)

-- TELEPORT TAB
local locs = {
    ["Gear NPC"] = Vector3.new(41,6,-110),
    ["Summer Event"] = Vector3.new(-33,6,90),
    ["Egg Shop"] = Vector3.new(0,6,-42),
    ["Honey Machine"] = Vector3.new(67,6,-11),
}
y = 10
for name, vec in pairs(locs) do
    local b = Instance.new("TextButton", tabFrames[2])
    b.Size = UDim2.new(0, 330, 0, 30)
    b.Position = UDim2.new(0, 15, 0, y)
    b.Text = "📍 "..name
    b.BackgroundColor3 = Color3.fromRGB(120, 70, 70)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(vec + Vector3.new(0,3,0)) end
    end)
    y += 35
end

-- ESP TAB
local espOn = false
local tags = {}
local b = Instance.new("TextButton", tabFrames[3])
b.Size = UDim2.new(0, 330, 0, 30)
b.Position = UDim2.new(0, 15, 0, 10)
b.Text = "👀 Toggle ESP"
b.BackgroundColor3 = Color3.fromRGB(90, 90, 140)
b.TextColor3 = Color3.new(1, 1, 1)
b.Font = Enum.Font.GothamBold
b.TextSize = 14
Instance.new("UICorner", b)
b.MouseButton1Click:Connect(function()
    espOn = not espOn
    b.Text = espOn and "👁️ Disable ESP" or "👀 Enable ESP"
    if espOn then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("Tool") or obj.Name:lower():find("seed") or obj.Name:lower():find("fruit")) and not tags[obj] then
                local gui = Instance.new("BillboardGui", obj:IsA("Model") and obj.PrimaryPart or obj)
                gui.Size = UDim2.new(0, 100, 0, 30)
                gui.AlwaysOnTop = true
                local label = Instance.new("TextLabel", gui)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = obj.Name
                label.TextColor3 = Color3.new(1, 1, 0)
                tags[obj] = gui
            end
        end
    else
        for o, tag in pairs(tags) do tag:Destroy() tags[o] = nil end
    end
end)

-- MOVEMENT TAB
local f = tabFrames[4]
y = 10
local function addSlider(prop, min, max)
    local label = Instance.new("TextLabel", f)
    label.Position = UDim2.new(0, 15, 0, y)
    label.Size = UDim2.new(0, 150, 0, 30)
    label.Text = prop
    label.TextColor3 = Color3.new(1,1,1)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 14

    local box = Instance.new("TextBox", f)
    box.Position = UDim2.new(0, 180, 0, y)
    box.Size = UDim2.new(0, 120, 0, 30)
    box.PlaceholderText = tostring(min).."-"..tostring(max)
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then
            local h = plr.Character:FindFirstChildOfClass("Humanoid")
            if h then h[prop] = math.clamp(val, min, max) end
        end
    end)
    y += 40
end

addSlider("WalkSpeed", 16, 250)
addSlider("JumpPower", 50, 300)

-- SERVER HOP
local hopBtn = Instance.new("TextButton", tabFrames[5])
hopBtn.Size = UDim2.new(0, 330, 0, 30)
hopBtn.Position = UDim2.new(0, 15, 0, 15)
hopBtn.Text = "🔁 Server Hop"
hopBtn.BackgroundColor3 = Color3.fromRGB(150, 60, 120)
hopBtn.TextColor3 = Color3.new(1,1,1)
hopBtn.Font = Enum.Font.GothamBold
hopBtn.TextSize = 14
Instance.new("UICorner", hopBtn)
hopBtn.MouseButton1Click:Connect(function()
    local data = Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, s in ipairs(data.data) do
        if s.playing < s.maxPlayers then
            TS:TeleportToPlaceInstance(game.PlaceId, s.id)
            break
        end
    end
end)

print("✅ YexScript Hub Swipe UI Fully Loaded!")
