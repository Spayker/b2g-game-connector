private ["_role","_status","_skilllist"];

if!(isNil 'WF_newBuyRolerequest')then{
    if(WF_newBuyRolerequest)then{
        params [["_role", "",[""]], ["_status", "",[""]], ["_rolelist", [],[[]]]];

        if (_role == "" || _status == "") exitWith {
            if (!isNull (findDisplay 2800)) then {
                ctrlEnable[2804, true];
            };
        };

        // get the skill details
        _roleDetails = [_role, side player] call WFCO_fnc_getRoleDetails;
        WF_gbl_boughtRoles = _rolelist;

        // Role not found/invalid
        if (count _roleDetails == 0) exitWith {
            if (!isNull (findDisplay 2800)) then {
                ctrlEnable[2804, true];
            };
        };

        switch (_status) do {
            case "owned": {
                [format["You have already selected the ""%1"" role.", (_roleDetails # 1)]] spawn WFCL_fnc_handleMessage;
                if (!isNull (findDisplay 2800)) then { ctrlEnable[2804, true]; };
            };

            case "maxRoleLimit": {
                [format["Maximum limit is reached for ""%1"" role in team.", (_roleDetails # 1)]] spawn WFCL_fnc_handleMessage;
                if (!isNull (findDisplay 2800)) then { ctrlEnable[2804, true]; };
            };

            case "money": {
                [format["You do not have enough money to buy the ""%1"" role.", (_roleDetails # 1)]] spawn WFCL_fnc_handleMessage;
                if (!isNull (findDisplay 2800)) then { ctrlEnable[2804, true]; };
            };

            case "success": {                
				[format[localize 'STR_WF_RoleSelector_Text', (_roleDetails # 1)]] spawn WFCL_fnc_handleMessage;
                [] call WFCL_fnc_updateRolesMenu;
                removeAllActions player;

                WF_PlayerMenuAction = player addAction ["<t color='#42b6ff'>" + (localize "STR_WF_Options") + "</t>",{createDialog "WF_Menu"}, "", 999, false, true, "", ""];


				[] spawn {
					waitUntil {!isNil "ASL_Add_Player_Actions"};					
					
					[] call ASL_Add_Player_Actions;
					player setVariable ["ASL_Actions_Loaded",true];					
				};

                if (!isNull(commanderTeam)) then {
                    if (commanderTeam == Group player) then {
                        _MHQs = (WF_Client_SideJoined) Call WFCO_FNC_GetSideHQ;
                        _MHQ = [player,_MHQs] call WFCO_FNC_GetClosestEntity;
                        HQAction = leader(group player) addAction [localize "STR_WF_BuildMenu",{call WFCL_fnc_callBuildMenu}, [_MHQ], 1000, false, true, "", "hqInRange && canBuildWHQ && (_target == player)"];
                    };
                };

                WF_SK_V_Type = _roleDetails # 0;
                (player) Call WFCL_FNC_applySkill;

                if (!isNull (findDisplay 2800)) then { ctrlEnable[2805, true]; };
                [] call WF_fnc_selectRole;

                WF_FreeRolePurchase = false;

                if(!WF_isFirstRoleSelected)then {
                    if!(WF_P_gearPurchased) then {
                    _roleDefaultGear = [];

                        _sideGearTxt = WF_Client_SideJoinedText;
                        _friendlySide = call WFCO_fnc_getFriendlySide;
                        if(_friendlySide != sideUnknown) then { _sideGearTxt = str _friendlySide };

                    switch (WF_SK_V_Type) do {
                            case WF_RECON: {_roleDefaultGear = missionNamespace getVariable Format["WF_%1_DefaultGearSpot", _sideGearTxt];};
                            case WF_ASSAULT: {_roleDefaultGear = missionNamespace getVariable Format["WF_%1_DefaultGearSoldier", _sideGearTxt];};
                            case WF_ENGINEER: {_roleDefaultGear = missionNamespace getVariable Format["WF_%1_DefaultGearEngineer", _sideGearTxt];};
                            case WF_SPECOPS: {_roleDefaultGear = missionNamespace getVariable Format["WF_%1_DefaultGearLock", _sideGearTxt];};
                            case WF_MEDIC: {_roleDefaultGear = missionNamespace getVariable Format["WF_%1_DefaultGearMedic", _sideGearTxt];};
                            case WF_SUPPORT: {_roleDefaultGear = missionNamespace getVariable Format["WF_%1_DefaultGearSupport", _sideGearTxt];};
                    };
                    [player, _roleDefaultGear] call WFCO_FNC_EquipUnit;
                        WF_P_CurrentGear = (player) call WFCO_FNC_GetUnitLoadout;
                        missionnamespace setVariable ["WF_loaded_inventory", WF_P_CurrentGear];
                    };
                    WF_isFirstRoleSelected = true;
                    closeDialog 0;
                };
            };
        };
        WF_newBuyRolerequest = false;
    };
};

