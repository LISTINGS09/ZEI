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
		private _nearObjects = _keyObj nearObjects ((sizeOf typeOf _keyObj) + 2); 
		private _tempArr = _nearObjects apply { 
			if (_x != _keyObj && !(typeOf _x in ["Sign_Arrow_Large_Green_F", "CamCurator"])) then { 
				[typeOf _x, _keyObj worldToModel (getPosATL _x), round ((getDir _keyObj) - (getDir _x))]
			} else {
				objNull
			};
		};
		_tempArr = _tempArr - [objNull];
		
		copyToClipboard (typeOf _keyObj + ": " + str _tempArr);
		systemChat (typeOf _keyObj + " -> is in your clipboard, save it in a file or send it to the mod developer!");
	};
};

