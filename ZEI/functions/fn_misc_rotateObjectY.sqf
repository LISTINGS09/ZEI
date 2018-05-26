/*
Rotate object in x,y,z
By bapedibupa

Parameters: [object,angle]
Returns: nothing

Rotates an object, giving it the specified rotation angle around a choosen axis, in degrees.

The rotation is about the world coordinates. When the object you want to rotate is attached to another object, it rotates relative to this coordinates (it doesent rotates around the axis from the rotating object).

A positive number rotates the object in positive axis rotation. Negative numbers in the other direction.
Positive axis rotation means when you take your right hand, make a fist and spread out your thumb, make sure that the thumb is heading in positive axis direction: Your other fingers show you now the positive rotation around this axis.

All 3 functions rotate the object relative to its previous direction. You also can combine all 3 functions togheter by calling one funtion after the other. You even can use the same function twice whenever needed.

If you use the functions in combination with attachTo use first the attachTo command an then this functions.

Never Use setDir after one of this funtions, it resets previous direction.

Example:	[object, 45] call rotateObjectX;	// the object turn 45Â° back
		[object, -90] call rotateObjectZ;	// the object turn 90Â° right (east), but still hanging 45Â°back


*/

// find object and rotation angle
_object = _this select 0;
_angle = _this select 1;

// get current vector dir and up
_dir = vectorDir _object;
_up = vectorUp _object;

// split into x,y,z
_dirX = _dir select 0;
_dirY = _dir select 1;
_dirZ = _dir select 2;

_upX = _up select 0;
_upY = _up select 1;
_upZ = _up select 2;

// calculate new values
_dirXTemp = _dirX;
_dirX = (_dirZ * sin _angle) + (_dirXTemp * cos _angle);
_dirZ = (_dirZ * cos _angle) + (_dirXTemp * -sin _angle);

_upXTemp = _upX;
_upX = (_upZ * sin _angle) + (_upXTemp * cos _angle);
_upZ = (_upZ * cos _angle) + (_upXTemp * -sin _angle);

// set vetor dir and up
_object setVectorDirAndUp [[_dirX,_dirY,_dirZ],[_upX,_upY,_upZ]];