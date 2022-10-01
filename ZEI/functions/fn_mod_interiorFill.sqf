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
			if (is3DEN) then {delete3DENEntities [_logic]} else {deleteVehicle _logic};
		};
		
		// Work out which building to fill
		ZEI_UiLastBuilding = objNull;
		
		if (is3DEN) then {
			//systemChat str get3DENMouseOver;
			if (get3DENMouseOver # 0 == "Object") then { ZEI_UiLastBuilding = get3DENMouseOver # 1;  };
		} else {
			//systemChat str curatorMouseOver;
			if (curatorMouseOver # 0 == "Object") then { ZEI_UiLastBuilding = curatorMouseOver # 1 };
		};
		
		// If object isn't valid, reset it
		if !(ZEI_UiLastBuilding isKindOf "building" || ZEI_UiLastBuilding isKindOf "thing") then { ZEI_UiLastBuilding = objNull };
						
		// Find a valid nearby building.
		if (isNull ZEI_UiLastBuilding) then {
			private _nearArr = nearestObjects [(screenToWorld getMousePosition), ["building"], 25, true];
			private _objArr = _nearArr select { sizeOf typeOf _x > 2 || count (_x buildingPos -1) > 0 };

			if (count _objArr > 0) then { ZEI_UiLastBuilding = _objArr select 0 };
		};
		
		if (isNull ZEI_UiLastBuilding) exitWith {
			["No valid buildings within 25m", "ERROR"] call ZEI_fnc_misc_logMsg;
		};
		
		// Skip UI and use default values.
		if ((inputAction "lookAround") isEqualTo 1) then {
			[
				missionNamespace getVariable["ZEI_UiInteriorType", 0],
				0,
				missionNamespace getVariable["ZEI_UiInteriorEdit", true],
				missionNamespace getVariable["ZEI_UiInteriorDamage", false],
				missionNamespace getVariable["ZEI_UiInteriorDetail", 1]
			] call ZEI_fnc_ui_interiorFill;
		} else {
			// Start Display 1705
			if (_isCuratorPlaced) then { 
				findDisplay 312 createDisplay "Rsc_ZEI_InteriorFill";  // Zeus
			} else {
				if (is3DEN) then {
					findDisplay 313 createDisplay "Rsc_ZEI_InteriorFill"; // Eden
				} else {
					createDialog "Rsc_ZEI_InteriorFill";
				};
			};
		};
	};
};

true