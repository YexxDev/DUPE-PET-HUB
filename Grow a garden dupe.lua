-- YexScript Dupe Troll UI v2 - Clean Horizontal Loading
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "YexScript_DupeTrollUI"

-- DARK BACKGROUND
local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

-- FRAME BOX (long horizontal clean style)
local box = Instance.new("Frame", bg)
box.Size = UDim2.new(0.6, 0, 0.2, 0)
box.Position = UDim2.new(0.2, 0, 0.4, 0)
box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
box.BorderSizePixel = 0
box.BackgroundTransparency = 0
box.ClipsDescendants = true
box.Name = "CleanBox"
box.AnchorPoint = Vector2.new(0, 0)
box.ZIndex = 2
box.BorderMode = Enum.BorderMode.Outline
box.BorderColor3 = Color3.fromRGB(80, 80, 80)
box:TweenSize(box.Size, "Out", "Quad", 0.3)

-- Corner styling
local corner = Instance.new("UICorner", box)
corner.CornerRadius = UDim.new(0, 16)

-- LABEL: TITLE
local title = Instance.new("TextLabel", box)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0.05, 0)
title.BackgroundTransparency = 1
title.Text = "🧠 YexScript Duplication Engine"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(200, 255, 200)
title.TextSize = 20
title.TextStrokeTransparency = 0.8

-- LABEL: STATUS
local status = Instance.new("TextLabel", box)
status.Size = UDim2.new(1, 0, 0.25, 0)
status.Position = UDim2.new(0, 0, 0.4, 0)
status.BackgroundTransparency = 1
status.Text = "Duplicating your pet..."
status.Font = Enum.Font.Gotham
status.TextColor3 = Color3.fromRGB(180, 180, 180)
status.TextSize = 17
status.TextWrapped = true

-- PROGRESS BAR OUTER
local barBG = Instance.new("Frame", box)
barBG.Size = UDim2.new(0.9, 0, 0.15, 0)
barBG.Position = UDim2.new(0.05, 0, 0.75, 0)
barBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
barBG.BorderSizePixel = 0
Instance.new("UICorner", barBG).CornerRadius = UDim.new(0, 8)

-- PROGRESS FILL
local bar = Instance.new("Frame", barBG)
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
bar.BorderSizePixel = 0
Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 8)

-- Animate the bar filling
task.spawn(function()
	for i = 1, 100 do
		bar.Size = UDim2.new(i / 100, 0, 1, 0)
		status.Text = "Duplicating: " .. string.rep(".", i % 4)
		wait(0.03)
	end

	status.Text = "❌ Dupe Failed: Server blocked duplication!"
	bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	wait(2)

	plr:Kick("❌ You have been banned from Grow a Garden for trying to dupe using YexScript.")
end)
