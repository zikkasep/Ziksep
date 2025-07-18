-- Zik Auto Chest Bypass v1.0
-- Tanpa gerak, langsung teleport ambil semua chest + anti kick

if not game:IsLoaded() then game.Loaded:Wait() end

local ChestFarm = true

local chests = {
    "Chest1", "Chest2", "Chest3", "Chest4", "Chest5",
    "Chest6", "Chest7", "Chest8", "Chest9", "Chest10"
}

-- Anti Kick
local mt = getrawmetatable(game)
setreadonly(mt, false)
local namecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if getnamecallmethod() == "Kick" then
        return wait(9e9)
    end
    return namecall(self, unpack(args))
end)

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ZikChestGui"
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 80)
Frame.Position = UDim2.new(0.5, -100, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true
Frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", Frame)
title.Size = UDim2.new(1, 0, 0.5, 0)
title.Text = "Auto Chest: ON"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local toggle = Instance.new("TextButton", Frame)
toggle.Position = UDim2.new(0.1, 0, 0.5, 5)
toggle.Size = UDim2.new(0.8, 0, 0.4, 0)
toggle.Text = "Turn OFF"
toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.Gotham
toggle.TextSize = 14
toggle.MouseButton1Click:Connect(function()
    ChestFarm = not ChestFarm
    title.Text = "Auto Chest: " .. (ChestFarm and "ON" or "OFF")
    toggle.Text = ChestFarm and "Turn OFF" or "Turn ON"
end)

-- Chest farming loop
spawn(function()
    while wait(0.1) do
        if ChestFarm then
            for _, v in pairs(workspace:GetDescendants()) do
                if table.find(chests, v.Name) and v:IsA("Part") and v.Parent:IsA("Model") then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 4, 0)
                        firetouchinterest(char.HumanoidRootPart, v, 0)
                        firetouchinterest(char.HumanoidRootPart, v, 1)
                        wait(0.1)
                    end
                end
            end
        end
    end
end)
