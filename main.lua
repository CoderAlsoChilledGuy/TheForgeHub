-- THE FORGE HUB (v3) | Full Features
if game.CoreGui:FindFirstChild("TheForge") then
    game.CoreGui.TheForge:Destroy()
end

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- ==== UI SETUP ====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TheForge"
ScreenGui.Parent = game.CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 500, 0, 350)
Main.Position = UDim2.new(0.5, -250, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40,40,40)
Title.Text = "🔥 THE FORGE HUB"
Title.TextColor3 = Color3.fromRGB(255, 140, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = Main

local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(1, 0, 1, -40)
Tabs.Position = UDim2.new(0, 0, 0, 40)
Tabs.BackgroundTransparency = 1
Tabs.Parent = Main

local TabNames = {"Mining", "Forge", "Combat", "Player", "Quests"}
local TabFrames = {}
local TabButtons = {}

for i, name in ipairs(TabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 0, 30)
    btn.Position = UDim2.new(0, 10 + (i-1)*100, 0, 5)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Parent = Main
    TabButtons[name] = btn

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 1, -50)
    frame.Position = UDim2.new(0, 10, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Visible = (i==1)
    frame.Parent = Tabs
    TabFrames[name] = frame

    btn.MouseButton1Click:Connect(function()
        for _, f in pairs(TabFrames) do f.Visible = false end
        frame.Visible = true
    end)
end

-- Toggle UI
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)

-- ==== HUB FUNCTIONALITY ====
local Hub = {}

-- ===== MINING =====
do
    local frame = TabFrames["Mining"]
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 150, 0, 40)
    toggle.Position = UDim2.new(0, 10, 0, 10)
    toggle.Text = "Auto Mine: OFF"
    toggle.Parent = frame

    local mining = false
    toggle.MouseButton1Click:Connect(function()
        mining = not mining
        toggle.Text = "Auto Mine: " .. (mining and "ON" or "OFF")
        if mining then
            spawn(function()
                while mining do
                    -- Example: Trigger forge remote (you may need adjust)
                    local success, err = pcall(function()
                        local forgeRF = RS.Shared.Packages.Knit.Services.ProximityService.RF.Forge
                        forgeRF:InvokeServer()
                    end)
                    wait(0.5)
                end
            end)
        end
    end)
end

-- ===== FORGE =====
do
    local frame = TabFrames["Forge"]
    local startBtn = Instance.new("TextButton")
    startBtn.Size = UDim2.new(0, 150, 0, 40)
    startBtn.Position = UDim2.new(0, 10, 0, 10)
    startBtn.Text = "Start Forge"
    startBtn.Parent = frame

    startBtn.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            RS.Shared.Packages.Knit.Services.ForgeService.RF.StartForge:InvokeServer()
        end)
    end)

    local endBtn = Instance.new("TextButton")
    endBtn.Size = UDim2.new(0, 150, 0, 40)
    endBtn.Position = UDim2.new(0, 10, 0, 60)
    endBtn.Text = "End Forge"
    endBtn.Parent = frame

    endBtn.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            RS.Shared.Packages.Knit.Services.ForgeService.RF.EndForge:InvokeServer()
        end)
    end)
end

-- ===== COMBAT =====
do
    local frame = TabFrames["Combat"]
    local equipBtn = Instance.new("TextButton")
    equipBtn.Size = UDim2.new(0, 150, 0, 40)
    equipBtn.Position = UDim2.new(0, 10, 0, 10)
    equipBtn.Text = "Equip Tool"
    equipBtn.Parent = frame

    equipBtn.MouseButton1Click:Connect(function()
        pcall(function()
            RS.Shared.Packages.Knit.Services.CharacterService.RF.EquipItem:InvokeServer()
        end)
    end)

    local dashBtn = Instance.new("TextButton")
    dashBtn.Size = UDim2.new(0, 150, 0, 40)
    dashBtn.Position = UDim2.new(0, 10, 0, 60)
    dashBtn.Text = "Dash"
    dashBtn.Parent = frame

    dashBtn.MouseButton1Click:Connect(function()
        pcall(function()
            RS.Shared.Packages.Knit.Services.CharacterService.RF.Dash:InvokeServer()
        end)
    end)
end

-- ===== PLAYER =====
do
    local frame = TabFrames["Player"]
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1, -20, 0, 40)
    statsLabel.Position = UDim2.new(0, 10, 0, 10)
    statsLabel.Text = "Gold: 0 | XP: 0"
    statsLabel.TextColor3 = Color3.fromRGB(255,255,255)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Font = Enum.Font.Gotham
    statsLabel.TextSize = 16
    statsLabel.Parent = frame

    spawn(function()
        while true do
            local success, gold, xp = pcall(function()
                -- Example placeholders, replace with actual remotes
                return 0,0
            end)
            statsLabel.Text = "Gold: "..gold.." | XP: "..xp
            wait(1)
        end
    end)
end

-- ===== QUESTS =====
do
    local frame = TabFrames["Quests"]
    local trackBtn = Instance.new("TextButton")
    trackBtn.Size = UDim2.new(0, 150, 0, 40)
    trackBtn.Position = UDim2.new(0, 10, 0, 10)
    trackBtn.Text = "Track Quests"
    trackBtn.Parent = frame

    trackBtn.MouseButton1Click:Connect(function()
        pcall(function()
            RS.Shared.Packages.Knit.Services.QuestService.RF.ClientTrackQuest:InvokeServer()
            RS.Shared.Packages.Knit.Services.QuestService.RF.ProgressUIQuest:InvokeServer()
        end)
    end)
end

print("✅ THE FORGE HUB v3 Loaded")
