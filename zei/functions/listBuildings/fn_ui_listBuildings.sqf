params [
		["_filter", 0],
		["_fCount", 15],
		["_showBP", false]
	];
	
_configs = "configName _x isKindof 'Building' && getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgVehicles"); 
_classNames = _configs apply {configName _x}; 
_classNames = _classNames select {toLower _x find "ruin" < 0}; // Remove Ruins
 
_count = 0;
_orgX = 1000; 
_orgY = 1000; 
_posX = _orgX; 
_posY = _orgY; 

_fnc_createTemplateMarker = {
	_this params ["_counter", "_building", "_offset", "_className"];
	
	for "_i" from 1 to _counter do {
		_tmpPos = [(getPos _building select 0) + (_i * 2), (getPos _building select 1) - (abs (((boundingBox _building) select 1) select 0)) - _offset, 0];
		
		if (is3DEN) then {
			_tmp = create3DENEntity ["Object", _className, _tmpPos, true];
		} else {
			_tmp = _className createVehicle _tmpPos; 
		};
	};
};

[format["Processing %1 Classes.", count _classNames], "INFO"] call ZEI_fnc_misc_logMsg;
 
{ 
	_bld = objNull;
	_skip = false;
	
	if (is3DEN) then {
		_bld = create3DENEntity ["Object", _x, [_posX, _posY, 0], true];
	} else {
		_bld = _x createVehicle [_posX, _posY]; 
	};
	
	// If building has positions check if it has got matching templates.
	if (count (_bld buildingPos -1) > 0) then {
		
		private _type = ["all","mil","cbrn","civ"] select _filter;
	
		private _milCount = count ([_bld, "mil", true] call ZEI_fnc_findTemplates);
		private _cbrCount = count ([_bld, "cbrn", true] call ZEI_fnc_findTemplates);
		private _civCount = count ([_bld, "civ", true] call ZEI_fnc_findTemplates);
		
				
		switch (_type) do {
			// Military Only
			case "mil": {
				if (_milCount > _fCount) then { 
					_skip = true;
				} else {
					[_milCount, _bld, 15, "Sign_Arrow_Large_F"] spawn _fnc_createTemplateMarker
				};
			};
			// CBRN Only
			case "cbrn": {
				if (_cbrCount > _fCount) then { 
					_skip = true;
				} else {
					[_cbrCount, _bld, 20, "Sign_Arrow_Large_Yellow_F"] spawn _fnc_createTemplateMarker
				};
			};
			// Civilian Only
			case "civ": {
				if (_civCount > _fCount) then { 
					_skip = true;
				} else {
					[_civCount, _bld, 10, "Sign_Arrow_Large_Pink_F"] spawn _fnc_createTemplateMarker
				};
			};
			// All
			default {
				if (_civCount > _fCount || _milCount > _fCount) then {
					_skip = true;
				} else {
				


					if (_civCount > 0) then { [_civCount, _bld, 10, "Sign_Arrow_Large_Pink_F"] spawn _fnc_createTemplateMarker };
					if (_cbrCount > 0) then { [_cbrCount, _bld, 20, "Sign_Arrow_Large_Yellow_F"] spawn _fnc_createTemplateMarker };
					if (_milCount > 0) then { [_milCount, _bld, 15, "Sign_Arrow_Large_F"] spawn _fnc_createTemplateMarker };
				};
			};
		};
		
		// Highlight building positions
		if (!_skip && _showBP) then {
			{		
				private _obj = create3DENEntity ["Object", "Sign_Arrow_Large_Green_F", [0, 0, 0]];
				_obj set3DENAttribute ["rotation", [ 0, 0, 0]];
				_obj set3DENAttribute ["position", _x];
			} forEach (_bld buildingPos -1);
		};
		
		// Delete the object or move along.
		if (!_skip) then {
			_count = _count + 1;
			_posX = _posX + 75; 

			if (_count %75 == 0) then {  
				_posX = _orgX; 
				_posY = _orgY + (_count * 10); 
			};
		};
	} else {
		_skip = true;
	};
	
	if (_skip) then {
		if (is3DEN) then {
			delete3DENEntities [_bld];
		} else {
			deleteVehicle _bld; 
		};
	};
} forEach _classNames;

[format["Output %1 buildings with positions.", _count], "INFO"] call ZEI_fnc_misc_logMsg;