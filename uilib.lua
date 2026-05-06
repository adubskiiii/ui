-- Load The Abyss UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/adubskiiii/ui/main/uilib.lua"))()

-- Get Player and Character
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Store original walkspeed
local originalWalkSpeed = humanoid.WalkSpeed

-- Create the UI
local Window = Library.new("WALKSPEED", "CONTROLLER")

Window:OnKeyVerified(function()
    Window:CreateUI()
    
    -- Create Main Tab
    local MainTab = Window:CreateTab("Main")
    
    -- Create Card for Walkspeed
    local SpeedCard = Window:CreateCard(MainTab, "WALKSPEED", "Adjust your movement speed")
    
    -- Create Walkspeed Slider
    local sliderValue = 16
    local toggleEnabled = false
    
    Window:CreateSlider(SpeedCard, "Speed", 16, 500, 16, function(value)
        sliderValue = value
        if toggleEnabled and humanoid then
            humanoid.WalkSpeed = value
        end
    end)
    
    -- Create Toggle to enable/disable walkspeed
    Window:CreateToggle(SpeedCard, "Enable Speed", function(state)
        toggleEnabled = state
        
        if humanoid then
            if state then
                humanoid.WalkSpeed = sliderValue
            else
                humanoid.WalkSpeed = originalWalkSpeed
            end
        end
    end)
    
    -- Handle character respawn
    player.CharacterAdded:Connect(function(newCharacter)
        character = newCharacter
        humanoid = newCharacter:WaitForChild("Humanoid")
        originalWalkSpeed = humanoid.WalkSpeed
        
        if toggleEnabled then
            humanoid.WalkSpeed = sliderValue
        end
    end)
end)
