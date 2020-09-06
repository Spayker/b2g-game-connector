class WF_Client {
    tag = "WFCL";

    class ClientFunctions {
        file = "Client";
        class remoteExecServer {};
    };

    class Map {
        file = "Client\Player\Map";
        class arRadarMarkerUpdate {};
        class getStructureMarkerLabel {};
        class markerAnim {};
        class isOnMap {};
        class handleOnMap {};
        class initMarkers {};
        class initGlobalMarkingMonitorFunctions {};
        class updateTeamsMarkers {};
        class updateTownMarkers {};
        class IconVehicle {};
        class UpdateRadarMarker {};
    };

    class Warfare {
        file = "Client\Warfare";
        class getClosestAirport {};
    };

    class WarfareTown {
        file = "Client\Warfare\Town";
        class getClosestDepot {};
        class townCaptured {};
        class townRemoved {};
    };

    class WarfareCamp {
        file = "Client\Warfare\Camp";
        class getClosestCamp {};
        class allCampsCaptured {};
        class campCaptured {};
        class getNearestCamp {};
    };

    class Base {
        file = "Client\Base";
        class initConstructionModule {};
        class callConstructionInterface {};
        class requestBaseArea {};
        class setMHQLock {};
        class handleHQAction {};
        class initBaseStructure {};
        class showUpgradeStartedMessage {};
        class showUpgradeDoneMessage {};
        class changeAutoWallConstructingFlag {};
    };

    class Unit {
        file = "Client\Unit";
        class buildUnit {};
        class buildGroup {};
        class setVehicleLock {};
        class UpdateSalvage {};
    };

    class Task {
        file = "Client\Task";
        class taskSystem {};
        class setTask {};
    };

    class Chat {
        file = "Client\Player\Chat";
        class showAwardHint {};
        class commandChatMessage {};
        class groupChatMessage {};
        class titleTextMessage {};
        class localizeMessage {};
    };

    class Skill {
        file = "Client\Player\Skill";
        class applySkill {};
        class initSkill {};
        class processArtyStrikeAction {};
        class processEngineerAction {};
        class processLiteRepairAction {};
        class processSniperAction {};
        class processSpecOpsAction {};
    };

    class Economy {
        file = "Client\Economy";
        class getIncome {};
        class getPlayerFunds {};
        class awardBounty {};
        class awardBountyPlayer {};
        class changePlayerFunds {};
    };

    class Player {
        file = "Client\Player";
        class changeScore {};
        class preRespawnHandler {};
        class onKilled {};
        class missionIntro {};
        class showEndGameResults {};
        class updateCanJoinFlag {};
        class updateAvailableActions {};
    };

    class PlayerActions {
        file = "Client\Player\Action";
        class callBuildMenu {};
        class callBuildMenuForRepairTruck {};
        class destroyCampEngineer {};
        class ejectCargo {};
        class doHalo {};
        class pushVehicle {};
        class repairCamp {};
        class repairCampEngineer {};
        class taxiReverse {};
        class toggleLock {};
        class toggleMHQLock {};
        class ejectFromVehicle {};
        class addBaseBuildingRepAction {};
        class baseBuildingRepAction {};
    };
	
	class PlayerAnims {
		file = "Client\Player\Anims";
		class doJump {};
	};

    class Icbm {
        file = "Client\Module\Nuke";
        class initIcbmStrike {};
    };

    class Gui {
        file = "Client\Player\GUI";
        class clearCurrentCutDisplay {};
        class displayEndOfGameStats {};
        class setCurrentCutDisplay {};
        class updatePlayerHud {};
        class getTime {};
        class showTitleCapture {};
    };

    class GuiBuyUnitsMenu {
        file = "Client\Player\GUI\BuyUnitsMenu";
        class displayBuyUnitsMenu {};
        class fillListBuyUnits {};
        class fillListBuyGroups {};
        class changeComboBuyUnits {};
        class changeComboBuyGroups {};
    };

    class GuiCommanderVoteMenu {
        file = "Client\Player\GUI\CommanderVoteMenu";
        class displayCommanderVoteMenu {};
    };

    class GuiEasaMenu {
        file = "Client\Player\GUI\EasaMenu";
        class displayEasaMenu {};
    };

    class GuiEconomyMenu {
        file = "Client\Player\GUI\EconomyMenu";
        class displayEconomyMenu {};
    };

    class GuiFundsMenu {
        file = "Client\Player\GUI\FundsMenu";
        class displayTransferMenu {};
    };

    class GuiGearMenu {
        file = "Client\Player\GUI\GearMenu";
        class displayGearMenu {};
        class displayWarfareGearMenu {};
        class displayInventoryVehicle {};
        class loadAvailableUnits {};
        class displayShoppingItems {};
        class getTotalMass {};
        class updateContainerProgress {};
        class updatePrice {};
        class displayInventory {};
        class getVehicleLoad {};
        class enableVehicleOverlay {};
        class updateVehicleContainerProgress {};
        class addItem {};
        class addVehicleItem {};
        class equipTemplate {};
        class equipVehicleCargo {};
        class onShoppingItemDrag {};
        class onShoppingItemDrop {};
        class updateLinkedItems {};
        class displayContainerItems {};
        class replaceContainer {};
        class replaceWeapon {};
        class updateMass {};
        class updateVehicleLoad {};
        class changeCurrentMagazine {};
        class highlightTab {};
        class tryContainerAddItem {};
        class tryEquipAccessory {};
        class addContainerItem {};
        class canAddItemWithMass {};
        class checkAccessories {};
        class checkMagazines {};
        class getGearCostDelta {};
        class changeCurrentGrenade {};
        class getItemConfigType {};
        class getItemAllowedSlots {};
        class getGenericItemMass {};
        class getContainerMassCapacity {};
        class getItemsMass {};
        class getContainerMass {};
    };

    class GuiGearTemplates {
        file = "Client\Player\GUI\GearMenu\Templates";
        class getGearTemplates {};
        class saveGearTemplate {};
        class deleteGearTemplate {};
    };

    class GuiHelpMenu {
        file = "Client\Player\GUI\HelpMenu";
        class displayHelpMenu {};
    };

    class GuiParametersMenu {
        file = "Client\Player\GUI\ParametersMenu";
        class displayParameters {};
    };

    class GuiRespawnMenu {
        file = "Client\Player\GUI\RespawnMenu";
        class displayRespawnMenu {};
        class respawnSelector {};
        class onRespawnHandler {};
        class getRespawnAvailable {};
    };

    class GuiRoleMenu {
        file = "Client\Player\GUI\RolesMenu";
        class buyRole {};
        class selectRole {};
        class updateRolesMenu {};
        class closeRoleSelectDialog {};
        class updateRoleList {};
        class resetRoles {};
        class buyRoleConfirm {};
        class resetRolesConfirm {};
    };

    class PlayerInit {
        file = "Client\Player\Init";
        class initClient {};
        class initFaction {};
		class doKeyDown {};
        class initKeybind {};
        class initProfileVariables {};
    };

    class GuiServiceMenu {
        file = "Client\Player\GUI\ServiceMenu";
        class displayServiceMenu {};
        class startHeal {};
        class startRearm {};
        class startRefuel {};
        class startRepair {};
    };

    class GuiTacticalMenu {
        file = "Client\Player\GUI\TacticalMenu";
        class displayTacticalMenu {};
        class setControlFadeAnim {};
        class setControlFadeAnimStop {};
        class RequestFireMission {};
        class uav {};
        class uav_interface {};
        class uav_spotter {};
    };

    class GuiTankMagsMenu {
        file = "Client\Player\GUI\TankMagsMenu";
        class displayTankMagzMenu {};
    };

    class GuiTeamMenu {
        file = "Client\Player\GUI\TeamMenu";
        class displayTeamMenu {};
    };

    class GuiUnitCameraMenu {
        file = "Client\Player\GUI\UnitCameraMenu";
        class displayUnitCameraMenu {};
        class getUnitVehicle {};
        class abortRemoteControl {};
    };

    class GuiUpgradeMenu {
        file = "Client\Player\GUI\UpgradeMenu";
        class displayUpgradeMenu {};
    };

    class GuiVoteMenu {
        file = "Client\Player\GUI\VoteMenu";
        class displayVoteMenu {};
    };

    class GuiWarfareMenu {
        file = "Client\Player\GUI\WarfareMenu";
        class displayWarfareMenu {};
    };

    class Commander {
        file = "Client\Player\Commander";
        class assignedCommander {};
        class processVoteCommanderResults {};
        class startCommanderVoting {};
        class updateCommanderState {};
        class passVoteResults {};
    };

    class SaveTourists {
        file = "WASP\TaskDirector\tasks\saveTourists";
        class svTrstTsk {};
    };
};

class WFDC {
	class Log {
		class LogContent { file = "Common\Logging\fn_LogContentDiscord.sqf"; };
	};
};

class WF_Common {
    tag = "WFCO";

    class Common {
        file = "Common";
        class initCommon {};
        class initCommonConstants{};
        class initParameters {};
    };

    class Array{
        file = "Common\Array";
        class arrayDiffers {};
        class arrayShift {};
        class arrayShuffle {};
        class arrayToLower {};
        class multiArrayToSimple {};
    };

    class Base {
        file = "Common\Base";
        class buildingInRange {};
        class cleanResBaseArea {};
        class getClosestStructure {};
        class getFactories {};
        class getSideHQ {};
        class getSideHQDeployStatus {};
        class getSideStructures {};
        class getSideStructuresByType {};
        class getSideUpgrades {};
    };

    class Economy {
        file = "Common\Economy";
        class changeSideSupply {};
        class changeTeamFunds {};
        class getTeamFunds {};
        class getSideSupply {};
        class getTotalSupplyValue {};
    };

    class Log {
        file = "Common\Logging";
        class logContent {};
        class updateStatistics {};

    };

    class Map {
        file = "Common\Map";
        class markerUpdate {};
        class trackAirTargets {};
        class initBoundaries {};
    };

    class ModuleCipher {
        file = "Common\Module\Cipher";
        class compareString {};
        class reverseArray {};
        class sortArray {};
        class sortArrayIndex {};
        class sortUpgradeLabels {};
        class swapArray {};
    };

    class ModuleKbFunctions {
        file = "Common\Module\Kb";
        class initHq {};
    };

    class ModuleRole {
        file = "Common\Module\Role";
        class getRoleDetails {};
        class roleList {};
    };

    class Object {
        file = "Common\Object";
        class trashObject {};
        class getSideFromID {};
        class getSideID {};
        class getSideLogic {};
        class getHighCommandGroups {};
    };

    class ObjectGear {
        file = "Common\Object\Gear";
        class convertGearToFlat {};
        class equipBackpack {};
        class equipContainerBackpack {};
        class equipContainerUniform {};
        class equipContainerVest {};
        class getGearItemCost {};
        class proccedLoadOutForSide {};
    };

    class ObjectUnit {
        file = "Common\Object\Unit";
        class createTownUnits {};
        class createUnit {};
        class CreateHighCommandGroup {};
        class createUnitForStaticDefence {};
        class createUnitsForResBases {};
        class equipUnit {};
        class initUnit {};
        class initManUnit {};
        class isUnitInBuilding {};
        class killStaticDefenseCrew {};
        class onUnitHit {};
        class onUnitKilled {};
        class requip_AI {};
        class revealArea {};
        class getLiveUnits {};
        class getUnitLoadout {};
        class getHostilesInArea {};
    };

    class ObjectUnitAi {
        file = "Common\Object\Unit\Ai";
        class getAIDigit {};
    };

    class ObjectUnitPlayer {
        file = "Common\Player";
        class getCommanderTeam {};
        class saveProfile {};
        class setProfileVariable {};
    };

    class ObjectUnitTeam {
        file = "Common\Object\Unit\Team";
        class createTeam {};
        class getTeamArtillery {};
        class getTeamMoveMode {};
        class getTeamMovePos {};
        class getTeamRespawn {};
        class getTeamType {};
        class getTeamVehicles {};
		class setPatrol {};
        // class getPatrol {}; //--NOT USED--
        class setTeamMoveMode {};
        class setTeamMovePos {};
        class setTeamRespawn {};
        class setTeamType {};
        class updateClientTeams {};
    };

    class ObjectUnitTeamWaypoint {
        file = "Common\Object\Unit\Team\Waypoint";
        class areWaypointsComplete {};
        class waypointPatrol {};
        class waypointPatrolTown {};
        class waypointsAdd {};
        class waypointSimple {};
        class waypointsRemove {};
    };

    class ObjectVehicle {
        file = "Common\Object\Vehicle";
        class initAdvancedSlingLoading {};
        class getConfigVehicleCrewSlot {};
        class getConfigVehicleTurrets {};
        class getConfigVehicleTurretsReturn {};
        class isVehicleAround {};
        class balanceInit {};
        class brokeTerObjsAround {};
        class clearVehicleCargo {};
        class createVehicle {};
        class findTurretsRecursive {};
        class handleAAMissiles {};
        class handleBombs {};
        class handleIncomingMissile {};
        class placeSafe {};
        class rearmVehicle {};
        class requip_AIR_VEH {};
        class initVehicle {};
        class sellSupplyTruck {};
        class unflipVehicle {};
    };

    class ObjectVehicleArty {
        file = "Common\Object\Vehicle\Arty";
        class fireArtillery {};
        class isArtillery {};
        class finishArtyMission {};
        class prepareArtyMission {};
    };

    class UtilLocation {
        file = "Common\Utils\Location";
        class getClosestEntity {};
        class getClosestEntity2 {};
        class getClosestEntity3 {};
        class getClosestEntity4 {};
		class getClosestEntity5 {};
        class getClosestLocation {};
        class getClosestLocationBySide {};
        class getEmptyPosition {};
        class getPositionFrom {};
        class getRandomPosition {};
        class getSafePlace {};
        class getDirTo {};
    };

    class UtilConfig {
        file = "Common\Utils\Config";
        class getConfigInfo {};
        class getConfigType {};
        class getConfigEntry {};
        class getUnitConfigGear {};
    };

    class UtilMutex {
        file = "Common\Utils\Mutex";
        class IsMutexLocked {};
        class MutexLock {};
        class MutexTryLock {};
        class MutexUnlock {};
    };

    class UtilDate {
        file = "Common\Utils\Date";
        class dateToString {};
    };

    class Warfare {
        file = "Common\Warfare";
        class getAreaEnemiesCount {};
        class sortByDistance {};
        class initAirports {};
		class respawnStartVeh {};
    };

    class WarfareTown {
        file = "Common\Warfare\Town";
        class initTown {};
        class initTownMode {};
        class initTowns {};
        class getTownsHeld {};
        class getTownsIncome {};
        class getSideTowns {};
        class getTownsSupply {};
        class getSpecialLocations {};
    };

     class WarfareCommon {
        file = "Common\Warfare\Camp";
        class getFriendlyCamps {};
        class getRespawnCamps {};
        class getSideFLAG {};
        class getTotalCamps {};
        class getTotalCampsOnSide {};
        class updateCampsInTown {};
     };	
};