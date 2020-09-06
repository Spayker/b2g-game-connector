disableSerialization;

_display = _this # 0;
_lastRange = artyRange;
_lastUpdate = 0;
_listBox = 17019;

sliderSetRange[17005, 10, missionNamespace getVariable "WF_C_ARTILLERY_AREA_MAX"];
sliderSetPosition[17005, artyRange];

ctrlSetText [17025,localize "STR_WF_TACTICAL_ArtilleryOverview" + ":"];

_markers = [];
_FTLocations = [];
_checks = [];
_fireTime = 0;
_status = 0;
_canFT = false;
_forceReload = true;
_startPoint = objNull;

_marker = "artilleryMarker";
createMarkerLocal [_marker,artyPos];
_marker setMarkerTypeLocal "mil_destroy";
_marker setMarkerColorLocal "ColorRed";
_marker setMarkerSizeLocal [1,1];

_area = "artilleryAreaMarker";
createMarkerLocal [_area,artyPos];
_area setMarkerShapeLocal "Ellipse";
_area setMarkerColorLocal "ColorRed";
_area setMarkerSizeLocal [artyRange,artyRange];

_map = _display DisplayCtrl 17002;
_listboxControl = _display DisplayCtrl _listBox;

_pard = missionNamespace getVariable "WF_C_PLAYERS_SUPPORT_PARATROOPERS_DELAY";
{lbAdd[17008,_x]} forEach (missionNamespace getVariable Format ["WF_%1_ARTILLERY_DISPLAY_NAME",WF_Client_SideJoinedText]);
lbSetCurSel[17008,0];

_IDCS = [17005,17006,17007,17008];
if ((missionNamespace getVariable "WF_C_ARTILLERY") == 0) then {{ctrlEnable [_x,false]} forEach _IDCS};

{ctrlEnable [_x, false]} forEach [17010,17011,17012,17013,17014,17015,17017,17018,17020];

_currentValue = -1;
_currentFee = -1;
_currentSpecial = "";
_currentFee = -1;

//--- Support List.
_lastSel = -1;
_addToList = [localize 'STR_WF_ICBM',localize 'STR_WF_TACTICAL_ParadropVehicle',localize 'STR_WF_TACTICAL_Paratroop',localize 'STR_WF_TACTICAL_Heli_Paratroop',localize 'STR_WF_TACTICAL_UAV',localize 'STR_WF_TACTICAL_UAVDestroy',localize 'STR_WF_TACTICAL_UAVRemoteControl'];
_addToListID = ["ICBM","Paradrop_Vehicle","Paratroopers","HeliParatroopers","UAV","UAV_Destroy","UAV_Remote_Control"];
_addToListFee = [150000,9500,3500,3500,6500,0,0];
_addToListInterval = [1000,800,600,600,0,0,0];

for '_i' from 0 to count(_addToList)-1 do {
	lbAdd [_listBox,_addToList # _i];
	lbSetValue [_listBox, _i, _i];
};

lbSort _listboxControl;

//--- Artillery Mode.
_mode = missionNamespace getVariable 'WF_V_ARTILLERYMINMAP';
if (isNil '_mode') then {_mode = 2;missionNamespace setVariable ['WF_V_ARTILLERYMINMAP',_mode]};
_trackingArray = [];
_trackingArrayID = [];
_lastArtyUpdate = -60;
_minRange = 100;
_maxRange = 200;
_requestMarkerTransition = false;
_requestRangedList = true;
_startLoad = true;
_logik = (side player) Call WFCO_FNC_GetSideLogic;

//--- Startup coloration.
with uinamespace do {
	currentBEDialog = _display;
	switch (_mode) do {
		case 0: {(currentBEDialog displayCtrl 17023) ctrlSetTextColor [1,1,1,1]};
		case 1: {(currentBEDialog displayCtrl 17023) ctrlSetTextColor [0,0.635294,0.909803,1]};
		case 2: {(currentBEDialog displayCtrl 17023) ctrlSetTextColor [0.6,0.850980,0.917647,1]};
	};
};

lbSetCurSel[_listbox, 0];

if ((missionNamespace getVariable "WF_C_ARTILLERY") == 0) then {
	(_display displayCtrl 17016) ctrlSetStructuredText (parseText Format['<t align="right" color="#FF4747">%1</t>',localize 'STR_WF_Disabled']);
};

_textAnimHandler = [] spawn {};

WF_MenuAction = -1;
mouseButtonUp = -1;

while {alive player && dialog} do {
	if (side player != WF_Client_SideJoined) exitWith {deleteMarkerLocal _marker;deleteMarkerLocal _area;{deleteMarkerLocal _x} forEach _markers;closeDialog 0};
	if (!dialog) exitWith {deleteMarkerLocal _marker;deleteMarkerLocal _area;{deleteMarkerLocal _x} forEach _markers};
	
	_currentUpgrades = (WF_Client_SideJoined) Call WFCO_FNC_GetSideUpgrades;
	_currentSel = lbCurSel(_listBox);

	//--- Special changed or a reload is requested.
	if (_currentSel != _lastSel || _forceReload) then {
		_currentValue = lbValue[_listBox, _currentSel];

		_currentSpecial = _addToListID # _currentValue;
		_currentFee = _addToListFee # _currentValue;
        _selectedRole = WF_gbl_boughtRoles # 0;
        if!(isNil '_selectedRole')then{
            if(_selectedRole == WF_UAV_OPERATOR)then{
                _currentFee = _currentFee - (_currentFee * WF_ADV_UAV_DISCOUNT);
            };
        };

	    _currentGroupSize = count ((Units (group player)) Call WFCO_FNC_GetLiveUnits);
		_currentInterval = _addToListInterval # _currentValue;
		_forceReload = false;
		_controlEnable = false;

		_funds = Call WFCL_FNC_GetPlayerFunds;

		ctrlSetText[17021,Format ["$%1",_currentFee]];

		//--- Enabled or disabled?
		switch (_currentSpecial) do {
			case "ICBM": {
				if ((missionNamespace getVariable "WF_C_MODULE_WF_ICBM") > 0) then {
					_commander = false;
					if (!isNull(commanderTeam)) then {
						if (commanderTeam == group player) then {_commander = true};
					};
					_currentLevel = _currentUpgrades # WF_UP_ICBM;
					_controlEnable = (_currentLevel > 0 && _commander && _funds >= _currentFee);
				};
			};
			case "Paratroopers": {
				_currentLevel = _currentUpgrades # WF_UP_PARATROOPERS;
				_controlEnable = (_funds >= _currentFee && _currentLevel > 0 && time - lastParaCall > _currentInterval && _currentGroupSize <= WF_C_PLAYERS_AI_MAX);
				if(_currentGroupSize > WF_C_PLAYERS_AI_MAX) then { hint parseText localize "STR_WF_INFO_Paratroop_NotAllowed" };
			};
			case "HeliParatroopers": {
                _currentLevel = _currentUpgrades # WF_UP_PARATROOPERS;
                _controlEnable = (_funds >= _currentFee && _currentLevel > 0 && time - lastParaCall > _currentInterval && _currentGroupSize <= WF_C_PLAYERS_AI_MAX);
                if(_currentGroupSize > WF_C_PLAYERS_AI_MAX) then { hint parseText localize "STR_WF_INFO_Paratroop_NotAllowed" };
			};
			case "Paradrop_Vehicle": {
				_currentLevel = _currentUpgrades # WF_UP_SUPPLYPARADROP;
				_controlEnable = (_funds >= _currentFee && _currentLevel > 0 && time - lastSupplyCall > _currentInterval);
			};
			case "UAV": {
				_currentLevel = _currentUpgrades # WF_UP_UAV;
				_controlEnable = (_funds >= _currentFee && _currentLevel > 0 && !(alive playerUAV));
			};
			case "UAV_Destroy": {
				_controlEnable = (alive playerUAV);
			};
			case "UAV_Remote_Control": {
				_controlEnable = (alive playerUAV);
			}
		};

		if(WF_Debug) then {
		    _controlEnable = true;
		};

		ctrlEnable[17020, _controlEnable];

		WF_MenuAction = -1;
	};

	//--- Request Asset.
	if (WF_MenuAction == 20) then {
		WF_MenuAction = -1;

		//--- Output.
		switch (_currentSpecial) do {
			case "ICBM": {
				WF_MenuAction = 8;
				if !(scriptDone _textAnimHandler) then {terminate _textAnimHandler};
				_textAnimHandler = [17022,localize 'STR_WF_TACTICAL_ClickOnMap',10,"ff9900"] spawn WFCL_FNC_SetControlFadeAnim;
			};
			case "Paratroopers": {
				WF_MenuAction = 3;
				if !(scriptDone _textAnimHandler) then {terminate _textAnimHandler};
				_textAnimHandler = [17022,localize 'STR_WF_TACTICAL_ClickOnMap',10,"ff9900"] spawn WFCL_FNC_SetControlFadeAnim;
			};
			case "HeliParatroopers": {
                WF_MenuAction = 4;
				if !(scriptDone _textAnimHandler) then {terminate _textAnimHandler};
				_textAnimHandler = [17022,localize 'STR_WF_TACTICAL_ClickOnMap',10,"ff9900"] spawn WFCL_FNC_SetControlFadeAnim;
			};
			case "Paradrop_Vehicle": {
				WF_MenuAction = 9;

				if !(scriptDone _textAnimHandler) then {terminate _textAnimHandler};
				_textAnimHandler = [17022,localize 'STR_WF_TACTICAL_ClickOnMap',10,"ff9900"] spawn WFCL_FNC_SetControlFadeAnim;
			};
			case "UAV": {
				closeDialog 0;
				call WFCL_fnc_uav;
			};
			case "UAV_Destroy": {
				if !(isNull playerUAV) then {
					{_x setDammage 1} forEach (crew playerUAV);
					playerUAV setDammage 1;
					playerUAV = objNull;
				};
			};
			case "UAV_Remote_Control": {
				closeDialog 0;
				call WFCL_fnc_uav;
			}
		};
	};

	artyRange = floor (sliderPosition 17005);
	if (_lastRange != artyRange) then {_area setMarkerSizeLocal [artyRange,artyRange];};

	if (mouseButtonUp == 0) then {
		mouseButtonUp = -1;
		//--- Set Artillery Marker on map.
		if (WF_MenuAction == 1) then {
			WF_MenuAction = -1;
			artyPos = _map posScreenToWorld[mouseX,mouseY];
			_marker setMarkerPosLocal artyPos;
			_area setMarkerPosLocal artyPos;
			_requestRangedList = true;
		};
		//--- Paratroops.
		if (WF_MenuAction == 3) then {
			WF_MenuAction = -1;
			_forceReload = true;
			if !(scriptDone _textAnimHandler) then {terminate _textAnimHandler};
			[17022] Call WFCL_FNC_SetControlFadeAnimStop;
			_callPos = _map posScreenToWorld[mouseX,mouseY];
			if (!surfaceIsWater _callPos) then {
				lastParaCall = time;
				-(_currentFee) Call WFCL_FNC_ChangePlayerFunds;
				[WF_Client_SideJoined, _callPos, WF_Client_Team, WF_C_PLAYERS_AI_MAX] remoteExec ["WFSE_FNC_Paratroopers",2];
				hint parseText localize "STR_WF_INFO_Paratroop_Info";
			};
		};

		//--- Heli Paratroops.
        if (WF_MenuAction == 4) then {
            WF_MenuAction = -1;
            _forceReload = true;
            if !(scriptDone _textAnimHandler) then {terminate _textAnimHandler};
            [17022] Call WFCL_FNC_SetControlFadeAnimStop;
            _callPos = _map posScreenToWorld[mouseX,mouseY];
            _height = getTerrainHeightASL [_callPos # 0, _callPos # 1];
            _callPos = [_callPos # 0, _callPos # 1, _height];

            if (!surfaceIsWater _callPos) then {
                lastParaCall = time;
                -(_currentFee) Call WFCL_FNC_ChangePlayerFunds;
                [WF_Client_SideJoined, _callPos, WF_Client_Team, WF_C_PLAYERS_AI_MAX] remoteExec ["WFSE_FNC_HeliParatroopers",2];
				hint parseText localize "STR_WF_INFO_Paratroop_Info";
			};
		};
		
		//--- ICBM Strike.
		if (WF_MenuAction == 8) then {
			_forceReload = true;
			if !(scriptDone _textAnimHandler) then {terminate _textAnimHandler};
			[17022] Call WFCL_FNC_SetControlFadeAnimStop;
			WF_MenuAction = -1;
			-_currentFee Call WFCL_FNC_ChangePlayerFunds;
			_callPos = _map PosScreenToWorld[mouseX,mouseY];
			_obj = "Land_HelipadEmpty_F" createVehicle _callPos;
			_nukeMarker = createMarkerLocal ["icbmstrike", _callPos];
			_nukeMarker setMarkerTypeLocal "mil_warning";
			_nukeMarker setMarkerTextLocal "Nuclear Strike";
			_nukeMarker setMarkerColorLocal "ColorRed";
			
			[_obj,_nukeMarker] spawn WFCO_FNC_NukeIncomming;
		};
		//--- Vehicle Paradrop.
		if (WF_MenuAction == 9) then {
			_forceReload = true;
			if !(scriptDone _textAnimHandler) then {terminate _textAnimHandler};
			[17022] Call WFCL_FNC_SetControlFadeAnimStop;
			WF_MenuAction = -1;
			lastSupplyCall = time;
			-_currentFee Call WFCL_FNC_ChangePlayerFunds;
			_callPos = _map PosScreenToWorld[mouseX,mouseY];
			[WF_Client_SideJoined,_callPos,WF_Client_Team] remoteExec ["WFSE_FNC_ParaVehicles",2];
		};
	};
	
	//--- Update the Artillery Status.
	if ((missionNamespace getVariable "WF_C_ARTILLERY") > 0) then {
		_fireTime = (missionNamespace getVariable "WF_C_ARTILLERY_INTERVALS") # (_currentUpgrades # WF_UP_ARTYTIMEOUT);
		_status = round(_fireTime - (time - fireMissionTime));
		_txt = [Format ['<t align="left" color="#4782FF">%1 %2</t>',_status,localize 'STR_WF_Seconds'], Format['<t align="left" color="#73FF47">%1</t>',localize 'STR_WF_TACTICAL_Available']] select (time - fireMissionTime > _fireTime);
		(_display displayCtrl 17016) ctrlSetStructuredText (parseText _txt);
		_enable = !(_status > 0);
		if(WF_Debug) then { _enable = true; };
		ctrlEnable [17007,_enable];
	};
	
	//--- Request Fire Mission.
	if (WF_MenuAction == 2) then {
		WF_MenuAction = -1;
		_units = [Group player,false,lbCurSel(17008),WF_Client_SideJoinedText,_logik] Call WFCO_FNC_GetTeamArtillery;
		if (Count _units > 0) then {
			fireMissionTime = time;
			[GetMarkerPos "artilleryMarker",lbCurSel(17008),_logik,_units] Spawn WFCL_FNC_RequestFireMission;
		} else {
			hint (localize "STR_WF_INFO_NoArty");
		};			
	};
	
	//--- Arty Combo Change or Script init.
	if (WF_MenuAction == 200 || _startLoad) then {
		WF_MenuAction = -1;
		
		_index = lbCurSel(17008);
		_minRange = (missionNamespace getVariable Format ["WF_%1_ARTILLERY_RANGES_MIN",WF_Client_SideJoined]) # _index;
		_maxRange = round(((missionNamespace getVariable Format ["WF_%1_ARTILLERY_RANGES_MAX",WF_Client_SideJoined]) # _index) / (missionNamespace getVariable "WF_C_ARTILLERY"));

		_trackingArray = [group player,true,lbCurSel(17008),WF_Client_SideJoined,_logik] Call WFCO_FNC_GetTeamArtillery;
		
		_requestMarkerTransition = true;
		_requestRangedList = true;
		_startLoad = false;
	};
	
	//--- Focus on an artillery cannon.
	if (WF_MenuAction == 60) then {
		WF_MenuAction = -1;
		
		ctrlMapAnimClear _map;
		_map ctrlMapAnimAdd [1,.475,getPos(_trackingArray # (lnbCurSelRow 17024))];
		ctrlMapAnimCommit _map;
	};
	
	//--- Flush on change.
	if (_requestMarkerTransition) then {
		_requestMarkerTransition = false;
		
		{
			_track = (_x # 0);
			_vehicle = (_x # 1);

			_vehicle setVariable ['WF_A_Tracked', nil];
			deleteMarkerLocal Format ["WF_A_Large%1",_track];
			deleteMarkerLocal Format ["WF_A_Small%1",_track];
		} forEach _trackingArrayID;
		_trackingArrayID = [];
	};
	
	//--- Artillery List.
	if ((missionNamespace getVariable "WF_C_ARTILLERY") > 0 && (_requestRangedList || time - _lastArtyUpdate > 3)) then {
		_requestRangedList = false;
		
		//--- No need to update the list all the time.
		if (time - _lastArtyUpdate > 5) then {
			_lastArtyUpdate = time;
			_trackingArray = [group player,true,lbCurSel(17008),WF_Client_SideJoined,_logik] Call WFCO_FNC_GetTeamArtillery;
		};
		
		//--- Clear & Fill;
		lnbClear 17024;
		_i = 0;
		{
            _artillery = _x;
		    _magazines = getArtilleryAmmo [_artillery];
		    _magazineRangeOk = false;
		    {
		        if(artyPos inRangeOfArtillery [[_artillery], _x]) exitWith { _magazineRangeOk = true }
		    } forEach _magazines;

            _text = localize 'STR_WF_TACTICAL_ArtilleryInRange'; 																		//---changed-MrNiceGuy //"In Range";
			_color = [0, 0.875, 0, 0.8];
		    if(_magazineRangeOk) then {
		        _distance = _artillery distance (getMarkerPos _marker);
			if (_distance > _maxRange) then {_color = [0.875, 0, 0, 0.8];_text = localize 'STR_WF_TACTICAL_ArtilleryOutOfRange'}; 		 //---changed-MrNiceGuy //"Out of Range"};
			if (_distance <= _minRange) then {_color = [0.875, 0.5, 0, 0.8];_text = localize 'STR_WF_TACTICAL_ArtilleryRangeTooClose'}; //---changed-MrNiceGuy //"Too close"};
		    } else {
		        _color = [0.875, 0, 0, 0.8];_text = localize 'STR_WF_TACTICAL_ArtilleryRangeTooClose'
		    };
		    lnbAddRow [17024,[[typeOf _artillery, 'displayName'] Call WFCO_FNC_GetConfigInfo,_text]];
            lnbSetPicture [17024,[_i,0],[typeOf _artillery, 'picture'] Call WFCO_FNC_GetConfigInfo];
			
			lnbSetColor [17024,[_i,0],_color];
			lnbSetColor [17024,[_i,1],_color];
			_i = _i + 1;
		} forEach _trackingArray;
	};
	
	//--- Artillery map toggle.
	if (WF_MenuAction == 40) then {
		WF_MenuAction = -1;
		if (_mode == -1) then {_mode = 0};
		_mode = [_mode + 1, 0] select (_mode == 2);
		with uinamespace do {
			switch (_mode) do {
				case 0: {(currentBEDialog displayCtrl 17023) ctrlSetTextColor [1,1,1,1]};
				case 1: {(currentBEDialog displayCtrl 17023) ctrlSetTextColor [0,0.635294,0.909803,1]};
				case 2: {(currentBEDialog displayCtrl 17023) ctrlSetTextColor [0.6,0.850980,0.917647,1]};
			};
		};
		
		if !(scriptDone _textAnimHandler) then {terminate _textAnimHandler};
		_textAnimHandler = [17022,localize 'STR_WF_TACTICAL_ArtilleryMinimapInfo',7,"ff9900"] spawn WFCL_FNC_SetControlFadeAnim;
		
		missionNamespace setVariable ['WF_V_ARTILLERYMINMAP',_mode];
		
		_requestMarkerTransition = true;
	};
	
	//--- Update artillery display.
	if (_mode != -1) then {
	
		//--- Nothing.
		if (_mode == 0) then {
			_requestMarkerTransition = true;
			_mode = -1;
		};
			
		//--- Filled Content.
		if (_mode == 1 || _mode == 2) then {
			//--- Remove if dead or null or sel changed.
			{
				_track = (_x # 0);
				_vehicle = (_x # 1);
				
				if !(alive _vehicle) then {
					deleteMarkerLocal Format ["WF_A_Large%1",_track];
					deleteMarkerLocal Format ["WF_A_Small%1",_track];
				};
			} forEach _trackingArrayID;
			
			//--- No need to update the marker all the time.
			if (time - _lastArtyUpdate > 5) then {
				_lastArtyUpdate = time;
				_trackingArray = [group player,true,lbCurSel(17008),WF_Client_SideJoined,_logik] Call WFCO_FNC_GetTeamArtillery;
			};
			
			//--- Live Feed.
			_trackingArrayID = [];
			{
				_track = _x getVariable 'WF_A_Tracked';
				if (isNil '_track') then {
					_track = buildingMarker;
					buildingMarker = buildingMarker + 1;
					_x setVariable ['WF_A_Tracked', _track];
					_dmarker = Format ["WF_A_Large%1",_track];
					createMarkerLocal [_dmarker, getPos _x];
					_dmarker setMarkerColorLocal "ColorBlue";
					_dmarker setMarkerShapeLocal "ELLIPSE";
					_brush = "SOLID";
					if (_mode == 1) then {_brush = "SOLID"};
					if (_mode == 2) then {_brush = "BORDER"};
					_dmarker setMarkerBrushLocal _brush;
					_dmarker setMarkerAlphaLocal 0.4;
					_dmarker setMarkerSizeLocal [_maxRange,_maxRange];
					_dmarker = Format ["WF_A_Small%1",_track];
					createMarkerLocal [_dmarker, getPos _x];
					_dmarker setMarkerColorLocal "ColorBlack";
					_dmarker setMarkerShapeLocal "ELLIPSE";
					_dmarker setMarkerBrushLocal "SOLID";
					_dmarker setMarkerAlphaLocal 0.4;
					_dmarker setMarkerSizeLocal [_minRange,_minRange];
				} else {
					_dmarker = Format ["WF_A_Large%1",_track];
					_dmarker setMarkerPosLocal (getPos _x);
					_dmarker = Format ["WF_A_Small%1",_track];
					_dmarker setMarkerPosLocal (getPos _x);
				};
				_trackingArrayID = _trackingArrayID + [[_track,_x]];
			} forEach _trackingArray;
		};
	};
	
	_lastRange = artyRange;
	_lastSel = lbCurSel(_listbox);
	sleep 0.1;
	
	//--- Back Button.
	if (WF_MenuAction == 30) exitWith { //---added-MrNiceGuy
		WF_MenuAction = -1;
		closeDialog 0;
		createDialog "WF_Menu"
	};
};

deleteMarkerLocal _marker;
deleteMarkerLocal _area;
{deleteMarkerLocal _x} forEach _markers;

if !(scriptDone _textAnimHandler) then {terminate _textAnimHandler};
//--- Remove Markers.
{
	_track = (_x # 0);
	_vehicle = (_x # 1);
	
	_vehicle setVariable ['WF_A_Tracked', nil];

	deleteMarkerLocal Format ["WF_A_Large%1",_track];
	deleteMarkerLocal Format ["WF_A_Small%1",_track];
} forEach _trackingArrayID;