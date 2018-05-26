params [
		["_type", 0],
		["_area", 0],
		["_addZeus", FALSE]
	];

private _isCiv = if (_type isEqualTo 0) then { FALSE } else { TRUE };
private _fillArea = if (_area isEqualTo 0) then { FALSE } else { TRUE };
private _bldTmp = nearestObjects [(missionNamespace getVariable ["ZEI_LastPos", [0,0,0]]), ["Building"], if (_area isEqualTo 0) then { 25 } else { _area }, TRUE]; 

// Don't continue if no objects were found.
if (_bldTmp isEqualTo []) exitWith {
	systemChat "No objects were found!";
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
			[_x, _fillArea, _addZeus, _isCiv] call ZEI_fnc_createTemplate;
		} forEach _bldArr;
	};
} else {
	{
		[_x, _fillArea, _addZeus, _isCiv] call ZEI_fnc_createTemplate;
	} forEach _bldArr;
};