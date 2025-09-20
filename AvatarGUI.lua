-- Avatar GUI by Pedro of War

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "AvatarGUI"

-- Criar Frame Principal
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 300)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true -- permite mover a GUI
Frame.Parent = ScreenGui

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "Avatar GUI - Made by Pedro of War"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = Frame

-- Botão Minimizar
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -55, 0, 2)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = Frame

-- Botão Fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -28, 0, 2)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = Frame

-- Container de botões
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -10, 1, -40)
Container.Position = UDim2.new(0, 5, 0, 35)
Container.BackgroundTransparency = 1
Container.Parent = Frame

-- Função para alterar escala do corpo
local function changeScale(partName, scale)
    local part = Character:FindFirstChild(partName)
    if part then
        part.Size = part.Size * scale
    end
end

-- Criar Botão
local function createButton(text, yPos, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.Position = UDim2.new(0, 0, 0, yPos)
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 14
    Button.Text = text
    Button.Parent = Container
    Button.MouseButton1Click:Connect(callback)
end

-- Funções dos botões
createButton("Aumentar Cabeça", 0, function() changeScale("Head", 1.2) end)
createButton("Diminuir Cabeça", 35, function() changeScale("Head", 0.8) end)
createButton("Braços Gigantes", 70, function() changeScale("Left Arm", 1.5); changeScale("Right Arm", 1.5) end)
createButton("Pernas Gigantes", 105, function() changeScale("Left Leg", 1.5); changeScale("Right Leg", 1.5) end)
createButton("Resetar Avatar", 140, function() Character:BreakJoints() end)

-- Botão mudar cor
createButton("Cor Aleatória", 175, function()
    for _, part in pairs(Character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Color = Color3.new(math.random(), math.random(), math.random())
        end
    end
end)

-- Fechar GUI
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Minimizar GUI
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, child in pairs(Container:GetChildren()) do
        child.Visible = not minimized
    end
    Frame.Size = minimized and UDim2.new(0,250,0,40) or UDim2.new(0,250,0,300)
end)
