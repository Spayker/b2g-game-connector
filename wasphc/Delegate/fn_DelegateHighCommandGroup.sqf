params ["_player", "_selectedGroupTemplate", "_position", "_direction"];

["INFORMATION", Format["fn_DelegateHighCommandGroup.sqf: Received a delegation request from the server for [%1].", _selectedGroupTemplate]] Call WFCO_FNC_LogContent;

[_player, _selectedGroupTemplate, _position, _direction] call WFCO_fnc_CreateHighCommandGroup