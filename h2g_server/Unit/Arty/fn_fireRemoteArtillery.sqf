params ["_units", "_destination", "_side", "_artyRange", "_magazineType"];

{
    [_x, _destination, _side, _artyRange, _magazineType] Spawn WFCO_FNC_FireArtillery
} forEach _units
