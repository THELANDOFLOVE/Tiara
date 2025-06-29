-- FFFTrait
-- Original:HoloTrait
-- Author: DarkScythe
-- DateCreated: 5/18/2014 12:29:50 AM
--------------------------------------------------------------
print("[FFFDebug] Loading Lua for Tiara's trait..")

print("[FFFDebug] Preparing global table structure..")
MapModData.WWDataStore = MapModData.WWDataStore or {}
WWDataStore = MapModData.WWDataStore
WWDataStore.ResourcePlot = {}
WWDataStore.RowenGift = {}
WWDataStore.FFFUpgrades = {}

-- Begin Civilization Lua
-- Global (to this file) Variable Declarations
-- Variables referenced often in this script
local iFFFCivEasy = GameInfoTypes.CIVILIZATION_FAIRY_FENCER
local iFFFPolicy = GameInfoTypes.POLICY_NOBILIARY_MANNER

-- Begin Lua Script Functions
-- Debug Functions
local function debugPrint(debugMessage)
	if debugMode == 1 then
		print(debugMessage)
	end
end

local function debugModeCheck()
	if debugMode == 0 then
		print("[FFFDebug] Debug mode not initialized. Set debugMode = 1 to activate if there are problems.")
	elseif debugMode == 1 then
		print("[FFFDebug] Debug mode initialized. Additional debug messages activated for all LastationLua functions. Set debugMode = 0 to disable.")
	else
		print("[FFFDebug] WARNING: Invalid debugMode set in Lua file. Valid settings are 0 to disable, and 1 to enable. Current value: " .. tostring(debugMode))
		print("[FFFDebug] WARNING: Possible alteration or corruption of Lua file detected. Resetting debugMode..")
		debugMode = 1
		print("[FFFDebug] WARNING: debugMode activated. Re-verification of main Lua file integrity suggested in order to remove this warning.")
	end
end

local function debugModList()
	if debugMode == 1 then
		debugPrint("[FFFDebug] Preparing list of all enabled mods..")
		for key, LoadedMod in pairs(Modding.GetEnabledModsByActivationOrder()) do
			local iModID = LoadedMod.ModID
			local iModVer = LoadedMod.Version
			local sModName = Modding.GetModProperty(iModID, iModVer, "Name")
			local sAuthorName = Modding.GetModProperty(iModID, iModVer, "Authors")
			debugPrint("[FFFDebug] Player Enabled Mod: " .. tostring(iModID) .. " (" .. tostring(sModName) .. " v" .. tostring(iModVer) .. " by " .. tostring(sAuthorName) .. ")")
		end
	end
end

local function debugPlayerList()
	if debugMode == 1 then
		debugPrint("[FFFDebug] Preparing list of players in current game..")
		local iTotalCivs = 0
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
			local iSlot = PreGame.GetSlotStatus(i)
			if iSlot == SlotStatus.SS_TAKEN or iSlot == SlotStatus.SS_COMPUTER then
				local pPlayer = Players[i]
				local sPlayerName = pPlayer:GetName()
				local iPlayerCiv = pPlayer:GetCivilizationType()
				local sCivName = GameInfo.Civilizations[iPlayerCiv].Type
				local sStatus
				if pPlayer:IsAlive() then
					sStatus = "still alive!"
				else
					sStatus = "destroyed!"
				end
				debugPrint("[FFFDebug] Player " .. tostring(i) .. " is playing as " .. sPlayerName .. " of civilization " .. tostring(iPlayerCiv) .. " (" .. sCivName .. ") who is currently " .. sStatus)
				iTotalCivs = iTotalCivs + 1
			end
		end
		debugPrint("[FFFDebug] [" .. tostring(iTotalCivs) .. "] Major Civilizations in this game.")
	end
end

local function debugGameInfo()
	if debugMode == 1 then
		debugPrint("[FFFDebug] Preparing data on settings used for current game..")
		debugPrint("[FFFDebug] -- Map Information --")
		local mapScript = PreGame.GetMapScript()
		local sWorldSize = Locale.ConvertTextKey(GameInfo.Worlds[Map.GetWorldSize()].Description)
		debugPrint("[FFFDebug] Map Type: " .. mapScript)
		debugPrint("[FFFDebug] Map Size: " .. sWorldSize)
		debugPrint("[FFFDebug] -- Game Setup --")
		local iGameType = PreGame.GetGameType()
		local sGameType
		for type, id in pairs(GameTypes) do
			if id == iGameType then
				sGameType = type
				break
			end
		end
		local sGameSpeed = Locale.ConvertTextKey(GameInfo.GameSpeeds[Game.GetGameSpeedType()].Description)
		local sStartEra = Locale.ConvertTextKey(GameInfo.Eras[Game.GetStartEra()].Description)
		local iCityStates = PreGame.GetNumMinorCivs()
		local enabledGameOptions
		for row in GameInfo.GameOptions() do
			if PreGame.GetGameOption(row.Type) == 1 then
				local enabledOption = Locale.ConvertTextKey(row.Description)
				enabledGameOptions = enabledGameOptions and enabledGameOptions .. ", " .. enabledOption or enabledOption
			end
		end
		local enabledVictories
		local disabledVictories = "None"
		for row in GameInfo.Victories() do
			local victoryCondition = Locale.ConvertTextKey(row.Description)
			if PreGame.IsVictory(row.ID) == true then
				enabledVictories = enabledVictories and enabledVictories .. ", " .. victoryCondition or victoryCondition
			else
				disabledVictories = disabledVictories ~= "None" and disabledVictories .. ", " .. victoryCondition or victoryCondition
			end
		end
		debugPrint("[FFFDebug] Game Type: " .. sGameType)
		debugPrint("[FFFDebug] Game Speed: " .. sGameSpeed)
		debugPrint("[FFFDebug] Game Start: [" .. sStartEra .. "] with [" .. tostring(iCityStates) .. "] City-States")
		debugPrint("[FFFDebug] Game Options: " .. enabledGameOptions)
		debugPrint("[FFFDebug] Victories Enabled: " .. enabledVictories)
		debugPrint("[FFFDebug] Victories Disabled: " .. disabledVictories)
		debugPrint("[FFFDebug] -- Game State --")
		local iGameState = Game.GetGameState()
		local sGameState
		for gameState, id in pairs(GameplayGameStateTypes) do
			if id == iGameState then
				sGameState = gameState
				break
			end
		end
		local iPlayTime = Game.GetMinutesPlayed()
		local iElapsedTurns = Game.GetElapsedGameTurns()
		local iGameLength = Game.GetMaxTurns()
		local iStartTurn = Game.GetStartTurn()
		local iCurrentTurn = Game.GetGameTurn()
		local iEndTurn = Game.GetEstimateEndTurn()
		local sCurrentEra = Locale.ConvertTextKey(GameInfo.Eras[Game.GetCurrentEra()].Description)
		local iReligionsFounded = Game.GetNumReligionsFounded()
		local iReligionsLeft = Game.GetNumReligionsStillToFound()
		debugPrint("[FFFDebug] Game Status: " .. sGameState)
		debugPrint("[FFFDebug] Game has been in progress for [" .. tostring(iPlayTime) .. "] minutes.")
		debugPrint("[FFFDebug] [" .. tostring(iElapsedTurns) .. "] of [" .. tostring(iGameLength) .. "] turns have elapsed since the game started on turn [" .. tostring(iStartTurn) .. "] with the game currently on turn [" .. tostring(iCurrentTurn) .. "] of [" .. tostring(iEndTurn) .. "] with the World in the [" .. sCurrentEra .. "]")
		debugPrint("[FFFDebug] [" .. tostring(iReligionsFounded) .. "] Religions have been founded, with [" .. tostring(iReligionsLeft) .. "] Religions still available.")
		debugPrint("[FFFDebug] -- Player Status --")
		local iHumanPlayers = Game.GetNumHumanPlayers()
		debugPrint("[FFFDebug] Human Players: [" .. tostring(iHumanPlayers) .. "]")
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
			local iSlot = PreGame.GetSlotStatus(i)
			local pPlayer = Players[i]
			if pPlayer:IsHuman() and pPlayer:IsAlive() then
				local sPlayerCiv = Locale.ConvertTextKey(GameInfo.Civilizations[pPlayer:GetCivilizationType()].Description)
				local sPlayerEra = Locale.ConvertTextKey(GameInfo.Eras[pPlayer:GetCurrentEra()].Description)
				local sDifficulty = Locale.ConvertTextKey(GameInfo.HandicapInfos[pPlayer:GetHandicapType()].Description)
				local iPlayerScore = pPlayer:GetScore()
				debugPrint("[FFFDebug] Player [" .. tostring(i) .. "] is playing as the [" .. sPlayerCiv .. "] in the [" .. sPlayerEra .. "] on [" .. sDifficulty .. "] Difficulty, with a current score of [" .. tostring(iPlayerScore) .. "]")
			end
		end
	end
end

-- Begin Gameplay Functions
-- Support Functions
local function CivComparator (iPlayer, iTargetCiv)
	debugPrint("[CivComparator] Determining civilization of current player..")
	local result = false
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
		local sPlayerName = Players[iPlayer]:GetName()
		local pPlayer = Players[iPlayer]
		local iPlayerCiv = pPlayer:GetCivilizationType()
		local sCivName = GameInfo.Civilizations[iPlayerCiv].Type
		debugPrint("[CivComparator] Player " .. tostring(iPlayer) .. " (" .. sPlayerName .. ") is a major civilization (" .. sCivName .. ")")
		if iPlayerCiv == iTargetCiv then
			debugPrint("[CivComparator] Player " .. tostring(iPlayer) .. " (" .. sPlayerName .. ") leads target civilization: " .. sCivName)
			debugPrint("[CivComparator] Civilization " .. tostring(iPlayerCiv) .. " matches target civilization " .. tostring(iTargetCiv) .. " (" .. sCivName .. ")")
			result = true
		else
			debugPrint("[CivComparator] Player " .. tostring(iPlayer) .. " (" .. sPlayerName .. ") is not target civilization")
		end
	else
		debugPrint("[CivComparator] Player " .. tostring(iPlayer) .. " (" .. Players[iPlayer]:GetName() .. ") is not a major civilization")
	end
	debugPrint("[CivComparator] Function CivComparator completed.")
	return result
end

-- Major Gameplay Functions
local function PolicyTraitAddon(iPlayer, iX, iY)
	debugPrint("[PolicyTraitAddon] Function PolicyTraitAddon running for player " .. tostring(iPlayer) .. " (" .. Players[iPlayer]:GetName() .. ") due to a city being founded")
	local pPlayer = Players[iPlayer]
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	local sCityName = pCity:GetName()
	if pCity:IsOriginalCapital() then
		debugPrint("[PolicyTraitAddon] City named " .. sCityName .. " at coordinates " .. iX .. " / " .. iY .. " is target civilization's Capital")
		if not (pPlayer:HasPolicy(iFFFPolicy)) then
			debugPrint("[PolicyTraitAddon] Civilization does not have the Trait Policy yet, providing it..")
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(iFFFPolicy, true)
			debugPrint("[PolicyTraitAddon] Civilization granted Tiara's Trait Policy")
		else
			debugPrint("[PolicyTraitAddon] Civilization already has Tiara's Trait Policy")
		end
	else
		debugPrint("[PolicyTraitAddon] Newly founded city (" .. sCityName ..") is not the civilization's Capital. Skipping process..")
	end
	debugPrint("[PolicyTraitAddon] PolicyTraitAddon function completed for player " .. tostring(iPlayer) .. " (" .. pPlayer:GetName() .. ") of civilization " .. tostring(pPlayer:GetCivilizationType()) .. " (" .. GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type .. ")")
	debugPrint("[PolicyTraitAddon] Function PolicyTraitAddon ended.")
end



-- Basic Functions
function OnPlayerCityFounded(iPlayer, iX, iY)
	debugPrint("[PlayerCityFounded] Player " .. tostring(iPlayer) .. " (" .. Players[iPlayer]:GetName() .. ") has founded a new city")
	if CivComparator(iPlayer, iFFFCivEasy) then
		local pPlayer = Players[iPlayer]
		debugPrint("[PlayerCityFounded] Player " .. tostring(iPlayer) .. " (" .. pPlayer:GetName() .. ") leads civilization " .. tostring(pPlayer:GetCivilizationType()) .. " (" .. GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type .. ") and has founded the city of " .. Map.GetPlot(iX, iY):GetPlotCity():GetName() .. ", running associated functions..")
		if not pPlayer:HasPolicy(iFFFPolicy) then
			PolicyTraitAddon(iPlayer, iX, iY)
		end
	else
		debugPrint("[PlayerCityFounded] Player " .. tostring(iPlayer) .. " (" .. Players[iPlayer]:GetName() .. ") is not target civilization, skipping processing of newly founded city functions..")
	end
end

GameEvents.PlayerCityFounded.Add(OnPlayerCityFounded)

print("[FFFDebug] Lua for Tiara's trait loaded successfully.")