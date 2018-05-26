// Return the Eden X Y Rotation of an object by its VectorDirAndUp
// Credit: Ian Banks @foxhound.international 
params [
		["_source", objNull],
		["_xyOnly", FALSE]
	];
	
private _direction = vectorDir _source;
private _up = vectorUp _source;
private _aside = _direction vectorCrossProduct _up;
private ["_xRot", "_yRot", "_zRot"];

if (abs (_up select 0) < 0.999999) then {
	_yRot = -asin (_up select 0);
	_signCosY = if (cos _yRot < 0) then { -1 } else { 1 };
	_xRot = (_up select 1 * _signCosY) atan2 (_up select 2 * _signCosY);
	_zRot = (_direction select 0 * _signCosY) atan2 (_aside select 0 * _signCosY);
} else {
	_zRot = 0;
	if (_up select 0 < 0) then {
		_yRot = 90;
		_xRot = (_aside select 1) atan2 (_aside select 2);
	} else {
		_yRot = -90;
		_xRot = (-(_aside select 1)) atan2 (-(_aside select 2));
	};
};

if (_xyOnly) exitWith { [_xRot, _yRot] };

[_xRot, _yRot, _zRot]