-- 🐾 YEXSCRIPT: Fake Visual Pet (Client Only)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local petName = "Candy Blossom" -- 🔁 Change to any pet name you want

-- If already has fake pet, don't duplicate
if workspace:FindFirstChild("YexFakePet_" .. petName) then return end

-- Create fake pet model (sphere with name)
local pet = Instance.new("Part")
pet.Name = "YexFakePet_" .. petName
pet.Shape = Enum.PartType.Ball
pet.Size = Vector3.new(1.5, 1.5, 1.5)
pet.Position = char.HumanoidRootPart.Position + Vector3.new(2, 2, 0)
pet.Anchored = false
pet.CanCollide = false
pet.Material = Enum.Material.Neon
pet.BrickColor = BrickColor.Random()
pet.Parent = workspace

-- Pet label
local tag = Instance.new("BillboardGui", pet)
tag.Size = UDim2.new(0, 100, 0, 40)
tag.AlwaysOnTop = true
local nameLabel = Instance.new("TextLabel", tag)
nameLabel.Size = UDim2.new(1, 0, 1, 0)
nameLabel.Text = "🐾 "..petName.." (YEXScript)"
nameLabel.TextColor3 = Color3.new(1, 1, 1)
nameLabel.BackgroundTransparency = 1
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextScaled = true

-- Follow player
local align = Instance.new("BodyPosition", pet)
align.MaxForce = Vector3.new(1e5, 1e5, 1e5)
align.D = 500
align.P = 3000

-- Update follow
game:GetService("RunService").Heartbeat:Connect(function()
	if char and char:FindFirstChild("HumanoidRootPart") then
		align.Position = char.HumanoidRootPart.Position + Vector3.new(2, 2, 0)
	end
end)
