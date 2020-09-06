/*
	Client towns markers initialization.
*/

{
	Private ["_townColor", "_townMarker", "_townSide"];

	//--- Wait for the sideID to be initialized.
	waitUntil {!isNil {_x getVariable "sideID"}};
	_townSide = _x getVariable "sideID";
	
	_camps = _x getVariable "camps";
	
	//--- Determine the coloration method.
	_townColor = missionNamespace getVariable "WF_C_UNKNOWN_COLOR";
	if (_townSide == WF_Client_SideID) then {
		_townColor = missionNamespace getVariable (Format ["WF_C_%1_COLOR",(_townSide) Call WFCO_FNC_GetSideFromID]);
	};

	//--- Place a marker over the logic.
	_townMarker = Format ["WF_%1_CityMarker", _x getVariable "name"];
	createMarkerLocal [_townMarker, getPos _x];
    _townMarker setMarkerTextLocal (_x getVariable "name");
    if(count _camps > 0) then {
        _townMarker setMarkerTypeLocal "n_unknown"
    } else {
        _townMarker setMarkerTypeLocal "n_installation"
    };
	_townMarker setMarkerColorLocal _townColor;

	//--- Wait for the camps to be initialized.
	waitUntil {!isNil {_camps}};
	
	//--- The town may have some camps.
	{
		Private ["_campColor","_campMarker","_campSide"];
		
		//--- Wait for the sideID to be initialized.
		waitUntil {!isNil {_x getVariable "sideID"}};
		_campSide = _x getVariable "sideID";
		
		// --- Determine the coloration method.
		_campColor = missionNamespace getVariable "WF_C_UNKNOWN_COLOR";
		if (_townSide == WF_Client_SideID) then {
			_campColor = missionNamespace getVariable (Format ["WF_C_%1_COLOR",(_campSide) Call WFCO_FNC_GetSideFromID]);
		};

		//--- Place a marker over the logic.
		_campMarker = _x getVariable "wf_camp_marker";
		createMarkerLocal [_campMarker, getPos _x];
		_campMarker setMarkerTypeLocal "o_unknown";
		_campMarker setMarkerColorLocal _campColor;
		_campMarker setMarkerSizeLocal [0.5,0.5];
	} forEach _camps;
} forEach towns;