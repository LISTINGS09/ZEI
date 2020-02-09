if hasInterface then {
	[] spawn {
		// Wait until logic is present.
		waitUntil {sleep 1; !isNull (getAssignedCuratorLogic player)};
		// Add EH to spawn ZEI Modules.
		(getAssignedCuratorLogic player) addEventHandler ["CuratorObjectRegistered", { [] spawn ZEI_fnc_zeus_addModules }];
	};
};