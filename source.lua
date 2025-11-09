local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local lp = Players.LocalPlayer
local level = lp:WaitForChild("Stats"):WaitForChild("Level")

-- Remote Finder
local function GetRemote()
    local folder = ReplicatedStorage:FindFirstChild("RemoteEvent") or ReplicatedStorage:FindFirstChild("Ability")
    if not folder then
        for _, n in {"Remotes", "Events"} do
            folder = ReplicatedStorage:FindFirstChild(n)
            if folderFolder then break end
        end
    end
    if not folder then return end
    return folder:FindFirstChild("information") or folder:FindFirstChildWhichIsA("RemoteEvent")
end
local Remote = GetRemote()

-- === CHARACTER MOVES ===
local Characters = {
    VeioDaLancha = {
        ToolName = "VeioDaLancha",
        Config = {
            [Enum.UserInputType.MouseButton1] = { Args = {"Combat", "Combo"} },
            [Enum.KeyCode.Z] = { Args = {"VeioDaLancha", "UseX"} },
            [Enum.KeyCode.X] = { Args = {"VeioDaLancha", "UseZ"} },
            [Enum.KeyCode.C] = { Args = {"VeioDaLancha", "UseV"} },
            [Enum.KeyCode.V] = { Args = {"VeioDaLancha", "UseC"} }
        },
        MoveNames = { Z = "ZMove", X = "XMove", C = "CMove", V = "VMove" }
    },
    GojoKuna = {
        ToolName = "GojoKuna",
        Config = {
            [Enum.UserInputType.MouseButton1] = { Args = {"Combat", "Combo"} },
            [Enum.KeyCode.Z] = { Args = {"GojoKuna", "UseX"} },
            [Enum.KeyCode.X] = { Args = {"GojoKuna", "UseZ"} },
            [Enum.KeyCode.C] = { Args = {"GojoKuna", "UseV"} },
            [Enum.KeyCode.V] = { Args = {"GojoKuna", "UseC"} }
        },
        MoveNames = { Z = "ZMove", X = "XMove", C = "CMove", V = "VMove" }
    },
    Sunshine = {
        ToolName = "Sunshine",
        Config = {
            [Enum.UserInputType.MouseButton1] = { Args = {"Combat", "Combo"} },
            [Enum.KeyCode.Z] = { Args = {"Sunshine", "UseX"} },
            [Enum.KeyCode.X] = { Args = {"Sunshine", "UseZ"} },
            [Enum.KeyCode.C] = { Args = {"Sunshine", "UseV"} },
            [Enum.KeyCode.V] = { Args = {"Sunshine", "UseC"} }
        },
        MoveNames = { Z = "ZMove", X = "XMove", C = "CMove", V = "VMove" }
    },
    SukunaSeniorCT = {
        ToolName = "SukunaSeniorCT",
        Config = {
            [Enum.UserInputType.MouseButton1] = { Args = {"Combat", "Combo"} },
            [Enum.KeyCode.X] = { Args = {"SukunaSeniorCT", "UseZ"} },
            [Enum.KeyCode.C] = { Args = {"SukunaSeniorCT", "UseV"} },
            [Enum.KeyCode.V] = { Args = {"SukunaSeniorCT", "UseC"} }
        },
        MoveNames = { X = "XMove", C = "CMove", V = "VMove" }
    },
    GegeAkutami = {
        ToolName = "GegeAkutami",
        Config = {
            [Enum.UserInputType.MouseButton1] = { Args = {"Combat", "Combo"} },
            [Enum.KeyCode.Z] = { Args = {"GegeAkutami", "UseX"} },
            [Enum.KeyCode.X] = { Args = {"GegeAkutami", "UseZ"} },
            [Enum.KeyCode.C] = { Args = {"GegeAkutami", "UseV"} },
            [Enum.KeyCode.V] = { Args = {"GegeAkutami", "UseC"} }
        },
        MoveNames = { Z = "ZMove", X = "XMove", C = "CMove", V = "VMove" }
    },
    GojoSenior = {
        ToolName = "GojoSenior",
        Config = {
            [Enum.UserInputType.MouseButton1] = { Args = {"Combat", "Combo"} },
            [Enum.KeyCode.Z] = { Args = {"GojoSenior", "UseX"} },
            [Enum.KeyCode.X] = { Args = {"GojoSenior", "UseZ"} },
            [Enum.KeyCode.C] = { Args = {"GojoSenior", "UseV"} },
            [Enum.KeyCode.V] = { Args = {"GojoSenior", "UseC"} }
        },
        MoveNames = { Z = "ZMove", X = "XMove", C = "CMove", V = "VMove" }
    },
    InfectedInfinity = {
        ToolName = "InfectedInfinity",
        Config = {
            [Enum.UserInputType.MouseButton1] = { Args = {"Combat", "Combo"} },
            [Enum.KeyCode.Z] = { Args = {"Infected Infinity", "UseX"} },
            [Enum.KeyCode.X] = { Args = {"Infected Infinity", "UseZ"} },
            [Enum.KeyCode.C] = { Args = {"Infected Infinity", "UseV"} },
            [Enum.KeyCode.V] = { Args = {"Infected Infinity", "UseC"} }
        },
        MoveNames = { Z = "ZMove", X = "XMove", C = "CMove", V = "VMove" }
    }
}

-- === MOVE SYSTEM ===
local LastFire = {}
local COOLDOWN = 0.3

local function CreateMoveScript(data)
    local ToolName, Config, MoveNames = data.ToolName, data.Config, data.MoveNames
    local Character = lp.Character or lp.CharacterAdded:Wait()

    local function IsEquipped() return Character:FindFirstChild(ToolName) end

    local function Fire(input)
        if not IsEquipped() or not Remote then return end
        local move = Config[input.KeyCode or input.UserInputType]
        if not move then return end
        local now = tick()
        if now - (LastFire[move] or 0) < COOLDOWN then return end
        LastFire[move] = now

        local gui = lp.PlayerGui:FindFirstChild("Gameplay")
        if gui then
            local moveset = gui:FindFirstChild("Moveset")
            local mainFrame = moveset and moveset:FindFirstChild("MainFrame")
            local skills = mainFrame and mainFrame:FindFirstChild("Skills")
            if skills then
                local keyName = input.KeyCode and input.KeyCode.Name
                if keyName then
                    local moveFrame = skills:FindFirstChild(keyName .. "Move")
                    if moveFrame then
                        local meter = moveFrame:FindFirstChild("MeterFrame")
                        if meter then
                            meter.Size = UDim2.new(1, 0, 1, 0)
                            local ls = meter:FindFirstChildOfClass("LocalScript")
                            if ls then ls.Disabled = true end
                            local enable = meter:FindFirstChild("Enable")
                            if enable then enable.Value = true end
                            local cd = meter:FindFirstChild("Cooldown")
                            if cd then cd.Value = 0 end
                        end
                    end
                end
            end
        end

        pcall(function() Remote:FireServer(unpack(move.Args)) end)
    end

    UserInputService.InputBegan:Connect(function(i, gp)
        if not gp then Fire(i) end
    end)

    local function HookGUI()
        local gui = lp.PlayerGui:WaitForChild("Gameplay", 5)
        if not gui then return end
        local moveset = gui:FindFirstChild("Moveset")
        if not moveset then return end
        local mainFrame = moveset:FindFirstChild("MainFrame")
        if not mainFrame then return end
        local skills = mainFrame:FindFirstChild("Skills")
        if not skills then return end

        for key, btnName in pairs(MoveNames) do
            local btnFrame = skills:FindFirstChild(btnName)
            if btnFrame then
                local useBtn = btnFrame:FindFirstChild("Use")
                if useBtn then
                    useBtn.MouseButton1Click:Connect(function()
                        Fire({ KeyCode = Enum.KeyCode[key] })
                    end)
                end
            end
        end
    end
    HookGUI()

    lp.CharacterAdded:Connect(function(newChar)
        Character = newChar
        Remote = GetRemote()
        task.delay(1, function()
            if not newChar:FindFirstChild(ToolName) and not lp.Backpack:FindFirstChild(ToolName) then
                local tool = Instance.new("Tool")
                tool.Name = ToolName
                tool.RequiresHandle = false
                tool.Parent = lp.Backpack
                tool.Parent = newChar
            end
        end)
        HookGUI()
    end)

    if not Character:FindFirstChild(ToolName) and not lp.Backpack:FindFirstChild(ToolName) then
        local tool = Instance.new("Tool")
        tool.Name = ToolName
        tool.RequiresHandle = false
        tool.Parent = lp.Backpack
        tool.Parent = Character
    end
end

-- === FARMING DATA ===
local QuestData = {
    {level=1,cf=CFrame.new(-3988.375,1190.24219,-3920.59131)},
    {level=10,cf=CFrame.new(-4052.21851,1189.74365,-4334.3042)},
    {level=25,cf=CFrame.new(-4049.20532,1190.05176,-4402.9458)},
    {level=50,cf=CFrame.new(-3990.72754,1189.93921,-4419.74805)},
    {level=75,cf=CFrame.new(-3681.0249,1189.6698,-4423.59814)},
    {level=125,cf=CFrame.new(-1263.37061,1188.24268,-4632.24512)},
    {level=150,cf=CFrame.new(-1326.88855,1188.18677,-3771.10596)},
    {level=175,cf=CFrame.new(-813.92749,1188.54907,-4563.81055)},
    {level=200,cf=CFrame.new(-1055.32996,1188.43408,-4262.25684)},
    {level=250,cf=CFrame.new(-328.684204,1188.2323,-3926.08643)},
    {level=300,cf=CFrame.new(199.716797,1072.23804,-2340.7644)},
    {level=350,cf=CFrame.new(-50.5863037,1072.14868,-2298.58447)},
    {level=400,cf=CFrame.new(556.568665,1111.84302,-1979.19897)},
    {level=450,cf=CFrame.new(556.421204,1111.98486,-1853.63611)},
    {level=500,cf=CFrame.new(-11310.4688,-265.822754,1493.49414)},
    {level=550,cf=CFrame.new(-11480.335,-266.28653,1233.84778)},
    {level=600,cf=CFrame.new(-11604.0527,-266.126404,1671.75269)},
    {level=650,cf=CFrame.new(-12210.4062,-265.760742,1395.9043)},
    {level=700,cf=CFrame.new(-13112.3262,-266.132385,1642.56348)},
    {level=750,cf=CFrame.new(-13238.3428,-266.172424,1753.3407)},
    {level=800,cf=CFrame.new(-13665.5928,-266.063904,2106.37305)},
    {level=900,cf=CFrame.new(-14104.8584,-264.654663,2372.2771)},
    {level=1000,cf=CFrame.new(1903.63135,1179.94275,-4145.44629)},
    {level=1250,cf=CFrame.new(2811.7627,1179.73572,-3811.27441)},
    {level=1500,cf=CFrame.new(2747.18701,1180.13354,-3579.74463)},
    {level=1750,cf=CFrame.new(3556.82764,1180.38208,-3719.61108)},
    {level=2500,cf=CFrame.new(3345.41431,1179.81848,-4114.46875)},
    {level=2750,cf=CFrame.new(4029.12744,1180.48914,-3973.57495)},
    {level=3000,cf=CFrame.new(3521.13818,1180.45752,-4163.56738)},
    {level=3500,cf=CFrame.new(1671.66357,1179.94067,-4681.10547)},
    {level=5000,cf=CFrame.new(1994.05933,1180.0564,-3637.19556)},
    {level=10000,cf=CFrame.new(1901.69751,1179.93005,-4838.75391)}
}

local EnemyData = {
    {level=1,cf=CFrame.new(-4021.01807,1190.72205,-3856.13403)},
    {level=10,cf=CFrame.new(-4140.7168,1190.80872,-4317.74854)},
    {level=25,cf=CFrame.new(-4508.16992,1192.03577,-4594.99365)},
    {level=50,cf=CFrame.new(-3924.17578,1195.24805,-4532.13281)},
    {level=75,cf=CFrame.new(-3709.99316,1189.54041,-4523.49316)},
    {level=125,cf=CFrame.new(-1171.78125,1190.65527,-4745.05078)},
    {level=150,cf=CFrame.new(-1340.78821,1188.65588,-3514.55615)},
    {level=175,cf=CFrame.new(-890.071777,1218.21387,-4650.52441)},
    {level=200,cf=CFrame.new(-1001.37549,1190.5592,-4386.32227)},
    {level=250,cf=CFrame.new(-401.848999,1189.40247,-3849.2439)},
    {level=300,cf=CFrame.new(180.227005,1072.14624,-2263.48999)},
    {level=350,cf=CFrame.new(-168.029999,1072.14624,-2222.55103)},
    {level=400,cf=CFrame.new(590.75,1112.95898,-2062.85791)},
    {level=450,cf=CFrame.new(604.864014,1112.95898,-1822.31104)},
    {level=500,cf=CFrame.new(-11068.1641,-265.704987,1587.99304)},
    {level=550,cf=CFrame.new(-11586.1328,-265.704987,1222.21301)},
    {level=600,cf=CFrame.new(-11426.9629,-265.704987,1754.01196)},
    {level=650,cf=CFrame.new(-12285.6357,-265.704987,1471.27698)},
    {level=700,cf=CFrame.new(-12965.665,-265.704987,1669.70703)},
    {level=750,cf=CFrame.new(-13289.5771,-265.704987,1846.64197)},
    {level=800,cf=CFrame.new(-13627.4043,-265.704987,2196.177)},
    {level=900,cf=CFrame.new(-13970.918,-265.704987,2354.90991)},
    {level=1000,cf=CFrame.new(1845.41492,1181.29749,-4302.9668)},
    {level=1250,cf=CFrame.new(2837.15771,1181.29639,-4354.55664)},
    {level=1500,cf=CFrame.new(2601.34692,1181.29663,-3338.63867)},
    {level=1750,cf=CFrame.new(3670.229,1181.797,-3630.21899)},
    {level=2500,cf=CFrame.new(3137.40698,1181.29639,-4163.49707)},
    {level=2750,cf=CFrame.new(4088.91602,1181.797,-3801.25488)},
    {level=3000,cf=CFrame.new(3688.396,1181.297,-4231.90723)},
    {level=3500,cf=CFrame.new(2120.80957,1181.29749,-4627.26416)},
    {level=5000,cf=CFrame.new(1683.96375,1183.29639,-3562.02124)},
    {level=10000,cf=CFrame.new(2084.09863,1180.29639,-4997.74854)}
}

local bossCFrames = {
    ["Infected Gojo"] = CFrame.new(2704.337891, 1180.296387, -5033.666016),
    ["Yuji Shinjuku"] = CFrame.new(3011.909180, 1180.296387, -5041.400879),
    ["Heian Era Sukuna"] = CFrame.new(3764.334229, 1180.796387, -5060.624512)
}

-- === UTILITY ===
local function findForLevel(data, lv)
    local best = data[1]
    for _, v in ipairs(data) do
        if v.level > lv then break end
        best = v
    end
    return best
end

local function getPrompt(cf)
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local p = v.Parent:IsA("BasePart") and v.Parent or v.Parent:FindFirstChildWhichIsA("BasePart")
            if p and (p.Position - cf.Position).Magnitude < 10 then return v end
        end
    end
end

local function tween(cf)
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local dist = (hrp.Position - cf.Position).Magnitude
        local tween = TweenService:Create(hrp, TweenInfo.new(dist/400, Enum.EasingStyle.Linear), {CFrame = cf})
        tween:Play(); tween.Completed:Wait()
    end
end

-- === FARMING LOOPS ===
local farmActive = false
local instaBossActive = false
local selectedBosses = {"Infected Gojo"}
local farmThread, bossThread

-- SPAM THREADS (FIXED: Can turn off)
local auraThread, gojoCrashThread, domainCrashThread = nil, nil, nil

local function farmLoop()
    while farmActive do
        local lv = level.Value
        local q = findForLevel(QuestData, lv)
        tween(q.cf); task.wait(0.4)
        local p = getPrompt(q.cf)
        if p then fireproximityprompt(p) end
        task.wait(2)
        local e = findForLevel(EnemyData, lv)
        tween(e.cf); task.wait(2)
    end
end

local function bossLoop()
    while instaBossActive do
        for _, name in ipairs(selectedBosses) do
            local cf = bossCFrames[name]
            if cf then
                tween(cf); task.wait(0.5)
                local boss = Workspace.Enemies:FindFirstChild(name)
                if boss and boss:FindFirstChild("Humanoid") then
                    pcall(function() Remote:FireServer("TojiNormal", "UseV") end)
                    task.wait(0.1)
                    boss.Humanoid.Health = 0
                end
                task.wait(1)
            end
        end
    end
end

-- === ESP ===
local function toggleESP(on)
    for _, plr in Players:GetPlayers() do
        if plr ~= lp and plr.Character then
            for _, part in plr.Character:GetDescendants() do
                if part:IsA("BasePart") then
                    local hl = part:FindFirstChild("ESP_HL") or Instance.new("Highlight", part)
                    hl.Name = "ESP_HL"
                    hl.FillColor = Color3.fromRGB(255,0,0)
                    hl.OutlineColor = Color3.fromRGB(255,255,255)
                    hl.FillTransparency = on and 0.5 or 1
                    hl.OutlineTransparency = on and 0 or 1
                end
            end
        end
    end
end

-- === SPEED ===
local speedOn, speedVal = false, 16
lp.CharacterAdded:Connect(function()
    task.wait(0.5)
    if speedOn and lp.Character then
        local hum = lp.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = speedVal end
    end
end)

-- === GUI ===
local Window = Rayfield:CreateWindow({
    Name = "Jujutsu Legacy v3",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Made By Starman999_",
    ConfigurationSaving = { Enabled = true, FolderName = nil, FileName = "JJLegacyV1Config" },
    KeySystem = false
})

local UsefulTab = Window:CreateTab("Useful")
local FarmingTab = Window:CreateTab("Farming")
local LimitedTab = Window:CreateTab("Limited's")
local MiscTab = Window:CreateTab("Misc")

-- Useful
UsefulTab:CreateParagraph({Title = "", Content = "Spinnable stuff only :("})

local techVal = ""
UsefulTab:CreateInput({Name="Technique", PlaceholderText="Type technique", Callback=function(t) techVal=t end})
UsefulTab:CreateButton({Name="Set Technique", Callback=function() if techVal~="" then ReplicatedStorage.SetTechnique:FireServer("Boogie Woogie", techVal, 1, 0.001) end end})

local raceVal = ""
UsefulTab:CreateInput({Name="Race", PlaceholderText="Type race", Callback=function(t) raceVal=t end})
UsefulTab:CreateButton({Name="Set Race", Callback=function() if raceVal~="" then ReplicatedStorage.SetRace:FireServer("None", raceVal, 1, 0.1) end end})

local clanVal = ""
UsefulTab:CreateInput({Name="Clan", PlaceholderText="Type clan", Callback=function(t) clanVal=t end})
UsefulTab:CreateButton({Name="Set Clan", Callback=function() if clanVal~="" then ReplicatedStorage.SetClan:FireServer("None", clanVal, 1, 0.1) end end})

-- Farming
FarmingTab:CreateToggle({Name="Auto Farm Quests", CurrentValue=false, Callback=function(v) farmActive=v; if v and not farmThread then farmThread=task.spawn(farmLoop) end end})

-- SPAM TOGGLES – FIXED: Can turn OFF
FarmingTab:CreateToggle({Name="Spam Aura (V)", CurrentValue=false, Callback=function(v)
    if v then
        auraThread = task.spawn(function()
            while task.wait(0.1) do
                if not v then break end
                pcall(function() Remote:FireServer("TojiNormal","UseV") end)
            end
        end)
    else
        if auraThread then task.cancel(auraThread); auraThread = nil end
    end
end})

FarmingTab:CreateToggle({Name="Crash Server (Gojo)", CurrentValue=false, Callback=function(v)
    if v then
        gojoCrashThread = task.spawn(function()
            while task.wait(0.1) do
                if not v then break end
                pcall(function() Remote:FireServer("Gojo","UseV") end)
            end
        end)
    else
        if gojoCrashThread then task.cancel(gojoCrashThread); gojoCrashThread = nil end
    end
end})

FarmingTab:CreateToggle({Name="Domain Crash (Sukuna)", CurrentValue=false, Callback=function(v)
    if v then
        domainCrashThread = task.spawn(function()
            while task.wait(0.1) do
                if not v then break end
                pcall(function() Remote:FireServer("HeianSukunaNew","UseG") end)
            end
        end)
    else
        if domainCrashThread then task.cancel(domainCrashThread); domainCrashThread = nil end
    end
end})

FarmingTab:CreateDropdown({Name="Select Boss", Options={"Infected Gojo","Yuji Shinjuku","Heian Era Sukuna"}, CurrentOption={"Infected Gojo"}, Multiple=true, Callback=function(v) selectedBosses=v end})
FarmingTab:CreateToggle({Name="Insta Kill Boss", CurrentValue=false, Callback=function(v) instaBossActive=v; if v and not bossThread then bossThread=task.spawn(bossLoop) elseif not v and bossThread then task.cancel(bossThread); bossThread=nil end end})

-- Limited's
LimitedTab:CreateSection("Moves")
for name, data in pairs(Characters) do
    LimitedTab:CreateButton({Name="Load "..name, Callback=function() CreateMoveScript(data); Rayfield:Notify({Title="Loaded",Content=name.." ready",Duration=3}) end})
end

LimitedTab:CreateSection("Tools")

-- GojoKuna Eyes
LimitedTab:CreateButton({Name="Give GojoKuna Eyes", Callback=function()
    local storage = lp:FindFirstChild("AcessoryHatStorage")
    if not storage then
        Rayfield:Notify({Title="Error", Content="AcessoryHatStorage not found!", Duration=5})
        return
    end
    if not storage:FindFirstChild("GojoKuna Eyes") then
        local item = Instance.new("StringValue")
        item.Name = "GojoKuna Eyes"
        item.Value = "GojoKuna Eyes"
        item.Parent = storage
    end
    Rayfield:Notify({Title="Success", Content="GojoKuna Eyes added!", Duration=4})
end})

-- Infected Collar
LimitedTab:CreateButton({Name="Give Infected Collar", Callback=function()
    local storage = lp:FindFirstChild("AcessoryHatStorage")
    if not storage then
        Rayfield:Notify({Title="Error", Content="AcessoryHatStorage not found!", Duration=5})
        return
    end
    if not storage:FindFirstChild("Infected Collar") then
        local item = Instance.new("StringValue")
        item.Name = "Infected Collar"
        item.Value = "Infected Collar"
        item.Parent = storage
    end
    Rayfield:Notify({Title="Success", Content="Infected Collar added!", Duration=4})
end})

-- Misc
MiscTab:CreateToggle({Name="Player ESP", CurrentValue=false, Callback=toggleESP})
MiscTab:CreateToggle({Name="Speed Hack", CurrentValue=false, Callback=function(v) speedOn=v; if lp.Character then local hum=lp.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed=v and speedVal or 16 end end end})
MiscTab:CreateSlider({Name="Walk Speed", Range={16,500}, Increment=1, Suffix=" WS", CurrentValue=16, Callback=function(v) speedVal=v; if speedOn and lp.Character then local hum=lp.Character:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed=v end end end})

Rayfield:Notify({Title="Jujutsu Legacy v3", Content="Loaded. All features fixed.", Duration=5})
