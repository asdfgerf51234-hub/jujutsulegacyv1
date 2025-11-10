local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Jujutsu Legacy",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

local Tab = Window:CreateTab("Main")

Tab:CreateParagraph({
    Title = "Outdated Version",
    Content = "This script is outdated. Join the Discord server for the updated version."
})

Tab:CreateButton({
    Name = "Join Discord",
    Callback = function()
        setclipboard("https://discord.gg/HmTWR2gBpe")
        Rayfield:Notify({
            Title = "Copied!",
            Content = "Discord invite copied to clipboard.",
            Duration = 3
        })
    end
})
