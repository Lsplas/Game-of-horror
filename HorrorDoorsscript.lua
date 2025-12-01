-- Script for a horror door in Roblox

local door = script.Parent
local jumpScareChance = 0.2 -- 20% chance to scare
local scareSoundId = "rbxassetid://912319043" -- You can change to any scary audio asset
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Create a ScarySound if it doesn't exist
if not door:FindFirstChild("ScarySound") then
    local sound = Instance.new("Sound")
    sound.Name = "ScarySound"
    sound.SoundId = scareSoundId
    sound.Volume = 1
    sound.Parent = door
end

-- Create an event to flash the player's screen
if not replicatedStorage:FindFirstChild("FlashEvent") then
    local remoteEvent = Instance.new("RemoteEvent")
    remoteEvent.Name = "FlashEvent"
    remoteEvent.Parent = replicatedStorage
end

local function flashPlayer(player)
    replicatedStorage.FlashEvent:FireClient(player)
end

local function onClicked(player)
    -- Open the door
    door.CanCollide = false
    door.Transparency = 0.5

    -- Determine if jumpscare occurs
    if math.random() < jumpScareChance then
        -- Play scary sound
        door.ScarySound:Play()
        -- Flash screen for this player
        flashPlayer(player)
    end

    wait(2)
    door.CanCollide = true
    door.Transparency = 0
end

-- Make sure door has ClickDetector
local clickDetector = door:FindFirstChildOfClass("ClickDetector")
if clickDetector then
    clickDetector.MouseClick:Connect(onClicked)
else
    warn("Add a ClickDetector to the door!")
end
