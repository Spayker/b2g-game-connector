//--- Update the corresponding RscProgress bar
private ["_idc"];

_idc = 70301;

_mass = uiNamespace getVariable "wf_dialog_ui_gear_target_gear_mass";
_container_capacity = _mass select 0;
_container_items_mass = _mass select 1;

_progress = if !(_container_capacity isEqualTo 0) then {_container_items_mass / _container_capacity} else {0};
((uiNamespace getVariable "wf_dialog_ui_gear") displayCtrl _idc) progressSetPosition _progress;
((uiNamespace getVariable "wf_dialog_ui_gear") displayCtrl _idc) ctrlSetTooltip (if !(_container_capacity isEqualTo 0) then {Format ["Mass: %1 / %2", _container_items_mass, _container_capacity]} else {""});