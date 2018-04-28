params ["_template"];

0 != (_template findIf {!isClass (configFile >> "CfgVehicles" >> (_x select 0))})
