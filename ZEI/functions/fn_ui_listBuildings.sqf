params [
		["_filter", 0],
		["_fCount", 15],
		["_showBP", FALSE]
	];

systemChat format["Passed: Filter: %1 - Empty: %2 - BP: %3", _filter, _fCount, _showBP];
diag_log format["Passed: Filter: %1 - Empty: %2 - BP: %3", _filter, _fCount, _showBP];

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
			_tmp = create3DENEntity ["Object", _className, _tmpPos, TRUE];
		} else {
			_tmp = _className createVehicle _tmpPos; 
		};
	};
};
 
{ 
	_bld = objNull;
	_skip = FALSE;
	
	if (is3DEN) then {
		_bld = create3DENEntity ["Object", _x, [_posX, _posY, 0], TRUE];
	} else {
		_bld = _x createVehicle [_posX, _posY]; 
	};
	
	// If building has positions check if it has got matching templates.
	if (count (_bld buildingPos -1) > 0) then {
		_civTemplates = [_bld, FALSE, !is3DEN, TRUE, TRUE] call ZEI_fnc_createTemplate;
		_milTemplates = [_bld, FALSE, !is3DEN, FALSE, TRUE] call ZEI_fnc_createTemplate;
		
		switch (_filter) do {
			// Civilian Only
			case 1: {
				if (_civTemplates > _fCount) then { 
					_skip = TRUE;
				} else {
					[_civTemplates, _bld, 10, "Sign_Arrow_Large_Pink_F"] spawn _fnc_createTemplateMarker
				};
			};
						
			// Military Only
			case 2: {
				if (_milTemplates > _fCount) then { 
					_skip = TRUE;
				} else {
					[_milTemplates, _bld, 15, "Sign_Arrow_Large_F"] spawn _fnc_createTemplateMarker
				};
			};
			
			// All
			default {
				if (_civTemplates > _fCount || _milTemplates > _fCount) then {
					_skip = TRUE;
				} else {
					if (_civTemplates > 0) then { [_civTemplates, _bld, 10, "Sign_Arrow_Large_Pink_F"] spawn _fnc_createTemplateMarker };
					if (_milTemplates > 0) then { [_milTemplates, _bld, 15, "Sign_Arrow_Large_F"] spawn _fnc_createTemplateMarker };
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
		_skip = TRUE;
	};
	
	if (_skip) then {
		if (is3DEN) then {
			delete3DENEntities [_bld];
		} else {
			deleteVehicle _bld; 
		};
	};
} forEach _classNames;

systemChat format["Output %1 buildings with positions.", _count];