class DefaultEventhandlers;
class CfgPatches {
    class waspServer {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"A3_Data_F","A3_Soft_F","A3_Soft_F_Offroad_01","A3_Characters_F"};
        fileName = "h2g_Server.pbo";
        author = "Spayker";
    };
};

class CfgFunctions {
	class H2G_server {
        tag = "H2G";

        class ServerMain {
            file = "h2g_Server";
            class initServer {};
        };

        class ServerPlayer {
            file = "h2g_Server\Player";
            class onPlayerConnected {};
            class onPlayerDisconnected {};
        };
    };
};