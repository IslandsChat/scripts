local function _H(h)
    return (h:gsub('..', function(cc)
        return string.char(tonumber(cc, 16))
    end))
end

local _1 = game:GetService(_H("4d61726b6574706c61636553657276696365"))
local _2 = game:GetService(_H("506c6179657273"))
local _3 = game:GetService(_H("436f7265477569"))
local _4 = _2.LocalPlayer

local _name = _H("526f62757853686f70427970617373")
if _3:FindFirstChild(_name) then
    _3[_name]:Destroy()
end

local _5 = Instance.new(_H("53637265656e477569"), _3)
_5.Name = _name

local _6 = Instance.new(_H("4672616d65"), _5)
_6.Size = UDim2.new(0, 240, 0, 220)
_6.Position = UDim2.new(0.5, -120, 0.35, 0)
_6.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
_6.Active = true
_6.Draggable = true

local _7 = Instance.new(_H("4672616d65"), _6)
_7.Size = UDim2.new(1, 0, 0, 30)
_7.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

local _8 = Instance.new(_H("546578744c6162656c"), _7)
_8.Size = UDim2.new(1, -35, 1, 0)
_8.Position = UDim2.new(0, 8, 0, 0)
_8.Text = _H("742e6d652f49736c616e647343686174")
_8.TextColor3 = Color3.new(1, 1, 1)
_8.BackgroundTransparency = 1
_8.Font = Enum.Font.SourceSansBold
_8.TextXAlignment = Enum.TextXAlignment.Left

local _9 = Instance.new(_H("546578744c6162656c"), _6)
_9.Size = UDim2.new(1, -10, 0, 35)
_9.Position = UDim2.new(0, 5, 0, 175)
_9.Text = _H("d0a1d182d0b0d182d183d1813a20d09ed0b6d0b8d0b4d0b0d0bdd0b8d0b52e2e2e")
_9.TextColor3 = Color3.fromRGB(255, 200, 0)
_9.BackgroundTransparency = 1
_9.TextWrapped = true
_9.TextSize = 11

local _A = Instance.new(_H("54657874427574746f6e"), _7)
_A.Size = UDim2.new(0, 24, 0, 24)
_A.Position = UDim2.new(1, -27, 0, 3)
_A.Text = "📋"
_A.TextSize = 14
_A.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
_A.TextColor3 = Color3.new(1, 1, 1)
_A.Font = Enum.Font.SourceSansBold

_A.MouseButton1Click:Connect(function()
    local _B = setclipboard or toclipboard or (Synapse and Synapse.set_clipboard)
    if _B then
        _B(_H("68747470733a2f2f742e6d652f49736c616e647343686174"))
        _9.Text = _H("d0a1d181d18bd0bbd0bad0b020d181d0bad0bed0bfd0b8d180d0bed0b2d0b0d0bdd0b021")
    else
        _9.Text = _H("d09ed188d0b8d0b1d0bad0b03a20736574636c6970626f617264")
    end
end)

local _C = {
    {Name = "Cookie Wheel", ID = 1126385328, ItemName = "CookieWheel"},
    {Name = "Dragon Harpoon", ID = 1109792341, ItemName = "DragonHarpoon"},
    {Name = "Cannon Egg", ID = 1161573715, ItemName = "CannonEgg"}
}

local function _D(_E)
    local _F = _4:FindFirstChild(_H("506c61796572477569"))
    if _F and firesignal then
        for _, v in pairs(_F:GetDescendants()) do
            if (v:IsA(_H("477569427574746f6e")) or v:IsA(_H("54657874427574746f6e")) or v:IsA(_H("496d616765427574746f6e"))) then
                if string.find(string.lower(v.Name), string.lower(_E.ItemName)) or string.find(string.lower(v.Name), string.lower(_E.Name)) then
                    firesignal(v.MouseButton1Click)
                    firesignal(v.Activated)
                    return true, _H("d092d18bd0b7d0b2d0b0d0bdd0be20d187d0b5d180d0b5d0b720554920d0b8d0b3d180d18b")
                end
            end
        end
    end

    local _10 = setthreadidentity or setidentity or setthreadcontext
    if _10 then
        local s, _ = pcall(function()
            _10(2)
            _1:PromptProductPurchase(_4, _E.ID)
        end)
        _10(7)
        if s then return true, _H("d092d18bd0b7d0b2d0b0d0bdd0be20d187d0b5d180d0b5d0b7204964656e746974792032") end
    end

    local s, e = pcall(function()
        _1:PromptProductPurchase(_4, _E.ID)
    end)
    return s, s and _H("d09fd180d18fd0bcd0bed0b920d0b2d18bd0b7d0bed0b220d183d181d0bfd0b5d188d0b5d0bd") or tostring(e)
end

local _11 = 35
for _, _12 in pairs(_C) do
    local _13 = Instance.new(_H("54657874427574746f6e"), _6)
    _13.Size = UDim2.new(0.9, 0, 0, 40)
    _13.Position = UDim2.new(0.05, 0, 0, _11)
    _13.Text = _H("d09ed182d0bad180d18bd182d18c20") .. _12.Name
    _13.BackgroundColor3 = Color3.fromRGB(0, 150, 70)
    _13.TextColor3 = Color3.new(1, 1, 1)
    _13.Font = Enum.Font.SourceSansBold
    
    _13.MouseButton1Click:Connect(function()
        _9.Text = _H("d097d0b0d0bfd180d0bed1812e2e2e")
        task.spawn(function()
            local s, msg = _D(_12)
            _9.Text = s and (_H("d0a3d181d0bfd0b5d1853a20") .. msg) or _H("d097d0b0d0b1d0bbd0bed0bad0b8d180d0bed0b2d0b0d0bdd0be20d0b8d0bdd0b6d0b5d0bad182d0bed180d0bed0bc2e")
        end)
    end)
    _11 = _11 + 45
end
