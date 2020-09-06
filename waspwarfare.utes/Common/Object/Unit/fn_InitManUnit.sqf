/*
	Create a unit.
	 Parameters:
		- Classname
		- Group
		- Position
		- Side ID
		- {Global Init}
		- {PLacement}
*/

params ["_unit", "_type", "_group", "_position", "_side", ["_global", true]];
private ["_get", "_skill"];

if(isNil '_group') then { _group = createGroup [_side, true]; };

//--Set unit skill according config core--
if(_side == 2) then {
    _skill = missionNamespace getVariable ["WF_C_TOWNS_DEFENDER_AIM_SKILL", 2];
    _skill = _skill / 10;    
    _unit setSkill ["aimingShake", _skill];
	
	if(_skill < 0.5) then {
		_unit setSkill ["aimingAccuracy", _skill - 0.1];
		_unit setSkill ["aimingSpeed", _skill - 0.4];
		_unit setSkill ["spotTime", _skill - 0.1];
		_unit setSkill ["spotDistance", _skill - 0.1];
	} else {
		_unit setSkill ["aimingAccuracy", _skill];
		_unit setSkill ["aimingSpeed", _skill];
		_unit setSkill ["spotTime", _skill];
		_unit setSkill ["spotDistance", _skill];
	};
} else {
    _upgrades = (_side) Call WFCO_FNC_GetSideUpgrades;
    _current_infantry_upgrade = _upgrades select WF_UP_BARRACKS;
    _skill = 0.3;
    switch (_current_infantry_upgrade) do {
        case 1: { _skill = 0.5 };
        case 2: { _skill = 0.7 };
        case 3: { _skill = 0.9 };
    };
    _unit setSkill ["aimingShake", _skill];
    _unit setSkill ["aimingAccuracy", _skill];
    _unit setSkill ["aimingSpeed", _skill];
    _unit setSkill ["spotTime", _skill];
    _unit setSkill ["spotDistance", _skill]
};

if ((missionNamespace getVariable "WF_C_GAMEPLAY_FATIGUE_ENABLED") == 1) then {
    _unit enableFatigue true;
} else {
    _unit enableFatigue false;
};

if(side _unit == east && !(_unit hasWeapon "NVGoggles")) then { _unit addWeapon "NVGoggles"; };

if (_side IsEqualType WEST) then {_side = (_side) Call WFCO_FNC_GetSideID;};

//--Check the need for unit re-equip--
for "_x" from 0 to ((count WF_C_INFANTRY_TO_REQUIP) - 1) do {
	_currentElement = WF_C_INFANTRY_TO_REQUIP # _x;
	if ((typeOf _unit) in _currentElement) exitWith{(_unit) call WFCO_FNC_Requip_AI;};
};

if (_global) then {
	if (_side != WF_DEFENDER_ID) then {
		if ((missionNamespace getVariable "WF_C_UNITS_TRACK_INFANTRY") > 0) then {
			[_unit,_side] remoteExec ["WFCO_FNC_initUnit", 0, true];
		} else {
			if (isPlayer leader _group) then {[_unit, _side] spawn WFCO_FNC_initUnit};
		};
	};
};

_unit addEventHandler ['killed', format ['[_this # 0,_this # 1,%1] spawn WFCO_FNC_OnUnitKilled', _side]];
if(!isHostedServer) then {
    [_unit, ["killed", format ['params ["_unit", "_killer"]; if(local _unit) then { [_unit, _killer, %1] spawn WFCO_FNC_OnUnitKilled; };', _side]]] remoteExec ["addEventHandler", 2];
};

["INFORMATION", Format ["fn_InitManUnit.sqf: [%1] Unit [%2] skill [%5] with a was created at [%3] and has been assigned to team [%4]",
    _side Call WFCO_FNC_GetSideFromID, _type, _position, _group, _skill]] Call WFCO_FNC_LogContent;

_unit