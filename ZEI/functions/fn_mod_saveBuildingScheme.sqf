// Increase the default radius by setting 'ZEI_SaveRadius' to larger number.
params [["_mode","",[""]],["_input",[],[[]]]];

switch _mode do {
	case "attributesChanged3DEN";
	case "init": {
		_input params [["_logic",objNull,[objNull]],["_isActivated",true,[true]], ["_isCuratorPlaced",false,[true]]];
		
		// In MP only run for local client.
		if (!local _logic) exitWith {};

		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (_isCuratorPlaced) then {deleteVehicle _logic} else {delete3DENEntities [_logic]};
		};
		
		[_isCuratorPlaced] spawn {
			params ["_isCuratorPlaced"];
			([get3DENMouseOver, curatorMouseOver] select _isCuratorPlaced) params [["_mouseType", ""], ["_mouseObj", objNull]];
			
			if (_mouseType != "Object" && {isNull _mouseObj}) exitWith {
				["Module must be placed over a building!", "ERROR"] call ZEI_fnc_misc_logMsg;
			};
			
			private _bldArr = [_mouseObj] select {!((_x buildingPos -1) isEqualTo []) || typeOf _x in (missionNamespace getVariable ["ZEI_additionalBuildings", []])};
			
			// Don't continue if array is empty.
			if (_bldArr isEqualTo [] && inputAction "LookAround" < 1) exitWith {
				["No valid building found! Add it to 'ZEI_additionalBuildings' if it has no positions.", "ERROR"] call ZEI_fnc_misc_logMsg;
			};
			
			// Array is empty, but 'LookAround' was pressed, force the object.
			if (_bldArr isEqualTo []) then { _bldArr = [_mouseObj] };
			
			// Decorate building in Eden, select building then run code below in debug console to generate a template to clipboard.
			private _keyObj = _bldArr select 0;
			private _keyObjType = typeOf _keyObj;
			private _nearObjects = _keyObj nearObjects ((sizeOf _keyObjType) + (missionNamespace getVariable ["ZEI_SaveRadius",5]));
			private _mod = "";
			diag_log text format["********** [ZEI - BUILDING OUTPUT ""%1""] **********", _keyObjType];
			
			private _tempArr = _nearObjects apply { 
				private _xType = typeOf _x;
				if !(_xType in ["Sign_Arrow_Large_Green_F", "Logic", "CamCurator", _keyObjType]) then {	
					private ["_objPos","_objDir","_pb","_pitch","_bank"];
					
					if !(_xType call ZEI_fnc_isVanillaObject) then {_mod = "[MOD] "};
					
					_objPos = _keyObj worldToModel (getPosATL _x);
					_objDir = round ((getDir _x) - (getDir _keyObj));
					
					_objPos = [_objPos#0, _objPos#1, _objPos#2];
					
					_pb = _x call BIS_fnc_getPitchBank;
					_pitch = ((abs (_pb#0)) + 360) mod 360;
					_bank = ((abs (_pb#1)) + 360) mod 360;
					
					// If the pitch/bank isn't significant, ignore it
					if (_pitch + _bank < 5) then {
						diag_log text format ["[""%1"", %2, %3],", _xType, _objPos, _objDir];
						[_xType, _objPos, _objDir]
					} else {
						private _orgVec = [vectorDir _x, vectorUp _x];
						_x setVectorDirAndUp [[0,1,0],[0,0,1]]; // Realign object direction to get correct worldToModel position.
						_objPos = _keyObj worldToModel (getPosATL _x);
						_x setVectorDirAndUp _orgVec;  // Revert to original orientation.
						diag_log text format ["[""%1"", %2, %3, %4],", _xType, _objPos, _objDir, ((_x get3DENAttribute "Rotation") select 0)  apply { round _x }];
						[_xType, _objPos, _objDir, ((_x get3DENAttribute "Rotation") select 0) apply { round _x }]
					};
				} else {
					objNull
				};
			};
			_tempArr = _tempArr - [objNull];
			
			copyToClipboard format ["%3%1: %2", _keyObjType, _tempArr, _mod];
			[format["'%1' written to clipboard (%2). Paste and save or send it to the mod developer!", _keyObjType, count _tempArr], "INFO"] call ZEI_fnc_misc_logMsg;
			if !((_keyObj call BIS_fnc_getPitchBank) isEqualTo [0,0]) then {
				// Warn if building has been rotated (objects are not offset according to the building)
				// TODO: Add support for all building angles?
				["Building is not flat. Objects may be saved incorrectly!", "WARNING"] call ZEI_fnc_misc_logMsg;
			};
			if (count _tempArr > 130) then {
				// Warn if too many objects (causes clipboard to cut off text - 8191 length?)
				// TODO: Add line break when scheme is too large and will break clipboard?
				["High number of objects! Not all objects may have been copied due to clipboard limitations.", "WARNING"] call ZEI_fnc_misc_logMsg;
			};
			if (worldName != "VR") then {
				["World is not VR. Positions saved may not be accurate.", "WARNING"] call ZEI_fnc_misc_logMsg;
			};
		};
	};
};

true