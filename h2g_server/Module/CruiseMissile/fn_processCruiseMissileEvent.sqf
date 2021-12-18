params ["_side","_dropPosition","_target","_playerTeam"];

["INFORMATION", Format ["fn_processCruiseMissileEvent.sqf: [%1] Team [%2] [%3] has called cruise missile.", str _side, _playerTeam, name (leader _playerTeam)]] Call WFCO_FNC_LogContent;

if (isNull _target || !alive _target) exitWith {};

_height = (getPosAtl _target) # 2;
while {alive _target} do {
    if(alive _target)then{
        _height = (getPos _target) # 2
    }
};

if (_height < 25) then {
    [_dropPosition] call WFSE_FNC_processMissileDamage
}