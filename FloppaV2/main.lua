-- LIB : Floppa V2 by Frost X#6215

local GuiLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/roblox-scripts/main/FloppaV2/GuiLib.lua"), true)()

-- VARIABLES ~ TOGGLES

getgenv().AutoPet = false
getgenv().AutoPetAlways = false
getgenv().AutoClicker = false

getgenv().AutoSave = false
getgenv().AutoSaveCooldown = false

getgenv().AutoCollectMoney = false
getgenv().AutoCollectMoneyFloppaInc = 1000000000

getgenv().AutoFood = false
getgenv().AutoFoodCooldown = false

getgenv().AutoPlant = false
getgenv().NoMoneySound = false
getgenv().NoSound = false
getgenv().AutoCleaner = false

getgenv().AutoKill = false
getgenv().AutoKillBuying = false

getgenv().AutoSummon = false
getgenv().AutoBackrooms = false
getgenv().AutoUpgrade = false
getgenv().AutoDJ = false
getgenv().AutoPickup = false
getgenv().AutoUse = false

getgenv().AutoRoommate = false
getgenv().AutoRoommateCooldown1 = false
getgenv().AutoRoommateCooldown2 = false

getgenv().Debug = false

getgenv().AutoVault = false
getgenv().Item = ""
getgenv().VaultTPBack = false
getgenv().VaultFull = false

AutoVault_items = {"Milk",
                    "Floppa Food",
                    "Meteorite",
                    "Money Bag",
                    "Carrot",
                    "Tomato",
                    "Lettuce",
                    "Noodles",
                    "Chicken",
                    "Backrooms Key",
                    "Almond Water",
                    "Catnip",
                    "Mushroom"}

getgenv().FloppaName = "FS V2 ON TOP!"

-- OTHER
 
local SaveEvent = game:GetService("ReplicatedStorage").Events.Save
local BuyEvent = game:GetService("ReplicatedStorage").Events.Unlock
local CollectRentEvent = game:GetService("ReplicatedStorage").Events["Collect Rent"]
local RaiseRentEvent = game:GetService("ReplicatedStorage").Events["Raise Rent"]
local BingusViceEvent = game:GetService("ReplicatedStorage").Events["Mysterious Dialog"]

local MainWindow = GuiLib.Load("FLOPPA SCRIPT V2", true)

local Main = MainWindow.AddPage("Main", false)
local Misc = MainWindow.AddPage("Misc", false)
local Shop = MainWindow.AddPage("Shop", false)
local Teleports = MainWindow.AddPage("Teleports", false) -- still no TPs lol
local Credits = MainWindow.AddPage("Credits", false)
local Premium = MainWindow.AddPage("Premium", false)

-- CREDITS

local Credits1 = Credits.AddLabel("Scripting - Frost X#6215")
local Credits2 = Credits.AddLabel("Idea - Frost X#6215")

local CreditsOwn1 = Credits.AddLabel("Game Owner 1 - RealXyIo#0059")
local CreditsOwn2 = Credits.AddLabel("Game Owner 2 - ShiiroShogun#1105")

local Credits3 = Credits.AddLabel("Script Version: v1.7 (Watch github changelog below)")
local Credits5 = Credits.AddLabel("FrostX-Official/roblox-scripts/blob/main/FloppaV2")

local Credits3 = Credits.AddLabel("UI Lib - Kinlei#6459 (modified by Frost X#6215)")

-- FUNCTIONS

local function notification_new(title, text, duration)
    if getgenv().Debug then
        game.StarterGui:SetCore("SendNotification", {
            Title = title; -- the title (ofc)
            Text = text; -- what the text says (ofc) 
            Duration = duration; -- how long the notification should in secounds
            })
    end
end

local PremiumLabel = Premium.AddLabel("There is no premium you bum, it's open-source!")

writefile("FromizRug.png", game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/roblox-scripts/main/FloppaV2/assets/FromizRug.png"))

if workspace.Unlocks:FindFirstChild("Fancy Rug") then
    workspace.Unlocks["Fancy Rug"].Rug.Texture = getcustomasset("FromizRug.png")
    delfile("FromizRug.png")
end

local TPHome = Teleports.AddButton("IN-Home Teleport", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.InsidePoint.CFrame
end)

local ShopLabel = Shop.AddLabel("Shop Menus")
local ShopMenu = Shop.AddButton("Shop Menu", function()
    if game.Players.LocalPlayer.PlayerGui.PlayerUI["the_interwebs"].Visible == false then
        game.Players.LocalPlayer.PlayerGui.PlayerUI["the_interwebs"].Visible = true
    else
        game.Players.LocalPlayer.PlayerGui.PlayerUI["the_interwebs"].Visible = false
    end
end)

local ShopBuySword = Shop.AddButton("Buy Sword", function()
    local last_CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Village.SwordStore.Villager.HumanoidRootPart.CFrame
    fireproximityprompt(workspace.Village.SwordStore.Villager.HumanoidRootPart.ProximityPrompt, 1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_CFrame
end)

local MiscNostalgicMode = Misc.AddButton("Nostalgic Mode (Fall Ambience)", function()
    local findNostalgic = workspace:FindFirstChild("Nostalgic")

    if findNostalgic then
        notification_new("Nostalgic mode", "Toggled OFF", 2)

        findNostalgic:Destroy()
        workspace.Ambience.Playing = true
    else
        workspace.Ambience.Playing = false
        local music = Instance.new("Sound")
        music.Name = "Nostalgic"
        music.SoundId = "rbxassetid://9802437816"
        music.Parent = workspace
        music.TimePosition = 0
        music.Looped = true
        music.Volume = 0

        music:Play()

        notification_new("Nostalgic mode", "Toggled ON", 2)

        repeat
            music.Volume += 0.01
            wait(0.2)
        until music.Volume >= 0.75

        while wait(1) do
            if workspace.Ambience.Playing == true then
                music:Stop()
            end
        end
    end
end)

local FloppaRenaming = Misc.AddLabel("Rename your babies!")

local MiscRenameFloppas = Misc.AddTextBox("Floppa Name", function(text)
    getgenv().FloppaName = text
end)

local MiscRenameFloppas = Misc.AddButton("Rename", function()
    for i, v in pairs(workspace.Unlocks:GetChildren()) do
        if v.Name == "Baby Floppa" then
            v.Display.Frame.NameLabel.Text = getgenv().FloppaName
        end
    end
end)

local FloppaRenaming2 = Misc.AddLabel("~ ⭕ ~")

local AutoVault = Main.AddLabel("Auto-Vaulting")

local MainStoreEverything = Main.AddButton("Store Everything in Vault", function()
    local last_CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Unlocks["Small Vault"].Base.CFrame
    wait(1)
    for i, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if item.Name ~= "Excalibur" then
            item.Parent = game.Players.LocalPlayer.Character
            fireproximityprompt(workspace.Unlocks["Small Vault"].Base.ProximityPrompt, 1)
        end
    end

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_CFrame
end)

local MainItemToVault = Main.AddDropdown("Auto-Vault Item", AutoVault_items, function(selected)
    getgenv().Item = selected
end)

local MainAutoVault = Main.AddToggle("Auto-Vault", false, function(toggled)
    if toggled then
        getgenv().AutoVault = true
    else
        getgenv().AutoVault = false
    end
end)

local AutoVault = Main.AddLabel("~ ⭕ ~")

local MainGainSanity = Misc.AddButton("Gain Sanity (Backrooms)", function()
    local last_CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame
    wait(0.5)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_CFrame
end)

local DebugMode = Misc.AddToggle("Debug Mode", false, function(toggled)
    if toggled then
        getgenv().Debug = true
        notification_new("DEBUG MODE", "Debug mode activated!", 1)
    else
        getgenv().Debug = false
        notification_new("DEBUG MODE", "Debug mode deactivated!", 1)
    end
end)

local MainAutoPet = Main.AddToggle("AutoPet", false, function(toggled)
    if toggled then
        getgenv().AutoPet = true
    else
        getgenv().AutoPet = false
    end
end)
local MainAutoPetAlways = Main.AddToggle("AutoPet (Always)", false, function(toggled)
    if toggled then
        getgenv().AutoPetAlways = true
    else
        getgenv().AutoPetAlways = false
    end
end)

local MainAutoClick = Main.AddToggle("AutoClicker", false, function(toggled)
    if toggled then
        getgenv().AutoClicker = true
    else
        getgenv().AutoClicker = false
    end
end)

local AutoCollect = Main.AddLabel("Auto-Collecting")

local MainAutoCollectMoney = Main.AddToggle("AutoCollect Money", false, function(toggled)
    if toggled then
        getgenv().AutoCollectMoney = true
    else
        getgenv().AutoCollectMoney = false
    end
end)
local MainAutoCollectMoneyFloppaInc = Main.AddSlider("AutoCollect Floppa Inc", {Min = 1, Max = 100000000000, Def = 10000000000}, function(Value)
    getgenv().AutoCollectMoneyFloppaInc = Value
end)

local AutoCollect2 = Main.AddLabel("~ ⭕ ~")

local MainAutoUpgrade = Main.AddToggle("AutoUpgrade", false, function(toggled)
    if toggled then
        getgenv().AutoUpgrade = true
    else
        getgenv().AutoUpgrade = false
    end
end)
local MainAutoDJ = Main.AddToggle("AutoDJ", false, function(toggled)
    if toggled then
        getgenv().AutoDJ = true
    else
        getgenv().AutoDJ = false
    end
end)

local MainAutoFood = Main.AddToggle("AutoFood", false, function(toggled)
    if toggled then
        getgenv().AutoFood = true
    else
        getgenv().AutoFood = false
    end
end)
local MainAutoPlant = Main.AddToggle("AutoPlant", false, function(toggled)
    if toggled then
        getgenv().AutoPlant = true
    else
        getgenv().AutoPlant = false
    end
end)

local MainAutoCleaner = Main.AddToggle("AutoCleaner", false, function(toggled)
    if toggled then
        getgenv().AutoCleaner = true
    else
        getgenv().AutoCleaner = false
    end
end)
local MainAutoBackrooms = Main.AddToggle("AutoBackrooms", false, function(toggled)
    if toggled then
        getgenv().AutoBackrooms = true
    else
        getgenv().AutoBackrooms = false
    end
end)

local MainNoMoneySound = Main.AddToggle("No MoneySound", false, function(toggled)
    if toggled then
        getgenv().NoMoneySound = true
    else
        getgenv().NoMoneySound = false
    end
end)

local MainAutoRoommate = Main.AddToggle("AutoRoommate (OP)", false, function(toggled)
    if toggled then
        getgenv().AutoRoommate = true
    else
        getgenv().AutoRoommate = false
    end
end)
local MainAutoUse = Main.AddToggle("AutoUse (maybe auto-equip lol)", false, function(toggled)
    if toggled then
        getgenv().AutoUse = true
    else
        getgenv().AutoUse = false
    end
end)

local MainAutoKill = Main.AddToggle("AutoKill (Use when raid/boss)", false, function(toggled)
    if toggled then
        getgenv().AutoKill = true
    else
        getgenv().AutoKill = false
    end
end)
local MainAutoSummon = Main.AddToggle("AutoSummon (auto summons boss)", false, function(toggled)
    if toggled then
        getgenv().AutoSummon = true
    else
        getgenv().AutoSummon = false
    end
end)

local MainAutoPickup = Main.AddToggle("AutoPickup (seeds and other)", false, function(toggled)
    if toggled then
        getgenv().AutoPickup = true
    else
        getgenv().AutoPickup = false
    end
end)

local AutoVault = Main.AddLabel("In Developing...")

local MainNoSound = Main.AddToggle("No Sound (Do not toggle) [BETA-FUNCTION]", false, function(toggled)
    if toggled then
        getgenv().NoSound = true
    else
        getgenv().NoSound = false
    end
end)

-- TOGGLES FUNCTIONS

while wait() do
    local getPrize = workspace:FindFirstChild("Bingus Cult Prize")

    if getPrize then
        if #getPrize:GetChildren() <= 0 then
            getPrize:Destroy()
        end
    end

    if getgenv().AutoPet then
        if workspace.Floppa.Configuration.Happiness.Value < 51 and workspace.Floppa.Configuration.Hunger.Value > 35 then
            local prox = workspace.Floppa.HumanoidRootPart:WaitForChild("ProximityPrompt")
            if prox.ActionText == "Pet" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Floppa.HumanoidRootPart.CFrame + Vector3.new(0, 1, 0)
                fireproximityprompt(prox, 1)
            end
        end
    end
    if getgenv().AutoDJ then
        local DJ = workspace.Unlocks:FindFirstChild("DJ El Gato")

        if DJ then
            if DJ.Cooldown.Value == 0 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = DJ.Primary.CFrame + Vector3.new(0, 2, 0)
                local prox = DJ.Primary.ProximityPrompt
                fireproximityprompt(prox, 1)
            end
        end
    end
    if getgenv().AutoBackrooms then
        local BackroomsLevel = game.Players.LocalPlayer.BackroomsLevel.Value
        if BackroomsLevel < 4 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Backrooms.Rooms["Backrooms 10"].Exit.Primary.CFrame
            local prox = workspace.Backrooms.Rooms["Backrooms 10"].Exit.Frame:FindFirstChild("ProximityPrompt")
            fireproximityprompt(prox, 1)
        else
            local prox = workspace.Backrooms["Almond Water"]:FindFirstChild("ProximityPrompt")
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Backrooms["Almond Water"].CFrame
            fireproximityprompt(prox, 1)
        end
    end
    if getgenv().AutoUpgrade then
        local findPoster = workspace.Unlocks:FindFirstChild("Cat Poster")
        local findBed = workspace.Unlocks:FindFirstChild("Cat Bed")
        local findScratchPost = workspace.Unlocks:FindFirstChild("Scratching Post")
        local findBallOfYarn = workspace.Unlocks:FindFirstChild("Ball of Yarn")
        local findHouseplant = workspace.Unlocks:FindFirstChild("Houseplant")
        local findMsFloppa = workspace.Unlocks:FindFirstChild("Ms. Floppa")
        local findFloppaPaint = workspace.Unlocks:FindFirstChild("Floppa Painting")
        local findGameRig = workspace.Unlocks:FindFirstChild("Gaming Rig")
        local findDreamCatch = workspace.Unlocks:FindFirstChild("Dream Catcher")
        local findSogga = workspace.Unlocks:FindFirstChild("Sogga")
        local findFancyRug = workspace.Unlocks:FindFirstChild("Fancy Rug")
        local findHDTV = workspace.Unlocks:FindFirstChild("HD TV")
        local findJinx = workspace.Unlocks:FindFirstChild("Jinx")
        local findCeilingFan = workspace.Unlocks:FindFirstChild("Ceiling Fan")

        if not findPoster and game.Players.LocalPlayer.Money.Value >= 50 then
            BuyEvent:FireServer("Cat Poster", "the_interwebs")
        end
        if not findScratchPost and game.Players.LocalPlayer.Money.Value >= 75 then
            BuyEvent:FireServer("Scratching Post", "the_interwebs")
        end
        if not findBallOfYarn and game.Players.LocalPlayer.Money.Value >= 150 then
            BuyEvent:FireServer("Ball of Yarn", "the_interwebs")
        end
        if not findBed and game.Players.LocalPlayer.Money.Value >= 500 then
            BuyEvent:FireServer("Cat Bed", "the_interwebs")
        end
        if not findHouseplant and game.Players.LocalPlayer.Money.Value >= 500 then
            BuyEvent:FireServer("Houseplant", "the_interwebs")
        end
        if not findMsFloppa and game.Players.LocalPlayer.Money.Value >= 1000 then
            BuyEvent:FireServer("Floppa Painting", "the_interwebs")
        end
        if not findFloppaPaint and game.Players.LocalPlayer.Money.Value >= 1000 then
            BuyEvent:FireServer("Floppa Painting", "the_interwebs")
        end
        if not findGameRig and game.Players.LocalPlayer.Money.Value >= 2000 then
            BuyEvent:FireServer("Gaming Rig", "the_interwebs")
        end
        if not findDreamCatch and game.Players.LocalPlayer.Money.Value >= 3000 then
            BuyEvent:FireServer("Dream Catcher", "the_interwebs")
        end
        if not findSogga and game.Players.LocalPlayer.Money.Value >= 5000 then
            BuyEvent:FireServer("Sogga", "the_interwebs")
        end
        if not findFancyRug and game.Players.LocalPlayer.Money.Value >= 7500 then
            BuyEvent:FireServer("Sogga", "the_interwebs")
        end
        if not findHDTV and game.Players.LocalPlayer.Money.Value >= 15000 then
            BuyEvent:FireServer("HD TV", "the_interwebs")
        end
        if not findJinx and game.Players.LocalPlayer.Money.Value >= 25000 then
            BuyEvent:FireServer("Jinx", "the_interwebs")
        end
        if not findCeilingFan and game.Players.LocalPlayer.Money.Value >= 30000 then
            BuyEvent:FireServer("Ceiling Fan", "the_interwebs")
        end
    end
    if getgenv().AutoPetAlways then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Floppa.HumanoidRootPart.CFrame + Vector3.new(0, 1, 0)
        fireproximityprompt(workspace.Floppa.HumanoidRootPart.ProximityPrompt, 1)
    end
    if getgenv().AutoClicker then
        fireclickdetector(workspace.Floppa.ClickDetector, 32)
        for i, unlock in pairs(workspace.Unlocks:GetChildren()) do
            if unlock.Name == "Baby Floppa" then
                local clickDetector = unlock:WaitForChild("ClickDetector")
                fireclickdetector(clickDetector, 32)
            end
        end
    end
    if getgenv().AutoCollectMoney then
        local detect_floppainc = workspace.Unlocks:FindFirstChild("Floppa Inc")
        if detect_floppainc then
            if detect_floppainc.Profits.Value >= getgenv().AutoCollectMoneyFloppaInc then
                fireproximityprompt(detect_floppainc.Board.Prompt, 1)
            end
        end
        for i, v in pairs(workspace:GetChildren()) do
            if v.Name == "Money" or v.Name == "Money Bag" or v.Name == "Rent" then
                local touchablePart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                firetouchinterest(touchablePart, v)
            end
            if v.Name == "Bingus Cult Prize" then
                for i, prize in pairs(v:GetChildren()) do
                    if prize.Name == "Money Bag" then
                        local touchablePart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                        firetouchinterest(touchablePart, prize.Handle)
                    end
                end
            end
        end
    end
    if getgenv().AutoKill then
        if #workspace.Enemies:GetChildren() > 0 then
            for i, v in pairs(workspace.Enemies:GetChildren()) do
                if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hitPart = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Torso")

                    if hitPart then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = hitPart.CFrame

                        local getSword = game.Players.LocalPlayer.Character:FindFirstChild("Excalibur") or game.Players.LocalPlayer.Character:FindFirstChild("Sword")
                        local getSwordBackpack = game.Players.LocalPlayer.Backpack:FindFirstChild("Excalibur") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sword")

                        if not getSword then
                            if getSwordBackpack then
                                getSwordBackpack.Parent = game.Players.LocalPlayer.Character
                            else
                                if not getgenv().AutoKillBuying then
                                    getgenv().AutoKillBuying = true
                                    local last_CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Village.SwordStore.Villager.HumanoidRootPart.CFrame
                                    fireproximityprompt(workspace.Village.SwordStore.Villager.HumanoidRootPart.ProximityPrompt, 1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_CFrame
                                    wait(0.2)
                                    getgenv().AutoKillBuying = false
                                end
                            end
                        else
                            if getSword.Parent == game.Players.LocalPlayer.Character then
                                if game.Players.LocalPlayer.Character.Humanoid.Health > 2 then
                                    getSword:Activate()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if getgenv().AutoUse then
        for i, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if item.Name == "Almond Water" then
                if workspace.Floppa.Configuration.Lives.Value < 99 then
                    if not getgenv().AutoVault then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Floppa.HumanoidRootPart.CFrame
                        item.Parent = game.Players.LocalPlayer.Character
                        local prox = workspace.Floppa.HumanoidRootPart:WaitForChild("ProximityPrompt")
                        wait(0.5)
                        if prox.ActionText == "Feed Almond Water" then
                            fireproximityprompt(prox, 1)
                        end
                    end
                end
            end
            if item.Name == "Money Bag" then
                local findMoneyInChar = game.Players.LocalPlayer.Character:FindFirstChild("Money Bag")
                if not findMoneyInChar then
                    if not getgenv().AutoVault then
                        item.Parent = game.Players.LocalPlayer.Character
                    end
                end
            end
        end
    end

    if getgenv().AutoPickup then
        for i, seed in pairs(workspace.Seeds:GetChildren()) do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = seed.CFrame
            local prox = seed:WaitForChild("ProximityPrompt")
            fireproximityprompt(prox, 1)
        end
        for i, v in pairs(workspace:GetChildren()) do
            if v.Name == "Meteorite" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
            elseif v.Name == "Milk Delivery" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Crate.CFrame
                fireproximityprompt(v.Crate.ProximityPrompt, 1)
            end
        end
    end

    if getgenv().AutoSummon then
        local check_bingus = workspace.Unlocks:FindFirstChild("Cursed Altar")

        if check_bingus then
            if not check_bingus.Activated.Value then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = check_bingus.Bingus.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
                fireproximityprompt(check_bingus.Bingus.HumanoidRootPart.ProximityPrompt, 1)
            end
        else
            BingusViceEvent:FireServer()
        end
    end

    if getgenv().AutoPlant then
        for i, item in pairs(workspace.Unlocks:GetChildren()) do
            if item.Name == "Planter" then 
                if item.Sequence.Value < 10 or item.Sequence.Value > 49 then
                    if item.Plant.Value == "" or item.Plant.Value == nil then
                        for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if tool.Name:match("Seed") or tool.Name:match("Spore") then
                                tool.Parent = game.Players.LocalPlayer.Character
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item.Soil.CFrame + Vector3.new(0, 2, 0)
                                fireproximityprompt(item.Soil.ProximityPrompt, 1)
                            end
                        end
                    else
                        if item.Growth.Value >= 100 then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item.Soil.CFrame + Vector3.new(0, 2, 0)
                            fireproximityprompt(item.Soil.ProximityPrompt, 1)
                        end
                    end
                end
            end
        end
    end


    if getgenv().AutoFood then
        if not getgenv().AutoFoodCooldown then
            local findFood1 = game.Players.LocalPlayer.Backpack:FindFirstChild("Floppa Food")
            local findFood2 = game.Players.LocalPlayer.Character:FindFirstChild("Floppa Food")

            if findFood1 then
                if workspace["Key Parts"].Bowl.Part.Transparency == 1 then
                    getgenv().AutoFoodCooldown = true
                    findFood1.Parent = game.Players.LocalPlayer.Character
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Key Parts"].Bowl.Part.CFrame + Vector3.new(0, 4, 0)
                    fireproximityprompt(workspace["Key Parts"].Bowl.Part.ProximityPrompt, 1)
                    wait(0.2)
                    getgenv().AutoFoodCooldown = false
                end
            else
                if findFood2 then
                    if workspace["Key Parts"].Bowl.Part.Transparency == 1 then
                        getgenv().AutoFoodCooldown = true
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Key Parts"].Bowl.Part.CFrame + Vector3.new(0, 4, 0)
                        fireproximityprompt(workspace["Key Parts"].Bowl.Part.ProximityPrompt, 1)
                        wait(0.2)
                        getgenv().AutoFoodCooldown = false
                    else
                        getgenv().AutoFoodCooldown = true
                        game.Players.LocalPlayer.Character["Floppa Food"].Parent = game.Players.LocalPlayer.Backpack
                        wait(0.2)
                        getgenv().AutoFoodCooldown = false
                    end
                else  
                    if workspace["Key Parts"].Bowl.Part.Transparency == 1 then
                        getgenv().AutoFoodCooldown = true
                        BuyEvent:FireServer("Floppa Food", "the_interwebs")
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Key Parts"].Bowl.Part.CFrame + Vector3.new(0, 4, 0)
                        fireproximityprompt(workspace["Key Parts"].Bowl.Part.ProximityPrompt, 1)
                        wait(0.2)
                        getgenv().AutoFoodCooldown = false
                    end
                end
            end
        end
    end

    if getgenv().NoMoneySound then
        for i, v in pairs(workspace:GetChildren()) do
            if v.Name == "DollaDollaBills" then
                v:Destroy()
            end
        end
    end

    if getgenv().NoSound then
        local findSound1 = workspace:FindFirstChildWhichIsA("Sound")
        local findFloppaSound = workspace.Floppa.HumanoidRootPart:FindFirstChildWhichIsA("Sound")

        if findSound1 then
            findSound1:Destroy()
        end
        if findFloppaSound then
            findFloppaSound:Destroy()
        end
        for i, unlock in pairs(workspace.Unlocks:GetChildren()) do
            if unlock.Name == "Baby Floppa" then
                local findSound = unlock.HumanoidRootPart:FindFirstChildWhichIsA("Sound")
                if findSound then
                    findSound:Destroy()
                end
            end
        end
    end

    if getgenv().AutoCleaner then
        local findPoop = workspace["Key Parts"]["Litter Box"]:FindFirstChild("Poop")
        local findPoop2 = workspace:FindFirstChild("Poop")

        if findPoop then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = findPoop.PoopPart.CFrame + Vector3.new(0, 3, 0)
            local prox = findPoop:WaitForChild("ProximityPrompt")
            fireproximityprompt(findPoop.ProximityPrompt, 1)
            notification_new("Auto-Cleaner", "Cleaned poop which is in litter box.", 0.5)
        end
        if findPoop2 then
            findPoop2.PoopPart.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = findPoop2.PoopPart.CFrame + Vector3.new(0, 3, 0)
            local prox = findPoop2:WaitForChild("ProximityPrompt")
            fireproximityprompt(prox, 1)
            notification_new("Auto-Cleaner", "Cleaned poop which isn't in litter box.", 0.5)
        end
    end

    if getgenv().AutoRoommate then
        local check = workspace.Unlocks:FindFirstChild("Roommate")
        if check then
            if workspace.Unlocks.Roommate["Can Raise"].Value == true and workspace.Unlocks.Roommate["Amt"].Value < 1000000000 then
                if getgenv().AutoRoommateCooldown1 == false then
                    getgenv().AutoRoommateCooldown1 = true
                    RaiseRentEvent:FireServer()
                    notification_new("AutoRoommate", "Raised rent of roommate.", 0.5)
                    getgenv().AutoRoommateCooldown1 = false
                end
            end
            if workspace.Unlocks.Roommate["Can Collect"].Value == true then
                if getgenv().AutoRoommateCooldown2 == false then
                    getgenv().AutoRoommateCooldown2 = true
                    CollectRentEvent:FireServer()
                    notification_new("AutoRoommate", "Collected roommate money.", 0.5)
                    getgenv().AutoRoommateCooldown2 = false
                end
            end
        end
    end

    if getgenv().AutoVault then
        local getVault = workspace.Unlocks:FindFirstChild("Small Vault")

        if getVault then
            for i, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if getgenv().Item ~= "" and item.Name == getgenv().Item then
                    if #game.ReplicatedStorage["Small Vault"]:GetChildren() < 100 then
                        getgenv().VaultFull = false
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Unlocks["Small Vault"].Base.CFrame

                        item.Parent = game.Players.LocalPlayer.Character
                        wait(0.2)
                        fireproximityprompt(workspace.Unlocks["Small Vault"].Base.ProximityPrompt, 1)
                        notification_new("Auto-Vault", "Added item to Vault.", 0.2)
                        wait(0.2)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.InsidePoint.CFrame
                        notification_new("Auto-Vault", "Teleported IN-Home", 0.4)
                    else
                        if not getgenv().VaultFull then
                            getgenv().VaultFull = true
                            notification_new("Auto-Vault", "Vault is FULL! Please clear it if you need to store items.", 0.01)
                        end
                    end
                end
            end
        end
    end

    local findVault = workspace.Unlocks:FindFirstChild("Small Vault")

    if findVault then
        local findGui = findVault.Base:FindFirstChildWhichIsA("BillboardGui")
        if not findGui then
            local gui = Instance.new("BillboardGui")
            gui.AlwaysOnTop = true 
            gui.MaxDistance = 30
            gui.Size = UDim2.new(0, 100, 0, 50)
            gui.StudsOffset = Vector3.new(0, 3.5, 0)
            gui.Parent = findVault.Base

            local text = Instance.new("TextLabel")
            text.Parent = gui
            text.Text = "Loading FS V2."
            text.BackgroundTransparency = 1
            text.TextScaled = true
            text.Size = UDim2.new(1, 0, 1, 0)
        else
            findGui.TextLabel.Text = #game.ReplicatedStorage["Small Vault"]:GetChildren().."/100"
        end
    end
end

-- Goodbye.
