params [
		["_side", 0],
		["_type", ""],
		["_pos", false],
		["_bld", 0],
		["_enableDS", false]
	];
	
	
_setDirStance = {
	params ["_unit","_unitBld"];
	_count = 0;
	
	if (isNil "_unit") exitWith {};
	
	_unitEyePos = eyePos _unit;
		
	// Make unit crouch if they have sky above their heads.
	if (count (lineIntersectsWith [_unitEyePos, (_unitEyePos vectorAdd [0, 0, 10])] select {_x isKindOf 'Building'}) < 1) then {
		if (is3DEN) then { _unit set3DENAttribute ["unitPos", 1]; } else { _unit setUnitPos "MIDDLE"; };
		// Reset source to new height.
		_unitEyePos = eyePos _unit; 
	} else {
		// Unit will be inside building so allow setting DS.
		if (_enableDS) then {
			if (is3DEN) then {
				(group _unit) set3DENAttribute ["dynamicSimulation", TRUE];
			} else {
				group _unit enableDynamicSimulation TRUE;
			};
		};
	}; 
	
	_p1 = []; // Great pos, facing outside building.
	_p2 = []; // Good pos but facing inside building.
	_p3 = []; // OK pos but not best views.
	_p4 = []; // Bad pos facing wall.	
	_helper = "";
	_emptyCount = 0;
	
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
			_obj = createSimpleObject [_helper, [_unitEyePos, 1, _dir] call BIS_fnc_relPos]; 
			_obj setDir _dir;
		};
	};  
		
	// Pick a random angle from the best grouping.
	_finalDir = -1;
	{	
		if (count _x > 0) then {_finalDir = selectRandom _x };
		if (_finalDir >= 0) exitWith {}; 
	} forEach [_p1, _p2, _p3, _p4];
	
	if (is3DEN) then { 
		_unit set3DENAttribute ["rotation", [0, 0, _finalDir]];
	} else {
		_unit doWatch (_unit getPos [100,_finalDir]);
		// _unit setFormDir _finalDir; // DOESNT WORK - WHY?
		// _unit setDir _finalDir;
	};
	
	// Semi-exposed area, set to kneel.
	if (_emptyCount >= 5 && random 1 > 0.2) then { 
		if (is3DEN) then { _unit set3DENAttribute ["unitPos", 1]; } else { _unit setUnitPos "MIDDLE"; };
	};

	// Exposed area, set to prone.
	if (_emptyCount >= 7) then { 
		if (random 1 > 0.8) then { 
			if (is3DEN) then { _unit set3DENAttribute ["unitPos", 1]; } else { _unit setUnitPos "MIDDLE"; };
		} else { 
			if (is3DEN) then { _unit set3DENAttribute ["unitPos", 2]; } else { _unit setUnitPos "DOWN"; };
		};
	};
};

// Spawn items depending on Zeus/Eden
private _lastItem = objNull; // to track if it was undo in eden
if is3DEN then {
	_unit = create3DENEntity ["Object", _type, [0, 0, 0], TRUE];
	_unit set3DENAttribute ["position", _x];
	[_unit, _bld, _enableDS] call _setDirStance;
} else {
	private _group = switch _side do { 
		case 0: { createGroup [EAST, TRUE] };
		case 1: { createGroup [WEST, TRUE] };
		default { createGroup [INDEPENDENT, TRUE] };
	};

	private _unit = _group createUnit [_type, _pos, [], 0, "NONE"];
	//_unit setPosATL _pos;
	[_unit, _bld, _enableDS] call _setDirStance;
	
	//Add to Zeus
	{ _x addCuratorEditableObjects [[_unit],true] } forEach allCurators;
};