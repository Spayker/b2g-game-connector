#define F(NAME,TARGET) class NAME { \
	allowedTargets = TARGET; \
};
#define ANYONE 0
#define CLIENT 1
#define SERVER 2

class CfgRemoteExec {
    class Functions {
        mode = 2;
        jip = 1;
        /* Called on the Clients */
		F(setshotparents,CLIENT)
		F(hint,CLIENT)
		F(hintSilent,CLIENT)

        /* Called on the Server */
		F(WFDC_FNC_LogContent,SERVER)

        /* Functions for everyone */
		F(WFCL_FNC_LocalizeMessage,ANYONE)
		F(WFCL_FNC_SetTask,ANYONE)		
		F(WFCL_FNC_CampCaptured,ANYONE)
		F(BIS_fnc_taskCreate,ANYONE)
		F(BIS_fnc_setTask,ANYONE)
		F(BIS_fnc_taskSetDescription,ANYONE)
		F(ASL_Rope_Set_Mass,ANYONE)
		F(ASL_Extend_Ropes,ANYONE)
		F(ASL_Shorten_Ropes,ANYONE)
		F(ASL_Release_Cargo,ANYONE)
		F(ASL_Retract_Ropes,ANYONE)
		F(ASL_Hint,ANYONE)
		F(ASL_Deploy_Ropes,ANYONE)
		F(ASL_Deploy_Ropes_Index,ANYONE)
		F(ASL_Attach_Ropes,ANYONE)
		F(ASL_Drop_Ropes,ANYONE)
		F(ASL_Hide_Object_Global,ANYONE)
		F(ASL_Pickup_Ropes,ANYONE)		
    };

    class Commands {
        mode = 1;
        jip = 1;

		F(call,SERVER)
		F(execVM,ANYONE)
		F(say3d,ANYONE)
		F(setFace,ANYONE)
		F(enableSimulationGlobal,ANYONE)
		F(animatesource,ANYONE)
		F(addeventhandler,ANYONE)
    };
};