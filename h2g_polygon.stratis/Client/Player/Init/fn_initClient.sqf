Private ['_list'];

["INITIALIZATION", Format ["fn_initClient.sqf: Client initialization begins at [%1]", time]] Call WFCO_FNC_LogContent;

WF_Client_SideJoined = side player;
WF_Client_SideJoinedText = str WF_Client_SideJoined;

//--- Namespace related (GUI).
BIS_FNC_GUIset = {UInamespace setVariable [_this # 0, _this # 1]};
BIS_FNC_GUIget = {UInamespace getVariable (_this # 0)};

//// GEAR INIT
//--- Gear: Config sub ID
WF_SUBTYPE_ITEM = 0;
WF_SUBTYPE_ACC_MUZZLE = 101;
WF_SUBTYPE_ACC_OPTIC = 201;
WF_SUBTYPE_ACC_SIDE = 301;
WF_SUBTYPE_ACC_BIPOD = 302;
WF_SUBTYPE_HEADGEAR = 605;
WF_SUBTYPE_UAVTERMINAL = 621;
WF_SUBTYPE_VEST = 701;
WF_SUBTYPE_UNIFORM = 801;
WF_SUBTYPE_BACKPACK = 901;

//--- Gear: Config ID
WF_TYPE_RIFLE = 1;
WF_TYPE_PISTOL = 2;
WF_TYPE_LAUNCHER = 4;
WF_TYPE_RIFLE2H = 5;
WF_TYPE_EQUIPMENT = 4096;
WF_TYPE_ITEM = 131072;

// adjusting fatigue
player enableFatigue false;
player setCustomAimCoef 0.1;

call compile preprocessFileLineNumbers "Common\Warfare\Config\Gear\Gear_Vanilla_Common.sqf";
call compile preprocessFileLineNumbers format ["Common\Warfare\Config\Gear\Gear_Vanilla_%1.sqf", WF_Client_SideJoined];

_list = missionNamespace getVariable "wf_gear_list_explosives";
_list = _list + (missionNamespace getVariable "wf_gear_list_magazines");
_list = _list + (missionNamespace getVariable "wf_gear_list_accessories");
_list = _list + (missionNamespace getVariable "wf_gear_list_misc");
WF_C_GEAR_LIST = _list;

//--- Global Client Variables.
WF_Client_SideID = WF_Client_SideJoined Call WFCO_FNC_GetSideID;
WF_Client_Team = group player;

//--Set default Shadows Distance if it wasn't loaded from the profile--
setShadowDistance 25;

//--Set default Terrain grid if it wasn't loaded from the profile--
setTerrainGrid 25;

//--- Add the briefing (notes).
[] Call Compile preprocessFile "briefing.sqf";

// map click drop
onMapSingleClick {if (_shift) then {false} else {true}};

addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	mapAnimAdd [0, 0.05, player];
	mapAnimCommit;
}];

["INITIALIZATION", Format ["fn_initClient.sqf: Client initialization ended at [%1]", time]] Call WFCO_FNC_LogContent;