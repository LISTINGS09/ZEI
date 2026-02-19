params [["_house", "", [""]]];

if !(isClass (configFile >> "CfgVehicles" >> _house)) exitWith {
	[format ["Building class '%1' not found in CfgVehicles.", _house], "ERROR"] call ZEI_fnc_misc_logMsg;
};
if (isNil "ZEI_additionalBuildings") then {ZEI_additionalBuildings = []};

ZEI_additionalBuildings pushBackUnique _house;
