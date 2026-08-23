local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local targetPlayer = nil
local trackingConnection = nil

-- Очистка старого UI при повторном запуске
if game:GetService("CoreGui"):FindFirstChild("HeadStandGui") then
    game:GetService("CoreGui").HeadStandGui:Destroy()
end

-- Создание интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HeadStandGui"
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 280)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "Head Stand Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.Parent = MainFrame

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -85)
Scroll.Position = UDim2.new(0, 10, 0, 40)
Scroll.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
Scroll.BorderSizePixel = 0
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = Scroll
UIList.Padding = UDim.new(0, 4)

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
end)

local StopBtn = Instance.new("TextButton")
StopBtn.Size = UDim2.new(1, -20, 0, 30)
StopBtn.Position = UDim2.new(0, 10, 1, -35)
StopBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
StopBtn.Text = "Остановить"
StopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StopBtn.Font = Enum.Font.SourceSansBold
StopBtn.TextSize = 14
StopBtn.Parent = MainFrame

local StopCorner = Instance.new("UICorner")
StopCorner.CornerRadius = UDim.new(0, 6)
StopCorner.Parent = StopBtn

-- Функция отключения слежки и возврата в норму
local function stopTracking()
    if trackingConnection then
        trackingConnection:Disconnect()
        trackingConnection = nil
    end
    
    local myChar = LocalPlayer.Character
    if myChar then
        local humanoid = myChar:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false -- Возвращаем обычное управление
        end
    end
    
    targetPlayer = nil
end

StopBtn.MouseButton1Click:Connect(stopTracking)

-- Запуск слежки за головой
local function startTracking(plr)
    stopTracking()
    targetPlayer = plr

    local myChar = LocalPlayer.Character
    if myChar then
        local humanoid = myChar:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = true -- Отключает ходьбу и баги физики
        end
    end

    trackingConnection = RunService.Heartbeat:Connect(function()
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
            local myChar = LocalPlayer.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                local head = targetPlayer.Character.Head
                local myHrp = myChar.HumanoidRootPart
                
                -- Держимся на голове и гасим все случайные физические импульсы
                myHrp.CFrame = head.CFrame * CFrame.new(0, 3.5, 0)
                myHrp.AssemblyLinearVelocity = Vector3.zero
                myHrp.AssemblyAngularVelocity = Vector3.zero
            end
        else
            stopTracking()
        end
    end)
end

-- Обновление списка игроков
local function refreshPlayerList()
    for _, child in ipairs(Scroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 28)
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            btn.Text = plr.DisplayName .. " (@" .. plr.Name .. ")"
            btn.TextColor3 = Color3.fromRGB(220, 220, 220)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 13
            btn.Parent = Scroll

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 4)
            btnCorner.Parent = btn

            btn.MouseButton1Click:Connect(function()
                startTracking(plr)
            end)
        end
    end
end

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)
refreshPlayerList()
