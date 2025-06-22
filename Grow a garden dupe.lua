-- 😱 YexScript Troll Script: Fake Hack + Auto Kick
local plr = game.Players.LocalPlayer

-- Step 1: Start fake hack screen
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_HackScare"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BackgroundTransparency = 0

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(0.8, 0, 0.2, 0)
label.Position = UDim2.new(0.1, 0, 0.35, 0)
label.TextColor3 = Color3.new(1, 0, 0)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBlack
label.TextSize = 28
label.TextWrapped = true
label.Text = [[
⚠️ WARNING ⚠️
Your Roblox Account is Being Accessed From Another Location
Session Token: LEAKED
Logging Out All Devices...
]]

-- Step 2: Add fake console effect
local console = Instance.new("TextLabel", frame)
console.Size = UDim2.new(0.8, 0, 0.2, 0)
console.Position = UDim2.new(0.1, 0, 0.55, 0)
console.TextColor3 = Color3.new(0, 1, 0)
console.BackgroundTransparency = 1
console.Font = Enum.Font.Code
console.TextSize = 14
console.TextWrapped = true
console.Text = ""

-- Simulate hacker text
local logs = {
    "[ROOT] Accessing Player Data...",
    "[TOKEN] Stealing session...",
    "[WEBHOOK] Sending to Discord...",
    "[LOGOUT] Logging out all devices...",
    "[DELETE] Account scheduled for termination..."
}
for i, v in ipairs(logs) do
    console.Text = console.Text .. v .. "\n"
    wait(1.2)
end

-- Step 3: Fake logout kick
wait(2)
game:GetService("Players").LocalPlayer:Kick("🔓 Session stolen. You have been logged out.")

-- Note: No real logout happens. Just for troll/flex 😈
