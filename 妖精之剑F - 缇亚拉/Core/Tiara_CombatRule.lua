include( "UtilityFunctions.lua" )
----------------------------------------------------------------------------------------------------------------------------
function FairySaintCombatStrength()
	for i,player in pairs(Players) do
		local combat_str = 10--妖圣根据时代获得对应战斗力
		if (player:GetCurrentEra()==GameInfoTypes.ERA_ANCIENT) then combat_str = 20
		elseif (player:GetCurrentEra()==GameInfoTypes.ERA_CLASSICAL) then combat_str = 30
		elseif (player:GetCurrentEra()==GameInfoTypes.ERA_MEDIEVAL) then combat_str = 40
		elseif (player:GetCurrentEra()==GameInfoTypes.ERA_RENAISSANCE) then combat_str = 55
		elseif (player:GetCurrentEra()==GameInfoTypes.ERA_INDUSTRIAL) then combat_str = 70
		elseif (player:GetCurrentEra()==GameInfoTypes.ERA_MODERN) then combat_str = 90
		elseif (player:GetCurrentEra()==GameInfoTypes.ERA_WORLDWAR) then combat_str = 120
		elseif (player:GetCurrentEra()==GameInfoTypes.ERA_POSTMODERN) then combat_str = 150
		elseif (player:GetCurrentEra()==GameInfoTypes.ERA_INFORMATION) then combat_str = 200
		elseif (player:GetCurrentEra()==GameInfoTypes.ERA_FUTURE) then combat_str = 300
		else combat_str = 10 end
         for unit in player:Units() do
			if (unit:GetUnitType()==GameInfoTypes.UNIT_FAIRY_SAINT) then
				unit:SetBaseCombatStrength(combat_str)
				unit:SetBaseRangedCombatStrength(combat_str)
			end
		end
    end
end
Events.ActivePlayerTurnStart.Add(FairySaintCombatStrength)
Events.SerialEventUnitCreated.Add(FairySaintCombatStrength)
GameEvents.TeamSetEra.Add(FairySaintCombatStrength)
----------------------------------------------------------------------------------------------------------------------------
local FairyID = GameInfoTypes["UNIT_FAIRY_SAINT"]
	local NeuralInterface = GameInfoTypes["TECH_NUCLEAR_FISSION"]	
	function FairyPromotions(iTeam, iTech, bAdopted)
		for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
			local pPlayer = Players[iPlayer]
			local bTeam = (pPlayer:GetTeam() == iTeam)
			if bTeam and (pPlayer:GetCivilizationType() ~= BARBARIAN ) and bAdopted then
				local pTeam = Teams[iTeam]
				for pUnit in pPlayer:Units() do
					if pUnit:GetUnitType() == FairyID  then
						if iTech == NeuralInterface then
							pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_FAIRY_PANDORA"].ID, true)
						end
					end
				end
			end
		end
	end
GameEvents.TeamSetHasTech.Add(FairyPromotions)

function FairyPromotions2(playerID, unitID, hexVec, unitType, cultureType, civID, primaryColor, secondaryColor, unitFlagIndex, fogState, selected, military, notInvisible)
	local pPlayer = Players[playerID]
	local pUnit = pPlayer:GetUnitByID(unitID)
	if pPlayer:IsAlive() and (pPlayer:GetCivilizationType() ~= BARBARIAN ) then
		local pTeam = Teams[pPlayer:GetTeam()]
		if pUnit:GetUnitType() == FairyID  then
			if pTeam:GetTeamTechs():HasTech(NeuralInterface) then
				pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_FAIRY_PANDORA"].ID, true)
			end
		end
	end
end
Events.SerialEventUnitCreated.Add(FairyPromotions2)
------------------------------------------------------------------pUnit:SetBaseCombatStrength(1500)----------------------------------------------------------
print("单位特殊按钮监测运行正常")

BuildFairySanctuary  = {
  Name = "建造妖圣武装圣所",
  Title = "TXT_KEY_SP_BTNNOTE_BUILDING_FAIRY_SANCTUARY_SHORT", -- or a TXT_KEY
  OrderPriority = 200, -- default is 200
  IconAtlas = "FAIRY_FENCER_LOGO", -- 45 and 64 variations required
  PortraitIndex = 9,
  ToolTip = "TXT_KEY_SP_BTNNOTE_BUILDING_FAIRY_SANCTUARY", -- or a TXT_KEY_ or a function
  Condition = function(action, unit)
    return unit:CanMove() and unit:GetUnitType() == GameInfoTypes.UNIT_FAIRY_SAINT;
  end, -- or nil or a boolean, default is true
  
  Disabled = function(action, unit) 
    local plot = unit:GetPlot();
    if not plot:IsCity() then return true end;
    local city = plot:GetPlotCity()
    return not city or city:GetOwner() ~= unit:GetOwner() or city:IsHasBuilding(GameInfo.Buildings["BUILDING_FAIRY_SANCTUARY"].ID);
  end, -- or nil or a boolean, default is false
  
  Action = function(action, unit, eClick)
    local plot = unit:GetPlot();
    local city = plot:GetPlotCity()
    local player = Players[unit:GetOwner()]
    if not city then return end

    city:SetNumRealBuilding(GameInfoTypes["BUILDING_FAIRY_SANCTUARY"],1)
    unit:Kill();
	print ("妖圣武装圣所建造完成")

  end,
};
LuaEvents.UnitPanelActionAddin(BuildFairySanctuary);
----------------------------------------------------------------------------------------------------------------------------
local AirboatID = GameInfoTypes["UNIT_MAGIC_AIRBOAT"]
	local NeuralInterface = GameInfoTypes["TECH_ROCKETRY"]	
	function AirboatCombatStrength(iTeam, iTech, bAdopted)
		for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
			local pPlayer = Players[iPlayer]
			local bTeam = (pPlayer:GetTeam() == iTeam)
			if bTeam and (pPlayer:GetCivilizationType() ~= BARBARIAN ) and bAdopted then
				local pTeam = Teams[iTeam]
				for pUnit in pPlayer:Units() do
					if pUnit:GetUnitType() == AirboatID  then
						if iTech == NeuralInterface then
				pUnit:SetBaseCombatStrength(120)
				pUnit:SetBaseRangedCombatStrength(100)
				pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_MAGIC_AIRBOAT_RETROFIT"].ID, true)
								end
							end
						end
					end
				end
		end
	GameEvents.TeamSetHasTech.Add(AirboatCombatStrength)

	function AirboatCombatStrength2(playerID, unitID, hexVec, unitType, cultureType, civID, primaryColor, secondaryColor, unitFlagIndex, fogState, selected, military, notInvisible)
		local pPlayer = Players[playerID]
		local pUnit = pPlayer:GetUnitByID(unitID)
		if pPlayer:IsAlive() and (pPlayer:GetCivilizationType() ~= BARBARIAN ) then
			local pTeam = Teams[pPlayer:GetTeam()]
			if pUnit:GetUnitType() == AirboatID  then
				if pTeam:GetTeamTechs():HasTech(NeuralInterface) then
				pUnit:SetBaseCombatStrength(120)
				pUnit:SetBaseRangedCombatStrength(100)
				pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_MAGIC_AIRBOAT_RETROFIT"].ID, true)
				end
			end
		end
	end
	Events.SerialEventUnitCreated.Add(AirboatCombatStrength2)
----------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
--******************************************************************************* Unit Combat Rules *******************************************************************************
local g_DoNewAttackEffect = nil;
function NewAttackEffectStarted(iType, iPlotX, iPlotY)
	if (PreGame.GetGameOption("GAMEOPTION_SP_NEWATTACK_OFF") == 1) then
		print("SP Attack Effect - OFF!");
		return;
	end
	
	if iType == GameInfoTypes["BATTLETYPE_MELEE"]
	or iType == GameInfoTypes["BATTLETYPE_RANGED"]
	or iType == GameInfoTypes["BATTLETYPE_AIR"]
	or iType == GameInfoTypes["BATTLETYPE_SWEEP"]
	then
		g_DoNewAttackEffect = {
			attPlayerID = -1,
			attUnitID   = -1,
			defPlayerID = -1,
			defUnitID   = -1,
			attODamage  = 0,
			defODamage  = 0,
			PlotX = iPlotX,
			PlotY = iPlotY,
			bIsCity = false,
			defCityID = -1,
			battleType = iType,
		};
	end
end
GameEvents.BattleStarted.Add(NewAttackEffectStarted);
tCaptureSPUnits = {};
function NewAttackEffectJoined(iPlayer, iUnitOrCity, iRole, bIsCity)
	if g_DoNewAttackEffect == nil
	or Players[ iPlayer ] == nil or not Players[ iPlayer ]:IsAlive()
	or (not bIsCity and Players[ iPlayer ]:GetUnitByID(iUnitOrCity) == nil)
	or (bIsCity and (Players[ iPlayer ]:GetCityByID(iUnitOrCity) == nil or iRole == GameInfoTypes["BATTLEROLE_ATTACKER"]))
	or iRole == GameInfoTypes["BATTLEROLE_BYSTANDER"]
	then
		return;
	end
	if bIsCity then
		g_DoNewAttackEffect.defPlayerID = iPlayer;
		g_DoNewAttackEffect.defCityID = iUnitOrCity;
		g_DoNewAttackEffect.bIsCity = bIsCity;
	elseif iRole == GameInfoTypes["BATTLEROLE_ATTACKER"] then
		g_DoNewAttackEffect.attPlayerID = iPlayer;
		g_DoNewAttackEffect.attUnitID = iUnitOrCity;
		g_DoNewAttackEffect.attODamage = Players[ iPlayer ]:GetUnitByID(iUnitOrCity):GetDamage();
	elseif iRole == GameInfoTypes["BATTLEROLE_DEFENDER"] or iRole == GameInfoTypes["BATTLEROLE_INTERCEPTOR"] then
		g_DoNewAttackEffect.defPlayerID = iPlayer;
		g_DoNewAttackEffect.defUnitID = iUnitOrCity;
		g_DoNewAttackEffect.defODamage = Players[ iPlayer ]:GetUnitByID(iUnitOrCity):GetDamage();
	end
	
	-- Prepare for Capture Unit!
	if not bIsCity and g_DoNewAttackEffect.battleType == GameInfoTypes["BATTLETYPE_MELEE"]
	and Players[g_DoNewAttackEffect.attPlayerID] ~= nil and Players[g_DoNewAttackEffect.attPlayerID]:GetUnitByID(g_DoNewAttackEffect.attUnitID) ~= nil
	and Players[g_DoNewAttackEffect.defPlayerID] ~= nil and Players[g_DoNewAttackEffect.defPlayerID]:GetUnitByID(g_DoNewAttackEffect.defUnitID) ~= nil
	then
		local attPlayer = Players[g_DoNewAttackEffect.attPlayerID];
		local attUnit   = attPlayer:GetUnitByID(g_DoNewAttackEffect.attUnitID);
		local defPlayer = Players[g_DoNewAttackEffect.defPlayerID];
		local defUnit   = defPlayer:GetUnitByID(g_DoNewAttackEffect.defUnitID);
	
		if attUnit:GetCaptureChance(defUnit) > 0 then
			local unitClassType = defUnit:GetUnitClassType();
			local unitPlot = defUnit:GetPlot();
			local unitOriginalOwner = defUnit:GetOriginalOwner();
		
			local sCaptUnitName = nil;
			if defUnit:HasName() then
				sCaptUnitName = defUnit:GetNameNoDesc();
			end
			
			local unitLevel = defUnit:GetLevel();
			local unitEXP   = attUnit:GetExperience();
			local attMoves = attUnit:GetMoves();
			print("attacking Unit remains moves:"..attMoves);
		
			tCaptureSPUnits = {unitClassType, unitPlot, g_DoNewAttackEffect.attPlayerID, unitOriginalOwner, sCaptUnitName, unitLevel, unitEXP, attMoves};
		end
	end
end
GameEvents.BattleJoined.Add(NewAttackEffectJoined);
function NewAttackEffect()
	 --Defines and status checks
	if g_DoNewAttackEffect == nil or Players[ g_DoNewAttackEffect.defPlayerID ] == nil
	or Players[ g_DoNewAttackEffect.attPlayerID ] == nil or not Players[ g_DoNewAttackEffect.attPlayerID ]:IsAlive()
	or Players[ g_DoNewAttackEffect.attPlayerID ]:GetUnitByID(g_DoNewAttackEffect.attUnitID) == nil
	-- or Players[ g_DoNewAttackEffect.attPlayerID ]:GetUnitByID(g_DoNewAttackEffect.attUnitID):IsDead()
	or Map.GetPlot(g_DoNewAttackEffect.PlotX, g_DoNewAttackEffect.PlotY) == nil
	then
		return;
	end
	
	local attPlayerID = g_DoNewAttackEffect.attPlayerID;
	local attPlayer = Players[ attPlayerID ];
	local defPlayerID = g_DoNewAttackEffect.defPlayerID;
	local defPlayer = Players[ defPlayerID ];
	
	local attUnit = attPlayer:GetUnitByID(g_DoNewAttackEffect.attUnitID);
	local attPlot = attUnit:GetPlot();
	
	local plotX = g_DoNewAttackEffect.PlotX;
	local plotY = g_DoNewAttackEffect.PlotY;
	local batPlot = Map.GetPlot(plotX, plotY);
	local batType = g_DoNewAttackEffect.battleType;
	
	local bIsCity = g_DoNewAttackEffect.bIsCity;
	local defUnit = nil;
	local defPlot = nil;
	local defCity = nil;
	
	local attFinalUnitDamage = attUnit:GetDamage();
	local defFinalUnitDamage = 0;
	local attUnitDamage = attFinalUnitDamage - g_DoNewAttackEffect.attODamage;
	local defUnitDamage = 0;
	
	if not bIsCity and defPlayer:GetUnitByID(g_DoNewAttackEffect.defUnitID) then
		defUnit = defPlayer:GetUnitByID(g_DoNewAttackEffect.defUnitID);
		defPlot = defUnit:GetPlot();
		defFinalUnitDamage = defUnit:GetDamage();
		defUnitDamage = defFinalUnitDamage - g_DoNewAttackEffect.defODamage;
	elseif bIsCity and defPlayer:GetCityByID(g_DoNewAttackEffect.defCityID) then
		defCity = defPlayer:GetCityByID(g_DoNewAttackEffect.defCityID);
	end
	
	g_DoNewAttackEffect = nil;
	
	--Complex Effects Only for Human VS AI(reduce time and enhance stability)
	if not attPlayer:IsHuman() and not defPlayer:IsHuman() then
		--[[
		--Larger AI's Bonus against Smaller AIs - AI is easier to become a Boss! Player will feel excited fighting Boss!
		--AI will capture another AI's city by ranged attack
		-- AI boss's City cann't be Captured by AI Ranged Unit!
		if not AICanBeBoss(defPlayer) and defCity then
			print ("AI attacking AI's City!")
			if defCity:GetDamage() >= defCity:GetMaxHitPoints() - 1 then
				local cityPop = defCity:GetPopulation()
				if cityPop < 10 or AICanBeBoss(attPlayer) then
					-- attPlayer:AcquireCity(defCity)
					print ("AI Ranged Unit Takes another AI's city!")
				end
			end
		end
		]]
		return;
	end
	-- Not for Barbarins
	if attPlayer:IsBarbarian() then
		return;
	end
	
	----------- Tiara Air Ship:远程降低敌方移动力并给予敌军压制效果
	local TiaraPromotionsID = GameInfo.UnitPromotions["PROMOTION_DEATH_FROM_ABOVE"].ID
	local MoralWeaken1ID = GameInfo.UnitPromotions["PROMOTION_MORAL_WEAKEN_1"].ID

	if not bIsCity then
	   if  not defUnit:IsDead() and attUnit:IsHasPromotion(TiaraPromotionsID) and batType == GameInfoTypes["BATTLETYPE_RANGED"] then
			local defMoves = defUnit:GetMoves()
			print ("defUnit:GetMoves()"..defMoves)	
			if defMoves > 0 then
				local newMoves = defMoves / 2
				defUnit:SetMoves(newMoves)
				defUnit:SetHasPromotion(MoralWeaken1ID, true);
				if attPlayer:IsHuman() then
					local ht_text = Locale.ConvertTextKey( "TXT_KEY_DEATH_FROM_ABOVE_ATT", attUnit:GetName(), defUnit:GetName()) .. math.ceil(newMoves / 60) ..  Locale.ConvertTextKey("TXT_KEY_DEATH_FROM_ABOVE_END")
					Events.GameplayAlertMessage(ht_text)
				end
				if defPlayer:IsHuman() then
					local ht_text = Locale.ConvertTextKey( "TXT_KEY_DEATH_FROM_ABOVE_DEF", attUnit:GetName(), defUnit:GetName()) .. math.floor(newMoves / 60) ..  Locale.ConvertTextKey("TXT_KEY_DEATH_FROM_ABOVE_END")
					Events.GameplayAlertMessage(ht_text)
				end

			end
		end
	end

	----------- Tiara Air Ship:近战AOE
	if not bIsCity then
	if not attUnit:IsDead() and attUnit:IsHasPromotion(TiaraPromotionsID) and batType == GameInfoTypes["BATTLETYPE_MELEE"] 
	then

		for i = 0, 5 do
			local adjPlot = Map.PlotDirection(plotX, plotY, i)
			if (adjPlot ~= nil and not adjPlot:IsCity()) then
				print("Available for AOE Damage!")
				local unitCount = adjPlot:GetNumUnits();
				if unitCount > 0 then
				for i = 0, unitCount-1, 1 do
				local pUnit = adjPlot:GetUnit(i) ------------Find Units affected
				if pUnit and (pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND or pUnit:GetDomainType() == DomainTypes.DOMAIN_SEA) then
					local pCombat = pUnit:GetBaseCombatStrength()
					local pPlayer = Players[pUnit:GetOwner()]
					
					if PlayersAtWar(attPlayer, pPlayer) then
						local SplashDamageOri = attUnit:GetRangeCombatDamage(pUnit,nil,false)
							
						local AOEmod = 0.5   -- the percent of damage reducing to nearby units
							
						local text = nil;
						local attUnitName = attUnit:GetName();
						local defUnitName = pUnit:GetName();
							
						local SplashDamageFinal = math.floor(SplashDamageOri * AOEmod); -- Set the Final Damage
						if     SplashDamageFinal >= pUnit:GetCurrHitPoints() then
							SplashDamageFinal = pUnit:GetCurrHitPoints();
							local eUnitType = pUnit:GetUnitType();
							UnitDeathCounter(attPlayerID, pUnit:GetOwner(), eUnitType);
								
							-- Notification
							if     defPlayerID == Game.GetActivePlayer() then
								-- local heading = Locale.ConvertTextKey("TXT_KEY_SP_NOTIFICATION_UNIT_DESTROYED_SHORT")
								text = Locale.ConvertTextKey("TXT_KEY_SP_NOTIFICATION_SPLASH_DAMAGE_DEATH", attUnitName, defUnitName);
								-- defPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC , text, heading, plotX, plotY)
							elseif attPlayerID == Game.GetActivePlayer() then
								text = Locale.ConvertTextKey("TXT_KEY_SP_NOTIFICATION_SPLASH_DAMAGE_ENEMY_DEATH", attUnitName, defUnitName);
							end
						elseif SplashDamageFinal > 0 then
							-- Notification
							if     defPlayerID == Game.GetActivePlayer() then
								text = Locale.ConvertTextKey("TXT_KEY_SP_NOTIFICATION_SPLASH_DAMAGE", attUnitName, defUnitName, SplashDamageFinal);
							elseif attPlayerID == Game.GetActivePlayer() then
								text = Locale.ConvertTextKey("TXT_KEY_SP_NOTIFICATION_SPLASH_DAMAGE_ENEMY", attUnitName, defUnitName, SplashDamageFinal);
							end
						end
						if text then
							Events.GameplayAlertMessage( text );
						end
						pUnit:ChangeDamage(SplashDamageFinal, attPlayer)
						----------------Death Animation
						--pUnit:PushMission(MissionTypes.MISSION_DIE_ANIMATION)
						print("Splash Damage="..SplashDamageFinal)
					end
				end
				end
				end
			end
		end
	end
	end

end--function END
GameEvents.BattleFinished.Add(NewAttackEffect)

-- Unit death cause population loss -- MOD by CaptainCWB
function UnitDeathCounter(iKerPlayer, iKeePlayer, eUnitType)
	if (PreGame.GetGameOption("GAMEOPTION_SP_CASUALTIES") == 0) then
		print("War Casualties - OFF!");
		return;
	end
	
	if Players[iKeePlayer] == nil or not Players[iKeePlayer]:IsAlive() or Players[iKeePlayer]:GetCapitalCity() == nil
	or Players[iKeePlayer]:IsMinorCiv() or Players[iKeePlayer]:IsBarbarian()
	or GameInfo.Units[eUnitType] == nil
	-- UnCombat units do not count
	or(GameInfo.Units[eUnitType].Combat == 0 and GameInfo.Units[eUnitType].RangedCombat == 0)
	then
		return;
	end
	
	local defPlayer = Players[iKeePlayer];
	local iCasualty = defPlayer:GetCapitalCity():GetNumBuilding(GameInfoTypes["BUILDING_WAR_CASUALTIES"]);
	local sUnitType = GameInfo.Units[eUnitType].Type;
	local iDCounter = 6;
	
	if     GameInfo.Unit_FreePromotions{ UnitType = sUnitType, PromotionType = "PROMOTION_NO_CASUALTIES" }() then
		print ("This unit won't cause Casualties!");
		return;
	elseif GameInfo.Unit_FreePromotions{ UnitType = sUnitType, PromotionType = "PROMOTION_HALF_CASUALTIES" }() then
		iDCounter = iDCounter/2;
	end
	if defPlayer:HasPolicy(GameInfo.Policies["POLICY_CENTRALISATION"].ID) then
		iDCounter = 2*iDCounter/3;
	end
	
	print ("DeathCounter(Max-12): ".. iCasualty .. " + " .. iDCounter);
	if iCasualty + iDCounter < 12 then
		defPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes["BUILDING_WAR_CASUALTIES"], iCasualty + iDCounter);
	else
		defPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes["BUILDING_WAR_CASUALTIES"], 0);
		local PlayerCitiesCount = defPlayer:GetNumCities();
		if PlayerCitiesCount <= 0 then ---- In case of 0 city error
			return;
		end
		local apCities = {};
		local iCounter = 0;
		
		for pCity in defPlayer:Cities() do
			local cityPop = pCity:GetPopulation();
			if ( cityPop > 1 and defPlayer:IsHuman() ) or cityPop > 5 then
				apCities[iCounter] = pCity
				iCounter = iCounter + 1
			end
		end
		
		if (iCounter > 0) then
			local iRandChoice = Game.Rand(iCounter, "Choosing random city")
			local targetCity = apCities[iRandChoice]
			local Cityname = targetCity:GetName()
			local iX = targetCity:GetX();
			local iY = targetCity:GetY();
			
			if targetCity:GetPopulation() > 1 then
				targetCity:ChangePopulation(-1, true)
				print ("population lost!"..Cityname)
			else 
				return;
			end
			if defPlayer:IsHuman() then -- Sending Message
				local text = Locale.ConvertTextKey("TXT_KEY_SP_NOTE_POPULATION_LOSS",targetCity:GetName())
				local heading = Locale.ConvertTextKey("TXT_KEY_SP_NOTE_POPULATION_LOSS_SHORT")
				defPlayer:AddNotification(NotificationTypes.NOTIFICATION_STARVING, text, heading, iX, iY)
			end
		end
	end
end