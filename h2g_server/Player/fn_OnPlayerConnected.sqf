#include "..\script_macros.hpp"

params ["_uid","_name","_id"];
private ["_funds","_get","_max","_sideJoined","_sideOrigin","_team","_units"];

["INFORMATION", format ["fn_OnPlayerConnected.sqf: Player [%1] [%2] has joined the game", _name, _uid]] Call H2GCO_FNC_LogContent;