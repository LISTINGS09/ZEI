/*
Rotate an object around each axis
By bapedibupa

Parameters: [object, [x,y,z]]
Returns: nothing

Rotates an object, giving it the specified rotation angle around each axis, in degrees.

The rotation is about the world coordinates. When the object you want to rotate is attached to another object, it rotates relative to this coordinates (it doesent rotates around the axis from the rotating object).

A positive number rotates the object in positive axis rotation. Negative numbers in the other direction.
Positive axis rotation means when you take your right hand, make a fist and spread out your thumb, make sure that the thumb is heading in positive axis direction: Your other fingers show you now the positive rotation around this axis.

Default value [0,0,0] make the object face straight north.
If you want to face it straight west so you want it to turn 90Â° in positive axis rotation around Z. Your array parameters should look like this [0,0,90].
If you want to face it straight east so you want it to turn 90Â° in negative axis rotation around Z. Your array parameters should look like this [0,0,-90].
All axis work in the same way. Sure you can do this with the setDir command, but not in 3D.

You also can combine a rotation around X, Y and Z. But then you need a good visual thinkimg or the trial and error methode ;) Note, that the object rotates first around X, then Y and in the end Z.

This function is useful when you want to place an object on the map or on a attached object in the direction you want. If you use it in combination with attachTo use first the attachTo command an then this function.

If you want to use this function just to look which parameters you should fill in the setVectorDirAndUp command (whenever you use it), just uncomment the hintSilent in the end and you can see the parameters in the game.

Example: [object[45,0,-90]] call rotateObject; // rotates 45Â° back and 90Â° right (east).
*/

_object = _this select 0;
_rotations = _this select 1;

_aroundX = _rotations select 0;
_aroundY = _rotations select 1;
_aroundZ = _rotations select 2;

// set default values
_dirX = 0;
_dirY = 1;
_dirZ = 0;

_upX = 0;
_upY = 0;
_upZ = 1;

// rotate around X
if (_aroundX != 0) then {
	_dirY = cos _aroundX;
	_dirZ = sin _aroundX;

	_upY = -sin _aroundX;
	_upZ = cos _aroundX;
};

// rotate around Y
if (_aroundY != 0) then {
	_dirX = _dirZ * sin _aroundY;
	_dirZ = _dirZ * cos _aroundY;

	_upX = _upZ * sin _aroundY;
	_upZ = _upZ * cos _aroundY;
};

// rotate around Z
if (_aroundZ != 0) then {
	_dirXTemp = _dirX;
	_dirX = (_dirY * -sin _aroundZ) + (_dirXTemp* cos _aroundZ);
	_dirY = (_dirY * cos _aroundZ) + (_dirXTemp * sin _aroundZ);

	_upXTemp = _upX;
	_upX = (_upY * -sin _aroundZ) + (_upXTemp * cos _aroundZ);
	_upY = (_upY * cos _aroundZ) + (_upXTemp * sin _aroundZ);
};

// round
_dirX = [_dirX,3] call BIS_fnc_cutDecimals;
_dirY = [_dirY,3] call BIS_fnc_cutDecimals;
_dirZ = [_dirZ,3] call BIS_fnc_cutDecimals;

_upX = [_upX,3] call BIS_fnc_cutDecimals;
_upY = [_upY,3] call BIS_fnc_cutDecimals;
_upZ = [_upZ,3] call BIS_fnc_cutDecimals;

// set vector dir and up
_dir = [_dirX,_dirY,_dirZ];
_up = [_upX,_upY,_upZ];

//hintSilent format ["dir: %1 up: %2",_dir,_up];

_object setVectorDirAndUp [_dir,_up];