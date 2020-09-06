params ["_side", "_structure", "_isHq"];
private ["_index", "_delay", "_payback", "_env", "_logik", "_current", "_position"];

_structure setVariable ["wf_sold", true, true];
_index = _structure getVariable ["wf_index", -1];
_env = _structure getVariable ["wf_env", []];
_position = getPos _structure;

if (_isHq) then { _index = 0 };

_delay = missionNamespace getVariable "WF_C_STRUCTURES_SALE_DELAY";

//--- Inform the side (before).
['StructureSell', _index, _delay] remoteExecCall ["WFCL_FNC_LocalizeMessage", _side];

sleep _delay;

if !(alive _structure) exitWith {};

if (_index > 0) then {
    _payback = (missionNamespace getVariable format["WF_%1STRUCTURECOSTS", _side]) # _index;
    _payback = round((_payback * (missionNamespace getVariable "WF_C_STRUCTURES_SALE_PERCENT")) / 100);

    [_side, _payback] call WFCO_FNC_ChangeSideSupply;

    //--Decrement buildings limit--

    _logik = (_side) Call WFCO_FNC_GetSideLogic;

    _current = _logik getVariable "wf_structures_live";
    _current set [_index - 1, (_current # (_index-1)) - 1];
    _logik setVariable ["wf_structures_live", _current, true];

    _logik setVariable ["wf_structures", (_logik getVariable "wf_structures") - [_structure, objNull], true];

    [_side, "Destroyed", ["Base", _structure]] spawn WFSE_FNC_SideMessage;
};

//--- Inform the side.
['StructureSold', _index] remoteExec ["WFCL_FNC_LocalizeMessage", _side];

//--removeAllEH from env objects. Then Destroy env objects and master--
_structure removeAllEventHandlers "Hit";
_structure removeAllEventHandlers "HandleDamage";
{
    _x removeAllEventHandlers "Hit";
    _x removeAllEventHandlers "HandleDamage";    
} forEach _env;
{
    _x enableSimulationGlobal true;
    _x setDamage 1;
} forEach _env;

_structure enableSimulationGlobal true;
_structure setDammage 1;

//--Delete all ruins--
sleep WF_DELETE_RUINS_LAT;
//--Get attached objects and remove each of them--
{
	deleteVehicle _x;
} forEach _env;

_ruins = nearestObjects [_position, ["ruins"], 25];

//--Delete ruins--
{
	deleteVehicle _x;
} forEach _ruins;

deleteVehicle _structure;