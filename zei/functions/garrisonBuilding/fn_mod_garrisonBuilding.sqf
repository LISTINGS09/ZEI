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
		
		ZEI_UiLastBuilding = objNull;
		
		// Find nearest building
		private _nearArr = (nearestObjects [(screenToWorld getMousePosition), [], 25, true]) select { count (_x buildingPos -1) > 0 };
		if (count _nearArr > 0) then { ZEI_UiLastBuilding = _nearArr select 0 };
		
		if (isNull ZEI_UiLastBuilding) exitWith { ["No valid buildings within 25m", "ERROR"] call ZEI_fnc_misc_logMsg };
		
		if ((inputAction "lookAround") isEqualTo 1) then {
			if (isNil "ZEI_UiGarrisonFaction" || isNil "ZEI_UiGarrisonCategory" || isNil "ZEI_UiGarrisonDynamic") exitWith { ["Select your faction in the GUI first!", "ERROR"] call ZEI_fnc_misc_logMsg };
			[
				format["%1#%2", ZEI_UiGarrisonFaction, ZEI_UiGarrisonCategory],
				4,
				missionNamespace getVariable ["ZEI_UiGarrisonDynamic", true],
				missionNamespace getVariable ["ZEI_UiCreateTrigger", false]
			] call ZEI_fnc_ui_garrisonBuilding;
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