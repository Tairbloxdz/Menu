-- Tạo GUI
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "DynamicButtonMenu"

-- Nút bật/tắt menu
local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.05, 0, 0.1, 0)
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "rbxassetid://96693216224872" -- Thay bằng ID hình ảnh của bạn

-- Hiệu ứng động cho button
local buttonTweening = false
toggleButton.MouseEnter:Connect(function()
    if not buttonTweening then
        buttonTweening = true
        toggleButton:TweenSize(
            UDim2.new(0, 60, 0, 60), -- Phóng to khi hover
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true,
            function()
                buttonTweening = false
            end
        )
    end
end)

toggleButton.MouseLeave:Connect(function()
    if not buttonTweening then
        buttonTweening = true
        toggleButton:TweenSize(
            UDim2.new(0, 50, 0, 50), -- Thu nhỏ lại
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true,
            function()
                buttonTweening = false
            end
        )
    end
end)

-- Khung chính của menu
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0.3, 0, 0.4, 0)
mainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 60, 120) -- Xanh biển đậm
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Visible = false

-- Hiệu ứng góc bo cho menu
local uiCorner = Instance.new("UICorner", mainFrame)
uiCorner.CornerRadius = UDim.new(0, 15)

-- Gradient nền cho menu
local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 80, 160)), -- Xanh biển sáng
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 60, 120))  -- Xanh biển đậm
})
gradient.Rotation = 45

-- Tiêu đề menu
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 90, 150)
title.Text = "Dynamic Button Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.BorderSizePixel = 0

-- Hiệu ứng góc bo cho tiêu đề
local titleCorner = Instance.new("UICorner", title)
titleCorner.CornerRadius = UDim.new(0, 15)

-- Danh sách các nút
local buttons = {
    {name = "Option 1", position = UDim2.new(0.1, 0, 0.25, 0)},
    {name = "Option 2", position = UDim2.new(0.1, 0, 0.45, 0)},
    {name = "Option 3", position = UDim2.new(0.1, 0, 0.65, 0)}
}

-- Tạo nút trong menu
local function createButton(info)
    local button = Instance.new("TextButton", mainFrame)
    button.Name = info.name
    button.Size = UDim2.new(0.8, 0, 0.15, 0)
    button.Position = info.position
    button.BackgroundColor3 = Color3.fromRGB(50, 100, 180)
    button.Text = info.name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.Gotham
    button.BorderSizePixel = 0

    -- Hiệu ứng góc bo cho nút
    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 8)

    -- Hiệu ứng hover
    button.MouseEnter:Connect(function()
        button:TweenSize(
            UDim2.new(0.85, 0, 0.17, 0), -- Phóng to khi hover
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )
        button.BackgroundColor3 = Color3.fromRGB(70, 130, 200) -- Màu sáng hơn
    end)
    button.MouseLeave:Connect(function()
        button:TweenSize(
            UDim2.new(0.8, 0, 0.15, 0), -- Thu nhỏ lại
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.2,
            true
        )
        button.BackgroundColor3 = Color3.fromRGB(50, 100, 180) -- Màu ban đầu
    end)
end

-- Tạo các nút
for _, btnInfo in ipairs(buttons) do
    createButton(btnInfo)
end

-- Hiệu ứng mở/đóng menu
local function toggleMenu()
    if mainFrame.Visible then
        -- Hiệu ứng đóng menu
        mainFrame:TweenPosition(
            UDim2.new(0.35, 0, -0.5, 0), -- Trượt lên trên để đóng
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.5,
            true,
            function()
                mainFrame.Visible = false -- Ẩn menu sau khi đóng
            end
        )
    else
        -- Hiệu ứng mở menu
        mainFrame.Visible = true
        mainFrame.Position = UDim2.new(0.35, 0, -0.5, 0) -- Vị trí ban đầu khi chưa trượt
        mainFrame:TweenPosition(
            UDim2.new(0.35, 0, 0.3, 0), -- Trượt xuống để mở
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.5,
            true
        )
    end
end

-- Kết nối sự kiện bật/tắt menu
toggleButton.MouseButton1Click:Connect(toggleMenu)