local function _H(h)
    return (h:gsub('..', function(cc)
        return string.char(tonumber(cc, 16))
    end))
end

local _1 = game:GetService(_H("506c6179657273"))
local _2 = game:GetService(_H("436f7265477569"))
local _3 = _1.LocalPlayer

local _guiName = _H("42414246545f53686f704f70656e6572")
if _2:FindFirstChild(_guiName) then
    _2[_guiName]:Destroy()
end

local _4 = Instance.new(_H("53637265656e477569"), _2)
_4.Name = _guiName

local _5 = Instance.new(_H("4672616d65"), _4)
_5.Size = UDim2.new(0, 250, 0, 230)
_5.Position = UDim2.new(0.5, -125, 0.35, 0)
_5.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
_5.Active = true
_5.Draggable = true

local _6 = Instance.new(_H("4672616d65"), _5)
_6.Size = UDim2.new(1, 0, 0, 30)
_6.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

local _7 = Instance.new(_H("546578744c6162656c"), _6)
_7.Size = UDim2.new(1, -35, 1, 0)
_7.Position = UDim2.new(0, 8, 0, 0)
_7.Text = _H("742e6d652f49736c616e647343686174")
_7.TextColor3 = Color3.new(1, 1, 1)
_7.BackgroundTransparency = 1
_7.Font = Enum.Font.SourceSansBold
_7.TextXAlignment = Enum.TextXAlignment.Left

local _8 = Instance.new(_H("54657874427574746f6e"), _6)
_8.Size = UDim2.new(0, 24, 0, 24)
_8.Position = UDim2.new(1, -27, 0, 3)
_8.Text = "📋"
_8.TextSize = 14
_8.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
_8.TextColor3 = Color3.new(1, 1, 1)

local _9 = Instance.new(_H("546578744c6162656c"), _5)
_9.Size = UDim2.new(1, -10, 0, 35)
_9.Position = UDim2.new(0, 5, 0, 185)
_9.Text = _H("d09ed182d0bad180d0bed0b9d182d0b520d0bcd0b0d0b3d0b0d0b7d0b8d0bd20d0b220d0b8d0b3d180d0b520d0b820d0bdd0b0d0b6d0bcd0b8d182d0b520d0bad0bdd0bed0bfd0bad183")
_9.TextColor3 = Color3.fromRGB(255, 200, 0)
_9.BackgroundTransparency = 1
_9.TextWrapped = true
_9.TextSize = 11

_8.MouseButton1Click:Connect(function()
    local _clip = setclipboard or toclipboard or (Synapse and Synapse.set_clipboard)
    if _clip then
        _clip(_H("68747470733a2f2f742e6d652f49736c616e647343686174"))
        _9.Text = _H("d0a1d181d18bd0bbd0bad0b020d181d0bad0bed0bfd0b8d180d0bed0b2d0b0d0bdd0b021")
    end
end)

local _Items = {
    ["Cookie Wheel"] = {"cookie", "1126385328"},
    ["Dragon Harpoon"] = {"dragonharpoon", "dragon", "1109792341"},
    ["Cannon Egg"] = {"cannonegg", "egg", "1161573715"}
}

local function _openInShop(_kws)
    local _pGui = _3:FindFirstChild(_H("506c61796572477569"))
    if not _pGui then return false end

    for _, gui in pairs(_pGui:GetChildren()) do
        if gui:IsA(_H("53637265656e477569")) then
            for _, desc in pairs(gui:GetDescendants()) do
                if desc:IsA(_H("4775694f626a656374")) and (string.find(string.lower(desc.Name), _H("73686f70")) or string.find(string.lower(desc.Name), _H("73746f7265"))) then
                    desc.Visible = true
                end
            end
        end
    end

    local _clicked = false

    for _, v in pairs(_pGui:GetDescendants()) do
        if v:IsA(_H("4775694f626a656374")) or v:IsA(_H("56616c7565")) then
            local _matches = false
            local _vName = string.lower(v.Name)
            
            for _, kw in ipairs(_kws) do
                if string.find(_vName, kw) then
                    _matches = true
                    break
                end
            end

            if _matches then
                local _curr = v
                while _curr and _curr:IsA(_H("4775694f626a656374")) do
                    _curr.Visible = true
                    _curr = _curr.Parent
                end

                local _btn = v:IsA(_H("477569427574746f6e")) and v or v:FindFirstChildWhichIsA(_H("477569427574746f6e"), true) or (v.Parent and v.Parent:FindFirstChildWhichIsA(_H("477569427574746f6e")))
                if _btn then
                    _btn.Visible = true
                    
                    if firesignal then
                        pcall(function() firesignal(_btn.MouseButton1Click) end)
                        pcall(function() firesignal(_btn.Activated) end)
                        _clicked = true
                    end
                    
                    if getconnections then
                        for _, conn in pairs(getconnections(_btn.MouseButton1Click)) do
                            pcall(function() conn:Fire() end)
                            _clicked = true
                        end
                        for _, conn in pairs(getconnections(_btn.Activated)) do
                            pcall(function() conn:Fire() end)
                            _clicked = true
                        end
                    end
                end
            end
        end
    end

    return _clicked
end

local _y = 35
for _dName, _kws in pairs(_Items) do
    local _btn = Instance.new(_H("54657874427574746f6e"), _5)
    _btn.Size = UDim2.new(0.9, 0, 0, 40)
    _btn.Position = UDim2.new(0.05, 0, 0, _y)
    _btn.Text = _H("d09fd0bed0bad0b0d0b7d0b0d182d18c20") .. _dName
    _btn.BackgroundColor3 = Color3.fromRGB(0, 150, 70)
    _btn.TextColor3 = Color3.new(1, 1, 1)
    _btn.Font = Enum.Font.SourceSansBold
    
    _btn.MouseButton1Click:Connect(function()
        _9.Text = _H("d09fd0bed0b8d181d0bad020d18d0bd0b5d0bcd0b5d0bdd182d0bed0b22e2e2e")
        local _s = _openInShop(_kws)
        if _s then
            _9.Text = _H("d09ad0b0d180d182d0bed187d0bad0b020") .. _dName .. _H("20d0b0d0bad182d0b8d0b2d0b8d180d0bed0b0d0bdd0b021")
        else
            _9.Text = _H("d09ed182d0bad180d0bed0b9d182d0b520d0b2d0bad0bbd0b0d0b4d0bad1832053686f7020d0b220d0b8d0b3d180d0b521")
        end
    end)
    _y = _y + 45
end
