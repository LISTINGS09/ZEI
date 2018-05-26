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
			
			private _bldArr = [_mouseObj] select {!((_x buildingPos -1) isEqualTo []) || typeOf _x in (missionNamespace getVariable ["ZEI_additionalBuildings", []])};
			
			// Don't continue if array is empty.
			if (_bldArr isEqualTo [] && inputAction "LookAround" < 1) exitWith {
				systemChat "[ZEI] No valid building found! Add it to 'ZEI_additionalBuildings' if it has no positions.";
			};
			
			// Array is empty, but 'LookAround' was pressed, force the object.
			if (_bldArr isEqualTo []) then { _bldArr = [_mouseObj] };
			
			// Decorate building in Eden, select building then run code below in debug console to generate a template to clipboard.
			private _keyObj = _bldArr select 0;
			private _keyObjType = typeOf _keyObj;
			private _nearObjects = _keyObj nearObjects ((sizeOf _keyObjType) + 2);
			private _mod = "";
			private _tempArr = _nearObjects apply { 
				private _xType = typeOf _x;
				if !(_xType in ["Sign_Arrow_Large_Green_F", "Logic", "CamCurator", _keyObjType]) then {	
					if !(_xType call ZEI_fnc_isVanillaObject) then {_mod = "[MOD] "};
										
					if ((_x call BIS_fnc_getPitchBank) isEqualTo [0,0]) then {
						[_xType, _keyObj worldToModel (getPosATL _x), round ((getDir _x) - (getDir _keyObj))]
					} else {
						private _orgVec = [vectorDir _x, vectorUp _x];
						_x setVectorDirAndUp [[0,1,0],[0,0,1]]; // Realign Direction to get correct position.
						_objPos = _keyObj worldToModel (getPosATL _x);
						_x setVectorDirAndUp _orgVec;  // Revert to original orientation.
						[_xType, _objPos, round ((getDir _x)  - (getDir _keyObj)), ((_x get3DENAttribute "Rotation") select 0)]
					};
				} else {
					objNull
				};
			};
			_tempArr = _tempArr - [objNull];
			
			copyToClipboard format ["%3%1 %2", _keyObjType, _tempArr, _mod];
			diag_log text format ["%3%1 %2", _keyObjType, _tempArr, _mod];
			systemChat format["'%1' written to clipboard (%2). Paste and save or send it to the mod developer!", _keyObjType, count _tempArr];
			if !((_keyObj call BIS_fnc_getPitchBank) isEqualTo [0,0]) then {
				// Warn if building has been rotated (objects are not offset according to the building)
				// TODO: Add support for all building angles?
				systemChat format["[WARNING] Building is not flat. Objects may be saved incorrectly!"];
			};
			if (count _tempArr > 130) then {
				// Warn if too many objects (causes clipboard to cut off text)
				// TODO: Add line break when scheme is too large and will break clipboard?
				systemChat format["[WARNING] High number of objects! Not all objects may have been copied due to clipboard limitations."];
			};
			if (worldName != "VR") then {systemChat "[WARNING] World is not VR. Positions saved may not be accurate."};
		};
	};
};