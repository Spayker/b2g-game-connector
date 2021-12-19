#include "script_macros.hpp"

["INITIALIZATION", Format ["fn_initServer.sqf: Server initialization begins at [%1]", time]] Call H2GCO_FNC_LogContent;

// Prepare extDB before starting the initialization process for the server.
private _extDBNotLoaded = "";
extDBOpened = false;
private _dbresult = "extDB3" callExtension "9:VERSION";
if (_dbresult == "") then {
	["INITIALIZATION", "fn_initServer.sqf: extDB3 Failed to Load!"] Call H2GCO_FNC_LogContent;
} else {
    ["INITIALIZATION", Format ["fn_initServer.sqf: extDB3 loaded version: [%1]", _dbresult]] Call H2GCO_FNC_LogContent;
	if (isNil {uiNamespace getVariable "h2g_sql_id"}) then {
		h2g_sql_id = round(random(9999));
		CONSTVAR(h2g_sql_id);
		uiNamespace setVariable ["h2g_sql_id", h2g_sql_id];
		try {
			_result = EXTDB format ["9:ADD_DATABASE:%1",EXTDB_SETTING(getText,"DatabaseName")];
			if (!(_result isEqualTo "[1]")) then {throw "extDB3: Error with Database Connection"};
			_result = EXTDB format ["9:ADD_DATABASE_PROTOCOL:%2:SQL:%1:TEXT2",FETCH_CONST(h2g_sql_id),EXTDB_SETTING(getText,"DatabaseName")];
			if (!(_result isEqualTo "[1]")) then {throw "extDB3: Error with Database Connection"};
		} catch {
			diag_log _exception;
			_extDBNotLoaded = [true, _exception];
		};
		if (_extDBNotLoaded isEqualType []) exitWith {};

		EXTDB "9:LOCK";
		diag_log "extDB3: Connected to Database";
		extDBOpened = true;
	} else {
		h2g_sql_id = uiNamespace getVariable "h2g_sql_id";
		CONSTVAR(h2g_sql_id);
		diag_log "extDB3: Still Connected to Database";
		extDBOpened = true;
	};
};



//--- Server Init is now complete.
serverInitComplete = true;
["INITIALIZATION", "fn_initServer.sqf: Functions are loaded."] Call H2GCO_FNC_LogContent;

["INITIALIZATION", Format ["fn_initServer.sqf: Server initialization ended at [%1]", time]] Call H2GCO_FNC_LogContent;