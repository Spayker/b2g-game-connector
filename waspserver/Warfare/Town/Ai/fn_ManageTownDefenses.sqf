/*
	Manage or spawn defenses in a town if needed.
	 Parameters:
		- Town.
		- Side.
*/
params ["_town", "_side", "_sideID_old"];
private ["_defense","_sideID","_spawn"];

_sideID = _side call WFCO_FNC_GetSideID;
//--- Browse all the defenses of the town.
{
	_defense = _x # 3;
	_spawn = false;

	if (isNil '_defense') then {
		_spawn = true;
	} else {
		if (!alive _defense || _sideID_old != _sideID) then { //--- Remove if non-null.
			if !(isNull _defense) then {deleteVehicle _defense};
			_spawn = true;
		};
	};
	
	if (_spawn) then { //--- Spawn a defense according to the types (if it exists).
		[_town, _x, _forEachIndex, _side] call WFSE_fnc_SpawnTownDefense;
	};
	
	if(diag_fps > 35) then {
		sleep 2;
	};
} forEach (_town getVariable "wf_town_defenses")