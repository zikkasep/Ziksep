--[[ Zik Chest Bypass Final
   Fitur:
   - Auto Chest (Teleport Aman)
   - Anti Kick / Error 267
   - GUI Drag + Toggle ON/OFF
--]]

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local TweenService = game:GetService("TweenService")

-- Chest List
local chestNames = {"Chest1", "Chest2", "Chest3", "Chest4", "Chest5", "Chest6", "Chest7", "Chest8", "Chest9", "Chest10"}

-- GUI
local scr = Instance.new("ScreenGui", game.CoreGui)
scr.Name = "ZikChestBypass"
local frame = Instance.new("Frame", scr)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1, 0, 1, 0)
btn.Text = "Auto Chest: OFF"
btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
btn.TextColor3 = Color3.new(1,1,1)
btn.TextScaled = true

-- TP Aman
function SafeTP(pos)
	local tween = TweenService:Create(hrp, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
	tween:Play()
	tween.Completed:Wait()
end

-- Anti Kick
pcall(function()
	settings().Physics.AllowSleep = false
	game:GetService("Players").LocalPlayer.Idled:connect(function()
		game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
end)

-- Logic
local farming = false
btn.MouseButton1Click:Connect(function()
	farming = not farming
	btn.Text = "Auto Chest: "..(farming and "ON" or "OFF")
	while farming do
		for _, name in ipairs(chestNames) do
			for _, chest in ipairs(workspace:GetDescendants()) do
				if chest.Name == name and chest:IsA("Model") and chest:FindFirstChild("TouchInterest") then
					SafeTP(chest.Position + Vector3.new(0,3,0))
					wait(0.3)
				end
			end
			wait(0.2)
		end
	end
end)
