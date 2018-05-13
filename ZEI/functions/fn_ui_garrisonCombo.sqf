params [
		["_control", objNull]
	];

if (isNull (findDisplay 1702)) exitWith {};
	
_display = (findDisplay 1702) displayCtrl 10;

_factionsFound = [];

// Get all factions (fancy unit check was way too slow!).
{
	_factionsFound pushBack [[getNumber (_x >> "side")] call BIS_fnc_sideName, getText (_x >> "displayName"), configName _x];
} forEach ("getNumber (_x >> 'side') in [0, 1, 2]" configClasses (configFile >> "CfgFactionClasses"));

_factionsFound sort TRUE;

// Populate list.
{
	_x params ["_side", "_name", "_config"];
	_display lbAdd format["%1 (%2)", _name, _side];
	_display lbSetData [_forEachIndex, _config];
} forEach _factionsFound;

_display lbSetCurSel 0;