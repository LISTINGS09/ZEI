// Called from ZEI_fnc_createTemplate. Finds a suitable '_templates' array according to the passed '_tempType'.
params ["_bld", ["_tempType", "mil"], ["_infoOnly", false]];

private _bldType = typeOf _bld;

[format ["Passed - B: %1 T: %2 I: %3", _bldType, _tempType, _infoOnly], "DEBUG"] call ZEI_fnc_misc_logMsg;

// Fix Case
_tempType = toLower _tempType;

// Assign appropriate furnishing template for house			
private _templates = [];

// Find any user-created custom buildings.
private _customTemplate = missionNamespace getVariable [format["ZEI_%1_customBuildings", _tempType], []];

if !(_customTemplate isEqualTo []) then {
	private _path = [_customTemplate, _bldType] call BIS_fnc_findNestedElement;
	
	if !(_path isEqualTo []) then {
		(_customTemplate # (_path # 0)) params ["", ["_values", [], [[]]]];
		_templates append _values;
	};
};

// Mods
private _hasCUP = isClass (configFile >> "CfgPatches" >> "CUP_Editor_Buildings_Config");
private _hasGM = isClass (configFile >> "CfgPatches" >> "gm_core");
private _hasVN = isClass (configFile >> "CfgPatches" >> "data_f_vietnam");
private _hasWS = isClass (configFile >> "CfgPatches" >> "data_f_lxWS");
private _hasEF = isClass (configFile >> "CfgPatches" >> "EF_Data");
private _hasOP = isClass (configFile >> "CfgPatches" >> "OPTRE_Core");

switch (_tempType) do {
	case "mil": {
		_templates append (switch (_bldType) do {
			#include "..\..\templates\mil_vanilla.sqf"
			
			if (_hasCUP) then {
				#include "..\..\templates\mil_cup.sqf"
			};
			if (_hasGM) then {
				#include "..\..\templates\mil_gm.sqf"
			};
			if (_hasVN) then {
				#include "..\..\templates\mil_sog.sqf"
			};
			if (_hasWS) then {
				#include "..\..\templates\mil_ws.sqf"
			};
			if (_hasEF) then {
				#include "..\..\templates\mil_ef.sqf"
			};
			if (_hasOP) then {
				#include "..\..\templates\mil_optre.sqf"
			};

			#include "..\..\templates\mil_other.sqf"
			
			default {[]};
		});
	};
	case "cbrn": {
		_templates append (switch (_bldType) do {
			#include "..\..\templates\cbrn_vanilla.sqf"
			
			default {[]};
		});
	};
	default {
		_templates append (switch (_bldType) do {
			#include "..\..\templates\civ_vanilla.sqf"
			
			if (_hasCUP) then {
				#include "..\..\templates\civ_cup.sqf"
			};
			if (_hasWS) then {
				#include "..\..\templates\civ_ws.sqf"
			};
			if (_hasGM) then {
				#include "..\..\templates\civ_gm.sqf"
			};
			if (_hasOP) then {
				#include "..\..\templates\civ_optre.sqf"
			};
			
			default {[]};
		});
	};
};

private _before = count _templates;

// Scan for spawnable templates for the current modset
_templates = _templates select {[_x] call ZEI_fnc_templateCanSpawn};

if !(_before isEqualTo count _templates) then {
	// TODO: Really needed? ZEI_fnc_randomiseObject will replace any invalid objects in a template. 
	[format ["Template(s) removed due to invalid objects (%3): Before %1 | After: %2", _before, count _templates, toUpper _tempType], "WARNING"] call ZEI_fnc_misc_logMsg;
};

// Don't spam messages if there is an area to fill
if (!_infoOnly && {_templates isEqualTo []} && sizeOf _bldType > 2) then {
	[format ["Building Not Found: %1 (%2) - We need your help to get a %3 template/scheme for this building!", _bldType,  getText (configFile >> "CfgVehicles" >> _bldType >> "displayName"), _tempType], "INFO"] call ZEI_fnc_misc_logMsg;
}; 

_templates;
