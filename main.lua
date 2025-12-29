-- THE FORGE HUB (v2) | Full Features
if game.CoreGui:FindFirstChild("TheForge") then
    game.CoreGui.TheForge:Destroy()
end

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Create main GUI
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

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40,40,40)
Title.Text = "🔥 THE FORGE HUB"
Title.TextColor3 = Color3.fromRGB(255, 140, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = Main

-- Tabs Container
local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(1, 0, 1, -40)
Tabs.Position = UDim2.new(0, 0, 0, 40)
Tabs.BackgroundTransparency = 1
Tabs.Parent = Main

-- Tab Buttons
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

    -- Create frame for each tab
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 1, -50)
    frame.Position = UDim2.new(0, 10, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Visible = (i==1) -- first tab visible by default
    frame.Parent = Tabs
    TabFrames[name] = frame

    btn.MouseButton1Click:Connect(function()
        for _, f in pairs(TabFrames) do f.Visible = false end
        frame.Visible = true
    end)
end

-- Toggle UI with RightShift
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Main.Visible = not Main.Visible
    end
end)
