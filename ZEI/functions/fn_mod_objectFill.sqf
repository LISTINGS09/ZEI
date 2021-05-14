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
		
		// Store the Object under the cursor or nearest of type.
		if (is3DEN) then {
			//systemChat str get3DENMouseOver;
			if (get3DENMouseOver # 0 == "Object") then {
				ZEI_UiLastObject = get3DENMouseOver # 1;
			} else {
				ZEI_UiLastObject = (nearestObjects [screenToWorld getMousePosition, ["Thing"], 10, TRUE]) param [0, ObjNull];
			};
		} else {
			//systemChat str curatorMouseOver;
			if (curatorMouseOver # 0 == "Object") then {
				ZEI_UiLastObject = curatorMouseOver # 1;
			} else {
				ZEI_UiLastObject = (nearestObjects [screenToWorld getMousePosition, ["Thing"], 10, TRUE]) param [0, ObjNull];
			};
		};
		
		// Start Display 1704
		if ((inputAction "lookAround") isEqualTo 1) then {
			// Skip UI and use default values.
			[] call ZEI_fnc_ui_objectFill;
		} else {
			if (is3DEN) then {
				findDisplay 313 createDisplay "Rsc_ZEI_ObjectFill"; // Eden
			} else {
				findDisplay 312 createDisplay "Rsc_ZEI_ObjectFill";  // Zeus
			};
		};
	};
};

true