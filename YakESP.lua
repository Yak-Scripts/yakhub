local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ESPEnabled = false
local ESPBoxes = {}
local ESPColor = Color3.fromRGB(0,255,0)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YakESPGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,220,0,180)
Frame.Position = UDim2.new(0.02,0,0.02,0)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.2
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,25)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,0,0,0)
Title.Text = "MADE BY PEDRO OF WAR"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.Parent = Frame

local function CreateButton(name, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,200,0,25)
    btn.Position = UDim2.new(0,10,0,y)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Text = name
    btn.Parent = Frame
    btn.MouseButton1Click:Connect(callback)
end

local function CreateColorPicker(y, defaultColor, callback)
    local cpLabel = Instance.new("TextLabel")
    cpLabel.Size = UDim2.new(0,200,0,25)
    cpLabel.Position = UDim2.new(0,10,0,y)
    cpLabel.BackgroundColor3 = Color3.fromRGB(50,50,50)
    cpLabel.TextColor3 = defaultColor
    cpLabel.Font = Enum.Font.SourceSans
    cpLabel.TextSize = 14
    cpLabel.Text = "Mudar Cor ESP"
    cpLabel.Parent = Frame
    cpLabel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local newColor = Color3.fromHSV(math.random(),1,1)
            ESPColor = newColor
            cpLabel.TextColor3 = newColor
            callback(newColor)
        end
    end)
end

local function EnableESP()
    ESPEnabled = true
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not ESPBoxes[player] then
                local box = Instance.new("BoxHandleAdornment")
                box.Adornee = player.Character.HumanoidRootPart
                box.Size = Vector3.new(2,3,1)
                box.Transparency = 0.5
                box.Color3 = ESPColor
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Parent = workspace

                local nameTag = Instance.new("BillboardGui")
                nameTag.Adornee = player.Character:FindFirstChild("Head")
                nameTag.Size = UDim2.new(0,100,0,20)
                nameTag.StudsOffset = Vector3.new(0,2,0)
                nameTag.AlwaysOnTop = true
                nameTag.Name = "YakNameTag"
                nameTag.Parent = player.Character

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1,0,1,0)
                label.BackgroundTransparency = 1
                label.Text = player.Name
                label.TextColor3 = ESPColor
                label.Font = Enum.Font.SourceSansBold
                label.TextSize = 14
                label.Parent = nameTag

                ESPBoxes[player] = {box = box, nameTag = nameTag, label = label}
            end
        end
    end
end

local function DisableESP()
    ESPEnabled = false
    for _, data in pairs(ESPBoxes) do
        if data.box then data.box:Destroy() end
        if data.nameTag then data.nameTag:Destroy() end
    end
    ESPBoxes = {}
end

local function DestroyGUI()
    DisableESP()
    ScreenGui:Destroy()
end

CreateButton("Ativar ESP", 30, function() EnableESP() end)
CreateButton("Desativar ESP", 60, function() DisableESP() end)
CreateButton("Destruir GUI", 90, function() DestroyGUI() end)
CreateColorPicker(120, ESPColor, function(newColor)
    for _, data in pairs(ESPBoxes) do
        data.box.Color3 = newColor
        data.label.TextColor3 = newColor
    end
end)

RunService.RenderStepped:Connect(function()
    if ESPEnabled then
        for player, data in pairs(ESPBoxes) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Head") then
                data.box.Adornee = player.Character.HumanoidRootPart
                data.nameTag.Adornee = player.Character.Head
            else
                if data.box then data.box:Destroy() end
                if data.nameTag then data.nameTag:Destroy() end
                ESPBoxes[player] = nil
            end
        end
    end
end)
