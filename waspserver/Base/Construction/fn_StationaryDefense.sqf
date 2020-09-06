/* Description: Creates Defenses. */
params ["_type","_side","_position","_direction","_manned",["_playerUID", ""]];
private ["_buildings","_defense","_isArtillery","_sideID","_area","_crewUnits","_gunnerType"];

_sideID = (_side) call WFCO_FNC_GetSideID;

_area = [_position,((_side) call WFCO_FNC_GetSideLogic) getVariable "wf_basearea"] call WFCO_FNC_GetClosestEntity4;

_defense = createVehicle [_type, _position, [], 0, "NONE"];
_defense call WFCO_FNC_BalanceInit;

_defense setDir _direction;
_defense setPos _position;
_defense setVariable ["side", _side];
_defense setVariable ["playerUID", _playerUID];

["INFORMATION", format ["Construction_StationaryDefense.sqf: [%1] Defense [%2] has been constructed.", str _side, _type]] call WFCO_FNC_LogContent;

//--- If it's a minefield, we exit the script while spawning it.
if (_type == 'Sign_Danger') exitWith {
	private ["_c","_h","_mine","_mineType","_toWorld"];
   _mineType = if (_side == west) then {"CUP_Mine"} else {"CUP_MineE"};
	_h = -4;
	_c = 0;
	for [{_z=0;}, {_z<9}, {_z=_z+1;}] do {
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		mines set [count mines, [_mine, time]];

		_c = _c + 4;
	};

	_h = 0;
	_c = 2;
	for [{_z=0;}, {_z<8}, {_z=_z+1;}] do{
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		mines set [count mines, [_mine, time]];
		_c = _c + 4;
	};

	_h = 4;
	_c = 0;
	for [{_z=0;}, {_z<9}, {_z=_z+1;}] do{
		_array = [((_defense worldToModel (getPos _defense)) select 0) - 16 +_c,((_defense worldToModel (getPos _defense)) select 1) + _h];
		_toWorld = _defense modelToWorld _array;
		_toWorld set[2,0];
		_mine = createMine [_mineType, _toWorld,[], 0];
		mines set [count mines, [_mine, time]];
		_c = _c + 4;
	};
	deleteVehicle _defense;
};

_defense setVariable ["wf_defense", true]; //--- This is one of our defenses.

call Compile format ["_defense addEventHandler ['Killed',{[_this # 0,_this select 1,%1] spawn WFCO_FNC_OnUnitKilled; [_this # 0] spawn WFCO_FNC_KillStaticDefenseCrew;}]",_sideID];
_defense addEventHandler ['Deleted',{[_this # 0] call WFCO_FNC_KillStaticDefenseCrew;}];
_defense addEventHandler ['incomingMissile', {_this spawn WFCO_FNC_HandleIncomingMissile}];

if (_manned && _defense emptyPositions "gunner" > 0 && (((missionNamespace getVariable "WF_C_BASE_DEFENSE_MAX") > 0))) then {
	private ["_check","_team"];
	_team = _area getVariable "DefenseTeam";

	if (isNil '_team') then {
        _team = createGroup [_side, true];
        _area setVariable ["DefenseTeam", _team];
    } else {
        if(side _team != _side) then {
            _team = createGroup [_side, true];
        };
        if((count units _team) > 10) then {
            _team = createGroup [_side, true];
        };
        _area setVariable ["DefenseTeam", _team];
    };
	[_defense] spawn WFSE_FNC_addEmptyVehicleToQueue;

	private _specDefenseIndex = (WF_C_ADV_AIR_DEFENCE # 0) find (typeOf _defense);
	if(_specDefenseIndex > -1) then {
	    _gunnerType = missionNamespace getVariable format ["WF_%1SOLDIER", _side];
		_crewUnits = [_defense, [_gunnerType, "turret"], true, true] call BIS_fnc_initVehicleCrew;
		
		{
			[_x, _gunnerType, _team, _position, _side call WFCO_FNC_GetSideID] spawn WFCO_fnc_InitManUnit;
			_x setSkill 1;
			[_x, WF_C_GAMEPLAY_MISSILES_RANGE, getPosATL _defense] spawn WFCO_FNC_RevealArea;

			[str _side, 'UnitsCreated', 1] call WFCO_FNC_UpdateStatistics;
		} forEach _crewUnits;

		_defense setVariable ["_crewUnits", _crewUnits];
            
	    _defense addeventhandler ["fired", {
			params ["_unit"];
		
			[_unit] spawn {
				_unit = _this # 0;
				_specDefenseIndex = (WF_C_ADV_AIR_DEFENCE # 0) find (typeOf _unit);
        		_unit setVehicleAmmo 0;
        		sleep ((WF_C_ADV_AIR_DEFENCE # 1) # _specDefenseIndex);
        		_unit setVehicleAmmo 1;
            	};
            }];
	} else {
		if!([typeOf _defense] in (missionNamespace getVariable [format['WF_%1_ARTILLERY_CLASSNAMES', _side], []])) then {
			_defense addeventhandler ["fired", {
				params["_unit"];
				
				_crewUnit = crew _unit;
				if(count _crewUnit > 0) then {					
					_crewLieader = leader (_crewUnit # 0);
					
					if(!isNull _crewLieader && !isPlayer _crewLieader) then {
						if(_unit ammo (primaryWeapon _unit) <= 0) then { _unit setvehicleammo 1; };
					};				
				};
			}];
		};
	};

	if (_specDefenseIndex == -1) then {
        [_defense, _side, _team] spawn WFSE_FNC_HandleDefense;
	};
};

_defense