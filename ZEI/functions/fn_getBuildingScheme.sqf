params [
	["_mode", "", [""]],
	["_input", [], [[]]]
];

switch _mode do {
	case "init": {
		_input params [
				["_logic", objNull, [objNull]],
				"",
				["_isCuratorPlaced", false, [true]]
			];
		
		private _bldArr = nearestObjects [_logic, ["House", "Building"], 50, true]; 
		//private _bldArr = _bldArr select {!((_x buildingPos 0) isEqualTo [0,0,0])};
		_bldArr resize 1;
		
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (_isCuratorPlaced) then {deleteVehicle _logic} else {delete3DENEntities [_logic]};
		};
		
		// Don't continue if array is empty.
		if (_bldArr isEqualTo []) exitWith {systemChat "[ZEI] No valid building found"};
		
		// Decorate building in Eden, select building then run code below in debug console to generate a template to clipboard.
		private _keyObj = _bldArr select 0;
		private _keyObjType = typeOf _keyObj;
		private _nearObjects = _keyObj nearObjects ((sizeOf _keyObjType) + 2);
		private _moddedObjs = false;
		private _tempArr = _nearObjects apply { 
			private _xType = typeOf _x;
			if !(_xType in ["Sign_Arrow_Large_Green_F", "CamCurator", _keyObjType]) then {
				if !(_xType call ZEI_fnc_isVanillaObject) then {_moddedObjs = true};
				[_xType, _keyObj worldToModel (getPosATL _x), round ((getDir _keyObj) - (getDir _x))]
			} else {
				objNull
			};
		};
		_tempArr = _tempArr - [objNull];
		
		copyToClipboard format ["%3%1 : %2", _keyObjType, _tempArr, ["", "[MODDED] "] select _moddedObjs];
		systemChat (_keyObjType + " -> is in your clipboard, save it in a file and/or send it to the mod developer!");
		if (_moddedObjs) then {systemChat "[Warning] Some of the objects are not vanilla objects, this scheme can only be used with the right modset."};
	};
};

