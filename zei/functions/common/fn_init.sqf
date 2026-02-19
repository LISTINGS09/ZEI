if (hasInterface) then {
    if (isServer || {!(isClass (configFile >> "CfgPatches" >> "zen_common"))}) then {
        [] spawn {
            // Wait until logic is present.
            waitUntil {sleep 1; !isNull (getAssignedCuratorLogic player)};
            // Add EH to spawn ZEI Modules.
            (getAssignedCuratorLogic player) addEventHandler ["CuratorObjectRegistered", { [] spawn ZEI_fnc_zeus_addModules }];
        };
    } else {
        // Only add separate ZEN modules if ZEN is loaded and if not server (to avoid duplicate modules in curator list)
        // This is to prevent a bug where all other ZEN modules that were added per script would be in the wrong categories and mixed up; Bug doesn't happen if the client is the server

        ["Interiors (ZEI)", "Garrison Building", {
            params ["_pos"];

            // Give a temp object, because objNull is not local (because of "ZEI_fnc_mod_garrisonBuilding" requirement)
            private _temp = "Module_F" createVehicleLocal _pos;

            ["init", [_temp, true, true]] call ZEI_fnc_mod_garrisonBuilding;

            deleteVehicle _temp;
        }, "\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa"] call zen_custom_modules_fnc_register;

        ["Interiors (ZEI)", "Object Fill", {
            params ["_pos"];

            // Give a temp object, because objNull is not local (because of "ZEI_fnc_mod_objectFill" requirement)
            private _temp = "Module_F" createVehicleLocal _pos;

            ["init", [_temp, true, true]] call ZEI_fnc_mod_objectFill;

            deleteVehicle _temp;
        }, "\A3\ui_f\data\igui\cfg\simpleTasks\types\box_ca.paa"] call zen_custom_modules_fnc_register;

        ["Interiors (ZEI)", "Object Switch", {
            params ["_pos"];

            // Give a temp object, because objNull is not local (because of "ZEI_fnc_mod_objectSwitch" requirement)
            private _temp = "Module_F" createVehicleLocal _pos;

            ["init", [_temp, true, true]] call ZEI_fnc_mod_objectSwitch;

            deleteVehicle _temp;
        }, "\A3\Modules_f\data\portraitRespawn_ca.paa"] call zen_custom_modules_fnc_register;

        ["Interiors (ZEI)", "Interior Fill", {
            params ["_pos"];

            // Give a temp object, because objNull is not local (because of "ZEI_fnc_mod_interiorFill" requirement)
            private _temp = "Module_F" createVehicleLocal _pos;

            ["init", [_temp, true, true]] call ZEI_fnc_mod_interiorFill;

            deleteVehicle _temp;
        }, "\A3\modules_f\data\portraitModule_ca.paa"] call zen_custom_modules_fnc_register;
    };
};
