params ["_bld"];

private _bld = typeOf _bld;

// Assign appropriate furnishing template for house			
private _templates = [];

// for testing purposes
if (!isNil "ZEI_mil_customBuildings") then {
	private _path = [ZEI_mil_customBuildings, _bld] call BIS_fnc_findNestedElement;
	
	if !(_path isEqualTo []) then {
		(ZEI_mil_customBuildings # (_path # 0)) params ["", ["_values", [], [[]]]];
		_templates append _values;
	};
};

_templates append (switch (_bld) do {
	// Vanilla
	#include "..\templates\mil_vanilla.sqf"
	
	// CUP
	#include "..\templates\mil_cup.sqf"
	
	// OTHER
	#include "..\templates\mil_other.sqf"
	
	default {[]};
});

private _before = count _templates;

// Scan for spawnable templates for the current modset
_templates = _templates select {[_x] call ZEI_fnc_templateCanSpawn};

["[ZEI][MIL] Templates Total: %1 | After Filtering: %2", _before, count _templates] call ZEI_fnc_debug;

// Don't spam messages if there is an area to fill
if (!_fillArea && {_templates isEqualTo []}) then {
	systemChat format ["[ZEI] Building Not Found: %1 (%2) - We need your help to get a template/scheme for this building!", _bld,  getText (configFile >> "CfgVehicles" >> _bld >> "displayName")];
}; 

_templates;
