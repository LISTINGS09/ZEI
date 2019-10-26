params [
		["_type", 0],
		["_area", 0],
		["_addZeus", TRUE],
		["_allowDamage", FALSE]
	];

private _fillType = if (_type isEqualTo 0) then { "mil" } else { "civ" };
private _fillArea = if (_area isEqualTo 0) then { FALSE } else { TRUE };

// Save UI Settings for next time
ZEI_UiInteriorType = _type;
ZEI_UiInteriorEdit = _addZeus;
ZEI_UiInteriorDamage = _allowDamage;

private _bldTmp = ObjNull;

// Store the Object under the cursor or nearest of type.
if (is3DEN) then {
	//systemChat str get3DENMouseOver;
	if (get3DENMouseOver # 0 == "Object") then { _bldTmp = get3DENMouseOver # 1 };
} else {
	//systemChat str curatorMouseOver;
	if (curatorMouseOver # 0 == "Object") then { _bldTmp = curatorMouseOver # 1 };
};

if (isNull _bldTmp || (_bldTmp buildingPos 0) isEqualTo [0,0,0]) then { 
	_bldTmp = nearestObjects [(missionNamespace getVariable ["ZEI_UiLastPos", [0,0,0]]), ["Building"], if (_area isEqualTo 0) then { 15 } else { _area }, TRUE]; 
} else {
	_bldTmp = [_bldTmp];
};

// Don't continue if no objects were found.
if (_bldTmp isEqualTo []) exitWith {
	["No objects were found!", "ERROR"] call ZEI_fnc_misc_logMsg;
};

private _bldArr = _bldTmp select {!((_x buildingPos 0) isEqualTo [0,0,0]) || typeOf _x in (missionNamespace getVariable ["ZEI_additionalBuildings", []])};

if (!_fillArea && count _bldArr > 1) then {_bldArr resize 1};

if (_bldArr isEqualTo []) then { 
	if (!_fillArea) then {
		_bldArr = _bldTmp; 
	} else {
		_bldArr = [_bldTmp select 0];
	};
};

if (is3DEN) then {
	collect3DENHistory {
		{
			[_x, _fillType, _fillArea, _addZeus, _allowDamage] call ZEI_fnc_createTemplate;
		} forEach _bldArr;
	};
} else {
	{
		[_x, _fillType, _fillArea, _addZeus, _allowDamage] call ZEI_fnc_createTemplate;
	} forEach _bldArr;
};