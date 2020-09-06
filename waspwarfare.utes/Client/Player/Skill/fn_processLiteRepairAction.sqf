/*
	Script: Engineer Skill System by Benny.
	Description: Add special skills to the defined engineer.
*/
Private ['_dammages','_skip','_vehicle','_vehicles','_z'];

_vehicles = player nearEntities [["Car","Motorcycle","Tank","Ship","Air"],5];
if (count _vehicles < 1) exitWith {};

_vehicle = [player,_vehicles] Call WFCO_FNC_GetClosestEntity;

_dammages = getDammage _vehicle;

if !(_vehicle isKindOf "Plane") then {
	_vehicle_hit_point_damage_array = getAllHitPointsDamage _vehicle;
	if(count _vehicle_hit_point_damage_array > 1) then {
		_array = _vehicle_hit_point_damage_array select 2;
		{_dammages = _dammages + _x} forEach _array;
		_dammages = _dammages / count (_array);
	};
} else {_dammages = damage _vehicle};

if (_dammages <= 0) exitWith {};
WF_SK_V_LastUse_LR = time;

_skip = false;

HINT parseText(localize 'STR_HINT_FieldStarted');

for [{_z = 0},{_z < 25},{_z = _z + 1}] do {
	player playMove "Acts_carFixingWheel";
	sleep 1;
	if (!alive player || vehicle player != player || !alive _vehicle || _vehicle distance player > 5) exitWith { HINT parseText(localize 'STR_HINT_FieldFailed'); _skip = true; };
};

if (!alive player || vehicle player != player || !alive _vehicle || _vehicle distance player > 5) exitWith { HINT parseText(localize 'STR_HINT_FieldFailed'); _skip = true; };


if (!_skip) then {
	_dammages = _dammages - .15;
	if (_dammages < 0) then {_dammages = 0};
	_vehicle setDammage _dammages;
	
	HINT parseText(localize 'STR_HINT_FieldComplete');
};

player switchmove "";