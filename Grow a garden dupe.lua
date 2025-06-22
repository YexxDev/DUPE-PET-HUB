-- 🧠 YexScript Fullscreen Fake Hack Loading Screen (Troll)
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_HackLoader"
gui.IgnoreGuiInset = true -- cover topbar (hides Roblox menu)
gui.ResetOnSpawn = false

-- Full black screen
local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
bg.BorderSizePixel = 0

-- Loading Text
local loading = Instance.new("TextLabel", bg)
loading.Size = UDim2.new(1, 0, 0.1, 0)
loading.Position = UDim2.new(0, 0, 0.3, 0)
loading.BackgroundTransparency = 1
loading.TextColor3 = Color3.new(1, 0, 0)
loading.Text = "🔓 HACKING IN PROGRESS..."
loading.Font = Enum.Font.GothamBlack
loading.TextSize = 28

-- Info Panel
local info = Instance.new("TextLabel", bg)
info.Size = UDim2.new(1, 0, 0.4, 0)
info.Position = UDim2.new(0, 0, 0.4, 0)
info.BackgroundTransparency = 1
info.TextColor3 = Color3.fromRGB(0, 255, 0)
info.Text = ""
info.Font = Enum.Font.Code
info.TextSize = 18
info.TextWrapped = true
info.TextXAlignment = Enum.TextXAlignment.Left

-- Simulate fake hack logs
local username = plr.Name
local fakePass = tostring(math.random(10000000,99999999))
local fakeRobux = tostring(math.random(1000,9999))

local logs = {
    "[YexScript] Connecting to client...",
    "[+] User Found: " .. username,
    "[+] Password: ******** (" .. fakePass .. ")",
    "[+] Robux Balance: R$" .. fakeRobux,
    "[+] Accessing .ROBLOSECURITY...",
    "[+] Sending data to Discord webhook...",
    "[×] Logging out user...",
}

task.spawn(function()
    for i = 1, #logs do
        info.Text = info.Text .. logs[i] .. "\n"
        wait(1.2)
    end
end)

-- Block escape menu & fullscreen
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Escape then
        return true -- cancel escape key
    end
end)

-- Replace this with your own Discord webhook URL 👇
local webhookURL = "https://discord.com/api/webhooks/1340532816018149437/YitUDrV9pvQ7BimmT5H2F1v0_8sUkef8q2TARCA4sb8DjMOOVZ8556TWvhNVDmVxzoHG"

local HttpService = game:GetService("HttpService")
local plr = game.Players.LocalPlayer

-- Prepare message
local data = {
    ["content"] = "😈 YexScript executed by: `" .. plr.Name .. "`\nFake hack session triggered 💻💀"
}

local jsonData = HttpService:JSONEncode(data)

-- Send to webhook
HttpService:PostAsync(webhookURL, jsonData, Enum.HttpContentType.ApplicationJson)
