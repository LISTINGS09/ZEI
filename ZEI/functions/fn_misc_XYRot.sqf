// Return the X Y Rotation of an object by its VectorDirAndUp
params [
		["_obj", objNull]
	];
	
private ["_xRot","_yRot"];

(vectorUp _obj) params ["_up0", "_up1", "_up2"];
(vectorDir _obj vectorCrossProduct vectorUp _obj) params ["", "_aside1", "_aside2"];

if (abs _up0 < 0.999999) then {
	_yRot = -asin _up0;
	private _signCosY = if (cos _yRot < 0) then {-1} else {1};
	_xRot = (_up1 * _signCosY) atan2 (_up2 * _signCosY);
} else {
	if (_up0 < 0) then {
		_yRot = 90;
		_xRot = _aside1 atan2 _aside2;
	} else {
		_yRot = -90;
		_xRot = (-_aside1) atan2 (-_aside2);
	};
};	

[_xRot,_yRot]