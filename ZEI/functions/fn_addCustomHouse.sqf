params [["_house", "", [""]]];


if !(isClass (configFile >> "CfgVehicles" >> _house)) exitWith {systemChat format ["[ZEI][ERROR] You try to add a wrong custom house -> %1", _house]};
if (isNil "ZEI_additionalBuildings") then {ZEI_additionalBuildings = []};

ZEI_additionalBuildings pushBackUnique _house;
