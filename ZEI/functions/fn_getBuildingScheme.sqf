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

		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (_isCuratorPlaced) then {deleteVehicle _logic} else {delete3DENEntities [_logic]};
		};
		
		[_isCuratorPlaced] spawn {
			params ["_isCuratorPlaced"];
			([get3DENMouseOver, curatorMouseOver] select _isCuratorPlaced) params [["_mouseType", ""], ["_mouseObj", objNull]];
			
			if (_mouseType != "Object" && {isNull _mouseObj}) exitWith {systemChat "[ZEI][ERROR] Module must be placed over a building!"};
			
			if (isNil "ZEI_additionalBuildings") then {ZEI_additionalBuildings = []};
			private _bldArr = [_mouseObj] select {!((_x buildingPos -1) isEqualTo []) || typeOf _x in ZEI_additionalBuildings};
			
			// Don't continue if array is empty.
			if (_bldArr isEqualTo []) exitWith {systemChat "[ZEI] No valid building found. "};
			
			// Decorate building in Eden, select building then run code below in debug console to generate a template to clipboard.
			private _keyObj = _bldArr select 0;
			private _keyObjType = typeOf _keyObj;
			private _nearObjects = _keyObj nearObjects ((sizeOf _keyObjType) + 2);
			private _mod = "";
			private _tempArr = _nearObjects apply { 
				private _xType = typeOf _x;
				if !(_xType in ["Sign_Arrow_Large_Green_F", "CamCurator", _keyObjType]) then {	
					if !(_xType call ZEI_fnc_isVanillaObject) then {_mod = "[MOD] "};
					[_xType, _keyObj worldToModel (getPosATL _x), round ((getDir _keyObj) - (getDir _x))]
				} else {
					objNull
				};
			};
			_tempArr = _tempArr - [objNull];
			
			copyToClipboard format ["%3%1 %2", _keyObjType, _tempArr, _mod];
			diag_log text format ["%3%1 %2", _keyObjType, _tempArr, _mod]; // Sometimes too big for clipboard!
			systemChat format["'%1' written to clipboard. Paste and save or send it to the mod developer!", _keyObjType];
			if (worldName != "VR") then {systemChat "[WARNING] World is not VR. Positions saved may not be accurate."};
		};
	};
};
