class DefaultEventhandlers;
class CfgPatches {
    class h2g_server {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"A3_Data_F","A3_Soft_F","A3_Soft_F_Offroad_01","A3_Characters_F"};
        fileName = "h2g_server.pbo";
        author = "Spayker";
    };
};

class CfgFunctions {

    class MySQL_Database {
        tag = "DB";
        class MySQL {
            file = "\h2g_server\MySQL";
            class asyncCall {};
            class mresString {};
        };
    };

	class H2G_server {
        tag = "H2GSE";

        class ServerMain {
            file = "h2g_server";
            class initServer {};
        };

        class ServerPlayer {
            file = "h2g_server\Player";
            class onPlayerConnected {};
            class onPlayerDisconnected {};
        };
    };
};