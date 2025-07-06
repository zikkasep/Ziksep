-- Zik PvP Pro | by ZikSelebew
-- Rezh Style PvP GUI with Auto Bounty System
local plr = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")

-- Save Config
local configFile = "ZikPVP_Settings.txt"
local settings = {
    AutoBounty = false,
    AutoSkill = true,
    NoCooldown = true,
    KillAura = true,
    ESP = true,
    PvPMode = true,
    FlyDash = true
}

-- Load saved settings
pcall(function()
    local raw = readfile(configFile)
    settings = game:GetService("HttpService"):JSONDecode(raw)
end)

-- Save settings
local function saveSettings()
    writefile(configFile, game:GetService("HttpService"):JSONEncode(settings))
end

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ZikPvpGui"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 320, 0, 360)
Frame.Position = UDim2.new(0.05, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UIList = Instance.new("UIListLayout", Frame)
UIList.Padding = UDim.new(0, 5)

local function makeToggle(name, key)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Text = name .. ": " .. tostring(settings[key])
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.MouseButton1Click:Connect(function()
        settings[key] = not settings[key]
        btn.Text = name .. ": " .. tostring(settings[key])
        saveSettings()
    end)
end

makeToggle("Auto Bounty", "AutoBounty")
makeToggle("Auto Skill", "AutoSkill")
makeToggle("No Cooldown", "NoCooldown")
makeToggle("Kill Aura", "KillAura")
makeToggle("ESP Player", "ESP")
makeToggle("PvP Mode", "PvPMode")
makeToggle("Fly Dash", "FlyDash")

-- Tombol Hide UI & Force Show
uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        Frame.Visible = not Frame.Visible
    end
end)

rs.RenderStepped:Connect(function()
    if settings.FlyDash then
        local char = plr.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.Humanoid:ChangeState(11)
        end
    end

    if settings.NoCooldown then
        for _,v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "Cooldown") then
                v.Cooldown = 0
            end
        end
    end

    if settings.AutoBounty then
        for _,v in pairs(game.Players:GetPlayers()) do
            if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hum = v.Character:FindFirstChild("Humanoid")
                local bounty = v:FindFirstChild("leaderstats") and v.leaderstats:FindFirstChild("Bounty")
                if bounty and bounty.Value >= 100000 and hum and hum.Health > 0 then
                    local myhrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    local target = v.Character.HumanoidRootPart.Position + Vector3.new(0,5,0)
                    myhrp.CFrame = CFrame.new(target)
                    break
                end
            end
        end
    end

    if settings.KillAura then
        for _,v in pairs(game.Players:GetPlayers()) do
            if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (plr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                local hum = v.Character:FindFirstChild("Humanoid")
                if dist < 35 and hum and hum.Health > 0 then
                    local keys = {"Z","X","C","V"}
                    for _,k in pairs(keys) do
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, k, false, game)
                        task.wait(0.05)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, k, false, game)
                    end
                end
            end
        end
    end
end)

    if settings.NoCooldown then
        for _,v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "Cooldown") then
                v.Cooldown = 0
            end
        end
    end
    if settings.KillAura then
        for _,v in pairs(game.Players:GetPlayers()) do
            if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (plr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                if dist < 30 then
                    -- Attack
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                end
            end
        end
    end
end)

-- ESP Player
if settings.ESP then
    for _,pl in pairs(game.Players:GetPlayers()) do
        if pl ~= plr then
            local esp = Instance.new("BillboardGui", pl.Character:WaitForChild("Head"))
            esp.Size = UDim2.new(0,100,0,30)
            esp.AlwaysOnTop = true
            local label = Instance.new("TextLabel", esp)
            label.Size = UDim2.new(1,0,1,0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,0,0)
            label.Text = pl.Name
        end
    end
end
