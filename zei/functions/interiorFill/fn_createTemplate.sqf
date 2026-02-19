// Called from ZEI_fnc_ui_interiorFill
params [
		["_bld", objNull],
		["_fillType", "mil"],
		["_fillArea", false],
		["_addZeus", true],
		["_allowDamage", false],
		["_detail", 1]
	];

[format ["fn_createTemplate - Start - B: %1 T: %2 A: %3 Z: %4 D: %5 M: %6", _bld, _fillType, _fillArea, _addZeus, _allowDamage, _detail], "DEBUG"] call ZEI_fnc_misc_logMsg;
	
// Skip previously processed houses
if (isNull _bld || !isNull (_bld getVariable ["zei_furnished", objNull])) exitWith {};

private _templates = [];

_templates = [_bld, _fillType, _fillArea] call ZEI_fnc_findTemplates;

// Furnish house if list is assigned and no people inside
if !(_templates isEqualTo []) then {

	// Non-random template selection
	if (isNil "zei_counter") then {zei_counter = 0};
	if (zei_counter >= count _templates) then {zei_counter = 0};
	private _items = _templates select zei_counter;  
	zei_counter = zei_counter + 1;
	
	// Random template selection
	//_items = selectRandom _templates;
				
	// Spawn items depending on Zeus/Eden
	private _obj = objNull; // Used to track Undo in Eden.
		
	if (is3DEN) then {
		// TODO: Doesn't work in Eden? Find alternative method.
		// _bld set3DENAttribute ["allowDamage", false]; 
		
		{ 
			_x params ["_item", "_offset", ["_angle", 0], ["_rot", [0, 0, 0]]]; 
			_item = [_item] call ZEI_fnc_randomiseObject;

			if (_item != "" && ([_item, _detail] call ZEI_fnc_checkDetailLevel) ) then {
				_obj = create3DENEntity ["Object", _item, [0,0,0], true]; 
				_obj set3DENAttribute ["objectIsSimple", true]; 
				_obj setVectorDirAndUp [vectorDir _bld, vectorUp _bld];
				
				// BIS_fnc_rotateVector3D?
				if !(_rot isEqualTo [0,0,0]) then { 
					//_obj setVectorDirAndUp ([[vectorDir _bld, vectorUp _bld], (_rot select 0)*-1, (_rot select 1)*-1, (_rot select 2)*-1] call BIS_fnc_transformVectorDirAndUp);
				
					// Apply further rotation to object. 
					[_obj, (_rot select 0)*-1] call ZEI_fnc_rotateAroundOwnAxisX;
					[_obj, (_rot select 1)*-1] call ZEI_fnc_rotateAroundOwnAxisY; 
					[_obj, (_rot select 2)*-1] call ZEI_fnc_rotateAroundOwnAxisZ;
				} else {
					//_obj setVectorDir ([vectorDir _obj, _angle*-1, 2] call BIS_fnc_rotateVector3D);
					[_obj, _angle*-1] call ZEI_fnc_rotateAroundOwnAxisZ;
				};
				
				private _rotFinal = [_obj] call ZEI_fnc_misc_Vector2Eden;
				_obj set3DENAttribute ["rotation", _rotFinal];
								
				_pos = (_bld modelToWorld _offset);
				
				if (surfaceIsWater _pos) then {
					_obj set3DENAttribute ["position", ASLToATL _pos];
				} else {
					_obj set3DENAttribute ["position",_pos];
				};
			};
		} forEach _items;		
	} else {
		// Stop floating items when building is destroyed.
		if !(_allowDamage) then { [_bld, false] remoteExecCall ["allowDamage", _bld]; };

		{ 
			_x params ["_item", "_offset", ["_angle", 0], ["_rot", [0, 0, 0]]];
			_item = [_item] call ZEI_fnc_randomiseObject;
			
			if (_item != "" && ([_item, _detail] call ZEI_fnc_checkDetailLevel) ) then {
				if (_addZeus) then {
					_obj = createVehicle [_item, (_bld modelToWorld _offset), [], 0, "CAN_COLLIDE"];
					[_obj, false] remoteExec ["enableSimulationGlobal", 2];
					{ [_x, [ [_obj], true]] remoteExec ["addCuratorEditableObjects", 2] } forEach allCurators;
				} else {
					_obj = createSimpleObject [_item, AGLtoASL (_bld modelToWorld _offset)];
				};
				
				_obj setVectorDirAndUp [vectorDir _bld, vectorUp _bld];
				
				if !(_rot isEqualTo [0,0,0]) then { 
				
					[[vectorDirVisual uav, vectorUpVisual uav], 0, 0, 90] call BIS_fnc_transformVectorDirAndUp;
					// Apply further rotation to object. 
					[_obj, (_rot select 0)*-1] call ZEI_fnc_rotateAroundOwnAxisX;
					[_obj, (_rot select 1)*-1] call ZEI_fnc_rotateAroundOwnAxisY; 
					[_obj, (_rot select 2)*-1] call ZEI_fnc_rotateAroundOwnAxisZ;
				} else {
					[_obj, _angle*-1] call ZEI_fnc_rotateAroundOwnAxisZ;
				};
			};
		} forEach _items;
	};
	
	_bld setVariable ["zei_furnished", _obj];
};