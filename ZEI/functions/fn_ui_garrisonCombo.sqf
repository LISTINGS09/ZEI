params [
		["_control", objNull]
	];

if (isNull (findDisplay 1702)) exitWith {};
	
_display = (findDisplay 1702) displayCtrl 10;

_factionsFound = [];

{
	// Get all factions but ignore story and virtual groups.
	if !(getText (configFile >> "CfgEditorSubcategories" >> (getText (_x >> "editorSubcategory")) >> "displayName") in ["Men (Story)","Men (Virtual Reality)"]) then {
		_factionsFound pushBackUnique [
			[getNumber (_x >> "side")] call BIS_fnc_sideName,
			getText (configFile >> "CfgFactionClasses" >> (getText (_x >> "faction")) >> "displayName"),
			getText (configFile >> "CfgEditorSubcategories" >> (getText (_x >> "editorSubcategory")) >> "displayName"),
			getText (_x >> "faction"),
			getText (_x >> "editorSubcategory")
		];
	};
} forEach ("(configName _x iskindOf 'CAManBase') && (getNumber (_x >> 'side') in [0, 1, 2]) && getNumber(_x >> 'scope') == 2" configClasses (configFile >> "CfgVehicles"));

_factionsFound sort TRUE;
_factionIndex = 0;

// Populate list.
{
	_x params ["_side", "_factName", "_catName", "_factClass", "_catClass"];
	[format["Cfg Found: %1 - %2 - %3", _side, _factName, _catName], "DEBUG"] call ZEI_fnc_misc_logMsg;
	_display lbAdd format["%1 - %2 (%3)", _factName, _catName, _side];
	_display lbSetData [_forEachIndex, format["%1#%2", _factClass, _catClass]];
	if ((missionNamespace getVariable ["ZEI_UiGarrisonFaction",""]) == _factClass && (missionNamespace getVariable ["ZEI_UiGarrisonCategory",""]) == _catClass) then { _factionIndex = _forEachIndex };
} forEach _factionsFound;

_display lbSetCurSel _factionIndex; // Remember last used faction.