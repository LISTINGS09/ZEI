params ["_template"];

// TODO: Remove the object from the list and attempt rest of items?

if (!isNil "ZEI_debug" && {ZEI_debug}) then {
	{
		if (!isClass (configFile >> "CfgVehicles" >> (_x select 0))) then {
			["Template cannot be created due to invalid object: %1", _x select 0] call ZEI_fnc_misc_debug;
		};
	} forEach _template;
};

0 != (_template findIf {!isClass (configFile >> "CfgVehicles" >> (_x select 0))})
