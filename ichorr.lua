-- Blot’s Ichor Puddle | Better Visual Version
local plr = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "IchorPuddle"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = plr:WaitForChild("PlayerGui")

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 570, 0, 414)
frame.Position = UDim2.new(0, 258, 0, 112)
frame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
Instance.new("UICorner", frame)
Instance.new("UIStroke", frame).Thickness = 10

-- Title
local title = Instance.new("TextLabel", gui)
title.Size = UDim2.new(0, 258, 0, 40)
title.Position = UDim2.new(0, 264, 0, 44)
title.BackgroundTransparency = 1
title.Text = "Blot’s ichor puddle !"
title.TextSize = 32
title.TextColor3 = Color3.fromRGB(255,255,255)
title.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
Instance.new("UIStroke", title).Thickness = 3

-- Button Creator
local function NewBtn(name, text, pos, size, c1, c2, textsize)
    local b = Instance.new("TextButton", gui)
    b.Name = name
    b.Size = size
    b.Position = pos
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.BackgroundColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = textsize or 24
    b.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
    Instance.new("UICorner", b)
    local g = Instance.new("UIGradient", b)
    g.Rotation = 270
    g.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,c1), ColorSequenceKeypoint.new(1,c2)}
    Instance.new("UIStroke", b).Thickness = 8
    return b
end

-- Top Buttons
NewBtn("ESP", "ESP", UDim2.new(0,266,0,124), UDim2.new(0,142,0,76), Color3.fromRGB(63,63,63), Color3.fromRGB(149,149,149), 36)
NewBtn("FullBright", "FullBright", UDim2.new(0,420,0,124), UDim2.new(0,146,0,76), Color3.fromRGB(64,64,64), Color3.fromRGB(150,150,150), 24)

-- Bottom Buttons
NewBtn("Main", "Main", UDim2.new(0,264,0,534), UDim2.new(0,78,0,46), Color3.fromRGB(182,49,49), Color3.fromRGB(255,0,0))
NewBtn("Ichor", "Ichor+", UDim2.new(0,354,0,536), UDim2.new(0,92,0,44), Color3.fromRGB(173,126,0), Color3.fromRGB(255,210,0))
NewBtn("Autofarm", "Autofarm", UDim2.new(0,456,0,536), UDim2.new(0,112,0,44), Color3.fromRGB(138,137,0), Color3.fromRGB(255,234,0))
NewBtn("Automation", "Automation", UDim2.new(0,580,0,536), UDim2.new(0,110,0,44), Color3.fromRGB(23,151,0), Color3.fromRGB(43,255,0))
NewBtn("Credit", "Credit", UDim2.new(0,700,0,538), UDim2.new(0,94,0,42), Color3.fromRGB(36,75,140), Color3.fromRGB(41,106,255))
NewBtn("Custom", "Customisation", UDim2.new(0,262,0,596), UDim2.new(0,146,0,48), Color3.fromRGB(83,50,148), Color3.fromRGB(154,101,255))

print("✅ Blot’s Ichor Puddle Loaded - Better Version")
