-- Zik PvP Pro | Auto Bounty GUI v1.1 | by ZikSelebew
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

pcall(function()
    local raw = readfile(configFile)
    settings = game:GetService("HttpService"):JSONDecode(raw)
end)

local function saveSettings()
    writefile(configFile, game:GetService("HttpService"):JSONEncode(settings))
end

-- GUI Setup
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

-- Tombol CTRL = Hide / Show UI
uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        Frame.Visible = not Frame.Visible
    end
end)

-- AUTO LOOP
rs.RenderStepped:Connect(function()
    if settings.FlyDash then
        local char = plr.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.Humanoid:ChangeState-- Zik PvP Pro | Auto Bounty GUI v1.1 | by ZikSelebew
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

pcall(function()
    local raw = readfile(configFile)
    settings = game:GetService("HttpService"):JSONDecode(raw)
end)

local function saveSettings()
    writefile(configFile, game:GetService("HttpService"):JSONEncode(settings))
end

-- GUI Setup
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

-- Tombol CTRL = Hide / Show UI
uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        Frame.Visible = not Frame.Visible
    end
end)

-- AUTO LOOP
rs.RenderStepped:Connect(function()
    if settings.FlyDash then
        local char = plr.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.Humanoid:ChangeState
                            
