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
		private _bldTmp = nearestObjects [_logic, ["Building"], _searchRadius, true]; 
		
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (_isCuratorPlaced) then {deleteVehicle _logic} else {delete3DENEntities [_logic]};
		};
		
		// Don't continue if no objects were found.
		if (_bldTmp isEqualTo []) exitWith {
			systemChat "No objects were found!";
		};
		
		private _bldArr = _bldTmp select {!((_x buildingPos 0) isEqualTo [0,0,0]) || typeOf _x in (missionNamespace getVariable ["ZEI_additionalBuildings", []])};
		
		if (!_fillArea && count _bldArr > 1) then {_bldArr resize 1};
		
		// Don't continue if array is empty and user isn't pressing alternative option.
		if (_bldArr isEqualTo [] && (inputAction "lookAround") < 1) exitWith {
			systemChat "No valid buildings nearby!";
		};
		
		// Array is empty, but 'LookAround' was pressed, force the object.
		// TODO: Use this as a final option without making the user press anything? (Some CUP buildings have no positions defined)
		if (_bldArr isEqualTo []) then { 
			if (!_fillArea) then {
				_bldArr = _bldTmp; 
			} else {
				_bldArr = [_bldTmp select 0];
			};
		};
		
		private _civilian = getNumber (configFile >> "CfgVehicles" >> _typeLogic >> "interiorsType") == 1;
		
		if (_isCuratorPlaced) then {
			{
				[_x, _fillArea, _isCuratorPlaced, _civilian] call ZEI_fnc_createTemplate;
			} forEach _bldArr;
		} else {
			collect3DENHistory {
				{
					[_x, _fillArea, _isCuratorPlaced, _civilian] call ZEI_fnc_createTemplate;
				} forEach _bldArr;
			};
		};
	};
};