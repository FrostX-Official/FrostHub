local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end

local function GetURL(scripturl)
    if getgenv().FrostHubDeveloper then
        if not betterisfile("FrostHub/"..scripturl) then
            error("File not found : FrostHub/"..scripturl)
        end
        return readfile("FrostHub/"..scripturl)
    else
		local res = game:HttpGet("https://raw.githubusercontent.com/FrostX-Official/FrostHub/main/"..scripturl, true)
		assert(res ~= "404: Not Found", "File not found")
		return res
	end
end

local GuiLib = loadstring(GetURL("GuiLib.lua"), true)()

local FloppaV2Sc = GetURL("FloppaV2/main.lua")
local consoleprint = rconsoleprint

if not consoleprint then warn("Not supported exploit! Use KRNL or Synapse X") return end

getgenv().FrostHubStatus = "Status: Loading Hub"

local MainWindow = GuiLib.Load("FrostHub", true)
local Status = MainWindow.AddPage("Status", false)

local Status = Status.AddLabel("Status: Loading Hub")

if game.PlaceId == 9772878203 then
    consoleprint("Loading Floppa Script V2  ")
    loadstring(FloppaV2Sc, true)()
    getgenv().FrostHubStatus = "Status: Loaded script for game 'raise a floppa 2'"
else
    consoleprint("FrostHub not supported in this game")
    print("FrostHub not supported in this game")
    getgenv().FrostHubStatus = "Error: FrostHub not supported in this game"
end

while wait() do
    if Status then
        Status.ChangeText(getgenv().FrostHubStatus)
    end
end