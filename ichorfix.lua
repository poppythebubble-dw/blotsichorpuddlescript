-- Blot’s Ichor Puddle | Clean Delta Version
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")

local plr = Players.LocalPlayer
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
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
Instance.new("UIStroke", title).Thickness = 3

-- Button Function
local function CreateBtn(name, text, pos, size, col1, col2)
    local btn = Instance.new("TextButton", gui)
    btn.Name = name
    btn.Size = size
    btn.Position = pos
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 24
    btn.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json")
    Instance.new("UICorner", btn)
    local grad = Instance.new("UIGradient", btn)
    grad.Rotation = 270
    grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, col1), ColorSequenceKeypoint.new(1, col2)}
    Instance.new("UIStroke", btn).Thickness = 8
    return btn
end

-- Buttons
local btnESP = CreateBtn("ESP", "ESP", UDim2.new(0, 266, 0, 124), UDim2.new(0, 142, 0, 76), Color3.fromRGB(63,63,63), Color3.fromRGB(149,149,149))
btnESP.TextSize = 36

local btnFB = CreateBtn("FullBright", "FullBright", UDim2.new(0, 420, 0, 124), UDim2.new(0, 146, 0, 76), Color3.fromRGB(64,64,64), Color3.fromRGB(150,150,150))

local btnCalib = CreateBtn("AutoCalib", "Auto Calibration", UDim2.new(0, 264, 0, 220), UDim2.new(0, 146, 0, 60), Color3.fromRGB(64,64,64), Color3.fromRGB(150,150,150))

-- Click Sound
local function PlayClick()
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://552900451"
    s.Parent = gui
    s:Play()
    task.delay(1, function() s:Destroy() end)
end

-- FullBright
local fbToggle = false
btnFB.MouseButton1Click:Connect(function()
    PlayClick()
    fbToggle = not fbToggle
    if fbToggle then
        Lighting.Brightness = 4
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.new(1,1,1)
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = true
        Lighting.Ambient = Color3.new(0.5,0.5,0.5)
    end
end)

-- Auto Calibration
local calibActive = false
local calibConn = nil

btnCalib.MouseButton1Click:Connect(function()
    PlayClick()
    calibActive = not calibActive
    btnCalib.Text = calibActive and "Auto Calibration [ON]" or "Auto Calibration [OFF]"
    
    if calibActive then
        calibConn = RunService.Heartbeat:Connect(function()
            if not calibActive then return end
            for _, v in pairs(plr.PlayerGui:GetDescendants()) do
                if v:IsA("GuiObject") and v.Visible and v.AbsoluteSize.X > 80 then
                    local needle = nil
                    for _, child in pairs(v:GetChildren()) do
                        if child:IsA("GuiObject") and child.AbsoluteSize.X <= 15 and child.AbsoluteSize.Y > 10 then
                            needle = child
                            break
                        end
                    end
                    if needle then
                        local needleX = needle.AbsolutePosition.X
                        if needleX > v.AbsolutePosition.X + 50 and needleX < v.AbsolutePosition.X + v.AbsoluteSize.X - 50 then
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                            task.wait(0.05)
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                            task.wait(0.6)
                            break
                        end
                    end
                end
            end
        end)
    else
        if calibConn then calibConn:Disconnect() end
    end
end)

-- Drag GUI
local dragging, dragInput, dragStart, startPos
local dragBtn = Instance.new("ImageButton", gui)
dragBtn.Size = UDim2.new(0,74,0,72)
dragBtn.Position = UDim2.new(0,912,0,226)
dragBtn.Image = "rbxassetid://80216561917612"
dragBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
Instance.new("UICorner", dragBtn)
Instance.new("UIStroke", dragBtn).Thickness = 8

dragBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

dragBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

print("✅ Blot’s Ichor Puddle Loaded Successfully!")
