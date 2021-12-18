//--- Define which 'part' of the game to run.
#include "version.sqf"

WF_Debug = false;
#ifdef WF_DEBUG
	WF_Debug = true;
#endif

//--- Global Init, first file called.
isHostedServer = (isServer && !isDedicated);

WF_LogLevel = 0; //--- Logging level (0: Trivial, 1: Information, 2: Warnnings, 3: Errors).

//--- Mission is starting.
for '_i' from 0 to 3 do {diag_log "################################"};
diag_log format ["## Island Name: [%1]", worldName];
diag_log format ["## Mission Name: [%1]", WF_MISSIONNAME];
diag_log format ["## Max players Defined: [%1]", WF_MAXPLAYERS];
for '_i' from 0 to 3 do {diag_log "################################"};

["INITIALIZATION", "initJIPCompatible.sqf: Starting JIP Initialization"] Call WFCO_FNC_LogContent;
WF_Client_SideJoined = civilian;

//--- Server JIP Information
if (isHostedServer || isDedicated) then { //--- JIP Handler, handle connection & disconnection.
	onPlayerConnected {[_uid, _name, _id, _owner] spawn WFSE_FNC_OnPlayerConnected};
	addMissionEventHandler ["HandleDisconnect",{_this spawn WFSE_FNC_OnPlayerDisconnected}];
};

//--- Client initialization, either hosted or pure client. Part I
if (isHostedServer || !isDedicated) then {
	["INITIALIZATION", "Init.sqf: Client detected... waiting for non null result..."] Call WFCO_FNC_LogContent;
	waitUntil {!isNull player};
	["INITIALIZATION", "Init.sqf: Client is not null..."] Call WFCO_FNC_LogContent;
};

//--- Server & Client default View Distance.
if(isServer) then {
    setObjectViewDistance 500;
    setViewDistance 500;
} else {
    setObjectViewDistance 1750;
    setViewDistance 3000;
    waitUntil {time > 0};
    enableEnvironment [false, true];
};

//--- Server initialization.
if (isHostedServer || isDedicated) then { //--- Run the server's part.
	["INITIALIZATION", "initJIPCompatible.sqf: Executing the Server Initialization."] Call WFCO_FNC_LogContent;
	[] spawn WFSE_fnc_initServer;
};

//--- Client initialization, either hosted or pure client. Part II
if (isHostedServer || (!isDedicated)) then {
	["INITIALIZATION", "Init.sqf: Executing the Client Initialization."] Call WFCO_FNC_LogContent;
	[] spawn WFCL_fnc_initClient;
};