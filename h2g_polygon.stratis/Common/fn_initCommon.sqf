["INITIALIZATION", Format ["Init_Common.sqf: Common initialization begins at [%1]", time]] Call WFCO_FNC_LogContent;


["INITIALIZATION", "fn_initCommon.sqf: Functions are initialized."] Call WFCO_FNC_LogContent;


//--- Common initilization is complete at this point.
["INITIALIZATION", Format ["Init_Common.sqf: Common initialization ended at [%1]", time]] Call WFCO_FNC_LogContent;
commonInitComplete = true;