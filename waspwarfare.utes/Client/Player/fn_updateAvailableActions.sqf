_lastUpdate = time;
_handle = nil;
_mhqbr = missionNamespace getVariable "WF_C_BASE_HQ_BUILD_RANGE";
_pur = missionNamespace getVariable "WF_C_UNITS_PURCHASE_RANGE";
_pura = missionNamespace getVariable "WF_C_UNITS_PURCHASE_HANGAR_RANGE";
_ccr = missionNamespace getVariable "WF_C_STRUCTURES_COMMANDCENTER_RANGE";
_pgr = missionNamespace getVariable "WF_C_UNITS_PURCHASE_GEAR_RANGE";
_rptr = missionNamespace getVariable "WF_C_UNITS_REPAIR_TRUCK_RANGE";
_spr = missionNamespace getVariable "WF_C_STRUCTURES_SERVICE_POINT_RANGE";
_tcr = missionNamespace getVariable "WF_C_TOWNS_CAPTURE_RANGE";
_buygearfrom = missionNamespace getVariable "WF_C_TOWNS_GEAR";
_gear_field_range = missionNamespace getVariable "WF_C_UNITS_PURCHASE_GEAR_MOBILE_RANGE";
_boundaries_enabled = if ((missionNamespace getVariable "WF_C_GAMEPLAY_BOUNDARIES_ENABLED") > 0) then {true} else {false};
_typeRepair = missionNamespace getVariable Format['WF_%1REPAIRTRUCKS',WF_Client_SideJoinedText];

//--- Keep actions updated (GUI). - changed-MrNiceGuy 
12450 cutRsc ["OptionsAvailable","PLAIN",0];
_icons = [
	"RSC\Pictures\icon_wf_building_mhq.paa",       //mhq deployable
	"Rsc\Pictures\icon_wf_building_barracks.paa",  //barracks
	"RSC\Pictures\icon_wf_building_gear.paa",      //gear avail
	"RSC\Pictures\icon_wf_building_lvs.paa",       //lvsp
	"RSC\Pictures\icon_wf_building_hvs.paa",       //hvsp
	"RSC\Pictures\icon_wf_building_air.paa",       //helipad
	"RSC\Pictures\icon_wf_building_hangar.paa",    //hangar
	"RSC\Pictures\icon_wf_building_repair.paa",    //rearm | repair | refuel
	"RSC\Pictures\icon_wf_building_cc.paa",        //command center
	"RSC\Pictures\icon_wf_building_aa_radar.paa",  //AA radar
	"RSC\Pictures\icon_wf_building_am_radar.paa"
];

while {!WF_GameOver} do {

	if (time - _lastUpdate > 5 || WF_ForceUpdate) then {
		_buildings = (WF_Client_SideJoined) Call WFCO_FNC_GetSideStructures;
        _mhqs = (WF_Client_SideJoined) Call WFCO_FNC_GetSideHQ;
        _base = [player,_mhqs] call WFCO_FNC_GetClosestEntity;
		_purchaseRange = if (commandInRange) then {_ccr} else {_pur};

		//--- Boundaries are limited ?
		if (_boundaries_enabled) then {
			_isOnMap = Call WFCL_FNC_IsOnMap;
			if (!_isOnMap && alive player && !WF_Client_IsRespawning) then {
				if !(paramBoundariesRunning) then {_handle = [] Spawn WFCL_FNC_HandleOnMap;};
			} else {
				if !(isNil '_handle') then {terminate _handle;_handle = nil;};
				paramBoundariesRunning = false;
			};
		};

		//--- HQ.
		if !(isNull _base) then {
			hqInRange = if ((player distance _base < _mhqbr) && alive _base  && (side _base in [WF_Client_SideJoined,civilian])) then {true} else {false};
		};

		barracksInRange = if (isNull (['BARRACKSTYPE',_buildings,_purchaseRange,WF_Client_SideJoined,player] Call WFCO_FNC_BuildingInRange)) then {false} else {true};
		gearInRange = if (isNull (['BARRACKSTYPE',_buildings,_pgr,WF_Client_SideJoined,player] Call WFCO_FNC_BuildingInRange)) then {false} else {true};
		if !(gearInRange) then {
			if (_buygearfrom in [1,2,3]) then {
				_nObject = objNull;
				switch (_buygearfrom) do { 
					case 1:{_nObject = [vehicle player, _gear_field_range] Call WFCL_FNC_GetClosestCamp;};
					case 2:{_nObject = [vehicle player, _gear_field_range] Call WFCL_FNC_GetClosestDepot;};
					case 3:{{if !(isNull _x) exitWith {_nObject = _x;}} forEach [[vehicle player, _gear_field_range] Call WFCL_FNC_GetClosestCamp, [vehicle player, _gear_field_range] Call WFCL_FNC_GetClosestDepot]};
				};
				gearInRange = if !(isNull _nObject) then {true} else {false};
			};
		};

		lightInRange = if (isNull (['LIGHTTYPE',_buildings,_purchaseRange,WF_Client_SideJoined,player] Call WFCO_FNC_BuildingInRange)) then {false} else {true};
		heavyInRange = if (isNull (['HEAVYTYPE',_buildings,_purchaseRange,WF_Client_SideJoined,player] Call WFCO_FNC_BuildingInRange)) then {false} else {true};
		aircraftInRange = if (isNull (['AIRCRAFTTYPE',_buildings,_purchaseRange,WF_Client_SideJoined,player] Call WFCO_FNC_BuildingInRange)) then {false} else {true};
		serviceInRange = if (isNull (['SERVICEPOINTTYPE',_buildings,_spr,WF_Client_SideJoined,player] Call WFCO_FNC_BuildingInRange)) then {false} else {true};

		if !(serviceInRange) then {
			_checks = (getPos player) nearEntities[_typeRepair,_rptr];
			if (count _checks > 0) then {serviceInRange = true;};
		};

		_checks = [WF_Client_SideJoined, missionNamespace getVariable Format ["WF_%1AARADARTYPE",WF_Client_SideJoinedText],_buildings] Call WFCO_FNC_GetFactories;
		if (count _checks > 0) then {antiAirRadarInRange = true;} else {antiAirRadarInRange = false;};
		
		_checks = [WF_Client_SideJoined, missionNamespace getVariable Format ["WF_%1ArtyRadarTYPE",WF_Client_SideJoinedText],_buildings] Call WFCO_FNC_GetFactories;
		if (count _checks > 0) then {antiArtyRadarInRange = true;} else {antiArtyRadarInRange = false;};
		
		//--- Town Depot.
		depotInRange = if !(isNull ([vehicle player, _tcr] Call WFCL_FNC_GetClosestDepot)) then {true} else {false};
		if (depotInRange) then {serviceInRange = true};

		_checks = ['COMMANDCENTERTYPE',_buildings,_ccr,WF_Client_SideJoined,player] Call WFCO_FNC_BuildingInRange;
		commandInRange = if (isNull _checks) then {false} else {true};
		if!(commandInRange) then {
		    _capturedRadars = [WF_Client_SideJoined, WF_C_RADAR, true] call WFCO_fnc_getSpecialLocations;
		    if(count _capturedRadars > 0) then {
                {
                    if ((_x distance player) <= (_ccr/2)) exitWith { commandInRange = true }
                } forEach _capturedRadars;
		    }
		};

		//--- Airport.
		hangarInRange = if !(isNull ([vehicle player, _pura] Call WFCL_FNC_GetClosestAirport)) then {true} else {false};

		_usable = [hqInRange,barracksInRange,gearInRange,lightInRange,heavyInRange,aircraftInRange,hangarInRange,
		    serviceInRange,commandInRange,antiAirRadarInRange,antiArtyRadarInRange];

		_c = 0;
		if (isNull (["currentCutDisplay"] call BIS_FNC_GUIget)) then {12450 cutRsc["OptionsAvailable","PLAIN",0]};
		{
			if (_x) then {
				((["currentCutDisplay"] call BIS_FNC_GUIget) DisplayCtrl (3500 + _c)) ctrlSetText (_icons select _c);
				((["currentCutDisplay"] call BIS_FNC_GUIget) DisplayCtrl (3500 + _c)) ctrlSetTextColor WF_C_TITLETEXT_COLOR_INT;
			} else {
				((["currentCutDisplay"] call BIS_FNC_GUIget) DisplayCtrl (3500 + _c)) CtrlSetText "";
			};
			_c = _c + 1;
		} forEach _usable;

		[] spawn WFCL_fnc_updateCommanderState;

		0 = [] spawn {
			missionNamespace setVariable ["ASL_Nearby_Vehicles", (call ASL_Find_Nearby_Vehicles)];
		};

		if (WF_ForceUpdate) then {WF_ForceUpdate  = false}
	};

	_lastUpdate = time;
	sleep 5;
};