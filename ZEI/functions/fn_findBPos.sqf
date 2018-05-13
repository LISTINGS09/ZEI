// Spawns some markers indicating building positions within the object.
// This is intended to highlight positions to avoid when decorating houses.
params [["_mode","",[""]],["_input",[],[[]]]];

switch _mode do {
	case "init": {
		_input params [["_logic",objNull,[objNull]],["_isActivated",true,[true]], ["_isCuratorPlaced",false,[true]]];
						
		//systemChat format ["VAR: %1", allVariables _logic];
		
		private _fillArea = _logic getVariable ["fillArea",false];
		private _searchRadius = _logic getVariable ["searchRadius",50];
		private _bldArr = nearestObjects [_logic, ["building"], _searchRadius, true]; 
		
		_bldArr = _bldArr select {str (_x buildingPos 0) != "[0,0,0]"};
		
		if (!_fillArea && count _bldArr > 1) then { _bldArr resize 1; };
	
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (_isCuratorPlaced) then { deleteVehicle _logic; } else { delete3DENEntities [_logic]; };
		};
		
		collect3DENHistory {
			{ 
				private _bld = _x;
				private _bPos = _bld buildingPos -1;
				if (count _bPos > 0) then {
					{					
						if (surfaceIsWater _x) then {
							// DOESNT QUITE WORK!
							private _obj = create3DENEntity ["Object", "Sign_Arrow_Large_Green_F", AGLToASL	_x];
							_obj set3DENAttribute ["rotation", [ 0, 0, 0]];
						} else {
							private _obj = create3DENEntity ["Object", "Sign_Arrow_Large_Green_F", _x];
							_obj set3DENAttribute ["rotation", [ 0, 0, 0]];
						};
					} forEach _bPos;
				};
			} forEach _bldArr;
		};
	};
};

true