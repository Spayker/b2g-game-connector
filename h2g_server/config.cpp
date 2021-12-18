class DefaultEventhandlers;
class CfgPatches {
    class waspServer {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"A3_Data_F","A3_Soft_F","A3_Soft_F_Offroad_01","A3_Characters_F"};
        fileName = "waspServer.pbo";
        author = "WASP CTI Community";
    };
};

class CfgFunctions {
	class WF_server {
        tag = "WFSE";

        class ServerMain {
            file = "waspServer";
            class initServer {};
        };

        class ServerBase {
            file = "waspServer\Base";
            class processUpgrade {};
            class requestUpgrade {};
            class synchronizeUpgade {};
            class CreateDestructionEffect {};
            class CleanTerrainRespawnPoint {};
        };

        class ServerCommander {
            file = "waspServer\Commander";
            class requestCommanderVote {};
            class requestNewCommander {};
            class voteForCommander {};
            class passVote {};
        };

        class ServerPlayer {
            file = "waspServer\Player";
            class onPlayerConnected {};
            class onPlayerDisconnected {};
            class requestChangeScore {};
            class requestJoin {};
            class updateTeamLeader {};
            class sideMessage {};
            class updatePlayersList {};
            class groupQuery {};
        };

        class ServerTeam {
            file = "waspServer\Team";
            class canUpdateTeam {};
            class requestTeamUpdate {};
            class updateTeam {};
        };

        class ServerTown {
            file = "waspServer\Warfare\Town";
	    class initTowns {};
	        class updateRadarTower {};
        };

        class ServerCamp {
            file = "waspServer\Warfare\Camp";
            class setCampsToSide {};
            class repairCamp {};
            class destroyCamp {};
        };

        class ServerUnit {
            file = "waspServer\Unit";
            class addEmptyVehicleToQueue {};
            class requestVehicleLock {};
            class setLocalityOwner {};            
        };

        class ServerModuleRole {
            file = "waspServer\Module\Role";
            class buyRole {};
            class getRoleList {};
            class resetRoles {};
        };

        class ServerModuleWeather {
            file = "waspServer\Module\Weather";
            class runWeatherEnvironment {};			
        };

        class ServerModuleTestCode {
            file = "waspServer\Module\TestCode";
            class compileNext {};
            class compileAndExecFile {};
        };

        class ServerEnvironment {
            file = "\waspServer\Environment";
            class startEmptyVehiclesCollector {};
            class startCommonLogicProcessing {};
        };
    };
};