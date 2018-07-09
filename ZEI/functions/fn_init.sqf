// Zeus Dedicated Server Fix
// Adds the ZEI Modules to the Curator since they don't seem to be added automatically.
if !isServer then {
	[] spawn {
		// Wait until logic is present.
		waitUntil {sleep 5; !isNull (getAssignedCuratorLogic player)};
		// Add EH to spawn ZEI Modules.
		(getAssignedCuratorLogic player) addEventHandler ["CuratorObjectRegistered", { [] spawn ZEI_fnc_zeus_addModules }];
	};
};