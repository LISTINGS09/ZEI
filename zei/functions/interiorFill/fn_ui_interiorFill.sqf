params [
		["_type", 0],
		["_area", 0],
		["_addZeus", true],
		["_allowDamage", false],
		["_detail", 1]
	];

private _fillType = ["mil","cbrn","civ"] select _type;
private _fillArea = if (_area isEqualTo 0) then { false } else { true };

// Save UI Settings for next time
ZEI_UiInteriorType = _type;
ZEI_UiInteriorDetail = _detail;
ZEI_UiInteriorEdit = _addZeus;
ZEI_UiInteriorDamage = _allowDamage;

private _bldTmp = missionNamespace getVariable ["ZEI_UiLastBuilding", objNull];
private _bldArr = [];

if (isNull _bldTmp || _fillArea) then { 
	_bldTmp = nearestObjects [screenToWorld getMousePosition, ["Building"], if (_area isEqualTo 0) then { 15 } else { _area }, true]; 
	_bldArr = _bldTmp select { ((_x buildingPos 0) isNotEqualTo [0,0,0]) || typeOf _x in (missionNamespace getVariable ["ZEI_additionalBuildings", []]) };
	
	if !(_fillArea) then { _bldArr resize 1 };
} else {
	_bldArr = [_bldTmp];
};

_bldArr = _bldArr - [objNull];

// Don't continue if no objects were found.
if (_bldArr isEqualTo []) exitWith {
	["No valid objects within 25m", "INFO"] call ZEI_fnc_misc_logMsg;
};

if (is3DEN) then {
	collect3DENHistory {
		{
			[_x, _fillType, _fillArea, _addZeus, _allowDamage, _detail] call ZEI_fnc_createTemplate;
		} forEach _bldArr;
	};
} else {
	{
		[_x, _fillType, _fillArea, _addZeus, _allowDamage, _detail] call ZEI_fnc_createTemplate;
	} forEach _bldArr;
};