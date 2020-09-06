params ["_townName", ["_camps", []]];

towns = towns - [objNull];
_townMarker = Format ["WF_%1_CityMarker", _townName];
deleteMarkerLocal _townMarker;

{ deleteMarkerLocal (_x getVariable "wf_camp_marker") } forEach _camps

