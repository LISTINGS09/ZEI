params [["_mode","",[""]],["_input",[],[[]]]];

switch _mode do {
	case "attributesChanged3DEN";
	case "init": {
		_input params [["_logic",objNull,[objNull]],["_isActivated",true,[true]], ["_isCuratorPlaced",false,[true]]];
		
		// In MP only run for local client.
		if (!local _logic) exitWith {};
		
		if (!_isActivated) then { _logic setVariable ["bis_fnc_initModules_activate", true, !isServer] };
		
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (is3DEN) then { delete3DENEntities [_logic] } else { deleteVehicle _logic };
		};
		
		// Find nearest building
		ZEI_UiLastBuilding = nearestBuilding (screenToWorld getMousePosition);
		
		if ((screenToWorld getMousePosition) distance2D ZEI_UiLastBuilding > 25) exitWith { ["No valid buildings within 25m", "ERROR"] call ZEI_fnc_misc_logMsg };
		
		if ((inputAction "lookAround") isEqualTo 1) then {
			if (isNil "ZEI_UiGarrisonFaction" || isNil "ZEI_UiGarrisonCategory" || isNil "ZEI_UiGarrisonDynamic") exitWith { ["Select your faction in the GUI first!", "ERROR"] call ZEI_fnc_misc_logMsg };
			[format["%1#%2", ZEI_UiGarrisonFaction, ZEI_UiGarrisonCategory], 4, missionNamespace getVariable ["ZEI_UiGarrisonDynamic", true]] call ZEI_fnc_ui_garrisonBuilding;
		} else {
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
		};
	};
};

true