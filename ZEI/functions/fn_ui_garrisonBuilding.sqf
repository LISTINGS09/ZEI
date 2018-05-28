params [
		["_faction", ""],
		["_units", 4],
		["_enableDS", TRUE]
	];

[format["Passed - F: %1 U: %2 DS: %2", _faction, _units, _enableDS], "DEBUG"] call ZEI_fnc_misc_logMsg;
	
// Need to pass logic pos info to GUI somehow?
_bld = missionNamespace getVariable ["ZEI_LastBuilding", objNull];

// Get all units with a weapon and non-parachute backpack.
_tempList = "getText (_x >> 'faction') == _faction && (configName _x) isKindoF 'CAManBase' && getNumber(_x >> 'scope') == 2" configClasses (configFile >> "CfgVehicles");

// FIX - BIS didn't add viper units as a separate faction!
if (_faction == "OPF_V_F") then {
	_tempList = [
		configFile >> "CfgVehicles" >> "O_V_Soldier_Exp_ghex_F",
		configFile >> "CfgVehicles" >> "O_V_Soldier_JTAC_ghex_F",
		configFile >> "CfgVehicles" >> "O_V_Soldier_M_ghex_F",
		configFile >> "CfgVehicles" >> "O_V_Soldier_ghex_F",
		configFile >> "CfgVehicles" >> "O_V_Soldier_Medic_ghex_F",
		configFile >> "CfgVehicles" >> "O_V_Soldier_LAT_ghex_F",
		configFile >> "CfgVehicles" >> "O_V_Soldier_TL_ghex_F"
	];
};

// Filter out and invalid unit types matching strings.
_fnc_notInString = {
	params ["_type"];
	
	_notInString = TRUE;
	{
		if (toLower _type find _x >= 0) exitWith { _notInString = FALSE };
	} forEach [ "_story", "_vr", "competitor", "miller", "survivor", "crew", "pilot", "rangemaster", "uav", "unarmed", "officer" ];
	
	_notInString
};

// Attempt to clear up the units list.
_menList = _tempList select { ((configName _x) call _fnc_notInString) && (count getArray(_x >> "weapons") > 2) && (toLower getText (_x >> "backpack") find "para" < 0) };

// If no units remain, use the original list.
if (count _menList == 0) then { _menList = _tempList };

// No units exist at all!
if (count _menList == 0) exitWith {
	[format["No units found for faction: %1", _faction], "ERROR"] call ZEI_fnc_misc_logMsg;
};

_bldPos = _bld buildingPos -1;
_side = getNumber (configFile >> "CfgFactionClasses" >> _faction >> "side");

if (is3DEN) then {
	collect3DENHistory {
		for "_i" from 1 to _units do {
			if (count _bldPos == 0) exitWith {};
			_rndPos = selectRandom _bldPos;
			_bldPos = _bldPos - [_rndPos];
			[_side, configName (selectRandom _menList), _rndPos, _bld, _enableDS] call ZEI_fnc_garrisonUnit;
		};
	};
} else {
	for "_i" from 1 to _units do {
		if (count _bldPos == 0) exitWith {};
		_rndPos = selectRandom _bldPos;
		_bldPos = _bldPos - [_rndPos];
		[_side, configName (selectRandom _menList), _rndPos, _bld, _enableDS] call ZEI_fnc_garrisonUnit;
	};
};