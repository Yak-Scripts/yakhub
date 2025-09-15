local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "YAK HUB | Fluent UI",
    SubTitle = "by Pedro of war",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local args = {
    [1] = "RolePlayName",
    [2] = "BEM VINDO AO SCRIPT YAK HUB"
}
game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1RPNam1eTex1t"):FireServer(unpack(args))

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Troll = Window:AddTab({ Title = "Troll", Icon = "skull" }),
    Credits = Window:AddTab({ Title = "Credits", Icon = "heart" })
}

local jogadorSelecionado = nil
local autoFlingConexao = nil
local isViewingPlayer = false
local currentViewConnection = nil

local function ObterNomesJogadores()
    local nomes = {}
    for _, jogador in ipairs(game.Players:GetPlayers()) do
        table.insert(nomes, jogador.Name)
    end
    return nomes
end

Tabs.Main:AddParagraph({
    Title = "YAK HUB",
    Content = "Bem-vindo ao script YAK HUB com interface Fluent!"
})

Tabs.Main:AddButton({
    Title = "Atualizar Jogadores",
    Description = "Atualiza a lista de jogadores em todas as abas",
    Callback = function()
        Fluent:Notify({
            Title = "Sistema",
            Content = "Lista de jogadores atualizada!",
            Duration = 3
        })
    end
})

Tabs.Troll:AddParagraph({
    Title = "Ferramentas de Troll",
    Content = "Selecione um jogador e escolha uma ação"
})

local Dropdown = Tabs.Troll:AddDropdown("Dropdown", {
    Title = "Lista de Jogadores",
    Description = "Selecione um jogador para as ações",
    Values = ObterNomesJogadores(),
    Default = 1,
    Callback = function(Value)
        jogadorSelecionado = Value
        Fluent:Notify({
            Title = "Jogador Selecionado",
            Content = "Você selecionou: " .. Value,
            Duration = 3
        })
    end
})

Tabs.Troll:AddButton({
    Title = "🔄 Atualizar Lista",
    Description = "Atualiza a lista de jogadores",
    Callback = function()
        Dropdown:SetValues(ObterNomesJogadores())
        Fluent:Notify({
            Title = "Lista Atualizada",
            Content = "Jogadores atualizados com sucesso!",
            Duration = 2
        })
    end
})

-- REMOVI A LINHA AddDivider() QUE ESTAVA CAUSANDO O ERRO

Tabs.Troll:AddButton({
    Title = "📍 TP até Jogador",
    Description = "Teleporta até o jogador selecionado",
    Callback = function()
        local alvo = game.Players:FindFirstChild(jogadorSelecionado)
        local meuChar = game.Players.LocalPlayer.Character
        if alvo and meuChar and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
            meuChar:MoveTo(alvo.Character.HumanoidRootPart.Position + Vector3.new(2, 0, 2))
            Fluent:Notify({
                Title = "TP Realizado",
                Content = "Teleportado até " .. jogadorSelecionado,
                Duration = 3
            })
        else
            Fluent:Notify({
                Title = "Erro",
                Content = "Não foi possível realizar o TP",
                Duration = 3
            })
        end
    end
})

Tabs.Troll:AddButton({
    Title = "🛋️ Pegar Sofá",
    Description = "Teleporta para a sala da festa",
    Callback = function()
        local personagem = game.Players.LocalPlayer.Character
        if personagem and personagem:FindFirstChild("HumanoidRootPart") then
            personagem:MoveTo(Vector3.new(-164, 18, -38))
            Fluent:Notify({
                Title = "Localização",
                Content = "Teleportado para a sala da festa",
                Duration = 3
            })
        end
    end
})

Tabs.Troll:AddButton({
    Title = "💀 Kill Player",
    Description = "Elimina o jogador selecionado",
    Callback = function()
        if not jogadorSelecionado then
            Fluent:Notify({
                Title = "Erro",
                Content = "Nenhum jogador selecionado!",
                Duration = 3
            })
            return
        end

        local targetPlayer = game.Players:FindFirstChild(jogadorSelecionado)
        if not targetPlayer or not targetPlayer.Character then
            Fluent:Notify({
                Title = "Erro",
                Content = "Jogador não encontrado!",
                Duration = 3
            })
            return
        end

        local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
            Fluent:Notify({
                Title = "Sucesso",
                Content = jogadorSelecionado .. " foi eliminado!",
                Duration = 3
            })
        else
            Fluent:Notify({
                Title = "Erro",
                Content = "Humanoid não encontrado!",
                Duration = 3
            })
        end
    end
})

Tabs.Troll:AddButton({
    Title = "👁️ View Player",
    Description = "Especta/para de espectar o jogador",
    Callback = function()
        local player = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        local targetPlayer = game.Players:FindFirstChild(jogadorSelecionado)

        if not jogadorSelecionado then
            Fluent:Notify({
                Title = "Erro",
                Content = "Nenhum jogador selecionado!",
                Duration = 2
            })
            return
        end

        if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            Fluent:Notify({
                Title = "Erro",
                Content = "Jogador inválido!",
                Duration = 2
            })
            return
        end

        if not isViewingPlayer then
            isViewingPlayer = true
            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = targetPlayer.Character:FindFirstChildOfClass("Humanoid")

            if currentViewConnection then currentViewConnection:Disconnect() end
            currentViewConnection = targetPlayer.Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
                isViewingPlayer = false
                camera.CameraType = Enum.CameraType.Custom
                camera.CameraSubject = player.Character and player.Character:FindFirstChildOfClass("Humanoid") or nil
                Fluent:Notify({
                    Title = "View Player",
                    Content = "Jogador morreu!",
                    Duration = 2
                })
            end)

            Fluent:Notify({
                Title = "View Player",
                Content = "Espectando " .. jogadorSelecionado,
                Duration = 2
            })
        else
            isViewingPlayer = false
            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = player.Character and player.Character:FindFirstChildOfClass("Humanoid") or nil
            
            if currentViewConnection then
                currentViewConnection:Disconnect()
                currentViewConnection = nil
            end
            
            Fluent:Notify({
                Title = "View Player",
                Content = "Parou de espectar",
                Duration = 2
            })
        end
    end
})

Tabs.Troll:AddToggle("AutoFlingToggle", {
    Title = "💥 Auto Fling Player",
    Description = "Ativa o modo caótico contra o jogador",
    Default = false,
    Callback = function(ativo)
        local player = game.Players.LocalPlayer
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local hrp = char.HumanoidRootPart

        if ativo and jogadorSelecionado then
            local alvo = game.Players:FindFirstChild(jogadorSelecionado)
            if not alvo or not alvo.Character or not alvo.Character:FindFirstChild("HumanoidRootPart") then
                Fluent:Notify({
                    Title = "Erro",
                    Content = "Jogador alvo inválido!",
                    Duration = 3
                })
                return
            end

            local alvoHRP = alvo.Character.HumanoidRootPart
            hrp.CFrame = alvoHRP.CFrame * CFrame.new(2, 0, 2)

            local spin = Instance.new("BodyAngularVelocity")
            spin.AngularVelocity = Vector3.new(math.rad(1200), math.rad(1500), math.rad(1200))
            spin.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            spin.P = 1e5
            spin.Name = "YAK_SPIN"
            spin.Parent = hrp

            local force = Instance.new("BodyVelocity")
            force.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            force.P = 1e5
            force.Name = "YAK_FORCE"
            force.Parent = hrp

            local runService = game:GetService("RunService")
            autoFlingConexao = runService.Heartbeat:Connect(function()
                if not ativo then
                    autoFlingConexao:Disconnect()
                    if spin then spin:Destroy() end
                    if force then force:Destroy() end
                    return
                end

                if not (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then
                    autoFlingConexao:Disconnect()
                    if spin then spin:Destroy() end
                    if force then force:Destroy() end
                    return
                end

                local posAlvo = alvoHRP.Position
                local posEu = hrp.Position
                local offsetX = math.sin(tick() * 30) * 10
                local offsetZ = math.cos(tick() * 25) * 10
                local targetPos = posAlvo + Vector3.new(offsetX, 0, offsetZ)
                local direcao = (targetPos - posEu).Unit
                force.Velocity = direcao * 100

                local dist = (posEu - posAlvo).Magnitude
                if dist < 5 then
                    alvoHRP.Velocity = Vector3.new(math.random(-100, 100), 250, math.random(-100, 100))
                    hrp.Velocity = Vector3.new(0, 150, 0)

                    task.delay(2, function()
                        if autoFlingConexao then autoFlingConexao:Disconnect() end
                        if spin then spin:Destroy() end
                        if force then force:Destroy() end
                        
                        local originalPosition = hrp.CFrame
                        local skyPosition = hrp.CFrame * CFrame.new(0, 1000, 500)
                        hrp.CFrame = skyPosition

                        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            local tool = player.Character:FindFirstChildOfClass("Tool")
                            if tool then
                                tool.Parent = workspace
                            end
                        end

                        task.delay(4, function()
                            if hrp then
                                hrp.CFrame = originalPosition
                            end
                        end)
                    end)
                end
            end)

            Fluent:Notify({
                Title = "Auto Fling",
                Content = "Ativado contra " .. jogadorSelecionado,
                Duration = 2
            })
        else
            if autoFlingConexao then autoFlingConexao:Disconnect() end
            if hrp and hrp:FindFirstChild("YAK_SPIN") then hrp.YAK_SPIN:Destroy() end
            if hrp and hrp:FindFirstChild("YAK_FORCE") then hrp.YAK_FORCE:Destroy() end
            
            Fluent:Notify({
                Title = "Auto Fling",
                Content = "Desativado",
                Duration = 2
            })
        end
    end
})

Tabs.Credits:AddParagraph({
    Title = "📜 Créditos",
    Content = "👑 Dono do Hub: ★ Pedro of war ★"
})

Tabs.Credits:AddParagraph({
    Title = "✨ Características",
    Content = "• Interface Fluent UI\n• Sistema de notificações\n• Múltiplas funções de troll\n• Design moderno e elegante"
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
InterfaceManager:SetFolder("YAKHUB")
SaveManager:SetFolder("YAKHUB")

Window:SelectTab(1)

Fluent:Notify({
    Title = "YAK HUB",
    Content = "Script carregado com sucesso!",
    Duration = 5
})
