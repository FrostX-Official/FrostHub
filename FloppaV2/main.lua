-- Floppa V2 by Frost X#6215 -- Credits to Xylex (Roblox VapeV4 Owner) for GitHub scripts and functions.

if getgenv().Executed then
    error("[FS V2] Script already Executed!")
    return
else
    getgenv().Executed = true
end

local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end

local function GetURL(scripturl)
	if getgenv().Developer then
		if not betterisfile("FloppaV2/"..scripturl) then
			error("File not found : FloppaV2/"..scripturl)
		end
		return readfile("FloppaV2/"..scripturl)
	else
		local res = game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/roblox-scripts/main/FloppaV2/"..scripturl, true)
		assert(res ~= "404: Not Found", "File not found")
		return res
	end
end

-- VARIABLES ~ TOGGLES


local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
    if tab.Method == "GET" then
        return {
            Body = game:HttpGet(tab.Url, true),
            Headers = {},
            StatusCode = 200
        }
    else
        return {
            Body = "cringe exploit, shit.",
            Headers = {},
            StatusCode = 404
        }
    end
end 

local function checkvers()
    local req = requestfunc({
        Url = "https://raw.githubusercontent.com/FrostX-Official/roblox-scripts/main/FloppaV2/version.txt",
        Method = "GET"
    })
    if req.StatusCode == 200 then
        return req.Body
    else
        return nil
    end
end

local GuiLib = loadstring(GetURL("GuiLib.lua"))()

local SkinsMod = require(game.ReplicatedStorage.Modules.Skins)
local StoreMod = require(game:GetService("ReplicatedStorage").Modules.Storables)
local vu = game:GetService("VirtualUser")

local vers = "1.8"

getgenv().AutoPet = false
getgenv().AutoPetHappiness = 50
getgenv().AutoClicker = false

getgenv().AutoCollectMoney = false
getgenv().AutoCollectMoneyFloppaInc = 10000000000

getgenv().AutoFood = false
getgenv().AutoFoodCooldown = false

getgenv().AutoPlant = false
getgenv().AutoPlantPlants = 10

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
getgenv().AutoVaultItem = ""
getgenv().VaultTPBack = false
getgenv().VaultFull = false
getgenv().Version = checkvers()

getgenv().Status = "Loaded!"

if tonumber(vers) >= tonumber(getgenv().Version) then
    print("Fresh Script, your version: "..tostring(vers)..", github version: "..tostring(getgenv().Version))
else
    print("You using old script, go use loadstring you mf.")
end

table.remove(StoreMod, 39)
AutoVault_items = StoreMod

getgenv().FloppaName = "FS V2 ON TOP!"

-- ANTI-AFK

game.Players.LocalPlayer.Idled:Connect(function()
   vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- OTHER

local HRP = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
 
local SaveEvent = game:GetService("ReplicatedStorage").Events.Save
local BuyEvent = game:GetService("ReplicatedStorage").Events.Unlock
local CollectRentEvent = game:GetService("ReplicatedStorage").Events["Collect Rent"]
local RaiseRentEvent = game:GetService("ReplicatedStorage").Events["Raise Rent"]
local BingusViceEvent = game:GetService("ReplicatedStorage").Events["Mysterious Dialog"]
local SafeEvent = game:GetService("ReplicatedStorage").Events["Small Vault"]
local CookingEvent = game:GetService("ReplicatedStorage").Events.Cooking

local MainWindow = GuiLib.Load("FLOPPA SCRIPT V2", true)

local Main = MainWindow.AddPage("Main", false)
local Misc = MainWindow.AddPage("Misc", false)
local Cooking = MainWindow.AddPage("Cooking", false)
local Skins = MainWindow.AddPage("Skins", false)
local Shop = MainWindow.AddPage("Shop", false)
local Teleports = MainWindow.AddPage("Teleports", false) -- still no TPs lol
local Credits = MainWindow.AddPage("Credits", false)
local Premium = MainWindow.AddPage("Premium", false)
local Status = MainWindow.AddPage("Status", false)

-- CREDITS

local CreditsOwn = Credits.AddLabel("Owner - Frost X#6215")
local Credits1 = Credits.AddLabel("Scripting - Frost X#6215")
local Credits2 = Credits.AddLabel("Idea - Frost X#6215")

local Credits3 = Credits.AddLabel("Script Version: "..vers.." (Watch github changelog below)")
local Credits4 = Credits.AddLabel("FrostX-Official/roblox-scripts/tree/main/FloppaV2")

local Credits5 = Credits.AddLabel("UI Lib - Kinlei#6459 (modified by Frost X#6215)")

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

local function check_vault(item)
    if item ~= nil then
        local findInVault = game.ReplicatedStorage["Small Vault"]:FindFirstChild(item)

        if findInVault then
            return true
        else
            return false
        end
    end
end

local Status1 = Status.AddLabel("Status: Loading...")

local SkinCyborg = Skins.AddButton("Cyborg", function()
    for i, texture in pairs(workspace.Floppa.Head:GetChildren()) do
        local textureName = texture.Name
        texture.Texture = SkinsMod.Cyborg[textureName]
        getgenv().Status = textureName.." texture of Floppa changed."
    end
end)
local SkinDrip = Skins.AddButton("Drip", function()
    for i, texture in pairs(workspace.Floppa.Head:GetChildren()) do
        local textureName = texture.Name
        texture.Texture = SkinsMod.Drip[textureName]
        getgenv().Status = textureName.." texture of Floppa changed."
    end
end)
local SkinNerd = Skins.AddButton("Nerd", function()
    for i, texture in pairs(workspace.Floppa.Head:GetChildren()) do
        local textureName = texture.Name
        texture.Texture = SkinsMod.Nerd[textureName]
        getgenv().Status = textureName.." texture of Floppa changed."
    end
end)
local SkinGamer = Skins.AddButton("Gamer", function()
    for i, texture in pairs(workspace.Floppa.Head:GetChildren()) do
        local textureName = texture.Name
        texture.Texture = SkinsMod.Gamer[textureName]
        getgenv().Status = textureName.." texture of Floppa changed."
    end
end)
local SkinRich = Skins.AddButton("Rich", function()
    for i, texture in pairs(workspace.Floppa.Head:GetChildren()) do
        local textureName = texture.Name
        texture.Texture = SkinsMod.Rich[textureName]
        getgenv().Status = textureName.." texture of Floppa changed."
    end
end)

local PremiumLabel = Premium.AddLabel("There is no premium you bum, it's open-source!")

writefile("FromizRug.png", game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/roblox-scripts/main/FloppaV2/assets/FromizRug.png"))

if workspace.Unlocks:FindFirstChild("Fancy Rug") then
    workspace.Unlocks["Fancy Rug"].Rug.Texture = getcustomasset("FromizRug.png")
    delfile("FromizRug.png")
end

local TPHome = Teleports.AddButton("IN-Home Teleport", function()
    HRP.CFrame = workspace.InsidePoint.CFrame
    getgenv().Status = "Teleported to IN-Home."
end)

local TPFoodShop = Teleports.AddButton("FoodShop", function()
    HRP.CFrame = CFrame.new(59.5960388, 71.4648514, -118.311279)
    getgenv().Status = "Teleported to Food Shop"
end)

local TPExtraShop = Teleports.AddButton("ExtraShop", function()
    HRP.CFrame = CFrame.new(-0.967693269, 70.4992218, -109.236588)
    getgenv().Status = "Teleported to Extra Shop"
end)

local TPFishArea = Teleports.AddButton("Fishing Area", function()
    HRP.CFrame = CFrame.new(-8.46691895, 69.5943451, 7.40960598)
    getgenv().Status = "Teleported to Fishing Area"
end)

local TPSecondFloor = Teleports.AddButton("Second Floor", function()
    HRP.CFrame = workspace.WanderPoints2ndFloor.Point.CFrame
    
    getgenv().Status = "Teleported to Fishing Area"
end)

local TPBasement = Teleports.AddButton("Basement", function()
    HRP.CFrame = workspace.WanderPointsBasement.Point.CFrame
    
    getgenv().Status = "Teleported to Fishing Area"
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
    local last_CFrame = HRP.CFrame

    HRP.CFrame = workspace.Village.SwordStore.Villager.HumanoidRootPart.CFrame
    getgenv().Status = "Buying sword..."
    fireproximityprompt(workspace.Village.SwordStore.Villager.HumanoidRootPart.ProximityPrompt, 1)
    HRP.CFrame = last_CFrame
    getgenv().Status = "Bought sword! (idk if script really bought it.)"
end)

local MiscNostalgicMode = Misc.AddButton("Nostalgic Mode (Fall Ambience)", function()
    local findNostalgic = workspace:FindFirstChild("Nostalgic")

    if findNostalgic then
        notification_new("Nostalgic mode", "Toggled OFF", 2)

        findNostalgic:Destroy()
        workspace.Ambience.Playing = true
        getgenv().Status = "Why did you turned off Nostalgic mode?"
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
        getgenv().Status = "This music is lit..."

        while wait(1) do
            if workspace.Ambience.Playing == true then
                music:Stop()
                getgenv().Status = "AYO! Game turned off Nostalgic mode!"
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
            getgenv().Status = 'Renamed "Baby Floppa" to "'..getgenv().FloppaName..'"'
        end
    end
end)

local FloppaRenaming2 = Misc.AddLabel("~ ⭕ ~")

local CookingGrlChez = Cooking.AddButton("Grilled Cheese", function()
    if check_vault("Bread") and check_vault("Cheese") then
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Bread"])
        CookingEvent:FireServer("Add Ingredient", "Bread")
        wait(0.2)
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Cheese"])
        CookingEvent:FireServer("Add Ingredient", "Cheese")

        wait(0.1)

        CookingEvent:FireServer("Change Temperature", 3)
        CookingEvent:FireServer("Cook")
    end
end)
local CookingVgtSoup = Cooking.AddButton("Vegetable Soup", function()
    if check_vault("Noodles") and check_vault("Lettuce") and check_vault("Carrot") then
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Noodles"])
        CookingEvent:FireServer("Add Ingredient", "Noodles")
        wait(0.2)
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Lettuce"])
        CookingEvent:FireServer("Add Ingredient", "Lettuce")
        wait(0.2)
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Carrot"])
        CookingEvent:FireServer("Add Ingredient", "Carrot")

        wait(0.1)

        CookingEvent:FireServer("Change Temperature", 1)
        CookingEvent:FireServer("Cook")
    end
end)
local CookingBurg = Cooking.AddButton("Burger", function()
    if check_vault("Bread") and check_vault("Lettuce") and check_vault("Tomato") and check_vault("Beef") then
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Bread"])
        CookingEvent:FireServer("Add Ingredient", "Bread")
        wait(0.2)
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Lettuce"])
        CookingEvent:FireServer("Add Ingredient", "Lettuce")
        wait(0.2)
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Tomato"])
        CookingEvent:FireServer("Add Ingredient", "Tomato")
        wait(0.2)
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Beef"])
        CookingEvent:FireServer("Add Ingredient", "Beef")

        wait(0.1)

        CookingEvent:FireServer("Change Temperature", 2)
        CookingEvent:FireServer("Cook")
    end
end)
local CookingCake = Cooking.AddButton("Cake", function()
    if check_vault("Egg") and check_vault("Milk") and check_vault("Flour") and check_vault("Sugar") then
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Egg"])
        CookingEvent:FireServer("Add Ingredient", "Egg")
        wait(0.2)
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Milk"])
        CookingEvent:FireServer("Add Ingredient", "Milk")
        wait(0.2)
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Flour"])
        CookingEvent:FireServer("Add Ingredient", "Flour")
        wait(0.2)
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Sugar"])
        CookingEvent:FireServer("Add Ingredient", "Sugar")

        wait(0.1)

        CookingEvent:FireServer("Change Temperature", 1)
        CookingEvent:FireServer("Cook")
    end
end)
local CookingSpcSoup = Cooking.AddButton("Space Soup", function()
    if check_vault("Carrot") and check_vault("Noodles") then
        if check_vault("Meteorite") then
            local meteor_count = 0
            for i, v in pairs(game.ReplicatedStorage["Small Vault"]:GetChildren()) do
                if v.Name == "Meteorite" then
                    meteor_count += 1
                end

            end

            if meteor_count >= 2 then
                SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Meteorite"])
                CookingEvent:FireServer("Add Ingredient", "Meteorite")
                wait(0.2)
                SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Meteorite"])
                CookingEvent:FireServer("Add Ingredient", "Meteorite")
                wait(0.2)
                SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Noodles"])
                CookingEvent:FireServer("Add Ingredient", "Noodles")
                wait(0.2)
                SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Carrot"])
                CookingEvent:FireServer("Add Ingredient", "Carrot")

                wait(0.1)

                CookingEvent:FireServer("Change Temperature", 1)
                CookingEvent:FireServer("Cook")
            end
        end
    end
end)

local MainRemoveCold = Main.AddButton("Remove Cold (Winter)", function()
    local check_winter = workspace.World.Foliage:FindFirstChild("Hot Chocolate Stand")

    if check_winter then
        HRP.CFrame = check_winter.HotChocolate.CFrame
        local prox = check_winter.HotChocolate.ProximityPrompt
        wait(0.2)
        fireproximityprompt(prox, 1)
        wait(0.2)
        HRP.CFrame = workspace.Floppa.HumanoidRootPart.CFrame
        local floppa_prox = workspace.Floppa.HumanoidRootPart:WaitForChild("ProximityPrompt")
        wait(0.2)
        if floppa_prox.ActionText == "Feed Hot Chocolate" then
            fireproximityprompt(floppa_prox, 1)
            getgenv().Status = "Removed cold from this world! :)"
        end
    end
end)

local MainRemoveHot = Main.AddButton("Remove Hot (Summer)", function()
    local check_summer = workspace.World.Foliage:FindFirstChild("Lemonade Stand")

    if check_summer then
        HRP.CFrame = check_summer.Handle.CFrame
        local prox = check_summer.Handle.ProximityPrompt
        wait(0.1)
        fireproximityprompt(prox, 1)
        wait(0.1)
        HRP.CFrame = workspace.Floppa.HumanoidRootPart.CFrame
        local floppa_prox = workspace.Floppa.HumanoidRootPart:WaitForChild("ProximityPrompt")
        wait(0.1)
        if floppa_prox.ActionText == "Feed Lemonade" then
            fireproximityprompt(floppa_prox, 1)
            getgenv().Status = "Removed hot from this world! :)"
        end
    end
end)

local MainRemoveSickness = Main.AddButton("Remove Sick", function()
    if check_vault("Noodles") and check_vault("Lettuce") and check_vault("Carrot") then
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Noodles"])
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Lettuce"])
        SafeEvent:FireServer(game.ReplicatedStorage["Small Vault"]["Carrot"])

        wait(0.1)
        CookingEvent:FireServer("Add Ingredient", "Carrot")

        wait(0.5)

        game.Players.LocalPlayer.Backpack.Noodles.Parent = game.Players.LocalPlayer.Character
        wait(0.1)
        CookingEvent:FireServer("Add Ingredient", "Noodles") 

        wait(0.5)

        game.Players.LocalPlayer.Backpack.Lettuce.Parent = game.Players.LocalPlayer.Character
        wait(0.1)
        CookingEvent:FireServer("Add Ingredient", "Lettuce")

        CookingEvent:FireServer("Change Temperature", 1)
        CookingEvent:FireServer("Cook")

        wait(61)

        local CoockedSoup = workspace:FindFirstChild("Vegetable Soup")

        if CoockedSoup then
            wait(0.5)
            firetouchinterest(HRP, CoockedSoup.Handle)

            local floppa_prox = workspace.Floppa.HumanoidRootPart:FindFirstChild("ProximityPrompt")
            wait(0.5)

            HRP.CFrame = workspace.Floppa.HumanoidRootPart.CFrame + Vector3.new(0, 1, 0)
            fireproximityprompt(floppa_prox, 1)
        
        end
    end
end)

local AutoVault = Main.AddLabel("Auto-Vaulting")

local MainStoreEverything = Main.AddButton("Store Everything in Vault", function()
    local last_CFrame = HRP.CFrame

    HRP.CFrame = workspace.Unlocks["Small Vault"].Base.CFrame
    wait(1)
    for i, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if item.Name ~= "Excalibur" then
            item.Parent = game.Players.LocalPlayer.Character
            fireproximityprompt(workspace.Unlocks["Small Vault"].Base.ProximityPrompt, 1)
            getgenv().Status = item.Name.." in the Vault!"
        end
    end

    HRP.CFrame = last_CFrame
    getgenv().Status = "Stored Everything :)"
end)

local MainItemToVault = Main.AddDropdown("Auto-Vault Item", AutoVault_items, function(selected)
    getgenv().AutoVaultItem = selected
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
    local last_CFrame = HRP.CFrame

    HRP.CFrame = workspace.SpawnLocation.CFrame
    wait(0.5)
    HRP.CFrame = last_CFrame
    getgenv().Status = "Gained Sanity."
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

local MainAutoPetHappiness = Main.AddSlider("AutoPet Minimum Happiness Use", {Min = 0, Max = 100, Def = 50}, function(Value)
    getgenv().AutoPetHappiness = Value
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
local MainAutoCollectMoneyFloppaInc = Main.AddSlider("AutoCollect Floppa Inc", {Min = 1, Max = 50000000000, Def = 10000000000}, function(Value)
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
local MainAutoPlantPlants = Main.AddSlider("AutoPlant Plants", {Min = 1, Max = 53, Def = 10}, function(Value)
    getgenv().AutoPlantPlants = Value
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
        if workspace.Floppa.Configuration.Happiness.Value <= getgenv().AutoPetHappiness and workspace.Floppa.Configuration.Hunger.Value > 35 then
            local prox = workspace.Floppa.HumanoidRootPart:WaitForChild("ProximityPrompt")
            if prox.ActionText == "Pet" then
                HRP.CFrame = workspace.Floppa.HumanoidRootPart.CFrame + Vector3.new(0, 1, 0)
                fireproximityprompt(prox, 1)
                getgenv().Status = "Floppa got petted :))"
            end
        end
    end
    if getgenv().AutoDJ then
        local DJ = workspace.Unlocks:FindFirstChild("DJ El Gato")

        if DJ then
            if DJ.Cooldown.Value == 0 then
                HRP.CFrame = DJ.Primary.CFrame + Vector3.new(0, 2, 0)
                local prox = DJ.Primary.ProximityPrompt
                fireproximityprompt(prox, 1)
                getgenv().Status = "Yoo! Party 🎉"
            end
        end
    end
    if getgenv().AutoBackrooms then
        local BackroomsLevel = game.Players.LocalPlayer.BackroomsLevel.Value
        if BackroomsLevel < 4 then
            HRP.CFrame = workspace.Backrooms.Rooms["Backrooms 10"].Exit.Primary.CFrame
            local prox = workspace.Backrooms.Rooms["Backrooms 10"].Exit.Frame:FindFirstChild("ProximityPrompt")
            fireproximityprompt(prox, 1)
            getgenv().Status = "Teleporting thru backrooms..."
        else
            local prox = workspace.Backrooms["Almond Water"]:FindFirstChild("ProximityPrompt")
            HRP.CFrame = workspace.Backrooms["Almond Water"].CFrame
            fireproximityprompt(prox, 1)
            getgenv().Status = "Got Almond Water! :D"
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
                HRP.CFrame = detect_floppainc.Board.CFrame
                fireproximityprompt(detect_floppainc.Board.Prompt, 1)
            end
        end
        for i, v in pairs(workspace:GetChildren()) do
            if v.Name == "Money" or v.Name == "Money Bag" or v.Name == "Rent" then
                firetouchinterest(HRP, v)
            end
            if v.Name == "Bingus Cult Prize" then
                for i, prize in pairs(v:GetChildren()) do
                    if prize.Name == "Money Bag" then
                        firetouchinterest(HRP, prize.Handle)
                        getgenv().Status = "Congrats on winning boss!"
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
                         
                        HRP.CFrame = hitPart.CFrame

                        local getSword = game.Players.LocalPlayer.Character:FindFirstChild("Excalibur") or game.Players.LocalPlayer.Character:FindFirstChild("Sword")
                        local getSwordBackpack = game.Players.LocalPlayer.Backpack:FindFirstChild("Excalibur") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sword")

                        if not getSword then
                            if getSwordBackpack then
                                getSwordBackpack.Parent = game.Players.LocalPlayer.Character
                            else
                                if not getgenv().AutoKillBuying then
                                    getgenv().AutoKillBuying = true
                                    local last_CFrame = HRP.CFrame

                                    HRP.CFrame = workspace.Village.SwordStore.Villager.HumanoidRootPart.CFrame
                                    fireproximityprompt(workspace.Village.SwordStore.Villager.HumanoidRootPart.ProximityPrompt, 1)
                                    HRP.CFrame = last_CFrame
                                    wait(0.2)
                                    getgenv().AutoKillBuying = false
                                end
                            end
                        else
                            if getSword.Parent == game.Players.LocalPlayer.Character then
                                if game.Players.LocalPlayer.Character.Humanoid.Health > 2 then
                                    getSword:Activate()
                                    getgenv().Status = "Spamming sword!!! 😈"
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
                         
                        HRP.CFrame = workspace.Floppa.HumanoidRootPart.CFrame
                        item.Parent = game.Players.LocalPlayer.Character
                        local prox = workspace.Floppa.HumanoidRootPart:WaitForChild("ProximityPrompt")
                        wait(0.5)
                        if prox.ActionText == "Feed Almond Water" then
                            fireproximityprompt(prox, 1)
                            getgenv().Status = "+1 HP to Floppa."
                        end
                    end
                end
            end
            if item.Name == "Catnip" then
                if workspace.Floppa.Configuration.Happiness.Value > 65 and workspace.Floppa.Configuration.Happiness.Value < 80.5 and workspace.Floppa.Moodlets.Sick.Value == false then
                    if not getgenv().AutoVault then
                        HRP.CFrame = workspace.Floppa.HumanoidRootPart.CFrame
                        item.Parent = game.Players.LocalPlayer.Character
                        local prox = workspace.Floppa.HumanoidRootPart:WaitForChild("ProximityPrompt")
                        wait(0.5)
                        if prox.ActionText == "Feed Catnip" then
                            fireproximityprompt(prox, 1)
                            getgenv().Status = "Floppa goes crazy after catnip!"
                        end
                    end
                end
            end
            if item.Name == "Money Bag" then
                local findMoneyInChar = game.Players.LocalPlayer.Character:FindFirstChild("Money Bag")
                if not findMoneyInChar then
                    if not getgenv().AutoVault then
                        item.Parent = game.Players.LocalPlayer.Character
                        getgenv().Status = "Equipping money bags..."
                    end
                end
            end
        end
    end

    if getgenv().AutoPickup then
        for i, seed in pairs(workspace.Seeds:GetChildren()) do
            HRP.CFrame = seed.CFrame
            local prox = seed:WaitForChild("ProximityPrompt")
            fireproximityprompt(prox, 1)

            getgenv().Status = "Got seed."
        end
        for i, v in pairs(workspace:GetChildren()) do
            if v.Name == "Meteorite" then
                 
                HRP.CFrame = v.Handle.CFrame
                getgenv().Status = "Got meteorite."
            elseif v.Name == "Milk Delivery" then
                local crate = v:WaitForChild("Crate")
                 
                HRP.CFrame = crate.CFrame
                fireproximityprompt(crate.ProximityPrompt, 1)
                getgenv().Status = "Got milk."
            end
        end
    end

    if getgenv().AutoSummon then
        local check_bingus = workspace.Unlocks:FindFirstChild("Cursed Altar")

        if check_bingus then
            if not check_bingus.Activated.Value then
                 
                HRP.CFrame = check_bingus.Bingus.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
                fireproximityprompt(check_bingus.Bingus.HumanoidRootPart.ProximityPrompt, 1)
                getgenv().Status = "BOSS IS COMING!!! 😈"
            end
        else
            BingusViceEvent:FireServer()
            getgenv().Status = "Fired bingus event, ig?"
        end
    end

    if getgenv().AutoPlant then
        for i, item in pairs(workspace.Unlocks:GetChildren()) do
            if item.Name == "Planter" then 
                if item.Sequence.Value <= getgenv().AutoPlantPlants then
                    if item.Plant.Value == "" or item.Plant.Value == nil then
                        for i, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if tool.Name:match("Seed") or tool.Name:match("Spore") then
                                tool.Parent = game.Players.LocalPlayer.Character
                                 
                                HRP.CFrame = item.Soil.CFrame + Vector3.new(0, 2, 0)
                                wait(0.2)
                                if tool.Parent == game.Players.LocalPlayer.Character then
                                    fireproximityprompt(item.Soil.ProximityPrompt, 1)
                                    getgenv().Status = "AutoPlant is cool."
                                end
                            end
                        end
                    else
                        if item.Growth.Value >= 100 then
                            HRP.CFrame = item.Soil.CFrame + Vector3.new(0, 2, 0)
                            fireproximityprompt(item.Soil.ProximityPrompt, 1)
                            getgenv().Status = "Harvested some plant."
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
                    HRP.CFrame = workspace["Key Parts"].Bowl.Part.CFrame + Vector3.new(0, 4, 0)
                    fireproximityprompt(workspace["Key Parts"].Bowl.Part.ProximityPrompt, 1)
                    wait(0.2)
                    getgenv().AutoFoodCooldown = false
                end
            else
                if findFood2 then
                    if workspace["Key Parts"].Bowl.Part.Transparency == 1 then
                        getgenv().AutoFoodCooldown = true
                        HRP.CFrame = workspace["Key Parts"].Bowl.Part.CFrame + Vector3.new(0, 4, 0)
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
                        HRP.CFrame = workspace["Key Parts"].Bowl.Part.CFrame + Vector3.new(0, 4, 0)
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
            HRP.CFrame = findPoop.PoopPart.CFrame + Vector3.new(0, 3, 0)
            local prox = findPoop:WaitForChild("ProximityPrompt")
            fireproximityprompt(findPoop.ProximityPrompt, 1)
            notification_new("Auto-Cleaner", "Cleaned poop which is in litter box.", 0.5)
            getgenv().Status = "Cleaned poop... :flushed:"
        end
        if findPoop2 then
            findPoop2.PoopPart.CanCollide = false
            HRP.CFrame = findPoop2.PoopPart.CFrame + Vector3.new(0, 3, 0)
            local prox = findPoop2:WaitForChild("ProximityPrompt")
            fireproximityprompt(prox, 1)
            notification_new("Auto-Cleaner", "Cleaned poop which isn't in litter box.", 0.5)
            getgenv().Status = "Cleaned poop... :flushed:"
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
                    getgenv().Status = "Raised rent."
                end
            end
            if workspace.Unlocks.Roommate["Can Collect"].Value == true then
                if getgenv().AutoRoommateCooldown2 == false then
                    getgenv().AutoRoommateCooldown2 = true
                    CollectRentEvent:FireServer()
                    notification_new("AutoRoommate", "Collected roommate money.", 0.5)
                    getgenv().AutoRoommateCooldown2 = false
                    getgenv().Status = "Collected rent."
                end
            end
        end
    end

    if getgenv().AutoVault then
        local getVault = workspace.Unlocks:FindFirstChild("Small Vault")

        if getVault then
            for i, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if getgenv().Item ~= "" and item.Name == getgenv().AutoVaultItem then
                    if #game.ReplicatedStorage["Small Vault"]:GetChildren() < 100 then
                        getgenv().VaultFull = false
                        HRP.CFrame = workspace.Unlocks["Small Vault"].Base.CFrame

                        item.Parent = game.Players.LocalPlayer.Character
                        wait(0.2)
                        fireproximityprompt(workspace.Unlocks["Small Vault"].Base.ProximityPrompt, 1)
                        notification_new("Auto-Vault", "Added item to Vault.", 0.2)
                        getgenv().Status = "Added item to Vault, ig?"
                        wait(0.2)
                        HRP.CFrame = workspace.InsidePoint.CFrame
                        notification_new("Auto-Vault", "Teleported IN-Home", 0.4)
                        getgenv().Status = "Teleported IN-Home"
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
            gui.MaxDistance = 30
            gui.Size = UDim2.new(0, 100, 0, 50)
            gui.StudsOffset = Vector3.new(0, 3.5, 0)
            gui.Parent = findVault.Base

            local text = Instance.new("TextLabel")
            text.Parent = gui
            text.Text = "Loading FS V2."
            text.BackgroundTransparency = 1
            text.TextScaled = true
            text.TextColor3 = Color3.new(255, 255, 255)
            text.Size = UDim2.new(1, 0, 1, 0)
        else
            findGui.TextLabel.Text = #game.ReplicatedStorage["Small Vault"]:GetChildren().."/100"
        end
    end

    local check_vault_gui = game.Players.LocalPlayer.PlayerGui.FloppaUI.Frame.Buttons:FindFirstChild("Vault")

    if not check_vault_gui then
        local vault = game.Players.LocalPlayer.PlayerGui.FloppaUI.Frame.Buttons.Mute:Clone()
        vault.Parent = game.Players.LocalPlayer.PlayerGui.FloppaUI.Frame.Buttons
        vault.Name = "Vault"
        vault.Mute.Name = "Vault"
        vault.Vault.Text = "🔐"
        vault.Header.Text = "Vault"

        vault.MouseButton1Click:Connect(function()
            game.Players.LocalPlayer.PlayerGui.PlayerUI["Small Vault"].Visible = true
        end)
    end

    local check_floppainc_gui = game.Players.LocalPlayer.PlayerGui.HUD.Left:FindFirstChild("FloppaIncMoney Label")

    if not check_floppainc_gui then
        local label = game.Players.LocalPlayer.PlayerGui.HUD.Left["Money Label"]:Clone()
        label.Parent = game.Players.LocalPlayer.PlayerGui.HUD.Left
        label.Name = "FloppaIncMoney Label"
        label.Position = UDim2.new(0, 0, 0.4, 0)

        local get_floppa_inc = workspace.Unlocks:FindFirstChild("Floppa Inc")

        if get_floppa_inc then
            local abbreviated = GuiLib.Abbreviate(get_floppa_inc.Profits.Value)
            label.Text = "Floppa Inc: $"..abbreviated
        else
            label.Text = "Floppa Inc: $0"
        end
    else
        local get_floppa_inc = workspace.Unlocks:FindFirstChild("Floppa Inc")

        if get_floppa_inc then
            local abbreviated = GuiLib.Abbreviate(get_floppa_inc.Profits.Value)
            check_floppainc_gui.Text = "Floppa Inc: $"..abbreviated
        else
            label.Text = "Floppa Inc: $0"
        end
    end

    Status1.ChangeText("Status: "..tostring(getgenv().Status))

end

-- Goodbye.
