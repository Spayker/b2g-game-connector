if (!hasInterface || isDedicated) exitWith {};
params ["_winnerSide"];
private ['_HQ','_base','_blist','_camShotOrder','_camera','_nvgstate','_position','_secTarget','_track','_vehi'];

WF_GameOver = true;

if (dialog) then {closeDialog 0};

[_winnerSide] spawn WFCL_fnc_displayEndOfGameStats;

playMusic "LeadTrack01a_F";

_blist = [];
_track_hq = [];
_track = [];
{
	if (missionNamespace getVariable Format["WF_%1_PRESENT", _x]) then {
	    _side = _x;
		_logik = (_side) Call WFCO_FNC_GetSideLogic;
		_hqs = (_side) Call WFCO_FNC_GetSideHQ;
		{
		    if(!isNull  _x) then { _track_hq pushBack _x };
            _track = _track + ([_x, (_side) Call WFCO_FNC_GetSideStructures] Call WFCO_FNC_SortByDistance)
		} forEach _hqs;
	}
} forEach ([west,east] - [_winnerSide]);

_mhqs = (_winnerSide) Call WFCO_FNC_GetSideHQ;
_hq = [player,_mhqs] call WFCO_FNC_GetClosestEntity;

if(!isNull _hq) then { _blist pushBack _hq };
_blist = _blist + _track_hq + ([_hq, (_winnerSide) Call WFCO_FNC_GetSideStructures] Call WFCO_FNC_SortByDistance) + _track;

//--- Safety Pos.
_vehi = vehicle player;
if (_vehi != player) then {player action ["EJECT", _vehi];_vehi = player};
_vehi allowDamage false;
_vehi setVelocity [0,0,-0.1];
_vehi setPos ([getPos _hq,20,30] Call WFCO_FNC_GetRandomPosition);
[_vehi, false] remoteExecCall ["enableSimulationGlobal", 2];

if (!isNil "WF_DeathCamera") then {
	WF_DeathCamera cameraEffect["TERMINATE","BACK"];
	camDestroy WF_DeathCamera;
	"colorCorrections" ppEffectEnable false;
	"dynamicBlur" ppEffectEnable false;
};

_camera = "camera" camCreate (getPos (_blist select 0));
_camera camSetFov 0.200;
_camera cameraEffect["Internal","back"];
_camera camSetTarget getPos (_blist select 0);
_camera camSetRelPos [160.80,130.29,140.07];
_camera camCommit 0;
_nvgstate = if (daytime > 18.5 || daytime < 5.5) then {true} else {false};
camUseNVG _nvgstate;

waitUntil {camCommitted _camera};

_camera camSetRelPos [-190.71,190.55,180.94];
_camera camCommit 10;

waitUntil {camCommitted _camera};

_camShotOrder = [[0,100,35],[50,0,20],[0,-50,20],[-50,0,20]];

{
	_camera camSetPos getPos _x;
	_camera camSetTarget getPos _x;

	{
		_camera camSetRelPos _x;
		_camera camCommit 5;
		waitUntil {camCommitted _camera};
	} forEach _camShotOrder;

	_camera camSetRelPos [0,100,35];
	_camera camCommit 5;
	waitUntil {camCommitted _camera};
} forEach _blist;

failMission "END1";