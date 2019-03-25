params [
		["_group", grpNull],
		["_type", ""],
		["_pos", FALSE],
		["_bld", 0]
	];
	
private _unit = objNull;

private _setDirStance = {
	params ["_unit", "_unitBld"];

	if (isNil "_unit") exitWith {};
	
	private _unitEyePos = eyePos _unit;
		
	// TODO: Re-run check after unit has been made prone?
	
	// Make unit crouch if they have sky above their heads.
	if (count (lineIntersectsWith [_unitEyePos, (_unitEyePos vectorAdd [0, 0, 10])] select {_x isKindOf 'Building'}) < 1) then {
		if (is3DEN) then { _unit set3DENAttribute ["unitPos", 1]; } else { _unit setUnitPos "MIDDLE"; };
		// Reset source to new height.
		_unitEyePos = eyePos _unit; 
	}; 
	
	private _p1 = []; // Great pos, facing outside building.
	private _p2 = []; // Good pos but facing inside building.
	private _p3 = []; // OK pos but not best views.
	private _p4 = []; // Bad pos facing wall.	
	private _helper = "";
	private _emptyCount = 0;
	
	for "_dir" from (getDir _unitBld) to ((getDir _unitBld) + 359) step 45 do { 
		// Check 3m
		if (count (lineIntersectsWith [_unitEyePos, [_unitEyePos, 3, _dir] call BIS_fnc_relPos] select {_x isKindOf 'Building'}) > 0) then { 
			_p4 pushBack _dir;
			_helper = "Sign_Arrow_Direction_F";
		} else { 
			// Check 10m
			if (count (lineIntersectsWith [_unitEyePos, [_unitEyePos, 10, _dir] call BIS_fnc_relPos] select {_x isKindOf 'Building'}) > 0) then { 
				_p3 pushBack _dir;
				_helper = "Sign_Arrow_Direction_Yellow_F";
			} else { 
				if (abs ((_unitEyePos getDir _unitBld) - _dir) >= 120) then {
					_p1 pushBack _dir;
					_helper = "Sign_Arrow_Direction_Green_F";
				} else {
					_p2 pushBack _dir;
					_helper = "Sign_Arrow_Direction_Cyan_F";
				};
				_emptyCount = _emptyCount + 1;
			};
		};
		
		// Debug will output markers.
		if (missionNamespace getVariable ["ZEI_DEBUG", FALSE]) then {
			private _obj = createSimpleObject [_helper, [_unitEyePos, 1, _dir] call BIS_fnc_relPos]; 
			_obj setDir _dir;
		};
	};  
		
	// Pick a random angle from the best grouping.
	private _finalDir = -1;
	{	
		if (count _x > 0) then {_finalDir = selectRandom _x };
		if (_finalDir >= 0) exitWith {}; 
	} forEach [_p1, _p2, _p3, _p4];
	
	// Set unit rotation.
	if (is3DEN) then { 
		_unit set3DENAttribute ["rotation", [0, 0, _finalDir]];
	} else {
		_unit doWatch (_unit getPos [100,_finalDir]);
	};
	
	// Force hold position.
	if !(leader _unit == _unit) then {
		if (is3DEN) then { 
			_unit set3DENAttribute ["Init", "this disableAI 'PATH';"];
		} else {
			_unit disableAI "PATH";
		};
	};
	
	// Semi-exposed area, set to kneel (occasionally stand).
	if (_emptyCount >= 5 && random 1 > 0.2) then { 
		if (is3DEN) then { _unit set3DENAttribute ["unitPos", 1]; } else { _unit setUnitPos "MIDDLE"; };
	};

	// Exposed area, set to crouched (occasionally prone).
	if (_emptyCount >= 7) then { 
		if (random 1 > 0.2) then { 
			if (is3DEN) then { _unit set3DENAttribute ["unitPos", 1]; } else { _unit setUnitPos "MIDDLE"; };
		} else { 
			if (is3DEN) then { _unit set3DENAttribute ["unitPos", 2]; } else { _unit setUnitPos "DOWN"; };
		};
	};
};

// Spawn items depending on Zeus/Eden
if is3DEN then {
	_unit = _group create3DENEntity ["Object", _type, [0, 0, 0]];
	
	if (surfaceIsWater _pos) then { 
		_unit set3DENAttribute ["position", ASLToATL _pos];
	} else {
		_unit set3DENAttribute ["position", _pos];
	};
	
	[_unit, _bld] call _setDirStance;
} else {
	_unit = _group createUnit [_type, _pos, [], 0, "NONE"];
	if !(surfaceIsWater _pos) then { _unit setPosATL _pos };
	[_unit, _bld] call _setDirStance;
	
	//Add to Zeus
	{ [_x, [ [_unit], TRUE]] remoteExec ["addCuratorEditableObjects",2] } forEach allCurators;
};

[format["Created %1 [%2] at %3", typeOf _unit, _group, _pos], "DEBUG"] call ZEI_fnc_misc_logMsg;
	
TRUE