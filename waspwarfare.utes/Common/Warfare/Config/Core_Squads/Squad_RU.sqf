Private ['_aiTeamTemplateName','_aiTeamTemplates','_aiTeamUpgrades','_return','_side','_u'];

_side = _this;

//--- Overall Dump.
_aiTeamTemplates = [];
_aiTeamTypes = [];
_aiTeamTemplateName = [];
_aiTeamUpgrades = [];

//--- Infantry
_u = ["CUP_O_RU_Soldier_SL_Ratnik_Summer"];
_u pushBack "CUP_O_RU_Soldier_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_LAT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_Medic_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_GL_Ratnik_Summer";

_aiTeamTemplateName pushBack "Recon Infantry Squad";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Barracks';
_aiTeamUpgrades pushBack 0;

_u = ["CUP_O_RU_Soldier_TL_Ratnik_Summer"];
_u pushBack "CUP_O_RU_Soldier_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_MG_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_Medic_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_Engineer_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_GL_Ratnik_Summer";

_aiTeamTemplateName pushBack "Light Assault Infantry Squad";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Barracks';
_aiTeamUpgrades pushBack 1;

_u = ["CUP_O_RU_Soldier_TL_Ratnik_Summer"];
_u pushBack "CUP_O_RU_Soldier_Medic_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_GL_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_MG_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_MG_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_Marksman_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AA_Ratnik_Summer";

_aiTeamTemplateName pushBack "Medium Assault Infantry Squad";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Barracks';
_aiTeamUpgrades pushBack 2;

_u = ["CUP_O_RU_Soldier_TL_Ratnik_Summer"];
_u pushBack "CUP_O_RU_Soldier_GL_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AA_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_HAT_Ratnik_Summer";
_u pushBack "CUP_O_MVD_Soldier_AT";
_u pushBack "CUP_O_MVD_Soldier_AT";
_u pushBack "CUP_O_RU_Soldier_MG_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_HAT_Ratnik_Summer";

_aiTeamTemplateName pushBack "Heavy Assault Infantry Squad";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Barracks';
_aiTeamUpgrades pushBack 3;

_u = ["CUP_O_RU_Soldier_LAT_Ratnik_Summer"];
_u pushBack "CUP_O_RU_Soldier_LAT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_LAT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_LAT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_LAT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_LAT_Ratnik_Summer";

_aiTeamTemplateName pushBack "Light AT Infantry Squad";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Barracks';
_aiTeamUpgrades pushBack 0;

_u = ["CUP_O_RU_Soldier_AT_Ratnik_Summer"];
_u pushBack "CUP_O_RU_Soldier_AT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AT_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AT_Ratnik_Summer";

_aiTeamTemplateName pushBack "AT Infantry Squad";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Barracks';
_aiTeamUpgrades pushBack 2;

_u = ["CUP_O_RU_Soldier_HAT_VDV_M_EMR"];
_u pushBack "CUP_O_RU_Soldier_HAT_VDV_M_EMR";
_u pushBack "CUP_O_RU_Soldier_HAT_VDV_M_EMR";
_u pushBack "CUP_O_RU_Soldier_HAT_VDV_M_EMR";
_u pushBack "CUP_O_RU_Soldier_HAT_VDV_M_EMR";
_u pushBack "CUP_O_RU_Soldier_HAT_VDV_M_EMR";

_aiTeamTemplateName pushBack "Heavy AT Infantry Squad";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Barracks';
_aiTeamUpgrades pushBack 3;

_u = ["CUP_O_RU_Soldier_AA_Ratnik_Summer"];
_u pushBack "CUP_O_RU_Soldier_AA_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AA_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AA_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AA_Ratnik_Summer";
_u pushBack "CUP_O_RU_Soldier_AA_Ratnik_Summer";

_aiTeamTemplateName pushBack "AA Infantry Squad";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Barracks';
_aiTeamUpgrades pushBack 3;

//--- Light vehicles
_u = ["CUP_O_GAZ_Vodnik_PK_RU"];

_aiTeamTemplateName pushBack "Vodnik MG Patrol";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Light';
_aiTeamUpgrades pushBack 0;

_u = ["CUP_O_GAZ_Vodnik_AGS_RU"];

_aiTeamTemplateName pushBack "Vodnik AGS Patrol";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Light';
_aiTeamUpgrades pushBack 1;

_u = ["CUP_O_Kamaz_Repair_RU"];

_aiTeamTemplateName pushBack "Repair Truck Team";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Light';
_aiTeamUpgrades pushBack 2;

_u = ["CUP_O_UAZ_METIS_RU"];

_aiTeamTemplateName pushBack "UAZ Metis AT Patrol";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Light';
_aiTeamUpgrades pushBack 3;

_u = ["CUP_O_GAZ_Vodnik_KPVT_RU"];

_aiTeamTemplateName pushBack "Vodnik KPVT Patrol";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Light';
_aiTeamUpgrades pushBack 1;

_u = ["CUP_O_BRDM2_ATGM_RUS"];

_aiTeamTemplateName pushBack "AT BRDM Patrol";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Light';
_aiTeamUpgrades pushBack 2;

_u = ["CUP_O_GAZ_Vodnik_BPPU_RU"];

_aiTeamTemplateName pushBack "Vodnik BPPU Patrol";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Light';
_aiTeamUpgrades pushBack 2;

_u = ["CUP_O_BTR80A_CAMO_RU"];

_aiTeamTemplateName pushBack "BTR-80A Patrol";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Light';
_aiTeamUpgrades pushBack 3;

_u = ["CUP_O_BTR90_RU_WASP"];

_aiTeamTemplateName pushBack "BTR-90 Patrol";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Light';
_aiTeamUpgrades pushBack 3;

_u = ["CUP_O_BM21_RU"];

_aiTeamTemplateName pushBack "BM21 Arty Squad";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Light';
_aiTeamUpgrades pushBack 4;

//--- Heavy Vehicles
_u = ["CUP_O_BMP2_RU"];

_aiTeamTemplateName pushBack "BMP 2 Group";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Heavy';
_aiTeamUpgrades pushBack 0;

_u = ["CUP_O_BMP2_ZU_TKA"];

_aiTeamTemplateName pushBack "BMP 2 ЯГ Group";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Heavy';
_aiTeamUpgrades pushBack 0;

_u = ["CUP_O_BMP3_RU_WASP"];

_aiTeamTemplateName pushBack "BMP 3 Group";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Heavy';
_aiTeamUpgrades pushBack 1;

_u = ["cwr3_o_t64b"];

_aiTeamTemplateName pushBack "T64B Group";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Heavy';
_aiTeamUpgrades pushBack 2;

_u = ["CUP_O_ZSU23_ChDKZ"];

_aiTeamTemplateName pushBack "AA Shilka Group";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Heavy';
_aiTeamUpgrades pushBack 2;

_u = ["CUP_O_T72_RU"];

_aiTeamTemplateName pushBack "T72 Group";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Heavy';
_aiTeamUpgrades pushBack 2;

_u = ["cwr3_o_t72b1"];

_aiTeamTemplateName pushBack "T72B1 Group";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Heavy';
_aiTeamUpgrades pushBack 3;

_u = ["CUP_O_T90_RU"];

_aiTeamTemplateName pushBack "Heavy T90 Group";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Heavy';
_aiTeamUpgrades pushBack 4;

_u = ["CUP_O_2S6M_RU"];

_aiTeamTemplateName pushBack "Heavy AA Tunguska Group";
_aiTeamTemplates pushBack _u;
_aiTeamTypes pushBack 'Heavy';
_aiTeamUpgrades pushBack 3;

//--- Custom Groups.
missionNamespace setVariable [Format["WF_%1AITEAMTEMPLATES", _side], _aiTeamTemplates];
missionNamespace setVariable [Format["WF_%1AITEAMUPGRADES", _side], _aiTeamUpgrades];
missionNamespace setVariable [Format["WF_%1AITEAMTYPES", _side], _aiTeamTypes];
missionNamespace setVariable [Format["WF_%1AITEAMTEMPLATEDESCRIPTIONS", _side], _aiTeamTemplateName];