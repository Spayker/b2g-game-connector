/*
	Event Handler triggered everytime a player disconnect from the server, this file handle all the players disconnection.
	 Parameters:
		- User ID
		- User Name
*/

params ["_unit", "_id", "_uid", "_name"];
private ['_funds','_get','_hq','_side','_team','_unitVehicle','_canDeleteVehicle','_logic','_role'];


["INFORMATION", format ["fn_OnPlayerDisconnected.sqf: Player [%1] [%2] has left the game", _name, _uid]] call H2GCO_FNC_LogContent;
