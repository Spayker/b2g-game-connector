/*
	Client towns markers initialization.
*/

{
	Private ["_townColor", "_townMarker", "_townSideId"];

	//--- Wait for the sideID to be initialized.
	waitUntil {!isNil {_x getVariable "sideID"}};
	waitUntil {count (WF_Client_Logic getVariable ["wf_friendlySides", []]) > 0};
	_townSideId = _x getVariable ["sideID", WF_C_CIV_ID];
	_townSide = (_townSideId) Call WFCO_FNC_GetSideFromID;
	_camps = _x getVariable ["camps", []];
	
	//--- Get town speciality
	_townSpeciality = _x getVariable ["townSpeciality", []];

	//--- Place a marker over the logic.
	_townMarker = Format ["WF_%1_CityMarker", _x getVariable "name"];
	createMarkerLocal [_townMarker, getPos _x];
    _townMarker setMarkerTextLocal (_x getVariable "name");


    _townMarker setMarkerTypeLocal "n_unknown";

    if (WF_C_PORT in _townSpeciality) then { _townMarker setMarkerTypeLocal "n_naval" };

    if (WF_C_AIR_BASE in _townSpeciality) then { _townMarker setMarkerTypeLocal "c_plane" };

    if (WF_C_MILITARY_BASE in _townSpeciality) then { _townMarker setMarkerTypeLocal "loc_WaterTower" };

    if (WF_C_WAREHOUSE in _townSpeciality) then { _townMarker setMarkerTypeLocal "n_installation" };

    if (WF_C_PLANT in _townSpeciality || WF_C_POWER_PLANT in _townSpeciality) then { _townMarker setMarkerTypeLocal "loc_Power" };


    //--- Determine the coloration method.
    _townColor = missionNamespace getVariable "WF_C_CIV_COLOR";
    _townSide = (_townSideId) call WFCO_FNC_GetSideFromID;

    _friendlySides = WF_Client_Logic getVariable ["wf_friendlySides", []];

    if (_townSide in _friendlySides) then {
            _townColor = missionNamespace getVariable (Format ["WF_C_%1_COLOR",_townSide]);
        } else {
                _townColor = missionNamespace getVariable "WF_C_CIV_COLOR";
    };

	_townMarker setMarkerColorLocal _townColor;

	//--- The town may have some camps.
	{
		Private ["_campColor","_campMarker","_campSide"];
		_campSideId = _x getVariable ["sideID", WF_C_CIV_ID];
		_campSide = (_campSideId) Call WFCO_FNC_GetSideFromID;
		
		// --- Determine the coloration method.
		_campColor = missionNamespace getVariable "WF_C_CIV_COLOR";
        _friendlySides = WF_Client_Logic getVariable ["wf_friendlySides", []];
		if (_campSide in _friendlySides) then {
                _campColor = missionNamespace getVariable (Format ["WF_C_%1_COLOR", _campSide])
		};

		//--- Place a marker over the logic.
		_campMarker = _x getVariable "wf_camp_marker";
		createMarkerLocal [_campMarker, getPos _x];
		_campMarker setMarkerTypeLocal "o_unknown";
		_campMarker setMarkerColorLocal _campColor;
		_campMarker setMarkerSizeLocal [0.5,0.5];
	} forEach _camps;

	//--- Place service sub markers
	_townServices = _x getVariable "townServices";
	if(count _townServices > 0) then {
	    _townServiceMarkers = [];
	    _rearmServiceExists = false;
	    if(WF_C_TOWNS_SERVICE_REARM in _townServices) then {
	        _townMarkerPos = getPos _x;
	        _rearmMarker = Format ["WF_%1_CityMarker_Rearm", _x getVariable "name"];
            createMarkerLocal [_rearmMarker, [(_townMarkerPos # 0) - 75, (_townMarkerPos # 1) + 100]];
            _rearmMarker setMarkerTypeLocal "n_service";
            _rearmMarker setMarkerColorLocal (missionNamespace getVariable "WF_C_UNKNOWN_COLOR");
            _rearmMarker setMarkerSizeLocal [0.5,0.5];
            _townServiceMarkers pushBack _rearmMarker
	    };

	    if(WF_C_TOWNS_SERVICE_REPAIRING in _townServices) then {
	        _townMarkerPos = getPos _x;
            _repairMarker = Format ["WF_%1_CityMarker_Repair", _x getVariable "name"];
            createMarkerLocal [_repairMarker, [(_townMarkerPos # 0) - 75, (_townMarkerPos # 1) + 50]];
            _repairMarker setMarkerTypeLocal "n_maint";
            _repairMarker setMarkerColorLocal (missionNamespace getVariable "WF_C_UNKNOWN_COLOR");
            _repairMarker setMarkerSizeLocal [0.5,0.5];
            _townServiceMarkers pushBack _repairMarker
	    };

	    if(WF_C_TOWNS_SERVICE_FUEL in _townServices) then {
            _townMarkerPos = getPos _x;
            _refuelMarker = Format ["WF_%1_CityMarker_Refuel", _x getVariable "name"];
            createMarkerLocal [_refuelMarker, [(_townMarkerPos # 0) - 75, (_townMarkerPos # 1)]];
            _refuelMarker setMarkerTypeLocal "loc_fuelStation";
            _refuelMarker setMarkerColorLocal (missionNamespace getVariable "WF_C_UNKNOWN_COLOR");
            _refuelMarker setMarkerSizeLocal [0.5,0.5];
            _townServiceMarkers pushBack _refuelMarker
        };

        if(WF_C_TOWNS_SERVICE_HEAL in _townServices) then {
            _townMarkerPos = getPos _x;
            _healMarker = Format ["WF_%1_CityMarker_Heal", _x getVariable "name"];
            createMarkerLocal [_healMarker, [(_townMarkerPos # 0) - 75, (_townMarkerPos # 1) - 50]];
            _healMarker setMarkerTypeLocal "loc_Hospital";
            _healMarker setMarkerColorLocal (missionNamespace getVariable "WF_C_UNKNOWN_COLOR");
            _healMarker setMarkerSizeLocal [0.5,0.5];
            _townServiceMarkers pushBack _healMarker
        };
        _x setVariable ["serviceMarkers", _townServiceMarkers]
	};
} forEach towns;
{
    _currentTowerSideID = _x getVariable ["sideID", WF_C_UNKNOWN_ID];
    if (_currentTowerSideID == WF_Client_SideID) then {
        [WF_Client_SideID, _x] call WFCL_FNC_UpdateRadarMarker;
    } else {
        [_currentTowerSideID, _x] call WFCL_FNC_UpdateRadarMarker
    }

} forEach (nearestObjects [[0,0,0], WF_C_RADIO_OBJECTS, 100000])