local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Создаем локальную папку для коллизий
local folder = workspace:FindFirstChild("ClientColliders") or Instance.new("Folder", workspace)
folder.Name = "ClientColliders"

if _G.PlayerColLoop then 
    _G.PlayerColLoop:Disconnect() 
end

_G.PlayerColLoop = RunService.RenderStepped:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local char = player.Character
            local pFolder = folder:FindFirstChild(player.Name) or Instance.new("Folder", folder)
            pFolder.Name = player.Name

            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    local proxy = pFolder:FindFirstChild(part.Name)
                    if not proxy then
                        proxy = Instance.new("Part")
                        proxy.Name = part.Name
                        proxy.Transparency = 1 -- Прозрачный блок
                        proxy.CanCollide = true
                        proxy.Anchored = true
                        proxy.Material = Enum.Material.SmoothPlastic
                        proxy.Parent = pFolder
                    end
                    -- Синхронизируем размер и позицию каждый кадр
                    proxy.Size = part.Size
                    proxy.CFrame = part.CFrame
                end
            end
        end
    end
end)
