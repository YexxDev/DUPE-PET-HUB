-- YEXSCRIPT - Visual Gun Spawner (Client Only)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_GunUI"
gui.ResetOnSpawn = false

-- UI Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 270)
frame.Position = UDim2.new(0, 10, 0.4, -120)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0.2
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🔫 YEXSCRIPT GUN SPAWNER"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- Gun list
local guns = {
    "Pistol",
    "AK-47",
    "Rocket Launcher",
    "Ban Hammer",
    "Golden Shotgun",
    "Water Gun"
}

-- Create fake gun
local function spawnFakeGun(name)
    -- Remove old
    if char:FindFirstChild("Yex_FakeGun") then
        char.Yex_FakeGun:Destroy()
    end

    local gun = Instance.new("Part")
    gun.Name = "Yex_FakeGun"
    gun.Size = Vector3.new(2, 0.5, 1)
    gun.BrickColor = BrickColor.Random()
    gun.Material = Enum.Material.Neon
    gun.CanCollide = false
    gun.Anchored = false

    local weld = Instance.new("Weld", gun)
    weld.Part0 = gun
    weld.Part1 = char:WaitForChild("RightHand")
    weld.C0 = CFrame.new(0, 0, -1)

    gun.Parent = char

    -- Billboard
    local gui = Instance.new("BillboardGui", gun)
    gui.Size = UDim2.new(0, 100, 0, 25)
    gui.AlwaysOnTop = true
    local label = Instance.new("TextLabel", gui)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = "🔫 "..name.." (Visual)"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
end

-- Add buttons
for i, gunName in pairs(guns) do
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, 35 + (i - 1) * 35)
    btn.Text = gunName
    btn.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(function()
        spawnFakeGun(gunName)
    end)
end
