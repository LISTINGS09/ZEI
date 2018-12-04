params [
		["_mode", "", [""]],
		["_input", [], [[]]]//,
		//["_setVar", true, [true]]
	];
systemChat format ["Ausgabe1: %1", _this];
switch _mode do {
    case "attributesChanged3DEN";
	case "init": {
		_input params [["_logic",objNull,[objNull]],["_isActivated",true,[true]], ["_isCuratorPlaced",false,[true]]];
		
		// In MP only run for local client.
		if (!local _logic) exitWith {};
		
		private _bldArr = (nearestObjects [_logic, ["building"], 200, true]) select {count (_x buildingPos -1) > 0};
		systemChat format ["Ausgabe2: %1", count _bldArr];
		if (count _bldArr > 0) then {
			ZEI_LastPos = getPos _logic;
			ZEI_LastBuilding = _bldArr select 0;
			systemChat format ["Ausgabe3: %1 - %2", _isCuratorPlaced, is3DEN];
			// Start Display 1702
			if (_isCuratorPlaced) then { 
				findDisplay 312 createDisplay "Rsc_ZEI_GarrisonBuilding";  // Zeus
			} else {
				if (is3DEN) then {
					findDisplay 313 createDisplay "Rsc_ZEI_GarrisonBuilding"; // Eden
				} else {
					createDialog "Rsc_ZEI_GarrisonBuilding";
				};
			};
		} else {
			["No valid buildings found!", "ERROR"] call ZEI_fnc_misc_logMsg;
		};
		
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (is3DEN) then { delete3DENEntities [_logic] } else { deleteVehicle _logic };
		};
	};
};

true
