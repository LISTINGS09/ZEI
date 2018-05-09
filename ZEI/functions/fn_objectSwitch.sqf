params [
		["_mode", "", [""]],
		["_input", [], [[]]]//,
		//["_setVar", true, [true]]
	];

switch _mode do {
	case "init": {
		_input params [
				["_logic", objNull, [objNull]],
				["_isActivated", true, [true]],
				["_isCuratorPlaced", false, [true]]
			];
		
		// Need to pass logic pos info to GUI somehow?
		ZEI_LastPos = getPos _logic;
		ZEI_LastCurator = _isCuratorPlaced;
		
		createDialog "Rsc_ZEI_ObjectSwitch";
		
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (_isCuratorPlaced) then {deleteVehicle _logic} else {delete3DENEntities [_logic]};
		};
	};
};