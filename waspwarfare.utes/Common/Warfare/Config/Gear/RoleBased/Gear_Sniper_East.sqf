private ["_faction", "_i", "_p", "_side", "_u"];

_side = _this;
_faction = "East";

_i = [];
_u = [];
_p = [];

// East sniper special gear list
_i pushBack 'CUP_srifle_VSSVintorez';
_u pushBack 1;
_p pushBack 550;

_i pushBack 'CUP_srifle_SVD';
_u pushBack 1;
_p pushBack 500;

_i pushBack 'CUP_srifle_SVD_des';
_u pushBack 1;
_p pushBack 500;

_i pushBack 'CUP_srifle_CZ550';
_u pushBack 1;
_p pushBack 450;

_i pushBack 'CUP_srifle_CZ550_rail';
_u pushBack 1;
_p pushBack 450;

_i pushBack 'CUP_srifle_ksvk';
_u pushBack 3;
_p pushBack 800;

_i pushBack "CUP_srifle_CZ750";
_u pushBack 3;
_p pushBack 500;

_i pushBack "CUP_srifle_ksvk_PSO3";
_u pushBack 4;
_p pushBack 650;

_i pushBack  "U_O_FullGhillie_ard";
_u pushBack  2;
_p pushBack  200;

_i pushBack  "U_O_FullGhillie_sard";
_u pushBack  2;
_p pushBack  200;

_i pushBack  "U_O_FullGhillie_lsh";
_u pushBack  2;
_p pushBack  200;

_i pushBack  "CUP_U_O_RUS_Ghillie";
_u pushBack  2;
_p pushBack  190;

[_faction, _i, _u, _p, WF_SNIPER] call compile preprocessFileLineNumbers "Common\Warfare\Config\Gear\Gear_Role_Config_Set.sqf";
