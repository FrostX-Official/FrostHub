-- LIB : Floppa V2 by Frost X#6215

local GuiLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/roblox-scripts/main/FloppaV2/GuiLib.lua"), true)()

-- VARIABLES ~ TOGGLES

getgenv().AutoPet = false
getgenv().AutoPetAlways = false
getgenv().AutoClicker = false

getgenv().AutoSave = false
getgenv().AutoSaveCooldown = false

getgenv().AutoCollectMoney = false
getgenv().AutoFood = false
getgenv().NoMoneySound = false
getgenv().NoSound = false
getgenv().AutoCleaner = false
getgenv().AutoPickup = false

getgenv().AutoRoommate = false
getgenv().AutoRoommateCooldown1 = false
getgenv().AutoRoommateCooldown2 = false

getgenv().Debug = false

getgenv().AutoVault = false
getgenv().Item = ""
getgenv().VaultTPBack = false
getgenv().VaultFull = false

getgenv().FloppaName = "FrostX"

-- OTHER
 
local SaveEvent = game:GetService("ReplicatedStorage").Events.Save
local BuyEvent = game:GetService("ReplicatedStorage").Events.Unlock
local CollectRentEvent = game:GetService("ReplicatedStorage").Events["Collect Rent"]
local RaiseRentEvent = game:GetService("ReplicatedStorage").Events["Raise Rent"]

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

local Credits3 = Credits.AddLabel("Script Version: v1.6 (AutoUpgrade)")

local Credits3 = Credits.AddLabel("UI Lib - Kinlei#6459 (modified by Frost X#6215)")

-- MAKE PARTS

local toiletPart = Instance.new("Part")
toiletPart.Anchored = true
toiletPart.CFrame = CFrame.new(-74.0611572, 76, -19.4405117)

if not workspace:FindFirstChild("ToiletPart") then
    toiletPart.Parent = workspace
    toiletPart.Name = "ToiletPart"
    toiletPart.Transparency = 1
    toiletPart.CanCollide = false

    local toiletPartBox = Instance.new("BoxHandleAdornment")
    toiletPartBox.Adornee = toiletPart
    toiletPartBox.Parent = toiletPart

    local toiletPartGUI = Instance.new("BillboardGui")
    toiletPartGUI.Parent = toiletPart
    toiletPartGUI.Size = UDim2.new(0, 100, 0, 50)
    toiletPartGUI.AlwaysOnTop = true
    toiletPartGUI.MaxDistance = 30

    local toiletPartGUItext = Instance.new("TextLabel")
    toiletPartGUItext.Parent = toiletPartGUI
    toiletPartGUItext.Size = UDim2.new(1, 0, 1, 0)
    toiletPartGUItext.Text = "[FS V2] ToiletPart"
else
    toiletPart:Destroy()
end

local foodPart = Instance.new("Part")
foodPart.Anchored = true
foodPart.CFrame = CFrame.new(-40.3067436, 76, -19.1339455)

if not workspace:FindFirstChild("FoodPart") then
    foodPart.Parent = workspace
    foodPart.Name = "FoodPart"
    foodPart.Transparency = 1
    foodPart.CanCollide = false

    local foodPartBox = Instance.new("BoxHandleAdornment")
    foodPartBox.Adornee = foodPart
    foodPartBox.Parent = foodPart

    local foodPartGUI = Instance.new("BillboardGui")
    foodPartGUI.Parent = foodPart
    foodPartGUI.Size = UDim2.new(0, 100, 0, 50)
    foodPartGUI.AlwaysOnTop = true
    foodPartGUI.MaxDistance = 30

    local foodPartGUItext = Instance.new("TextLabel")
    foodPartGUItext.Parent = foodPartGUI
    foodPartGUItext.Size = UDim2.new(1, 0, 1, 0)
    foodPartGUItext.Text = "[FS V2] FoodPart"
else
    foodPart:Destroy()
end

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

writefile("FromizRug.png", game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/roblox-scripts/main/FloppaV2/assets/FromizRug.png"))

if workspace.Unlocks:FindFirstChild("Fancy Rug") then
    workspace.Unlocks["Fancy Rug"].Rug.Texture = getcustomasset("FromizRug.png")
    delfile("FromizRug.png")
end

local TPHome = Teleports.AddButton("IN-Home Teleport", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.InsidePoint.CFrame
end)

local TPHome = Teleports.AddButton("Basement Teleport", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame
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
    wait(1)
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
        music.TimePosition = 30
        music.Looped = true

        notification_new("Nostalgic mode", "Toggled ON", 2)

        repeat
            music.Volume += 0.1
            wait(0.2)
        until music.Volume >= 1

        music.Volume = 1
        music:Play()

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

local MiscRenameFloppas = Misc.AddButton("Rename All Baby Floppas", function()
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
        item.Parent = game.Players.LocalPlayer.Character
        fireproximityprompt(workspace.Unlocks["Small Vault"].Base.ProximityPrompt, 1)
    end

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last_CFrame
end)

items = {"Milk", "Floppa Food", "Meteorite"}

local MainItemToVault = Main.AddDropdown("Auto-Vault Item", items, function(selected)
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
local MainAutoCollectMoney = Main.AddToggle("AutoCollect Money", false, function(toggled)
    if toggled then
        getgenv().AutoCollectMoney = true
    else
        getgenv().AutoCollectMoney = false
    end
end)
local MainAutoUpgrade = Main.AddToggle("AutoUpgrade", false, function(toggled)
    if toggled then
        getgenv().AutoUpgrade = true
    else
        getgenv().AutoUpgrade = false
    end
end)
local MainAutoSave = Main.AddToggle("AutoSave (LAG!)", false, function(toggled)
    if toggled then
        getgenv().AutoSave = true
    else
        getgenv().AutoSave = false
    end
end)

local MainAutoFood = Main.AddToggle("AutoFood", false, function(toggled)
    if toggled then
        getgenv().AutoFood = true
    else
        getgenv().AutoFood = false
    end
end)

local MainAutoCleaner = Main.AddToggle("AutoCleaner", false, function(toggled)
    if toggled then
        getgenv().AutoCleaner = true
    else
        getgenv().AutoCleaner = false
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
    if getgenv().AutoPet then
        if workspace.Floppa.Configuration.Happiness.Value < 51 and workspace.Floppa.Configuration.Hunger.Value > 51 then
            local prox = workspace.Floppa.HumanoidRootPart:WaitForChild("ProximityPrompt")
            if prox.ActionText == "Pet" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Floppa.HumanoidRootPart.CFrame + Vector3.new(0, 1, 0)
                fireproximityprompt(prox, 1)
            end
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
        for i, v in pairs(workspace:GetChildren()) do
            if v.Name == "Money" or v.Name == "Money Bag" or v.Name == "Rent" then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v)
            end
        end
    end
    if getgenv().AutoSave then
        if not getgenv().AutoSaveCooldown then
            SaveEvent:FireServer()
            notification_new("AutoSave", "Saved.", 1)
            getgenv().AutoSaveCooldown = true
            wait(10)
            getgenv().AutoSaveCooldown = false
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
            end
        end
    end

    if getgenv().AutoFood then
        local findFood1 = game.Players.LocalPlayer.Backpack:FindFirstChild("Floppa Food")
        local findFood2 = game.Players.LocalPlayer.Character:FindFirstChild("Floppa Food")

        if findFood1 then
            if workspace["Key Parts"].Bowl.Part.Transparency == 1 then
                findFood1.Parent = game.Players.LocalPlayer.Character
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = foodPart.CFrame
                fireproximityprompt(workspace["Key Parts"].Bowl.Part.ProximityPrompt, 1)
            end
        else
            if findFood2 then
                if workspace["Key Parts"].Bowl.Part.Transparency == 1 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = foodPart.CFrame
                    fireproximityprompt(workspace["Key Parts"].Bowl.Part.ProximityPrompt, 1)
                else
                    game.Players.LocalPlayer.Character["Floppa Food"].Parent = game.Players.LocalPlayer.Backpack
                end
            else  
                if workspace["Key Parts"].Bowl.Part.Transparency == 1 then
                    BuyEvent:FireServer("Floppa Food", "the_interwebs")
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = foodPart.CFrame
                    fireproximityprompt(workspace["Key Parts"].Bowl.Part.ProximityPrompt, 1)

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
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = toiletPart.CFrame
            local prox = findPoop:WaitForChild("ProximityPrompt")
            fireproximityprompt(findPoop.ProximityPrompt, 1)
            notification_new("Auto-Cleaner", "Cleaned poop which is in litter box.", 0.5)
        end
        if findPoop2 then
            findPoop2.PoopPart.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = findPoop2.PoopPart.CFrame
            local prox = findPoop2:WaitForChild("ProximityPrompt")
            fireproximityprompt(prox, 1)
            notification_new("Auto-Cleaner", "Cleaned poop which isn't in litter box.", 0.5)
        end
    end

    if getgenv().AutoRoommate then
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

    if getgenv().AutoVault then
        local getVault = workspace.Unlocks:FindFirstChild("Small Vault")

        if getVault then
            for i, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if getgenv().Item ~= "" and item.Name == getgenv().Item then
                    if #game.ReplicatedStorage["Small Vault"]:GetChildren() ~= 100 then
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
end

-- Goodbye.
