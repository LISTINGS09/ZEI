params [
		["_mode", "", [""]],
		["_input", [], [[]]]
	];
	
switch _mode do {
	case "init": {
		_input params [["_logic",objNull,[objNull]],["_isActivated",true,[true]], ["_isCuratorPlaced",false,[true]]];
		
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (is3DEN) then { delete3DENEntities [_logic] } else { deleteVehicle _logic };
		};
		
		if (worldName != "VR") exitWith {systemChat "[ERROR] You must be in the VR world to use this module."};
		
		// Start Display 1702
		if (_isCuratorPlaced) then { 
			findDisplay 312 createDisplay "Rsc_ZEI_ListBuildings";  // Zeus
		} else {
			if (is3DEN) then {
				findDisplay 313 createDisplay "Rsc_ZEI_ListBuildings"; // Eden
			} else {
				createDialog "Rsc_ZEI_ListBuildings";
			};
		};
	};
};