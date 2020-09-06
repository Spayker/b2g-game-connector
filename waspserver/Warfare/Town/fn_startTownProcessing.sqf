private ["_hc"];
// "towns" use it to get all initiated towns on map
_timeAttacked = 0;
_activeEnemies = 0;
_force = 0;
_lastUp = 0;
_skipTimeSupply = false;
_newSID = -1;
_newSide = civilian;
_town_camps_capture_rate = missionNamespace getVariable "WF_C_CAMPS_CAPTURE_RATE_MAX";

_town_capture_rate = missionNamespace getVariable 'WF_C_TOWNS_CAPTURE_RATE';
_town_supply_time_delay = missionNamespace getVariable "WF_C_ECONOMY_SUPPLY_TIME_INCREASE_DELAY";
_town_supply_time = if ((missionNamespace getVariable "WF_C_ECONOMY_SUPPLY_SYSTEM") == 1) then {true} else {false};

_town_defender_enabled = if ((missionNamespace getVariable "WF_C_TOWNS_DEFENDER") > 0) then {true} else {false};
_town_occupation_enabled = if ((missionNamespace getVariable "WF_C_TOWNS_OCCUPATION") > 0) then {true} else {false};
_isTimeToUpdateSuppluys = false;

for "_j" from 0 to ((count towns) - 1) step 1 do {
	_loc = towns # _j;
	["INITIALIZATION",Format ["WFSE_fnc_startTownProcessing : Initialized for [%1].", _loc getVariable "name"]] Call WFCO_FNC_LogContent;
	sleep 0.01;
};

_procesTowns = {
    params ["_isTimeToUpdateSuppluys"];
    for "_i" from 0 to ((count towns) - 1) step 1 do {
        _location = towns # _i;
        if!(isNil "_location") then {
            _locationSpecialities = _location getVariable "townSpeciality";
            _maxSupplyValue = _location getVariable "maxSupplyValue";
		_startingSupplyValue = _location getVariable "startingSupplyValue";
            _initialStartingSupplyValue = _location getVariable "initialStartSupplyValue";
        _sideID = _location getVariable "sideID";
        _side = (_sideID) Call WFCO_FNC_GetSideFromID;
        _objects = (_location nearEntities[["Man","Car","Motorcycle","Tank","Air","Ship"], 	WF_C_TOWNS_CAPTURE_RANGE]) unitsBelowHeight 10;


        _west = west countSide _objects;
        _east = east countSide _objects;
        _resistance = resistance countSide _objects;

        _activeEnemies = switch (_sideID) do {
            case WF_C_WEST_ID: {_east + _resistance};
            case WF_C_EAST_ID: {_west + _resistance};
            case WF_C_GUER_ID: {_east + _west};
        };

        _supplyValue = _location getVariable "supplyValue";

        if (_town_supply_time) then {
            //--- If we're running on 2 sides, skip the time based supply if the defender hold the town.
            _skipTimeSupply = if (_sideID == WF_DEFENDER_ID) then {true} else {false};
        };

            if(_town_supply_time && _sideID != WF_C_UNKNOWN_ID && !_skipTimeSupply) then {
                if (_activeEnemies == 0 && _sideID != RESISTANCEID) then {
                    if (_isTimeToUpdateSuppluys) then {
                        _increaseOf = 1;
                    if (missionNamespace getVariable Format ["WF_%1_PRESENT",_side]) then {
                        _upgrades = (_side) Call WFCO_FNC_GetSideUpgrades;
                            _increaseOf = 2 * ((missionNamespace getVariable "WF_C_TOWNS_SUPPLY_LEVELS_TIME") # (_upgrades # WF_UP_SUPPLYRATE));
                    };

                        if!(WF_C_MINE in (_locationSpecialities)) then {
                        if(WF_C_WAREHOUSE in (_locationSpecialities)) then {
                            _supplyValue = _supplyValue - _increaseOf;
                            if (_supplyValue <= 0) exitWith {
                                towns = towns - [_location];
                                missionNamespace setVariable ["totalTowns", count towns, true];
                                [_location getVariable "name"] remoteExecCall ["WFCL_FNC_TownRemoved"];
                                deleteVehicle _location
                                };
                                    _location setVariable ["supplyValue", _supplyValue, true]
                        } else {
                                if (_supplyValue < _maxSupplyValue) then {
                    _supplyValue = _supplyValue + _increaseOf;
                                    if (_supplyValue >= _maxSupplyValue) then {_supplyValue = _maxSupplyValue};
                                    _location setVariable ["supplyValue", _supplyValue, true]
                                }
                                }
                        }
                    }
                }
        };

        if(_west > 0 || _east > 0 || _resistance > 0) then {
            _skip = false;
            _protected = false;
            _captured = false;

            _resistanceDominion = if (_resistance > _east && _resistance > _west) then {true} else {false};
            _westDominion = if (_west > _east && _west > _resistance) then {true} else {false};
            _eastDominion = if (_east > _west && _east > _resistance) then {true} else {false};

            if (_sideID == RESISTANCEID && _resistanceDominion) then {_force = _resistance;_protected = true;_skip = true};
            if (_sideID == EASTID && _eastDominion) then {_force = _east;_protected = true;_skip = true};
            if (_sideID == WESTID && _westDominion) then {_force = _west;_protected = true;_skip = true};

            if (_resistanceDominion) then {
                _resistance = if (_east > _west) then {_resistance - _east} else {_resistance - _west};
                _force = _resistance;
                _east = 0;
                _west = 0;
            };
            if (_westDominion) then {
                _west = if (_east > _resistance) then {_west - _east} else {_west - _resistance};
                _force = _west;
                _east = 0;
                _resistance = 0;
            };
            if (_eastDominion) then {
                _east = if (_west > _resistance) then {_east - _west} else {_east - _resistance};
                _force = _east;
                _west = 0;
                _resistance = 0;
            };

            if (!_resistanceDominion && !_westDominion && !_eastDominion) then {_west = 0; _east = 0; _resistance = 0};

            _totalCamps = _location Call WFCO_FNC_GetTotalCamps;
            if (_west > 0 && west in WF_PRESENTSIDES) then {
                if (_totalCamps != ([_location,west] Call WFCO_FNC_GetTotalCampsOnSide)) then {_skip = true};
            };
            if (_east > 0 && east in WF_PRESENTSIDES) then {
                if (_totalCamps != ([_location,east] Call WFCO_FNC_GetTotalCampsOnSide)) then {_skip = true};
            };
            if (_resistance > 0 && resistance in WF_PRESENTSIDES) then {
                if (_totalCamps != ([_location,resistance] Call WFCO_FNC_GetTotalCampsOnSide)) then {_skip = true};
            };

                _isSpawning = _location getVariable ["wf_spawning", false];
            if(_isSpawning) then { _skip = true };

            if !(_skip) then {
                _newSID = switch (true) do {case (_west > 0): {WF_C_WEST_ID}; case (_east > 0): {WF_C_EAST_ID}; case (_resistance > 0): {WF_C_GUER_ID};};
                _newSide = (_newSID) Call WFCO_FNC_GetSideFromID;
                _rate = _town_capture_rate * (([_location,_newSide] Call WFCO_FNC_GetTotalCampsOnSide) / (_location Call WFCO_FNC_GetTotalCamps)) * _town_camps_capture_rate;
                if (_rate < 1) then {_rate = 1};

                if (_sideID != WF_C_UNKNOWN_ID) then {
                    if (_activeEnemies > 0 && time > _timeAttacked && (missionNamespace getVariable Format ["WF_%1_PRESENT",_side])) then {_timeAttacked = time + 60;[_side, "IsUnderAttack", ["Town", _location]] Spawn WFSE_FNC_SideMessage};
                };

                _supplyValue = round(_supplyValue - (_resistance + _east + _west) * _rate);
                    if (_supplyValue < 1) then {_supplyValue = _startingSupplyValue; _captured = true};
                _location setVariable ["supplyValue",_supplyValue,true];
            };

            if (_protected) then {
                if (_supplyValue < _startingSupplyValue) then {
                    _supplyValue = _supplyValue + _force * _town_capture_rate;
                    if (_supplyValue > _startingSupplyValue) then {_supplyValue = _startingSupplyValue};
                    _location setVariable ["supplyValue",_supplyValue,true];
                };
            };

            if(_captured) then {
                ["INFORMATION", Format ["WFSE_fnc_startTownProcessing: Town [%1] was captured by [%2] From [%3].", _location, _newSide, _side]] Call WFCO_FNC_LogContent;

                //--Store town capturing time--
                _location setVariable ["captureTime",time];

                if(_side != resistance && _newSide != resistance) then {
                    [format [":homes: town **%1** was captured by %2%3 from %4%5", _location, _newSide Call WFCO_FNC_GetSideFLAG, _newSide, _side Call WFCO_FNC_GetSideFLAG, _side]] Call WFDC_FNC_LogContent;
                };

				_oldSideID = _location getVariable "sideID";
			
                if (_sideID != WF_C_UNKNOWN_ID) then {
                    if (missionNamespace getVariable Format ["WF_%1_PRESENT",_side]) then {[_side, "Lost", _location] Spawn WFSE_FNC_SideMessage};
                };

                if (missionNamespace getVariable Format ["WF_%1_PRESENT",_newSide]) then {[_newSide, "Captured", _location] Spawn WFSE_FNC_SideMessage};

                _location setVariable ["sideID",_newSID,true];
                    [_location, _location getVariable "name", _sideID, _newSID] remoteExecCall ["WFCL_FNC_TownCaptured"];

                    if (WF_C_RADAR in _locationSpecialities) then { [_location] remoteExec ["WFCL_FNC_UpdateRadarMarker", -2, true] };

                [_location, _sideID, _newSID] Spawn WFSE_FNC_SetCampsToSide;

                //--- Clear the town defenses, units first then replace the defenses if needed.
                [_location, _side, "remove"] Call WFSE_FNC_OperateTownDefensesUnits;

                //--- Check if the side is enabled in town and add defenses if needed.
                _side_enabled = false;
                if (_newSide == WF_DEFENDER) then {
                        if (_town_defender_enabled) then { _side_enabled = true }
                } else {
                        if (_town_occupation_enabled) then { _side_enabled = true }
                };


				//--If town belonged GUERS, check left groups, if infantry count is low than 9 or TownSV/10 kill them--
				if(_oldSideID == 2) then {
				    //--Check remaining units in the captured town--
                    _grps = _location getVariable ["wf_town_teams", []];
                    _totalTownUnitsCountLimit = ceil(_maxSupplyValue / 10);
                        if(_totalTownUnitsCountLimit < 9) then { _totalTownUnitsCountLimit = 9 };
                    _totalTownUnitsCount = _totalTownUnitsCountLimit;

                    if(count _grps > 0) then
                    {
                    	_totalTownUnitsCount = 0;
                    	{
                    		{
                    			if(vehicle _x == _x) then {
                    				_totalTownUnitsCount = _totalTownUnitsCount + 1;
                    			};
                    		} forEach (units _x);
                    	} forEach (_grps);
                    };

                    //--Check if HC is online--
                    _hc = missionNamespace getVariable ["WF_HEADLESSCLIENT_ID", 0];

                    if(_totalTownUnitsCount <= _totalTownUnitsCountLimit) then {
                        if(_hc > 0) then {
                            //--Command HC to kill remaining infantry--
                        	[_location, 1, false] remoteExec ["WFHC_FNC_RemoveTownAI", _hc];
                        } else { //--Do it on server--
                            //--- Teams Units.
                            {
                                if!(isNull _x) then {
                                    {
                                        if(vehicle _x == _x) then {
                                            _x setDamage 1;
                                        };
                                    } forEach units _x;
                                    deleteGroup _x;
                                };
                            } forEach (_grps);
                    	};
                    } else { //--Remove only man which is in building--
                        if(_hc > 0) then {
                                [_location, 2, false] remoteExec ["WFHC_FNC_RemoveTownAI", _hc];
                        } else {
                            {
                                if(!isNull _x) then {
                                    {
                                        if(!isNull _x) then {
                                            if(vehicle _x == _x && alive _x) then {
                                                if([_x] call WFCO_FNC_IsUnitInBuilding) then {
                                                    _x setDamage 1;
                                                };
                                            };
                                        };
                                    } forEach units _x;
                                };
                            } forEach (_grps);
                            }
                        }
                    };

                    if (WF_C_MINE in _locationSpecialities) then {
                        towns = towns - [_location];
                        missionNamespace setVariable ["totalTowns", count towns, true];
                        [_location getVariable "name"] remoteExecCall ["WFCL_FNC_TownRemoved"];

                        _locationPosition = getPosATL _location;
                        deleteVehicle _location;
                        _isTownRemowed = false;
                        [missionNamespace getVariable Format["WF_%1SUPPLY_TRUCK", str _side], _locationPosition, _oldSideID, 0, false, false] Call WFCO_FNC_CreateVehicle;
                    };

                    // calculating town damage
                        _halfTownRange = (_location getVariable "range")/2;
                        _initialTownMaxSupplyValue = _location getVariable "initialMaxSupplyValue";
                        _townRuins = count (nearestObjects [_location, ["Ruins"], _halfTownRange]);
                        _newTownMaxSV = floor (_initialTownMaxSupplyValue - ((_initialTownMaxSupplyValue/100)*_townRuins));

                        if (_newTownMaxSV < _initialStartingSupplyValue) then {
                            towns = towns - [_location];
                            missionNamespace setVariable ["totalTowns", count towns, true];
                            [_location getVariable "name", _location getVariable "camps"] remoteExecCall ["WFCL_FNC_TownRemoved"];
                            ["TownCanceled", _location] remoteExecCall ["WFCL_FNC_TaskSystem"];
                            sleep 3;
                            _camps = _location getVariable ["camps", []];
                            _flags = _location getVariable ["flags", []];
                            { deleteVehicle _x } forEach _camps + _flags;

                            deleteVehicle _location
                        } else {
                        _location setVariable ["maxSupplyValue", _newTownMaxSV, true];
                        _currentSupplyValue = _location getVariable "supplyValue";
                        if(_currentSupplyValue >= _newTownMaxSV) then {
                            _location setVariable ["supplyValue", _newTownMaxSV, true]
                        }
                        }
                    }
                }
                    	};
        sleep 0.05
    }
                    };

while {!WF_GameOver} do {
	[_isTimeToUpdateSuppluys] call _procesTowns;
	_isTimeToUpdateSuppluys = false;
	sleep 5;
	if (time >= _lastUp) then {
		_isTimeToUpdateSuppluys = true;
		_lastUp = time + _town_supply_time_delay;
	};
};