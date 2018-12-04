params [
		["_type", 0],
		["_area", 0],
		["_addZeus", TRUE],
		["_allowDamage", FALSE]
	];

private _fillType = if (_type isEqualTo 0) then { "mil" } else { "civ" };
private _fillArea = if (_area isEqualTo 0) then { FALSE } else { TRUE };
private _bldTmp = nearestObjects [(missionNamespace getVariable ["ZEI_UiLastPos", [0,0,0]]), ["Building"], if (_area isEqualTo 0) then { 15 } else { _area }, TRUE]; 

// Save UI Settings for next time
ZEI_UiInteriorType = _type;
ZEI_UiInteriorEdit = _addZeus;
ZEI_UiInteriorDamage = _allowDamage;

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