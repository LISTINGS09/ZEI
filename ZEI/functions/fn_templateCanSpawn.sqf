params ["_template"];

// TODO: Remove the object from the list and attempt rest of items?

if (!isNil "ZEI_debug" && {ZEI_debug}) then {
	{
		if (!isClass (configFile >> "CfgVehicles" >> (_x select 0))) then {
			[format ["Template cannot be created due to invalid object: %1", _x select 0], "ERROR"] call ZEI_fnc_misc_logMsg;
		};
	} forEach _template;
};

0 != (_template findIf {!isClass (configFile >> "CfgVehicles" >> (_x select 0))})
