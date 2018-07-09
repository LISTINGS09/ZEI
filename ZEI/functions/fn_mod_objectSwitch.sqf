params [
		["_mode", "", [""]],
		["_input", [], [[]]]
	];

switch _mode do {
	case "init": {
		_input params [["_logic",objNull,[objNull]],["_isActivated",TRUE,[TRUE]], ["_isCuratorPlaced",FALSE,[TRUE]]];
		
		// In MP only run for local client.
		if (!local _logic) exitWith {};
		
		// Need to pass logic pos info to GUI somehow?
		ZEI_LastPos = getPos _logic;
		
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (is3DEN) then { delete3DENEntities [_logic] } else { deleteVehicle _logic };
		};
		
		// Start Display 1701
		if (_isCuratorPlaced) then { 
			findDisplay 312 createDisplay "Rsc_ZEI_ObjectSwitch";  // Zeus
		} else {
			if (is3DEN) then {
				findDisplay 313 createDisplay "Rsc_ZEI_ObjectSwitch"; // Eden
			} else {
				createDialog "Rsc_ZEI_ObjectSwitch";
			};
		};
	};
};

TRUE