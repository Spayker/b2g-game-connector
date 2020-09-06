private["_WF_EmptyVehiclesQueue","_empVehTick","_prolongVehClasses"];

_prolongVehClasses = [];

{
    _prolongVehClasses pushBack (missionNamespace getVariable format["WF_%1REPAIRTRUCKS",str _x]);
} forEach WF_PRESENTSIDES;

_prolongVehClasses = _prolongVehClasses + (missionNamespace getVariable ["WF_AMBULANCES", []]);

while {!WF_GameOver} do {

	//--Prevent empty vehicles queue from outside changing while forEach is running--
	["WF_EmptyVehiclesQueueLocked", missionNamespace] call WFCO_FNC_MutexLock;

	_WF_EmptyVehiclesQueue = missionNamespace getVariable ["WF_EmptyVehiclesQueue", []];

	{
		if(alive _x) then {
			_empVehTick = _x getVariable ["_empVehTick", time];

			if (({alive _x} count crew _x) > 0) then {
				_empVehTick = time;
			};

			_subtraction = time - _empVehTick;
			if (typeOf _x in _prolongVehClasses) then {
				_subtraction = _subtraction - WF_C_UNITS_EMPTY_TIMEOUT;
			};

			if (_subtraction > WF_C_UNITS_EMPTY_TIMEOUT) then {
				["INFORMATION", Format["fn_startEmptyVehiclesCollector.sqf: Deleting empty vehicle [%1], it has been [%2] seconds.",
					_x, floor _subtraction]] Call WFCO_FNC_LogContent;
				deleteVehicle _x;
				_WF_EmptyVehiclesQueue = _WF_EmptyVehiclesQueue - [_x] - [objNull];
			} else {
				_x setVariable ["_empVehTick", _empVehTick];
			};
		};
	} forEach _WF_EmptyVehiclesQueue;

	missionNamespace setVariable ["WF_EmptyVehiclesQueue", _WF_EmptyVehiclesQueue];
	["WF_EmptyVehiclesQueueLocked", missionNamespace] call WFCO_FNC_MutexUnlock;
	
	if(diag_fps > 35) then {
		sleep 1;
	} else {
		sleep 5;
	};
};