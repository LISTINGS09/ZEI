// Spawns some markers indicating building positions within the object.
// This is intended to highlight positions to avoid when decorating houses.
params [["_mode","",[""]],["_input",[],[[]]]];

[format["Passed Mode: %1 - Input: %2", _mode, _input], "DEBUG"] call ZEI_fnc_misc_logMsg;

switch _mode do {
	case "attributesChanged3DEN";
	case "init": {
		_input params [["_logic",objNull,[objNull]],["_isActivated",true,[true]], ["_isCuratorPlaced",false,[true]]];
		
		// In MP only run for local client.
		if (!local _logic) exitWith {};
								
		private _bldArr = nearestObjects [_logic, [], 25, true]; 
		
		_bldArr = _bldArr select { str (_x buildingPos 0) != "[0,0,0]" };
		
		if (count _bldArr  == 0) exitWith { ["No valid buildings within 25m", "ERROR"] call ZEI_fnc_misc_logMsg };
		if (count _bldArr > 1) then { _bldArr resize 1 };
	
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (is3DEN) then { delete3DENEntities [_logic] } else { deleteVehicle _logic };
		};
				
		collect3DENHistory {
			{ 
				private _bld = _x;
				private _bPos = _bld buildingPos -1;
				if (count _bPos > 0) then {
					{		
						private _obj = create3DENEntity ["Object", if (surfaceIsWater _x) then {"Sign_Arrow_Large_Blue_F"} else {"Sign_Arrow_Large_Green_F"}, [0, 0, 0]];
						_obj set3DENAttribute ["rotation", [ 0, 0, 0]];
						_obj set3DENAttribute ["description", format["Building Position: %1", _bPos find _x]];
						if (surfaceIsWater _x) then {
							_obj set3DENAttribute ["position", ASLToATL _x]							
						} else {
							_obj set3DENAttribute ["position", _x]
						};
					} forEach _bPos;
				};
			} forEach _bldArr;
		};
	};
};

true