-- Interface simples e compatível
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🐂 YAK HUB | BROOKHAVEN RP",
   LoadingTitle = "YAK HUB Carregando...",
   LoadingSubtitle = "by Pedro of war",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "YAKHUB",
      FileName = "Config"
   },
   Discord = {
      Enabled = true,
      Invite = "qfSDax2zRV",
      RememberJoins = true
   },
   KeySystem = false,
})

-- Fire server message
local args = {
    [1] = "RolePlayName",
    [2] = "🐂 BEM VINDO AO YAK HUB 🐂"
}
game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1RPNam1eTex1t"):FireServer(unpack(args))

-- Variáveis globais
local jogadorSelecionado = nil
local autoFlingConexao = nil

-- ABA PRINCIPAL
local MainTab = Window:CreateTab("Principal", 4483362458)
MainTab:CreateSection("🐂 YAK HUB")
MainTab:CreateLabel("Hub modificado para Brookhaven RP | Versão BETA")

MainTab:CreateButton({
    Name = "🔗 Copiar Discord",
    Callback = function()
        setclipboard("https://discord.gg/qfSDax2zRV")
        Rayfield:Notify({
            Title = "Discord",
            Content = "Link copiado!",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

-- ABA SCRIPTS
local ScriptsTab = Window:CreateTab("Scripts", 4483362458)
ScriptsTab:CreateSection("Scripts Externos")

local scriptList = {
    {"YAK ESP", "https://raw.githubusercontent.com/Yak-Scripts/yakhub/main/YakESP.lua"},
    {"YAK Avatar GUI", "https://raw.githubusercontent.com/Yak-Scripts/yakhub/main/avatar%20GUI"},
    {"Cleitin Hub V4", "https://raw.githubusercontent.com/CLEITI6966/Brookhaven/refs/heads/main/start.lua"},
    {"Sander X", "https://rawscripts.net/raw/Brookhaven-RP-Sander-X-Hub-Latest-Version-3-16718"},
    {"R4D Sem Key", "https://rawscripts.net/raw/Brookhaven-RP-R4D-script-no-key-17562"},
    {"Infinite Yield", "https://rawscripts.net/raw/Infinite-Yield_500"},
    {"Troll GUI", "https://rawscripts.net/raw/Universal-Script-Troll-Gui-3874"}
}

for _, scriptData in pairs(scriptList) do
    ScriptsTab:CreateButton({
        Name = scriptData[1],
        Callback = function()
            loadstring(game:HttpGet(scriptData[2]))()
            Rayfield:Notify({
                Title = "Script Carregado",
                Content = scriptData[1] .. " executado!",
                Duration = 3,
                Image = 4483362458
            })
        end,
    })
end

-- ABA TROLL
local TrollTab = Window:CreateTab("Troll", 4483362458)
TrollTab:CreateSection("Ferramentas de Troll")

-- CAIXA DE TEXTO PARA DIGITAR O NOME
local playerNameInput = ""
TrollTab:CreateInput({
    Name = "Digite o nome do jogador",
    PlaceholderText = "Nome do jogador",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        playerNameInput = Text
        jogadorSelecionado = (Text ~= "") and Text or nil
        if Text ~= "" then
            Rayfield:Notify({
                Title = "Jogador Definido",
                Content = "Jogador: " .. Text,
                Duration = 2,
                Image = 4483362458
            })
        end
    end,
})

-- View Player
TrollTab:CreateButton({
    Name = "👁️ View Player",
    Callback = function()
        if not jogadorSelecionado or jogadorSelecionado == "" then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Digite o nome de um jogador primeiro!",
                Duration = 3,
                Image = 4483362458
            })
            return
        end
        
        local targetPlayer = nil
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Name:lower():find(jogadorSelecionado:lower(), 1, true) or 
               (player.DisplayName and player.DisplayName:lower():find(jogadorSelecionado:lower(), 1, true)) then
                targetPlayer = player
                break
            end
        end
        
        if targetPlayer and targetPlayer.Character then
            local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                workspace.CurrentCamera.CameraSubject = humanoid
                Rayfield:Notify({
                    Title = "View Player",
                    Content = "Espectando: " .. targetPlayer.Name,
                    Duration = 3,
                    Image = 4483362458
                })
            else
                Rayfield:Notify({
                    Title = "Erro",
                    Content = "Humanoid do jogador não encontrado!",
                    Duration = 3,
                    Image = 4483362458
                })
            end
        else
            Rayfield:Notify({
                Title = "Erro",
                Content = "Jogador não encontrado!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

-- TP to Player
TrollTab:CreateButton({
    Name = "📍 TP to Player",
    Callback = function()
        if not jogadorSelecionado or jogadorSelecionado == "" then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Digite o nome de um jogador primeiro!",
                Duration = 3,
                Image = 4483362458
            })
            return
        end
        
        local targetPlayer = nil
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Name:lower():find(jogadorSelecionado:lower(), 1, true) or 
               (player.DisplayName and player.DisplayName:lower():find(jogadorSelecionado:lower(), 1, true)) then
                targetPlayer = player
                break
            end
        end
        
        local meuChar = game.Players.LocalPlayer.Character
        if targetPlayer and meuChar and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and meuChar:FindFirstChild("HumanoidRootPart") then
            meuChar.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(2, 0, 2)
            Rayfield:Notify({
                Title = "TP Realizado",
                Content = "Teleportado até " .. targetPlayer.Name,
                Duration = 3,
                Image = 4483362458
            })
        else
            Rayfield:Notify({
                Title = "Erro",
                Content = "Não foi possível teleportar",
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

-- Kill Player
TrollTab:CreateButton({
    Name = "💀 Kill Player",
    Callback = function()
        if not jogadorSelecionado or jogadorSelecionado == "" then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Digite o nome de um jogador primeiro!",
                Duration = 3,
                Image = 4483362458
            })
            return
        end

        local targetPlayer = nil
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Name:lower():find(jogadorSelecionado:lower(), 1, true) or 
               (player.DisplayName and player.DisplayName:lower():find(jogadorSelecionado:lower(), 1, true)) then
                targetPlayer = player
                break
            end
        end

        if not targetPlayer or not targetPlayer.Character then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Jogador não encontrado!",
                Duration = 3,
                Image = 4483362458
            })
            return
        end

        local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
            Rayfield:Notify({
                Title = "Sucesso",
                Content = targetPlayer.Name .. " foi eliminado!",
                Duration = 3,
                Image = 4483362458
            })
        else
            Rayfield:Notify({
                Title = "Erro",
                Content = "Humanoid não encontrado!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

-- Pegar Sofá
TrollTab:CreateButton({
    Name = "🛋️ Pegar Sofá",
    Callback = function()
        local personagem = game.Players.LocalPlayer.Character
        if personagem and personagem:FindFirstChild("HumanoidRootPart") then
            personagem.HumanoidRootPart.CFrame = CFrame.new(-82, 19, -130)
            Rayfield:Notify({
                Title = "Localização",
                Content = "Teleportado para o sofá!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

-- AUTO FLING MELHORADO (VOID + DELETAR SOFÁ + VOLTAR)
TrollTab:CreateToggle({
    Name = "💥 FLING VOID (MELHORADO)",
    CurrentValue = false,
    Flag = "AutoFlingToggle",
    Callback = function(ativo)
        if ativo and (not jogadorSelecionado or jogadorSelecionado == "") then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Digite o nome de um jogador primeiro!",
                Duration = 3,
                Image = 4483362458
            })
            return
        end
        
        local player = game.Players.LocalPlayer
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then 
            Rayfield:Notify({
                Title = "Erro",
                Content = "Personagem não encontrado!",
                Duration = 3,
                Image = 4483362458
            })
            return
        end

        local targetPlayer = nil
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr.Name:lower():find(jogadorSelecionado:lower(), 1, true) or 
               (plr.DisplayName and plr.DisplayName:lower():find(jogadorSelecionado:lower(), 1, true)) then
                targetPlayer = plr
                break
            end
        end

        if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            Rayfield:Notify({
                Title = "Erro",
                Content = "Jogador alvo inválido!",
                Duration = 3,
                Image = 4483362458
            })
            return
        end

        local hrp = char.HumanoidRootPart
        local alvoHRP = targetPlayer.Character.HumanoidRootPart

        if ativo then
            -- Salva posição original para voltar depois
            local originalPosition = hrp.CFrame
            local originalAlvoPosition = alvoHRP.CFrame

            Rayfield:Notify({
                Title = "FLING VOID",
                Content = "Iniciando contra " .. targetPlayer.Name,
                Duration = 2,
                Image = 4483362458
            })

            -- FASE 1: FLING NORMAL
            hrp.CFrame = alvoHRP.CFrame * CFrame.new(0, 3, 0) -- Fica em cima do jogador

            local spin = Instance.new("BodyAngularVelocity")
            spin.AngularVelocity = Vector3.new(math.rad(2000), math.rad(2500), math.rad(2000))
            spin.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            spin.P = 1e9
            spin.Name = "YAK_SPIN"
            spin.Parent = hrp

            local force = Instance.new("BodyVelocity")
            force.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            force.P = 1e9
            force.Velocity = Vector3.new(0, 100, 0) -- Joga pra cima
            force.Name = "YAK_FORCE"
            force.Parent = hrp

            -- FASE 2: VOID (5 segundos depois)
            task.delay(3, function()
                if not ativo then return end
                
                Rayfield:Notify({
                    Title = "FLING VOID",
                    Content = "Mandando para o VOID!",
                    Duration = 2,
                    Image = 4483362458
                })
                
                -- Teleporta para o VOID (Y: -5000)
                hrp.CFrame = CFrame.new(0, -5000, 0)
                if targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    targetPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -5000, 0)
                end
                
                -- Deleta o sofá se existir
                local sofa = workspace:FindFirstChild("Sofa") or workspace:FindFirstChild("Couch")
                if sofa then
                    sofa:Destroy()
                    Rayfield:Notify({
                        Title = "FLING VOID",
                        Content = "Sofá deletado!",
                        Duration = 2,
                        Image = 4483362458
                    })
                end
            end)

            -- FASE 3: VOLTAR (10 segundos depois)
            task.delay(8, function()
                if not ativo then return end
                
                Rayfield:Notify({
                    Title = "FLING VOID",
                    Content = "Voltando para o início!",
                    Duration = 2,
                    Image = 4483362458
                })
                
                -- Volta para posição original
                hrp.CFrame = originalPosition
                if targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    targetPlayer.Character.HumanoidRootPart.CFrame = originalAlvoPosition
                end
                
                -- Remove os efeitos
                if spin then spin:Destroy() end
                if force then force:Destroy() end
                if autoFlingConexao then autoFlingConexao:Disconnect() end
            end)

        else
            -- DESATIVAR
            if autoFlingConexao then autoFlingConexao:Disconnect() end
            if hrp and hrp:FindFirstChild("YAK_SPIN") then hrp.YAK_SPIN:Destroy() end
            if hrp and hrp:FindFirstChild("YAK_FORCE") then hrp.YAK_FORCE:Destroy() end
            
            Rayfield:Notify({
                Title = "FLING VOID",
                Content = "Desativado",
                Duration = 2,
                Image = 4483362458
            })
        end
    end,
})

-- ABA FERRAMENTAS
local ToolsTab = Window:CreateTab("Ferramentas", 4483362458)
ToolsTab:CreateSection("Utilidades")

ToolsTab:CreateButton({
    Name = "🔄 Rejoin",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
})

ToolsTab:CreateButton({
    Name = "📋 Copiar Coordenadas",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = player.Character.HumanoidRootPart.Position
            setclipboard(string.format("X: %d, Y: %d, Z: %d", pos.X, pos.Y, pos.Z))
            Rayfield:Notify({
                Title = "Coordenadas",
                Content = "Coordenadas copiadas!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

ToolsTab:CreateButton({
    Name = "⏰ Anti AFK",
    Callback = function()
        local connection
        connection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
            wait(0.1)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
        end)
        Rayfield:Notify({
            Title = "Anti AFK",
            Content = "Ativado!",
            Duration = 3,
            Image = 4483362458
        })
        _G.AntiAFKConnection = connection
    end,
})

-- ABA CORPO
local BodyTab = Window:CreateTab("Corpo", 4483362458)
BodyTab:CreateSection("Controles do Corpo")

local speed = 16
local jumpPower = 50

BodyTab:CreateInput({
    Name = "Velocidade",
    PlaceholderText = tostring(speed),
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local newSpeed = tonumber(text)
        if newSpeed then
            speed = newSpeed
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speed
            end
            Rayfield:Notify({
                Title = "Velocidade",
                Content = "Velocidade alterada para: " .. speed,
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

BodyTab:CreateInput({
    Name = "Pulo",
    PlaceholderText = tostring(jumpPower),
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local newJumpPower = tonumber(text)
        if newJumpPower then
            jumpPower = newJumpPower
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = jumpPower
            end
            Rayfield:Notify({
                Title = "Pulo",
                Content = "Pulo alterado para: " .. jumpPower,
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

BodyTab:CreateButton({
    Name = "🚫 Anti Sit",
    Callback = function()
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Sit = false
            humanoid.Changed:Connect(function(property)
                if property == "Sit" then
                    humanoid.Sit = false
                end
            end)
            Rayfield:Notify({
                Title = "Anti Sit",
                Content = "Anti Sit ativado!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

-- ABA OUTROS
local OtherTab = Window:CreateTab("Outros", 4483362458)
OtherTab:CreateSection("Configurações Adicionais")

OtherTab:CreateButton({
    Name = "🎩 Set RP Name",
    Callback = function()
        local args = {
            [1] = "RolePlayName",
            [2] = "COOLKID 666"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1RPNam1eTex1t"):FireServer(unpack(args))
        Rayfield:Notify({
            Title = "RP Name",
            Content = "Nome definido: COOLKID 666",
            Duration = 3,
            Image = 4483362458
        })
    end,
})

OtherTab:CreateButton({
    Name = "⚡ Equip All Items",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    humanoid:EquipTool(tool)
                end
            end
            Rayfield:Notify({
                Title = "Itens Equipados",
                Content = "Todos os itens equipados!",
                Duration = 3,
                Image = 4483362458
            })
        end
    end,
})

Rayfield:Notify({
    Title = "🐂 YAK HUB",
    Content = "Script carregado com sucesso!",
    Duration = 5,
    Image = 4483362458
})
