// Called from ZEI_fnc_ui_interiorFill
params [
		["_bld", objNull],
		["_fillType", "mil"],
		["_fillArea", FALSE],
		["_addZeus", TRUE],
		["_infoOnly", FALSE]
	];

// Skip previously processed houses
if (isNull _bld || !isNull (_bld getVariable ["zei_furnished", objNull])) exitWith {};

private _templates = [];

_templates = [_bld, _fillType, (_fillArea || _infoOnly)] call ZEI_fnc_findTemplates;

// Return the number of templates only (listBuildings module).
if (_infoOnly) exitWith { count _templates };

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
		_bld set3DENAttribute ["allowDamage", false]; // TODO: Doesn't work in Eden? Find alternative method.
		
		{ 
			_x params ["_item", "_offset", ["_angle", 0], ["_rot", [0, 0, 0]]]; 
			_item = [_item] call ZEI_fnc_randomiseObject; 
			_obj = create3DENEntity ["Object", _item, [0,0,0], TRUE]; 
			_obj set3DENAttribute ["objectIsSimple", TRUE]; 
			_obj setVectorDirAndUp [vectorDir _bld, vectorUp _bld];

			if !(_rot isEqualTo [0,0,0]) then { 
				// Apply further rotation to object. 
				[_obj, (_rot select 0)*-1] call ZEI_fnc_misc_rotateAroundOwnAxisX;
				[_obj, (_rot select 1)*-1] call ZEI_fnc_misc_rotateAroundOwnAxisY; 
				[_obj, (_rot select 2)*-1] call ZEI_fnc_misc_rotateAroundOwnAxisZ;
			} else {
				[_obj, _angle*-1] call ZEI_fnc_misc_rotateAroundOwnAxisZ;
			};
			
			_obj set3DENAttribute ["rotation", [_obj] call ZEI_fnc_misc_Vector2Eden]; 
			_obj set3DENAttribute ["position", (_bld modelToWorld _offset)]; 
		} forEach _items;		
	} else {
		[_bld, false] remoteExecCall ["allowDamage", _bld]; // Stop floating items when building is destroyed.

		{ 
			_x params ["_item", "_offset", ["_angle", 0], ["_rot", [0, 0, 0]]];
			_item = [_item] call ZEI_fnc_randomiseObject;
			
			if (_addZeus) then {
				_obj = createVehicle [_item, (_bld modelToWorld _offset), [], 0, "CAN_COLLIDE"];
				_obj enableSimulationGlobal FALSE;
				{ _x addCuratorEditableObjects [[_obj],TRUE] } forEach allCurators;
			} else {
				_obj = createSimpleObject [_item, AGLtoASL (_bld modelToWorld _offset)];
			};
			
			_obj setVectorDirAndUp [vectorDir _bld, vectorUp _bld];
			
			if !(_rot isEqualTo [0,0,0]) then { 
				// Apply further rotation to object. 
				[_obj, (_rot select 0)*-1] call ZEI_fnc_misc_rotateAroundOwnAxisX;
				[_obj, (_rot select 1)*-1] call ZEI_fnc_misc_rotateAroundOwnAxisY; 
				[_obj, (_rot select 2)*-1] call ZEI_fnc_misc_rotateAroundOwnAxisZ;
			} else {
				[_obj, _angle*-1] call ZEI_fnc_misc_rotateAroundOwnAxisZ;
			};
			
			
		} forEach _items;
	};
	
	_bld setVariable ["zei_furnished", _obj];
};