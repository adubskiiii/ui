-- [[ THE ABYSS UI LIBRARY v2.0 ]] --
-- Made by CARTI
-- Enhanced with Mobile Support & Additional Components

local TheAbyss = {}
TheAbyss.__index = TheAbyss

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Theme = {
    Background = Color3.fromRGB(5, 5, 10),
    Card = Color3.fromRGB(15, 15, 22),
    AccentStart = Color3.fromRGB(80, 10, 100),
    AccentEnd = Color3.fromRGB(140, 30, 180),
    Text = Color3.fromRGB(240, 240, 255),
    TextDim = Color3.fromRGB(150, 150, 160),
    Success = Color3.fromRGB(46, 204, 113),
    Gold = Color3.fromRGB(255, 215, 0),
    BrightPurple = Color3.fromRGB(170, 50, 220),
    Error = Color3.fromRGB(231, 76, 60)
}

local VALID_KEY = "abysstx"
local DISCORD_INVITE = "https://discord.gg/Y5sd9xrbCp"

-- Helper Functions
local function Tween(obj, props, info)
    local t = TweenService:Create(obj, info or TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local function CopyToClipboard(text)
    if setclipboard then
        pcall(function() setclipboard(text) end)
    elseif toclipboard then
        pcall(function() toclipboard(text) end)
    elseif syn and syn.setclipboard then
        pcall(function() syn.setclipboard(text) end)
    end
end

local function OpenURL(url)
    pcall(function()
        if syn and syn.request then
            syn.request({ Url = url, Method = "GET" })
        elseif request then
            request({ Url = url, Method = "GET" })
        end
    end)
end

local function isMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled
end

function TheAbyss.new(title, subtitle)
    local self = setmetatable({}, TheAbyss)
    
    if CoreGui:FindFirstChild("TheAbyss") then 
        CoreGui.TheAbyss:Destroy() 
    end

    self.Gui = Instance.new("ScreenGui", CoreGui)
    self.Gui.Name = "TheAbyss"
    self.Gui.IgnoreGuiInset = true
    self.Gui.ResetOnSpawn = false
    self.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Key System Frame
    self.KeyFrame = Instance.new("Frame", self.Gui)
    self.KeyFrame.Size = UDim2.fromOffset(400, 320)
    self.KeyFrame.Position = UDim2.fromScale(0.5, 0.5)
    self.KeyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.KeyFrame.BackgroundColor3 = Theme.Background
    self.KeyFrame.ClipsDescendants = true
    self.KeyFrame.ZIndex = 10
    Instance.new("UICorner", self.KeyFrame).CornerRadius = UDim.new(0, 12)
    
    local KeyStroke = Instance.new("UIStroke", self.KeyFrame)
    KeyStroke.Color = Color3.fromRGB(40, 35, 50)
    KeyStroke.Thickness = 1.5
    
    local KeyTitle = Instance.new("TextLabel", self.KeyFrame)
    KeyTitle.Size = UDim2.new(1, 0, 0, 50)
    KeyTitle.Position = UDim2.new(0, 0, 0, 15)
    KeyTitle.BackgroundTransparency = 1
    KeyTitle.RichText = true
    KeyTitle.Text = string.format("%s<font color='rgb(140,30,180)'>%s</font>", string.upper(title), string.upper(subtitle))
    KeyTitle.Font = Enum.Font.GothamBlack
    KeyTitle.TextSize = 18
    KeyTitle.TextColor3 = Theme.Text
    KeyTitle.ZIndex = 10
    
    local KeySubtitle = Instance.new("TextLabel", self.KeyFrame)
    KeySubtitle.Size = UDim2.new(1, 0, 0, 25)
    KeySubtitle.Position = UDim2.new(0, 0, 0, 70)
    KeySubtitle.BackgroundTransparency = 1
    KeySubtitle.Text = "ENTER LICENSE KEY TO CONTINUE"
    KeySubtitle.TextColor3 = Theme.TextDim
    KeySubtitle.Font = Enum.Font.GothamBold
    KeySubtitle.TextSize = 12
    KeySubtitle.ZIndex = 10
    
    local KeyInput = Instance.new("TextBox", self.KeyFrame)
    KeyInput.Size = UDim2.new(0.8, 0, 0, 45)
    KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
    KeyInput.BackgroundColor3 = Theme.Card
    KeyInput.Text = ""
    KeyInput.PlaceholderText = "Enter key here..."
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.TextColor3 = Theme.Text
    KeyInput.TextSize = 14
    KeyInput.ClearTextOnFocus = false
    KeyInput.ZIndex = 10
    Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 8)
    
    local VerifyBtn = Instance.new("TextButton", self.KeyFrame)
    VerifyBtn.Size = UDim2.new(0.35, 0, 0, 40)
    VerifyBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
    VerifyBtn.BackgroundColor3 = Theme.AccentEnd
    VerifyBtn.Text = "VERIFY KEY"
    VerifyBtn.Font = Enum.Font.GothamBold
    VerifyBtn.TextColor3 = Theme.Text
    VerifyBtn.TextSize = 12
    VerifyBtn.ZIndex = 10
    Instance.new("UICorner", VerifyBtn).CornerRadius = UDim.new(0, 6)
    
    local GetKeyBtn = Instance.new("TextButton", self.KeyFrame)
    GetKeyBtn.Size = UDim2.new(0.35, 0, 0, 40)
    GetKeyBtn.Position = UDim2.new(0.55, 0, 0.6, 0)
    GetKeyBtn.BackgroundColor3 = Theme.Background
    GetKeyBtn.Text = "GET KEY"
    GetKeyBtn.Font = Enum.Font.GothamBold
    GetKeyBtn.TextColor3 = Theme.Text
    GetKeyBtn.TextSize = 12
    GetKeyBtn.ZIndex = 10
    Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", GetKeyBtn).Color = Theme.AccentEnd
    
    local StatusLabel = Instance.new("TextLabel", self.KeyFrame)
    StatusLabel.Size = UDim2.new(0.8, 0, 0, 30)
    StatusLabel.Position = UDim2.new(0.1, 0, 0.78, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = ""
    StatusLabel.TextColor3 = Theme.TextDim
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = 11
    StatusLabel.ZIndex = 10
    
    self.keyVerified = false
    self.OnVerified = nil
    
    VerifyBtn.MouseButton1Click:Connect(function()
        local enteredKey = string.lower(KeyInput.Text)
        
        if enteredKey == VALID_KEY then
            self.keyVerified = true
            StatusLabel.Text = "✓ Key Verified! Loading UI..."
            StatusLabel.TextColor3 = Theme.Success
            Tween(VerifyBtn, {BackgroundColor3 = Theme.Success})
            
            task.wait(0.5)
            self.KeyFrame.Visible = false
            
            if self.OnVerified then
                self.OnVerified()
            end
        else
            StatusLabel.Text = "✗ Invalid Key! Please try again."
            StatusLabel.TextColor3 = Theme.Error
            Tween(VerifyBtn, {BackgroundColor3 = Theme.Error})
            task.wait(0.3)
            Tween(VerifyBtn, {BackgroundColor3 = Theme.AccentEnd})
            KeyInput.Text = ""
        end
    end)
    
    GetKeyBtn.MouseButton1Click:Connect(function()
        CopyToClipboard(DISCORD_INVITE)
        OpenURL(DISCORD_INVITE)
        StatusLabel.Text = "✓ Discord link copied! Opening invite..."
        StatusLabel.TextColor3 = Theme.Success
        Tween(GetKeyBtn, {BackgroundColor3 = Theme.Success})
        task.wait(0.5)
        Tween(GetKeyBtn, {BackgroundColor3 = Theme.Background})
        task.wait(2)
        StatusLabel.Text = ""
    end)
    
    return self
end

function TheAbyss:OnKeyVerified(callback)
    self.OnVerified = callback
end

function TheAbyss:CreateUI()
    local isMobileDevice = isMobile()
    
    self.Main = Instance.new("Frame", self.Gui)
    self.Main.Size = isMobileDevice and UDim2.fromScale(0.95, 0.85) or UDim2.fromOffset(580, 480)
    self.Main.Position = UDim2.fromScale(0.5, 0.5)
    self.Main.AnchorPoint = Vector2.new(0.5, 0.5)
    self.Main.BackgroundColor3 = Theme.Background
    self.Main.ClipsDescendants = true
    self.Main.Visible = true
    self.Main.ZIndex = 5
    Instance.new("UICorner", self.Main).CornerRadius = UDim.new(0, 12)
    
    local MainStroke = Instance.new("UIStroke", self.Main)
    MainStroke.Color = Color3.fromRGB(40, 35, 50)
    MainStroke.Thickness = 1.5

    local TopBar = Instance.new("Frame", self.Main)
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    TopBar.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    TopBar.BorderSizePixel = 0
    TopBar.ZIndex = 6
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)
    
    local TopTitle = Instance.new("TextLabel", TopBar)
    TopTitle.Size = UDim2.new(1, -50, 1, 0)
    TopTitle.Position = UDim2.new(0, 15, 0, 0)
    TopTitle.BackgroundTransparency = 1
    TopTitle.Text = "THE ABYSS"
    TopTitle.Font = Enum.Font.GothamBlack
    TopTitle.TextSize = 14
    TopTitle.TextColor3 = Theme.Text
    TopTitle.TextXAlignment = Enum.TextXAlignment.Left
    TopTitle.ZIndex = 6

    self.Sidebar = Instance.new("Frame", self.Main)
    self.Sidebar.Size = UDim2.new(0, 160, 1, -35)
    self.Sidebar.Position = UDim2.new(0, 0, 0, 35)
    self.Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    self.Sidebar.BorderSizePixel = 0
    self.Sidebar.ZIndex = 5
    
    local SidebarCorner = Instance.new("UICorner", self.Sidebar)
    SidebarCorner.CornerRadius = UDim.new(0, 12)

    local Brand = Instance.new("TextLabel", self.Sidebar)
    Brand.Size = UDim2.new(1, -20, 0, 35)
    Brand.Position = UDim2.new(0, 15, 0, 10)
    Brand.BackgroundTransparency = 1
    Brand.Text = "THE ABYSS"
    Brand.Font = Enum.Font.GothamBlack
    Brand.TextSize = 16
    Brand.TextColor3 = Theme.Text
    Brand.TextXAlignment = Enum.TextXAlignment.Left
    Brand.ZIndex = 5

    local BrandCredit = Instance.new("TextLabel", self.Sidebar)
    BrandCredit.Size = UDim2.new(1, -20, 0, 18)
    BrandCredit.Position = UDim2.new(0, 15, 0, 45)
    BrandCredit.BackgroundTransparency = 1
    BrandCredit.Text = "Made by CARTI"
    BrandCredit.TextColor3 = Theme.BrightPurple
    BrandCredit.Font = Enum.Font.GothamBold
    BrandCredit.TextSize = 10
    BrandCredit.TextXAlignment = Enum.TextXAlignment.Left
    BrandCredit.ZIndex = 5
    
    local Separator = Instance.new("Frame", self.Sidebar)
    Separator.Size = UDim2.new(1, -30, 0, 1)
    Separator.Position = UDim2.new(0, 15, 0, 70)
    Separator.BackgroundColor3 = Color3.fromRGB(40, 35, 50)
    Separator.BorderSizePixel = 0
    Separator.ZIndex = 5

    self.TabHolder = Instance.new("Frame", self.Sidebar)
    self.TabHolder.Size = UDim2.new(1, -20, 0.6, 0)
    self.TabHolder.Position = UDim2.new(0, 10, 0, 85)
    self.TabHolder.BackgroundTransparency = 1
    self.TabHolder.ZIndex = 5
    
    local TabList = Instance.new("UIListLayout", self.TabHolder)
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 8)

    self.Content = Instance.new("Frame", self.Main)
    self.Content.Size = UDim2.new(1, -170, 1, -45)
    self.Content.Position = UDim2.new(0, 160, 0, 35)
    self.Content.BackgroundTransparency = 1
    self.Content.ZIndex = 5

    self.PageContainer = Instance.new("Frame", self.Content)
    self.PageContainer.Size = UDim2.new(1, -10, 1, -10)
    self.PageContainer.Position = UDim2.new(0, 5, 0, 10)
    self.PageContainer.BackgroundTransparency = 1
    self.PageContainer.ZIndex = 5

    local MinBtn = Instance.new("TextButton", TopBar)
    MinBtn.Size = UDim2.fromOffset(30, 30)
    MinBtn.Position = UDim2.new(1, -32, 0.5, -15)
    MinBtn.BackgroundTransparency = 1
    MinBtn.Text = "—"
    MinBtn.TextColor3 = Theme.TextDim
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 18
    MinBtn.ZIndex = 7

    self.MiniWidget = Instance.new("TextButton", self.Gui)
    self.MiniWidget.Name = "MiniWidget"
    self.MiniWidget.Size = UDim2.fromOffset(50, 50)
    self.MiniWidget.Position = UDim2.new(0.1, 0, 0.1, 0)
    self.MiniWidget.BackgroundColor3 = Theme.Background
    self.MiniWidget.Text = "AB"
    self.MiniWidget.Font = Enum.Font.GothamBlack
    self.MiniWidget.TextColor3 = Theme.AccentEnd
    self.MiniWidget.TextSize = 18
    self.MiniWidget.Visible = false
    self.MiniWidget.ZIndex = 10
    Instance.new("UICorner", self.MiniWidget).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", self.MiniWidget).Color = Theme.AccentEnd

    MinBtn.MouseButton1Click:Connect(function()
        self.Main.Visible = false
        self.MiniWidget.Visible = true
    end)

    self.MiniWidget.MouseButton1Click:Connect(function()
        self.MiniWidget.Visible = false
        self.Main.Visible = true
    end)

    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.Main.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            self.Main.Position = UDim2.new(
                startPos.X.Scale, 
                math.clamp(startPos.X.Offset + delta.X, -self.Main.AbsoluteSize.X/2, self.Gui.AbsoluteSize.X - self.Main.AbsoluteSize.X/2),
                startPos.Y.Scale, 
                math.clamp(startPos.Y.Offset + delta.Y, 0, self.Gui.AbsoluteSize.Y - self.Main.AbsoluteSize.Y/2)
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    local miniDragging = false
    local miniDragStart = nil
    local miniStartPos = nil
    
    self.MiniWidget.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            miniDragging = true
            miniDragStart = input.Position
            miniStartPos = self.MiniWidget.Position
        end
    end)
    
    self.MiniWidget.InputChanged:Connect(function(input)
        if miniDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - miniDragStart
            self.MiniWidget.Position = UDim2.new(
                miniStartPos.X.Scale,
                math.clamp(miniStartPos.X.Offset + delta.X, 0, self.Gui.AbsoluteSize.X - 50),
                miniStartPos.Y.Scale,
                math.clamp(miniStartPos.Y.Offset + delta.Y, 0, self.Gui.AbsoluteSize.Y - 50)
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            miniDragging = false
        end
    end)

    self.Pages = {}
    self.CurrentTab = nil
    self.nextYPosition = {} -- Track next Y position for each card
end

function TheAbyss:CreateTab(name)
    if not self.Main then return nil end
    
    local Page = Instance.new("ScrollingFrame", self.PageContainer)
    Page.Size = UDim2.fromScale(1, 1)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Theme.AccentEnd
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.ZIndex = 5
    Page.ScrollingDirection = Enum.ScrollingDirection.Y
    Page.ElasticBehavior = Enum.ElasticBehavior.Never
    
    local Layout = Instance.new("UIListLayout", Page)
    Layout.Padding = UDim.new(0, 12)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local Pad = Instance.new("UIPadding", Page)
    Pad.PaddingTop = UDim.new(0, 2)
    Pad.PaddingLeft = UDim.new(0, 2)
    Pad.PaddingRight = UDim.new(0, 5)
    
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.fromOffset(0, Layout.AbsoluteContentSize.Y + 10)
    end)

    local TabBtn = Instance.new("TextButton", self.TabHolder)
    TabBtn.Size = UDim2.new(1, 0, 0, 38)
    TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    TabBtn.Text = "  " .. name
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextColor3 = Theme.TextDim
    TabBtn.TextSize = 12
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.ZIndex = 5
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)
    
    local Indicator = Instance.new("Frame", TabBtn)
    Indicator.Size = UDim2.new(0, 3, 0.6, 0)
    Indicator.Position = UDim2.new(0, 0, 0.2, 0)
    Indicator.BackgroundColor3 = Theme.AccentEnd
    Indicator.BackgroundTransparency = 1
    Indicator.ZIndex = 5
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(self.PageContainer:GetChildren()) do 
            if p:IsA("ScrollingFrame") then 
                p.Visible = false 
            end
        end
        for _, t in pairs(self.TabHolder:GetChildren()) do
            if t:IsA("TextButton") then 
                Tween(t, {BackgroundColor3 = Color3.fromRGB(20, 20, 28), TextColor3 = Theme.TextDim})
                if t:FindFirstChild("Frame") then
                    Tween(t.Frame, {BackgroundTransparency = 1})
                end
            end
        end
        Page.Visible = true
        Tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(30, 30, 40), TextColor3 = Theme.Text})
        Tween(Indicator, {BackgroundTransparency = 0})
    end)

    if not self.CurrentTab then
        Page.Visible = true
        TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        TabBtn.TextColor3 = Theme.Text
        Indicator.BackgroundTransparency = 0
        self.CurrentTab = TabBtn
    end

    self.Pages[name] = Page
    return Page
end

function TheAbyss:CreateCard(page, titleText, descText)
    if not page then return nil end
    
    local cardHeight = 55 -- Base height for title
    if descText then cardHeight = cardHeight + 18 end -- Add room for description
    
    local Card = Instance.new("Frame", page)
    Card.Size = UDim2.new(1, 0, 0, cardHeight)
    Card.BackgroundColor3 = Theme.Card
    Card.ZIndex = 5
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", Card).Color = Color3.fromRGB(30, 30, 42)
    Instance.new("UIStroke", Card).Thickness = 1
    
    local Title = Instance.new("TextLabel", Card)
    Title.Position = UDim2.new(0, 15, 0, 10)
    Title.Size = UDim2.new(1, -30, 0, 22)
    Title.BackgroundTransparency = 1
    Title.Text = titleText
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Theme.Text
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 5
    
    if descText then
        local Desc = Instance.new("TextLabel", Card)
        Desc.Position = UDim2.new(0, 15, 0, 32)
        Desc.Size = UDim2.new(1, -30, 0, 18)
        Desc.BackgroundTransparency = 1
        Desc.Text = descText
        Desc.Font = Enum.Font.Gotham
        Desc.TextColor3 = Theme.TextDim
        Desc.TextSize = 11
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.ZIndex = 5
    end
    
    -- Store card for tracking elements
    Card.ElementCount = 0
    
    return Card
end

function TheAbyss:CreateButton(card, buttonText, callback)
    if not card then return nil end
    
    card.ElementCount = (card.ElementCount or 0) + 1
    local yOffset = 52 + ((card.ElementCount - 1) * 40)
    
    -- Expand card to fit
    card.Size = UDim2.new(1, 0, 0, yOffset + 40)
    
    local Button = Instance.new("TextButton", card)
    Button.Size = UDim2.new(1, -30, 0, 34)
    Button.Position = UDim2.new(0, 15, 0, yOffset)
    Button.BackgroundColor3 = Theme.AccentEnd
    Button.Text = buttonText
    Button.Font = Enum.Font.GothamBold
    Button.TextColor3 = Theme.Text
    Button.TextSize = 12
    Button.ZIndex = 6
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)
    
    Button.MouseEnter:Connect(function()
        Tween(Button, {BackgroundColor3 = Theme.BrightPurple})
    end)
    
    Button.MouseLeave:Connect(function()
        Tween(Button, {BackgroundColor3 = Theme.AccentEnd})
    end)
    
    Button.MouseButton1Click:Connect(function()
        Tween(Button, {BackgroundColor3 = Theme.Success})
        task.delay(0.2, function()
            Tween(Button, {BackgroundColor3 = Theme.AccentEnd})
        end)
        if callback then callback() end
    end)
    
    return Button
end

function TheAbyss:CreateToggle(card, toggleText, callback)
    if not card then return nil end
    
    card.ElementCount = (card.ElementCount or 0) + 1
    local yOffset = 52 + ((card.ElementCount - 1) * 40)
    
    -- Expand card to fit
    card.Size = UDim2.new(1, 0, 0, yOffset + 40)
    
    local ToggleFrame = Instance.new("Frame", card)
    ToggleFrame.Size = UDim2.new(1, -30, 0, 34)
    ToggleFrame.Position = UDim2.new(0, 15, 0, yOffset)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.ZIndex = 6
    
    local Label = Instance.new("TextLabel", ToggleFrame)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = toggleText
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Theme.Text
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 6
    
    local ToggleButton = Instance.new("Frame", ToggleFrame)
    ToggleButton.Size = UDim2.new(0, 44, 0, 24)
    ToggleButton.Position = UDim2.new(1, -44, 0.5, -12)
    ToggleButton.BackgroundColor3 = Theme.Background
    ToggleButton.ZIndex = 6
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", ToggleButton).Color = Color3.fromRGB(50, 50, 60)
    
    local ToggleKnob = Instance.new("Frame", ToggleButton)
    ToggleKnob.Size = UDim2.new(0, 18, 0, 18)
    ToggleKnob.Position = UDim2.new(0, 3, 0.5, -9)
    ToggleKnob.BackgroundColor3 = Theme.TextDim
    ToggleKnob.ZIndex = 7
    Instance.new("UICorner", ToggleKnob).CornerRadius = UDim.new(1, 0)
    
    local active = false
    
    local function updateToggle()
        if active then
            Tween(ToggleButton, {BackgroundColor3 = Theme.AccentEnd})
            Tween(ToggleKnob, {BackgroundColor3 = Theme.Text, Position = UDim2.new(0, 23, 0.5, -9)})
        else
            Tween(ToggleButton, {BackgroundColor3 = Theme.Background})
            Tween(ToggleKnob, {BackgroundColor3 = Theme.TextDim, Position = UDim2.new(0, 3, 0.5, -9)})
        end
    end
    
    ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            active = not active
            updateToggle()
            if callback then callback(active) end
        end
    end)
    
    return ToggleFrame
end

function TheAbyss:CreateSlider(card, sliderText, min, max, default, callback)
    if not card then return nil end
    
    card.ElementCount = (card.ElementCount or 0) + 1
    local yOffset = 52 + ((card.ElementCount - 1) * 40)
    
    -- Expand card to fit
    card.Size = UDim2.new(1, 0, 0, yOffset + 40)
    
    local SliderFrame = Instance.new("Frame", card)
    SliderFrame.Size = UDim2.new(1, -30, 0, 34)
    SliderFrame.Position = UDim2.new(0, 15, 0, yOffset)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.ZIndex = 6
    
    local Label = Instance.new("TextLabel", SliderFrame)
    Label.Size = UDim2.new(0.7, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = sliderText
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Theme.Text
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 6
    
    local ValueLabel = Instance.new("TextLabel", SliderFrame)
    ValueLabel.Size = UDim2.new(0, 45, 0, 20)
    ValueLabel.Position = UDim2.new(1, -45, 0, 0)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default or min)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextColor3 = Theme.AccentEnd
    ValueLabel.TextSize = 11
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.ZIndex = 6
    
    local SliderBar = Instance.new("Frame", SliderFrame)
    SliderBar.Size = UDim2.new(1, 0, 0, 6)
    SliderBar.Position = UDim2.new(0, 0, 1, -14)
    SliderBar.BackgroundColor3 = Theme.Background
    SliderBar.ZIndex = 6
    Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(1, 0)
    
    local SliderFill = Instance.new("Frame", SliderBar)
    local range = max - min
    local percent = ((default or min) - min) / range
    SliderFill.Size = UDim2.fromScale(percent, 1)
    SliderFill.BackgroundColor3 = Theme.AccentEnd
    SliderFill.ZIndex = 7
    Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)
    
    local SliderKnob = Instance.new("Frame", SliderBar)
    SliderKnob.Size = UDim2.fromOffset(14, 14)
    SliderKnob.Position = UDim2.new(percent, -7, 0.5, -7)
    SliderKnob.BackgroundColor3 = Theme.Text
    SliderKnob.ZIndex = 8
    Instance.new("UICorner", SliderKnob).CornerRadius = UDim.new(1, 0)
    
    local dragging = false
    
    local function updateSlider(input)
        local barPos = SliderBar.AbsolutePosition.X
        local barSize = SliderBar.AbsoluteSize.X
        local mouseX = math.clamp(input.Position.X - barPos, 0, barSize)
        local percent = mouseX / barSize
        local value = math.floor(min + (range * percent))
        
        SliderFill.Size = UDim2.fromScale(percent, 1)
        SliderKnob.Position = UDim2.new(percent, -7, 0.5, -7)
        ValueLabel.Text = tostring(value)
        
        if callback then callback(value) end
    end
    
    SliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    
    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            updateSlider(input)
            dragging = true
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    if default then
        updateSlider({Position = Vector2.new(SliderBar.AbsolutePosition.X + (percent * SliderBar.AbsoluteSize.X), 0)})
    end
    
    return SliderFrame
end

function TheAbyss:CreateDropdown(card, dropdownText, options, callback)
    if not card then return nil end
    
    card.ElementCount = (card.ElementCount or 0) + 1
    local yOffset = 52 + ((card.ElementCount - 1) * 40)
    
    -- Expand card to fit
    card.Size = UDim2.new(1, 0, 0, yOffset + 40)
    
    local DropdownFrame = Instance.new("Frame", card)
    DropdownFrame.Size = UDim2.new(1, -30, 0, 34)
    DropdownFrame.Position = UDim2.new(0, 15, 0, yOffset)
    DropdownFrame.BackgroundColor3 = Theme.Card
    DropdownFrame.ClipsDescendants = true
    DropdownFrame.ZIndex = 10
    Instance.new("UICorner", DropdownFrame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", DropdownFrame).Color = Color3.fromRGB(40, 40, 50)
    
    local DropdownButton = Instance.new("TextButton", DropdownFrame)
    DropdownButton.Size = UDim2.new(1, 0, 1, 0)
    DropdownButton.BackgroundTransparency = 1
    DropdownButton.Text = "  " .. dropdownText .. ": " .. (options[1] or "Select")
    DropdownButton.Font = Enum.Font.Gotham
    DropdownButton.TextColor3 = Theme.Text
    DropdownButton.TextSize = 12
    DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    DropdownButton.ZIndex = 10
    
    local Arrow = Instance.new("TextLabel", DropdownButton)
    Arrow.Size = UDim2.new(0, 20, 1, 0)
    Arrow.Position = UDim2.new(1, -25, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextColor3 = Theme.TextDim
    Arrow.TextSize = 10
    Arrow.ZIndex = 10
    
    local OptionList = Instance.new("Frame", DropdownFrame)
    OptionList.Size = UDim2.new(1, 0, 0, 0)
    OptionList.Position = UDim2.new(0, 0, 1, 2)
    OptionList.BackgroundColor3 = Theme.Card
    OptionList.ClipsDescendants = true
    OptionList.ZIndex = 15
    Instance.new("UICorner", OptionList).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", OptionList).Color = Color3.fromRGB(40, 40, 50)
    
    local ListLayout = Instance.new("UIListLayout", OptionList)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 1)
    
    local isOpen = false
    
    local function toggleDropdown()
        isOpen = not isOpen
        
        if isOpen then
            local optionHeight = math.min(#options * 34, 170)
            OptionList.Size = UDim2.new(1, 0, 0, optionHeight)
            DropdownFrame.Size = UDim2.new(1, -30, 0, 34 + optionHeight + 2)
            Arrow.Rotation = 180
        else
            OptionList.Size = UDim2.new(1, 0, 0, 0)
            DropdownFrame.Size = UDim2.new(1, -30, 0, 34)
            Arrow.Rotation = 0
        end
    end
    
    DropdownButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            toggleDropdown()
        end
    end)
    
    for i, option in ipairs(options) do
        local OptionButton = Instance.new("TextButton", OptionList)
        OptionButton.Size = UDim2.new(1, 0, 0, 34)
        OptionButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        OptionButton.Text = "  " .. option
        OptionButton.Font = Enum.Font.Gotham
        OptionButton.TextColor3 = Theme.TextDim
        OptionButton.TextSize = 12
        OptionButton.TextXAlignment = Enum.TextXAlignment.Left
        OptionButton.ZIndex = 15
        Instance.new("UICorner", OptionButton).CornerRadius = UDim.new(0, 4)
        
        OptionButton.MouseEnter:Connect(function()
            Tween(OptionButton, {BackgroundColor3 = Theme.AccentEnd})
            Tween(OptionButton, {TextColor3 = Theme.Text})
        end)
        
        OptionButton.MouseLeave:Connect(function()
            Tween(OptionButton, {BackgroundColor3 = Color3.fromRGB(25, 25, 35)})
            Tween(OptionButton, {TextColor3 = Theme.TextDim})
        end)
        
        OptionButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                DropdownButton.Text = "  " .. dropdownText .. ": " .. option
                toggleDropdown()
                if callback then callback(option) end
            end
        end)
    end
    
    return DropdownFrame
end

function TheAbyss:CreateInputBox(card, placeholderText, callback)
    if not card then return nil end
    
    card.ElementCount = (card.ElementCount or 0) + 1
    local yOffset = 52 + ((card.ElementCount - 1) * 40)
    
    -- Expand card to fit
    card.Size = UDim2.new(1, 0, 0, yOffset + 40)
    
    local InputFrame = Instance.new("Frame", card)
    InputFrame.Size = UDim2.new(1, -30, 0, 34)
    InputFrame.Position = UDim2.new(0, 15, 0, yOffset)
    InputFrame.BackgroundColor3 = Theme.Card
    InputFrame.ZIndex = 6
    Instance.new("UICorner", InputFrame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", InputFrame).Color = Color3.fromRGB(40, 40, 50)
    
    local Input = Instance.new("TextBox", InputFrame)
    Input.Size = UDim2.new(1, -40, 1, 0)
    Input.Position = UDim2.new(0, 12, 0, 0)
    Input.BackgroundTransparency = 1
    Input.PlaceholderText = placeholderText or "Enter text..."
    Input.Text = ""
    Input.Font = Enum.Font.Gotham
    Input.TextColor3 = Theme.Text
    Input.PlaceholderColor3 = Theme.TextDim
    Input.TextSize = 12
    Input.ClearTextOnFocus = false
    Input.ZIndex = 7
    
    local SubmitButton = Instance.new("TextButton", InputFrame)
    SubmitButton.Size = UDim2.new(0, 28, 0, 28)
    SubmitButton.Position = UDim2.new(1, -32, 0.5, -14)
    SubmitButton.BackgroundColor3 = Theme.AccentEnd
    SubmitButton.Text = "→"
    SubmitButton.Font = Enum.Font.GothamBold
    SubmitButton.TextColor3 = Theme.Text
    SubmitButton.TextSize = 14
    SubmitButton.ZIndex = 7
    Instance.new("UICorner", SubmitButton).CornerRadius = UDim.new(0, 4)
    
    SubmitButton.MouseEnter:Connect(function()
        Tween(SubmitButton, {BackgroundColor3 = Theme.BrightPurple})
    end)
    
    SubmitButton.MouseLeave:Connect(function()
        Tween(SubmitButton, {BackgroundColor3 = Theme.AccentEnd})
    end)
    
    SubmitButton.MouseButton1Click:Connect(function()
        if callback and Input.Text ~= "" then
            callback(Input.Text)
            Input.Text = ""
        end
    end)
    
    Input.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback and Input.Text ~= "" then
            callback(Input.Text)
            Input.Text = ""
        end
    end)
    
    return InputFrame
end

return TheAbyss
