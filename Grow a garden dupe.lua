-- ✅ YexScript | Fake Hack Screen + Discord Webhook Logger
-- Make sure you’re running this in Synapse/Fluxus/etc.

local plr = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- 🌐 Your Discord Webhook
local webhookURL = "https://discord.com/api/webhooks/1386632020402245632/R774BEgllTUj13wX5IK9J_8qrqXUZX-6mLGyxrF2vDWUmw6Ak7b89OutzI2wvGScfQa4"

-- 🔔 Send webhook message
pcall(function()
	local data = {
		["content"] = "😈 YexScript executed by: `" .. plr.Name .. "`\nFake hack session triggered 💻💀"
	}
	local json = HttpService:JSONEncode(data)
	HttpService:PostAsync(webhookURL, json, Enum.HttpContentType.ApplicationJson)
end)

-- 🖥️ Create Fake Fullscreen UI
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_HackLoader"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(5, 5, 5)

local loading = Instance.new("TextLabel", bg)
loading.Size = UDim2.new(1, 0, 0.1, 0)
loading.Position = UDim2.new(0, 0, 0.3, 0)
loading.BackgroundTransparency = 1
loading.TextColor3 = Color3.new(1, 0, 0)
loading.Text = "🔓 HACKING IN PROGRESS..."
loading.Font = Enum.Font.GothamBlack
loading.TextSize = 28

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

-- 🧠 Fake Logs
local fakePass = tostring(math.random(10000000,99999999))
local fakeRobux = tostring(math.random(1000,9999))

local logs = {
    "[YexScript] Connecting to client...",
    "[+] User Found: " .. plr.Name,
    "[+] Password: ******** (" .. fakePass .. ")",
    "[+] Robux Balance: R$" .. fakeRobux,
    "[+] Accessing .ROBLOSECURITY...",
    "[+] Sending data to Discord webhook...",
    "[×] Logging out user..."
}

task.spawn(function()
	for i = 1, #logs do
		info.Text = info.Text .. logs[i] .. "\n"
		wait(1.2)
	end
end)

-- ❌ Block Escape key (disable menu)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.Escape then
		return true
	end
end)
