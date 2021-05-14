// Add custom items to Zeus.
// Display needs time to init.
waitUntil {!isNull ((findDisplay 312) displayCtrl 280)};

// Get the UI control
//_display = findDisplay 312; // IDD_RSCDISPLAYCURATOR
// _ctrl = _display displayCtrl 280; // IDC_RSCDISPLAYCURATOR_CREATE_MODULES
private _ctrl = (findDisplay 312) displayCtrl 280; // IDC_RSCDISPLAYCURATOR_CREATE_MODULES

// Get all Vanilla Categories
private _doSort = false;
private _category_list = [];
for "_i" from 0 to ((_ctrl tvCount []) - 1) do { _category_list pushBack (_ctrl tvText [_i]) };

// Generate the data for the modules
{
	// Only add modules that define themselves in the "Ares" category
		private _className = _x;
		private _categoryName = getText (configFile >> "CfgFactionClasses" >> (getText (configFile >> "CfgVehicles" >> _className >> "category")) >> "displayName");
		private _displayName = getText (configFile >> "CfgVehicles" >> _className >> "displayName");
		private _icon = getText (configFile >> "CfgVehicles" >> _className >> "icon");
		
		[format["Checking Module: %1 %2 %3 %4", _className, _displayName, _categoryName, _icon], "DEBUG"] call ZEI_fnc_misc_logMsg;
		
		private _categoryIndex = _category_list find _categoryName;

		// Add category if it does not already exist
		if (_categoryIndex isEqualTo -1) then {
			private _tvBranch = _ctrl tvAdd [[], _categoryName];
			_ctrl tvSetData [[_tvBranch], ""];
			_categoryIndex = count _category_list;
			_category_list pushBack _categoryName;
			_doSort = true;
		};
		
		private _module_list = [];
		for "_i" from 0 to ((_ctrl tvCount [_categoryIndex]) - 1) do { _module_list pushBack (_ctrl tvText [_categoryIndex, _i]) };
		
		private _moduleIndex = _module_list find _displayName;
		
		// Add module if it does not already exist
		if (_moduleIndex isEqualTo -1) then {
			private _tvModule = _ctrl tvAdd [[_categoryIndex], _displayName];
			_ctrl tvSetData [[_categoryIndex, _tvModule], _className];
			_ctrl tvSetPicture [[_categoryIndex, _tvModule], _icon];
			_ctrl tvSetValue [[_categoryIndex, _tvModule], _forEachIndex];
		};
} forEach (getArray (configFile >> "cfgPatches" >> "ZEI" >> "units") select {getNumber (configFile >> "CfgVehicles" >> _x >> "scopeCurator") == 2});

// Resort Control + Children
if (_doSort) then {
	_ctrl tvSort [[], false];
	for "_i" from 0 to ((_ctrl tvCount []) - 1) do { _ctrl tvSort [[_i], false] };
};