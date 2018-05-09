params [["_house", "", [""]]];

if !(isClass (configFile >> "CfgVehicles" >> _house)) exitWith {
	diag_log text format ["[ZEI][ERROR] Building class '%1' not found in CfgVehicles.", _house];
	systemChat format ["[ZEI][ERROR] Building class '%1' not found in CfgVehicles.", _house];
};
if (isNil "ZEI_additionalBuildings") then {ZEI_additionalBuildings = []};

ZEI_additionalBuildings pushBackUnique _house;
