params ["_town", "_townName", "_townDubbingName", "_townStartSV", "_townMaxSV", "_townRange", ["_townSpecialities", []], ["_townServices", []], ["_townDefendersSpeciality", []]];
private ['_marker'];

if ((missionNamespace getVariable "WF_DEBUG_DISABLE_TOWN_INIT") == 1) exitWith {
	["DEBUG", "fn_initTown.sqf init is disabled"] Call WFCO_FNC_LogContent
};

//--- Prevent the isServer bug on the client.
sleep (1.2 + random 0.2);

//--- setup of town speciality
_town setVariable ["townSpeciality", _townSpecialities];

//--- setup of common data
_town setVariable ["name",_townName];
_town setVariable ["range",_townRange];

//--- setup town supply related data
if (count _townSpecialities > 0) then {
    _town setVariable ["startingSupplyValue",_townMaxSV]
} else {
    _town setVariable ["startingSupplyValue",_townStartSV]
};
_town setVariable ["maxSupplyValue",_townMaxSV];
_town setVariable ["initialMaxSupplyValue",_townMaxSV];
_town setVariable ["initialStartSupplyValue",_townStartSV];

waitUntil {!isNil "commonInitComplete"};
waitUntil {commonInitComplete};

_camps = nearestObjects [_town, WF_C_CAMP_SEARCH_ARRAY, _townRange];
_camps = _camps select { (_x getVariable ["WF_CAMP_TOWN", ""]) == _townName };

if (isServer) then {
    //--- Get the camps and defenses
    _town setVariable ["camps", _camps, true];
    ["INITIALIZATION",Format ["Init_Town.sqf : Found [%1] camps in [%2].", count _camps, _town getVariable "name"]] call WFCO_FNC_LogContent;

    //--- Setup town defense speciality
    if(count _townDefendersSpeciality > 0) then { _town setVariable ["townDefendersSpeciality", _townDefendersSpeciality, true] };

_defenseLocations = [];
{
    _kind = _x getVariable "wf_defense_kind";

    if !(isNil "_kind") then {
            if(count _kind > 1) then {
                _townBelongName = _kind # 1;
                if(_townBelongName == _townName) then { _defenseLocations pushBack [_kind, (getPosATL _x), getDir _x, nil] }
            } else {
                _defenseLocations pushBack [_kind, (getPosATL _x), getDir _x, nil]
            }
    }
} forEach (_town nearEntities[["Logic"], _townRange]);
    _town setVariable ["wf_town_defenses", _defenseLocations, true];

    _townDubbingName = switch (_townDubbingName) do {
        case "+": {_townName};//--- Copy the name.
        case "": {"Town"};//--- Unknown name, apply Town dubbing.
        default {_townDubbingName};//--- Input name.
    };
    _town setVariable ["wf_town_dubbing", _townDubbingName, true];

    [_town,_camps,_townStartSV, _townMaxSV, _townSpecialities, _townRange, _townServices] spawn {
        params ["_town", "_camps","_townStartSV", "_townMaxSV", "_townSpecialities", "_townRange", "_townServices"];
        if (count _townSpecialities > 0) then {
            _town setVariable ["supplyValue",_townMaxSV,true]
        } else {
            _town setVariable ["supplyValue",_townStartSV,true]
        };


        waitUntil {serverInitComplete};

        //--- setup town service related data
        _town setVariable ["townServices", _townServices, true];
        if(WF_C_MILITARY_BASE in _townSpecialities || WF_C_AIR_BASE in _townSpecialities) then {
            _respVehPositions = [];
            {
               _respVehDetails = [];
               _respVehDetails pushBack (getPosAtl _x);
               _respVehDetails pushBack (getDir _x);
               _respVehPositions pushBack (_respVehDetails);
               deleteVehicle _x
            } forEach (_town nearEntities[["LocationRespawnPoint_F"], _townRange]);
            _town setVariable ["respVehPositions", _respVehPositions, true]
        }
    }
};

//--- Client camp init.
if (local player) then {
    for '_i' from 0 to count(_camps)-1 do {
        _camp = _camps # _i;
        _camp setVariable ["wf_camp_marker", Format ["WF_%1_CityMarker_Camp%2", str _town, _i]];
        _camp setVariable ["town", _town]
    };

    ["INITIALIZATION",Format ["Init_Town.sqf : (Client) Initialized Camps [%1] for town [%2].", count _camps, _townName]] call WFCO_FNC_LogContent
};

["INITIALIZATION",Format ["Init_Town.sqf : Initialized town [%1].", _townName]] call WFCO_FNC_LogContent;

towns pushBack _town
