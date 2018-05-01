// ["init",[player,true,false]] execVM "fn_interiorCiv.sqf";

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
		
		//systemChat format ["VAR: %1", allVariables _logic];
		
		private _typeLogic = typeOf _logic;
		private _fillArea = getNumber (configFile >> "CfgVehicles" >> _typeLogic >> "fillArea") == 1;
		private _searchRadius = getNumber (configFile >> "CfgVehicles" >> _typeLogic >> "searchRadius");
		private _bldArr = nearestObjects [_logic, ["House", "Building"], _searchRadius, true]; 
		//private _bldArr = _bldArr select {!((_x buildingPos 0) isEqualTo [0,0,0])};
		
		if (!_fillArea && count _bldArr > 1) then {_bldArr resize 1};
		
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (_isCuratorPlaced) then {deleteVehicle _logic} else {delete3DENEntities [_logic]};
		};
		
		// Don't continue if array is empty.
		if (_bldArr isEqualTo []) exitWith {};
		
		private _civilian = getNumber (configFile >> "CfgVehicles" >> _typeLogic >> "interiorsType") == 1;
		
		if (_isCuratorPlaced) then {
			{
				[_x, _fillArea, _civilian] call ZEI_fnc_createTemplate;
			} forEach _bldArr;
		} else {
			collect3DENHistory {
				{
					[_x, _fillArea, _civilian] call ZEI_fnc_createTemplate;
				} forEach _bldArr;
			};
		};
	};
};