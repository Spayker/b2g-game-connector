/*
	Set a town's camps to a side on a client.
	 Parameters:
		- Town.
		- Old Side.
		- New Side.
*/
Params['_town', '_side_old', '_side_new'];
Private ["_camps","_side_old","_side_new","_town"];

_camps = _town getVariable ["camps", []];
_color = missionNamespace getVariable (Format ["WF_C_%1_COLOR",(_side_new) Call WFCO_FNC_GetSideFromID]);

{(_x getVariable "wf_camp_marker") setMarkerColorLocal _color} forEach _camps;