params ["_type", "_data"];

(_data splitString ": ") params ["_bld", "_template"];
_template = parseSimpleArray _template;

if ((_type isEqualTo TRUE && {_type}) || (_type isEqualTo "" && {_type == "civ"})) then {
	if (isNil "ZEI_civ_customBuildings") then {ZEI_civ_customBuildings = []};
	private _path = [ZEI_civ_customBuildings, _bld] call BIS_fnc_findNestedElement;
	
	if !(_path isEqualTo []) then {
		((ZEI_civ_customBuildings # (_path # 0)) # 1) pushBackUnique _template;
	} else {
		ZEI_civ_customBuildings pushBackUnique [_bld, [_template]];
	};
} else {
	if (isNil "ZEI_mil_customBuildings") then {ZEI_mil_customBuildings = []};
	private _path = [ZEI_mil_customBuildings, _bld] call BIS_fnc_findNestedElement;
	
	if !(_path isEqualTo []) then {
		((ZEI_mil_customBuildings # (_path # 0)) # 1) pushBackUnique _template;
	} else {
		ZEI_mil_customBuildings pushBackUnique [_bld, [_template]];
	};
};
