params [["_building", objNull, [objNull]]];

private _isVanilla = true;
private _furnitureArray = [];

private _detectionBox = boundingBoxReal _building;
_detectionBox params ["_p1", "_p2"];
private _detectionRadius = vectorMagnitude (_p1 vectorDiff _p2);
private _furniture = nearestObjects [position _building, [], _detectionRadius];

private _centerPosWorld = getPosWorld _building;
private _centerVecDir = vectorDir _building;
private _centerVecUp =  vectorUp _building;
private _centerVecPer = _centerVecDir vectorCrossProduct _centerVecUp;
private _standard_to_internal = [_centerVecDir, _centerVecUp, _centerVecPer];
{
	private _type = typeOf _x;
	if (_x != _building and not (isObjectHidden _x) and not (_type in ["","HouseFly","HoneyBee","ButterFly_random","Mosquito","Sign_Arrow_Large_Green_F","CamCurator"]) and (_type select [0,1 ] != "#") and not (_x isKindOf "Animal") and not (_x isKindOf "Man") and not (_x isKindOf "Logic")) then
	{
		private _isInsideDetectionBox = true;
		private _posWorld = getPosWorld _x;
		{if (_x < (_detectionBox select 0 select _forEachIndex) or _x > (_detectionBox select 1 select _forEachIndex)) exitWith {_isInsideDetectionBox = false}} forEach (_building worldToModel getPosATL _x);
		if (_isInsideDetectionBox) then
		{
			if !(_type call ZEI_fnc_isVanillaObject) then {_isVanilla = false};
			
			private _relPos = [_standard_to_internal, _posWorld vectorDiff _centerPosWorld] call Achilles_fnc_vectorMap;
			private _relVecDir = [_standard_to_internal, vectorDir _x] call Achilles_fnc_vectorMap;
			private _relVecUp = [_standard_to_internal, vectorUp _x] call Achilles_fnc_vectorMap;
			private _textures = getObjectTextures _x;
			private _materials = getObjectMaterials _x;
			if (isNil "_textures") then {_textures = []};
			if (isNil "_materials") then {_materials = []};
			_furnitureArray pushBack [_type, _relPos, _relVecDir, _relVecUp, _textures, _materials];
		};
	};
} forEach _furniture;

[_isVanilla, _furnitureArray];
