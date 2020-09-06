private["_town","_range_detect_active","_position","_groups","_town_camps","_town_camps_count","_airHeight","_unitsInactiveMax",
"_patrol_delay","_patrol_enabled","_town_defender_enabled","_town_occupation_enabled", "_hc", "_grps"];

for "_j" from 0 to ((count towns) - 1) step 1 do
{
	_loc = towns select _j;
	["INITIALIZATION",format ["fn_startTownAiProcessing.sqf : Initialized for [%1].", _loc getVariable "name"]] call WFCO_FNC_LogContent;
	sleep 0.01;
};

_range_detect_active = missionNamespace getVariable "WF_C_TOWNS_AI_SPAWN_RANGE";
_range_detect_active_occupation = _range_detect_active / 3;

_airHeight = missionNamespace getVariable "WF_C_TOWNS_DETECTION_RANGE_AIR";
_unitsInactiveMax = missionNamespace getVariable "WF_C_TOWNS_UNITS_INACTIVE";
_town_defender_enabled = if ((missionNamespace getVariable "WF_C_TOWNS_DEFENDER") > 0) then {true} else {false};
_town_occupation_enabled = if ((missionNamespace getVariable "WF_C_TOWNS_OCCUPATION") > 0) then {true} else {false};

for "_k" from 0 to ((count towns) - 1) step 1 do {
	_town = towns select _k;
	_town setVariable ["wf_active", false];
	_town setVariable ["wf_active_air", false];
	_town setVariable ["wf_inactivity", 0];
	_town setVariable ['wf_town_active_vehicles',[]];
	_town setVariable ['wf_active_vehicles', []];
	_town setVariable ['wf_town_teams', []];
	_town setVariable ['wf_saved_inf_town_teams', []];
	_town setVariable ['wf_saved_veh_town_teams', []];
    _town setVariable ['wf_rest_infantry_groups', [], true];
    _town setVariable ['wf_rest_vehicle_groups', [], true];
	_town setVariable ['wf_spawning', false];
	sleep 0.01;
};

for "_i" from 0 to ((count towns) - 1) step 1 do {

	_town = towns # _i;
	[_town, _unitsInactiveMax] spawn {
		params["_town", "_unitsInactiveMax"];
		_position = [];
		_infGroups = [];
		_vehGroups = [];

		while {!WF_GameOver} do {
            _sideID = _town getVariable "sideID";
            if!(isNil "_sideID") then {
            _side = (_sideID) call WFCO_FNC_GetSideFromID;

            if(_sideID != WF_C_UNKNOWN_ID) then {
                _detected = 0;

                _detected = (_town nearEntities ["AllVehicles", (_town getVariable "range") * 1.5]) unitsBelowHeight 20;
                _enemies = [_detected, _side] call WFCO_FNC_GetAreaEnemiesCount;
                if(_enemies > 0) then {

                    _town setVariable ["wf_inactivity", time];
                    if(!(_town getVariable "wf_active")) then {
                        ["INFORMATION", format ["fn_startTownAiProcessing.sqf: Town [%1] has been activated, creating defensive units for [%2].", _town, _side]] call WFCO_FNC_LogContent;
                        [_town, _side, "spawn"] spawn WFSE_FNC_OperateTownDefensesUnits;
                        _town setVariable ["wf_active", true];

                            if(_side == resistance) then {
                                _locationSpecialities = _town getVariable "townSpeciality";
                                _vehicles = _town getVariable ["respVehicles", []];
                                _startVehicles = GUER_StartVeh;
                                if (WF_C_AIR_BASE in _locationSpecialities) then { _startVehicles = GUER_StartAirVeh };

                                    if (count _vehicles > 0) then {
                                        {
                                            _vehicle = [_x # 0, _x # 1, resistance, _x # 2, false] Call WFCO_FNC_CreateVehicle;
                                            _vehicles set [_forEachIndex, [_x # 0, _x # 1, _x # 2, _vehicle]]
                                        } forEach _vehicles
                                    } else {
                                        _vehicles = [];
                                        {
                                        _type = _startVehicles # floor(random (count _startVehicles));
                                            _vehicle = [_type, _x # 0, resistance, _x # 1, false] Call WFCO_FNC_CreateVehicle;
                                            _vehicles pushBack [_type, _x # 0, _x # 1, _vehicle]
                                        } forEach (_town getVariable ["respVehPositions", []]);
                                        _town setVariable ["respVehicles", _vehicles];
                                        _town setVariable ["respVehPositions", []]
                                    }

                            };

                        _savedInfGroups = _town getVariable "wf_saved_inf_town_teams";
                        ["INFORMATION", format ["fn_startTownAiProcessing.sqf:  saved infantry groups [%1] to be spawned: %2", count _savedInfGroups, _savedInfGroups]] call WFCO_FNC_LogContent;
                        if (count _savedInfGroups == 0) then {
                            _infGroups = [_town, _side] call WFSE_FNC_GetTownGroups;
                            ["INFORMATION", format ["fn_startTownAiProcessing.sqf: infantry groups [%1] to be spawned: %2", count _infGroups, _infGroups]] call WFCO_FNC_LogContent
                        } else {
                            _infGroups = _savedInfGroups;
                            _town setVariable ['wf_saved_inf_town_teams', []]
                        };

                        _savedVehGroups = _town getVariable "wf_saved_veh_town_teams";
                        ["INFORMATION", format ["fn_startTownAiProcessing.sqf:  saved vehicles [%1] to be spawned: %2", count _savedVehGroups, _savedVehGroups]] call WFCO_FNC_LogContent;
                        if (count _savedVehGroups == 0 && count _savedInfGroups == 0) then {
                            _vehGroups = [_town, _side] call WFSE_FNC_GetVehicleTownGroups;
                            ["INFORMATION", format ["fn_startTownAiProcessing.sqf: vehicles %1 to be spawned: %2", count _vehGroups, _vehGroups]] call WFCO_FNC_LogContent
                        } else {
                            _vehGroups = _savedVehGroups;
                            _town setVariable ['wf_saved_veh_town_teams', []]
                        };

                        _camps = +(_town getVariable "camps");
                        {
                          _flag = _x getVariable "wf_flag";
                          _flag enableSimulationGlobal true;
                        } foreach _camps;

						//// start of creation
                        if (missionNamespace getVariable format ["WF_%1_PRESENT",_side]) then { [_side,"HostilesDetectedNear",_town] Spawn WFSE_FNC_SideMessage};

						//--- create the groups
                        if(count _infGroups > 0) then {
                            [_town, _camps, _side, _vehGroups, _infGroups] spawn WFSE_FNC_spawnTownGroups;
                        }
                        //// end of creating
                    };
                };

                if((_town getVariable "wf_active") || (_town getVariable "wf_active_air")) then {
                    if((time - (_town getVariable "wf_inactivity") > _unitsInactiveMax) &&
                        !(_town getVariable ['wf_spawning', false])) then {

                            _locationSpecialities = _town getVariable "townSpeciality";
                            if (WF_C_MILITARY_BASE in _locationSpecialities || WF_C_AIR_BASE in _locationSpecialities) then {
                                if(_side == resistance) then {
                                    { deleteVehicle (_x # 3) } forEach (_town getVariable ["respVehicles", []])
                                } else {
                                    _town setVariable ["respVehicles", []];
                                    _town setVariable ["respVehPositions", []]
                                }
                            };

                        _hc = missionNamespace getVariable ["WF_HEADLESSCLIENT_ID", 0];

                        if(_hc > 0) then {
                            ["INFORMATION", format ["fn_startTownAiProcessing.sqf: Delegate town [%2][%1] remove defensive units for HC[%3]", _town, _side, _hc]] call WFCO_FNC_LogContent;
                            [_town] remoteExec ["WFHC_FNC_RemoveTownAI", _hc];
                        } else {
                            //--Check remaining units in the captured town--
                            _grps = _town getVariable 'wf_town_teams';

                            //--- Teams Units.
							_groupsToSave = [];
                            {
                                if !(isNil '_x') then {
                                    if !(isNull _x) then {
                                        _groupToSave = [];
										{
										    _groupToSave pushBack (typeOf _x);
										    deleteVehicle _x
										} forEach units _x;

                                        deleteGroup _x;
                                        _groupsToSave pushBack (_groupToSave)
                                    };
                                };
                            } forEach (_grps);
							_town setVariable ['wf_saved_inf_town_teams', _groupsToSave];

                            //--- Teams vehicles.
							_vehCounter = 0;
							_groupsVehToSave = [];
							_groupToSave = [];
                            {
                                if (alive _x) then {
                                    if (_vehCounter == 2) then {
                                        _groupsVehToSave pushBack _groupToSave;
                                        _vehCounter = 0;
                                        _groupToSave = [];
                                    } else {
                                        _groupToSave pushBack (typeOf _x);
                                        _vehCounter = _vehCounter + 1
                                    }
                                }
                            } forEach (_town getVariable 'wf_active_vehicles');
							_town setVariable ['wf_saved_veh_town_teams', _groupsVehToSave];

                            _town setVariable ['wf_town_teams', []];
                            _town setVariable ['wf_active_vehicles', []];

                            _town setVariable ["wf_active", false];
                            _town setVariable ["wf_active_air", false];
                            _town setVariable ["captureTime", nil];
                        };

                        //--- Despawn the town defenses unit.
                        [_town, _side, "remove"] spawn WFSE_FNC_OperateTownDefensesUnits;
                        //// end of inner block
                    } else { //--Town still active, check capturing time--
                        if((time - (_town getVariable ["captureTime",time])) > WF_C_TOWNS_BACKCAPTURING_TIMEOUT) then {
                            //--The losing side did not have time to take back a town. Kill them--
                            _man_and_veh_groups = [objNull, "", [_town]] call WFSE_FNC_GetTownActiveGroups;
                            _town_teams = _man_and_veh_groups # 0;
                            _town_vehicles = _man_and_veh_groups # 1;

                            {
                                if!(isNull _x) then {
                                    {
                                        (vehicle _x) setDamage 1;
                                        _x setDamage 1;
                                    } forEach units _x;
                                    deleteGroup _x;
                                };
                            } forEach _town_teams;
                        }
                    }
                };
            };
            };
			sleep 5;
		};
	};

	sleep 0.01;
};

["INITIALIZATION",format ["fn_startTownAiProcessing.sqf : WF_GameOver [%1].", WF_GameOver]] call WFCO_FNC_LogContent;