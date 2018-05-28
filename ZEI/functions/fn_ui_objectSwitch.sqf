params [
		["_type", 0],
		["_searchRadius", 50]
	];
		
// Need to pass logic pos info to GUI somehow?
_pos = missionNamespace getVariable ["ZEI_LastPos", [0,0,0]];

[format["Passed: Type: %1 - Radius: %2 - Pos: %3", _type, _searchRadius, _pos], "DEBUG"] call ZEI_fnc_misc_logMsg;

_nearObjects = nearestObjects [_pos, [], _searchRadius, true]; 

_typeVanilla = 	["Land_BagFence_Corner_F", "Land_BagFence_Long_F", "Land_BagFence_Short_F", "Land_BagFence_End_F", "Land_BagFence_Round_F", "CamoNet_BLUFOR_F", "CamoNet_BLUFOR_open_F", "CamoNet_BLUFOR_big_F", "CamoNet_OPFOR_F", "CamoNet_OPFOR_open_F", "CamoNet_OPFOR_big_F", "Land_HBarrier_1_F", "Land_HBarrier_3_F", "Land_HBarrier_5_F", "Land_HBarrier_Big_F", "Land_BagBunker_Small_F", "Land_BagBunker_Large_F", "Land_BagBunker_Tower_F", "Land_Cargo_Patrol_V3_F", "Land_Cargo_House_V3_F", "Land_Cargo_HQ_V3_F", "Land_Cargo_Tower_V3_F"];
_typeAPEX = ["Land_BagFence_01_corner_green_F","Land_BagFence_01_long_green_F","Land_BagFence_01_short_green_F","Land_BagFence_01_end_green_F","Land_BagFence_01_round_green_F", "CamoNet_BLUFOR_F", "CamoNet_BLUFOR_open_F", "CamoNet_BLUFOR_big_F", "CamoNet_ghex_F", "CamoNet_ghex_open_F", "CamoNet_ghex_big_F", "Land_HBarrier_01_line_1_green_F", "Land_HBarrier_01_line_3_green_F", "Land_HBarrier_01_line_5_green_F", "Land_HBarrier_01_big_4_green_F", "Land_BagBunker_01_small_green_F", "Land_BagBunker_01_large_green_F", "Land_HBarrier_01_tower_green_F", "Land_Cargo_Patrol_V4_F", "Land_Cargo_House_V4_F", "Land_Cargo_HQ_V4_F", "Land_Cargo_Tower_V4_F"];
_typeCUP_D = ["Land_BagFenceCorner", "Land_BagFenceLong", "Land_BagFenceShort", "Land_BagFenceEnd", "Land_BagFenceRound", "Land_CamoNet_NATO_EP1", "Land_CamoNetVar_NATO_EP1", "Land_CamoNetB_NATO_EP1", "Land_CamoNet_EAST_EP1", "Land_CamoNetVar_EAST_EP1", "Land_CamoNetB_EAST_EP1", "Land_HBarrier1", "Land_HBarrier3", "Land_HBarrier5", "Land_HBarrier_large", "Land_fortified_nest_small_EP1", "Land_fortified_nest_big_EP1", "Land_Fort_Watchtower_EP1", "Land_Cargo_Patrol_V3_F", "Land_Cargo_House_V3_F", "Land_Cargo_HQ_V3_F", "Land_Cargo_Tower_V3_F"];
_typeCUP_W = ["Land_BagFenceCorner", "Land_BagFenceLong", "Land_BagFenceShort", "Land_BagFenceEnd", "Land_BagFenceRound", "Land_CamoNet_NATO", "Land_CamoNetVar_NATO", "Land_CamoNetB_NATO", "Land_CamoNet_EAST", "Land_CamoNetVar_EAST", "Land_CamoNetB_EAST", "Land_HBarrier_1_F", "Land_HBarrier_3_F", "Land_HBarrier_5_F", "Land_HBarrier_Big_F", "Fort_Nest", "Land_fortified_nest_big", "Land_Fort_Watchtower", "Land_Cargo_Patrol_V1_F", "Land_Cargo_House_V1_F", "Land_Cargo_HQ_V1_F", "Land_Cargo_Tower_V1_F"];

_searchType = [];
_replaceType = [];

switch (_type) do {
	case 0: {
		_replaceType = _typeVanilla;
		_searchType = [_typeAPEX, _typeCUP_D, _typeCUP_W];
	};
	case 1: {
		_replaceType = _typeAPEX;
		_searchType = [_typeVanilla, _typeCUP_D, _typeCUP_W];
	};
	case 2: {
		_replaceType = _typeCUP_D;
		_searchType = [_typeVanilla, _typeAPEX, _typeCUP_W];
	};
	case 3: {
		_replaceType = _typeCUP_W;
		_searchType = [_typeVanilla, _typeAPEX, _typeCUP_D];
	};
};

if (count _replaceType == 0) exitWith { 
	["No objects loaded to replace.", "ERROR"] call ZEI_fnc_misc_logMsg;
};

_toReplace = [];

// Iterate array of found objects in the radius.
{	
	_foundObj = _x;
	_foundType = typeOf _x;
	_isFound = FALSE;
	
	// Iterate array containing searchable objects.
	{
		_searchArr = _x;
		
		if (_isFound) exitWith {};
		
		// Iterate array for any matches.
		{		
			if (isClass (configFile >> "CfgVehicles" >> _x)) then {
				// Get correct class name for string comparison
				_searchObj = configName (configFile >> "CfgVehicles" >> _x);
				
				if (_foundType isEqualTo _searchObj) exitWith {
					// Pull replacement from array
					_replaceClass = _replaceType select _forEachIndex;

					// Add to the replacements list.
					if (isClass (configFile >> "CfgVehicles" >> _replaceClass)) then {
						if (_foundType != (configName (configFile >> "CfgVehicles" >> _replaceClass))) then {
							_toReplace pushBack [_foundObj, _replaceClass];
						};
					};
					
					_isFound = TRUE;
				};
			};
		} forEach _searchArr;
	} forEach _searchType;
} forEach _nearObjects;

if (count _toReplace == 0) exitWith { 
	["No objects to replace.", "INFO"] call ZEI_fnc_misc_logMsg;
};

_count = 0;

if (is3DEN) then {
	collect3DENHistory {
		{ 
			_x params ["_original", "_replacement"];
			[_original] set3DENObjectType _replacement;
		} forEach _toReplace;
	};
} else {
	{ 
		_x params ["_original", "_replacement"];
		_obj = createVehicle [_replacement, getPosATL _original, [], 0, "CAN_COLLIDE"];
		_obj setVectorDirAndUp [vectorDir _original, vectorUp _original];
		deleteVehicle _original;
	} forEach _toReplace;
};

[format["Converted %1 Objects", count _toReplace], "INFO"] call ZEI_fnc_misc_logMsg;