local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local SetTechnique = ReplicatedStorage:WaitForChild("SetTechnique")
local SetRace = ReplicatedStorage:WaitForChild("SetRace")
local SetClan = ReplicatedStorage:WaitForChild("SetClan")
local information = ReplicatedStorage:WaitForChild("RemoteEvent"):WaitForChild("information")

local auraRunning = false
local auraCoroutine
local crashRunning = false
local crashCoroutine
local serverCrasherV2Running = false
local serverCrasherV2Coroutine

local Window = Rayfield:CreateWindow({
    Name = "JJ Legacy V1",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Made By Starman999_",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "JJLegacyV1Config"
    },
    KeySystem = false,
    Theme = "AmberGlow"
})

local UsefulTab = Window:CreateTab("Useful")
local FarmingTab = Window:CreateTab("Farming")

UsefulTab:CreateParagraph({
    Title = "",
    Content = "spinnable stuff only :("
})

local techniqueValue = ""
UsefulTab:CreateInput({
    Name = "Technique",
    CurrentValue = "",
    PlaceholderText = "Type technique",
    RemoveTextAfterFocusLost = false,
    Callback = function(text) techniqueValue = text end,
})

UsefulTab:CreateButton({
    Name = "Set Technique",
    Callback = function()
        if techniqueValue ~= "" then
            SetTechnique:FireServer("Boogie Woogie", techniqueValue, 1, 0.001)
        end
    end,
})

local raceValue = ""
UsefulTab:CreateInput({
    Name = "Race",
    CurrentValue = "",
    PlaceholderText = "Type race",
    RemoveTextAfterFocusLost = false,
    Callback = function(text) raceValue = text end,
})

UsefulTab:CreateButton({
    Name = "Set Race",
    Callback = function()
        if raceValue ~= "" then
            SetRace:FireServer("None", raceValue, 1, 0.1)
        end
    end,
})

local clanValue = ""
UsefulTab:CreateInput({
    Name = "Clan",
    CurrentValue = "",
    PlaceholderText = "Type clan",
    RemoveTextAfterFocusLost = false,
    Callback = function(text) clanValue = text end,
})

UsefulTab:CreateButton({
    Name = "Set Clan",
    Callback = function()
        if clanValue ~= "" then
            SetClan:FireServer("None", clanValue, 1, 0.1)
        end
    end,
})

FarmingTab:CreateButton({
    Name = "Toggle Aura",
    Callback = function()
        auraRunning = not auraRunning
        if auraRunning then
            if not auraCoroutine or coroutine.status(auraCoroutine) == "dead" then
                auraCoroutine = coroutine.create(function()
                    while auraRunning do
                        information:FireServer("TojiNormal", "UseV")
                        task.wait(0.1)
                    end
                end)
                coroutine.resume(auraCoroutine)
            end
        end
    end,
})

FarmingTab:CreateButton({
    Name = "Toggle Server Crasher",
    Callback = function()
        crashRunning = not crashRunning
        if crashRunning then
            if not crashCoroutine or coroutine.status(crashCoroutine) == "dead" then
                crashCoroutine = coroutine.create(function()
                    while crashRunning do
                        information:FireServer("Gojo", "UseV")
                        task.wait(0.1)
                    end
                end)
                coroutine.resume(crashCoroutine)
            end
        end
    end,
})

FarmingTab:CreateButton({
    Name = "Domain Spam",
    Callback = function()
        serverCrasherV2Running = not serverCrasherV2Running
        if serverCrasherV2Running then
            if not serverCrasherV2Coroutine or coroutine.status(serverCrasherV2Coroutine) == "dead" then
                serverCrasherV2Coroutine = coroutine.create(function()
                    while serverCrasherV2Running do
                        information:FireServer("HeianSukunaNew", "UseG")
                        task.wait(0.1)
                    end
                end)
                coroutine.resume(serverCrasherV2Coroutine)
            end
        end
    end,
})
