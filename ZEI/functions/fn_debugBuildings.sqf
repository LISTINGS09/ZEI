params [
		["_mode", "", [""]],
		["_input", [], [[]]]
	];
	
switch _mode do {
	case "init": {
		_input params [["_logic",objNull,[objNull]],["_isActivated",true,[true]], ["_isCuratorPlaced",false,[true]]];
		
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (is3DEN) then { delete3DENEntities [_logic] } else { deleteVehicle _logic };
		};
		
		if (worldName != "VR") exitWith {systemChat "[ERROR] You must be in the VR world to use this module."};
		
		// TODO: Add GUI to allow category selection for output of objects in chosen 'editorCategory' and 'editorSubcategory'?
		// TODO: Remove Ruins?
		
		_configs = "configName _x isKindof 'Building' && getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgVehicles"); 
		_classNames = _configs apply {configName _x}; 
		_classNames = _classNames select {toLower _x find "ruin" < 0};
		 
		_count = 0;
		_orgX = 1000; 
		_orgY = 1000; 
		_posX = _orgX; 
		_posY = _orgY; 
		 
		{ 
			//if (_count > 10) exitWith {};
			_bld = objNull;
			
			if (is3DEN) then {
				_bld = create3DENEntity ["Object", _x, [_posX, _posY, 0], true];
			} else {
				_bld = _x createVehicle [_posX, _posY]; 
			};
			
			if (count (_bld buildingPos -1) > 0) then {
				// Output markers for templates
				diag_log text format["Created: %1", _x];
				
				_civTemplates = [_bld, FALSE, !is3DEN, TRUE, TRUE] call ZEI_fnc_createTemplate;
				if (_civTemplates > 0) then {
					for "_i" from 1 to _civTemplates do {
						_tmpPos = [_posX + (_i * 2), _posY - (abs (((boundingBox _bld) select 1) select 0)) - 10, 0];
						if (is3DEN) then {
							_tmp = create3DENEntity ["Object", "Sign_Arrow_Large_Pink_F", _tmpPos, true];
						} else {
							_tmp = "Sign_Arrow_Large_Pink_F" createVehicle _tmpPos; 
						};
					};
				};
				
				_milTemplates = [_bld, FALSE, !is3DEN, FALSE, TRUE] call ZEI_fnc_createTemplate;
				if (_milTemplates > 0) then {
					for "_i" from 1 to _milTemplates do {
						_tmpPos = [_posX + (_i * 2), _posY - (abs (((boundingBox _bld) select 1) select 0)) - 15, 0];
						if (is3DEN) then {
							_tmp = create3DENEntity ["Object", "Sign_Arrow_Large_F", _tmpPos, true];
						} else {
							_tmp = "Sign_Arrow_Large_F" createVehicle _tmpPos; 
						};
					};
				};
				
				
				_count = _count + 1;
				_posX = _posX + 75; 

				if (_count %30 == 0) then {  
					_posX = _orgX; 
					_posY = _orgY + (_count * 10); 
				};
			} else {
				if (is3DEN) then {
					delete3DENEntities [_bld];
				} else {
					deleteVehicle _bld; 
				};
			};
		} forEach _classNames;
		
		systemChat format["Output %1 buildings with positions.", _count];
	};
};