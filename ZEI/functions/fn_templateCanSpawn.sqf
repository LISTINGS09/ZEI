params ["_template"];

if (!isNil "ZEI_debug" && {ZEI_debug}) then {
	{
		if (!isClass (configFile >> "CfgVehicles" >> (_x select 0))) then {
			["Template cant be spawn because of: %1", _x select 0] call ZEI_fnc_debug;
		};
	} forEach _template;
};

0 != (_template findIf {!isClass (configFile >> "CfgVehicles" >> (_x select 0))})
