#include "script_macros.hpp"

if (!isServer || time > 30) exitWith {
	diag_log Format["[WF (WARNING)][frameno:%1 | ticktime:%2] Init_Server: The server initialization cannot be called more than once.",diag_frameno,diag_tickTime]
};

["INITIALIZATION", Format ["fn_initServer.sqf: Server initialization begins at [%1]", time]] Call WFCO_FNC_LogContent;


//--- Server Init is now complete.
serverInitComplete = true;
["INITIALIZATION", "fn_initServer.sqf: Functions are loaded."] Call WFCO_FNC_LogContent;


["INITIALIZATION", Format ["fn_initServer.sqf: Server initialization ended at [%1]", time]] Call WFCO_FNC_LogContent;
[format ["Server initialization ended at [%1]", time]] Call WFDC_FNC_LogContent;