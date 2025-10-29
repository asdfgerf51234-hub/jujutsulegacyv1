local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local SetTechnique = ReplicatedStorage:WaitForChild("SetTechnique")
local SetRace = ReplicatedStorage:WaitForChild("SetRace")
local SetClan = ReplicatedStorage:WaitForChild("SetClan")
local information = ReplicatedStorage:WaitForChild("RemoteEvent"):WaitForChild("information")

local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer
local Stats = lp:WaitForChild("Stats")
local level = Stats:WaitForChild("Level")

local farmActive = false
local auraRunning = false
local crashRunning = false
local serverCrasherV2Running = false
local chamsEnabled = false

local farmingThread
local auraCoroutine
local crashCoroutine
local serverCrasherV2Coroutine

local QuestData = {
    { name = "gojo", level = 1, cf = CFrame.new(-3988.375, 1190.24219, -3920.59131) },
    { name = "megumi", level = 10, cf = CFrame.new(-4052.21851, 1189.74365, -4334.3042) },
    { name = "megumi", level = 25, cf = CFrame.new(-4049.20532, 1190.05176, -4402.9458) },
    { name = "gojo", level = 50, cf = CFrame.new(-3990.72754, 1189.93921, -4419.74805) },
    { name = "sukuna", level = 75, cf = CFrame.new(-3681.0249, 1189.6698, -4423.59814) },
    { name = "gojo", level = 125, cf = CFrame.new(-1263.37061, 1188.24268, -4632.24512) },
    { name = "gojo", level = 150, cf = CFrame.new(-1326.88855, 1188.18677, -3771.10596) },
    { name = "gojo", level = 175, cf = CFrame.new(-813.92749, 1188.54907, -4563.81055) },
    { name = "gojo", level = 200, cf = CFrame.new(-1055.32996, 1188.43408, -4262.25684) },
    { name = "gojo", level = 250, cf = CFrame.new(-328.684204, 1188.2323, -3926.08643) },
    { name = "gojo", level = 300, cf = CFrame.new(199.716797, 1072.23804, -2340.7644) },
    { name = "gojo", level = 350, cf = CFrame.new(-50.5863037, 1072.14868, -2298.58447) },
    { name = "gojo", level = 400, cf = CFrame.new(556.568665, 1111.84302, -1979.19897) },
    { name = "gojo", level = 450, cf = CFrame.new(556.421204, 1111.98486, -1853.63611) },
    { name = "gojo", level = 500, cf = CFrame.new(-11310.4688, -265.822754, 1493.49414) },
    { name = "gojo", level = 550, cf = CFrame.new(-11480.335, -266.28653, 1233.84778) },
    { name = "gojo", level = 600, cf = CFrame.new(-11604.0527, -266.126404, 1671.75269) },
    { name = "gojo", level = 650, cf = CFrame.new(-12210.4062, -265.760742, 1395.9043) },
    { name = "gojo", level = 700, cf = CFrame.new(-13112.3262, -266.132385, 1642.56348) },
    { name = "gojo", level = 750, cf = CFrame.new(-13238.3428, -266.172424, 1753.3407) },
    { name = "gojo", level = 800, cf = CFrame.new(-13665.5928, -266.063904, 2106.37305) },
    { name = "gojo", level = 900, cf = CFrame.new(-14104.8584, -264.654663, 2372.2771) },
    { name = "gojo", level = 1000, cf = CFrame.new(1903.63135, 1179.94275, -4145.44629) },
    { name = "gojo", level = 1250, cf = CFrame.new(2811.7627, 1179.73572, -3811.27441) },
    { name = "gojo", level = 1500, cf = CFrame.new(2747.18701, 1180.13354, -3579.74463) },
    { name = "gojo", level = 1750, cf = CFrame.new(3556.82764, 1180.38208, -3719.61108) },
    { name = "gojo", level = 2500, cf = CFrame.new(3345.41431, 1179.81848, -4114.46875) },
    { name = "gojo", level = 2750, cf = CFrame.new(4029.12744, 1180.48914, -3973.57495) },
    { name = "gojo", level = 3000, cf = CFrame.new(3521.13818, 1180.45752, -4163.56738) },
    { name = "gojo", level = 3500, cf = CFrame.new(1671.66357, 1179.94067, -4681.10547) },
    { name = "sukuna", level = 5000, cf = CFrame.new(1994.05933, 1180.0564, -3637.19556) },
    { name = "gojo", level = 10000, cf = CFrame.new(1901.69751, 1179.93005, -4838.75391) }
}

local EnemyData = {
    { level = 1, cf = CFrame.new(-4021.01807, 1190.72205, -3856.13403) },
    { level = 10, cf = CFrame.new(-4140.7168, 1190.80872, -4317.74854) },
    { level = 25, cf = CFrame.new(-4508.16992, 1192.03577, -4594.99365) },
    { level = 50, cf = CFrame.new(-3924.17578, 1195.24805, -4532.13281) },
    { level = 75, cf = CFrame.new(-3709.99316, 1189.54041, -4523.49316) },
    { level = 125, cf = CFrame.new(-1171.78125, 1190.65527, -4745.05078) },
    { level = 150, cf = CFrame.new(-1340.78821, 1188.65588, -3514.55615) },
    { level = 175, cf = CFrame.new(-890.071777, 1218.21387, -4650.52441) },
    { level = 200, cf = CFrame.new(-1001.37549, 1190.5592, -4386.32227) },
    { level = 250, cf = CFrame.new(-401.848999, 1189.40247, -3849.2439) },
    { level = 300, cf = CFrame.new(180.227005, 1072.14624, -2263.48999) },
    { level = 350, cf = CFrame.new(-168.029999, 1072.14624, -2222.55103) },
    { level = 400, cf = CFrame.new(590.75, 1112.95898, -2062.85791) },
    { level = 450, cf = CFrame.new(604.864014, 1112.95898, -1822.31104) },
    { level = 500, cf = CFrame.new(-11068.1641, -265.704987, 1587.99304) },
    { level = 550, cf = CFrame.new(-11586.1328, -265.704987, 1222.21301) },
    { level = 600, cf = CFrame.new(-11426.9629, -265.704987, 1754.01196) },
    { level = 650, cf = CFrame.new(-12285.6357, -265.704987, 1471.27698) },
    { level = 700, cf = CFrame.new(-12965.665, -265.704987, 1669.70703) },
    { level = 750, cf = CFrame.new(-13289.5771, -265.704987, 1846.64197) },
    { level = 800, cf = CFrame.new(-13627.4043, -265.704987, 2196.177) },
    { level = 900, cf = CFrame.new(-13970.918, -265.704987, 2354.90991) },
    { level = 1000, cf = CFrame.new(1845.41492, 1181.29749, -4302.9668) },
    { level = 1250, cf = CFrame.new(2837.15771, 1181.29639, -4354.55664) },
    { level = 1500, cf = CFrame.new(2601.34692, 1181.29663, -3338.63867) },
    { level = 1750, cf = CFrame.new(3670.229, 1181.797, -3630.21899) },
    { level = 2500, cf = CFrame.new(3137.40698, 1181.29639, -4163.49707) },
    { level = 2750, cf = CFrame.new(4088.91602, 1181.797, -3801.25488) },
    { level = 3000, cf = CFrame.new(3688.396, 1181.297, -4231.90723) },
    { level = 3500, cf = CFrame.new(2120.80957, 1181.29749, -4627.26416) },
    { level = 5000, cf = CFrame.new(1683.96375, 1183.29639, -3562.02124) },
    { level = 10000, cf = CFrame.new(2084.09863, 1180.29639, -4997.74854) }
}

local function findQuestForLevel(lv)
    local quest = QuestData[1]
    for _, v in ipairs(QuestData) do
        if v.level > lv then break end
        quest = v
    end
    return quest
end

local function findEnemyForLevel(lv)
    local enemy = EnemyData[1]
    for _, v in ipairs(EnemyData) do
        if v.level > lv then break end
        enemy = v
    end
    return enemy
end

local function getNearestPrompt(cf)
    local closestPrompt, minDist = nil, 10
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            local part = obj.Parent:IsA("BasePart") and obj.Parent or obj.Parent:FindFirstChildWhichIsA("BasePart")
            if part then
                local dist = (part.Position - cf.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closestPrompt = obj
                end
            end
        end
    end
    return closestPrompt
end

local function tweenTo(cframe)
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local duration = (hrp.Position - cframe.Position).Magnitude / 400
        local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = cframe})
        tween:Play()
        tween.Completed:Wait()
    end
end

local function farmLoop()
    while farmActive do
        local currentLevel = level.Value
        local quest = findQuestForLevel(currentLevel)
        tweenTo(quest.cf)
        task.wait(0.4)

        local prompt = getNearestPrompt(quest.cf)
        if prompt then
            fireproximityprompt(prompt)
        end

        task.wait(2)
        local enemy = findEnemyForLevel(currentLevel)
        tweenTo(enemy.cf)
        task.wait(2)
    end
end

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
    Theme = "DiscordBlack"
})

local UsefulTab = Window:CreateTab("Useful")
local FarmingTab = Window:CreateTab("Farming")
local MiscTab = Window:CreateTab("Misc")

UsefulTab:CreateParagraph({ Title = "", Content = "spinnable stuff only :(" })

local techniqueValue = ""
UsefulTab:CreateInput({
    Name = "Technique",
    PlaceholderText = "Type technique",
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
    PlaceholderText = "Type race",
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
    PlaceholderText = "Type clan",
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

FarmingTab:CreateToggle({
    Name = "Toggle Auto Farm",
    CurrentValue = false,
    Callback = function(value)
        farmActive = value
        if farmActive and not farmingThread then
            farmingThread = task.spawn(farmLoop)
        end
    end,
})

FarmingTab:CreateToggle({
    Name = "Toggle Aura",
    CurrentValue = false,
    Callback = function(value)
        auraRunning = value
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

FarmingTab:CreateToggle({
    Name = "Toggle Server Crasher",
    CurrentValue = false,
    Callback = function(value)
        crashRunning = value
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

FarmingTab:CreateToggle({
    Name = "Domain Spam",
    CurrentValue = false,
    Callback = function(value)
        serverCrasherV2Running = value
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

-- Misc Tab: Chams
local function applyChams(character)
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            local highlight = part:FindFirstChild("ChamHighlight")
            if not highlight then
                highlight = Instance.new("Highlight", part)
                highlight.Name = "ChamHighlight"
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.OutlineColor = Color3.new(1, 1, 1)
            end
        end
    end
end

local function removeChams(character)
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            local highlight = part:FindFirstChild("ChamHighlight")
            if highlight then
                highlight:Destroy()
            end
        end
    end
end

local function toggleChams(state)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character then
            if state then
                applyChams(plr.Character)
                plr.CharacterAdded:Connect(applyChams)
            else
                removeChams(plr.Character)
            end
        end
    end
end

MiscTab:CreateToggle({
    Name = "Enable Chams",
    CurrentValue = false,
    Callback = function(state)
        chamsEnabled = state
        task.spawn(function()
            toggleChams(state)
        end)
    end,
})
