// Add custom items to Zeus.
sleep 1; // Display needs time to init.

if (isNull findDisplay 312) exitWith { 
	["Failed to add Modules - Zeus Display not found!", "ERROR"] call ZEI_fnc_misc_logMsg;
};

// Get the UI control
_display = findDisplay 312; // IDD_RSCDISPLAYCURATOR
_ctrl = _display displayCtrl 280; // IDC_RSCDISPLAYCURATOR_CREATE_MODULES

// Get all Vanilla Categories
_category_list = [];
for "_i" from 0 to ((_ctrl tvCount []) - 1) do { _category_list pushBack (_ctrl tvText [_i]) };

// Generate the data for the modules
{
	// Only add modules that define themselves in the "Ares" category
		_className = _x;
		_categoryName = getText (configFile >> "CfgFactionClasses" >> (getText (configFile >> "CfgVehicles" >> _className >> "category")) >> "displayName");
		_displayName = getText (configFile >> "CfgVehicles" >> _className >> "displayName");
		_icon = getText (configFile >> "CfgVehicles" >> _className >> "icon");
		
		[format["Adding Module: %1 %2 %3 %4", _className, _displayName, _categoryName, _icon], "DEBUG"] call ZEI_fnc_misc_logMsg;
		
		_categoryIndex = _category_list find _categoryName;

		// Add categories if it does not already exist
		if (_categoryIndex isEqualTo -1) then {
			private _tvBranch = _ctrl tvAdd [[], _categoryName];
			_ctrl tvSetData [[_tvBranch], ""];
			_categoryIndex = count _category_list;
			_category_list pushBack _categoryName;
		};

		private _moduleIndex = _ctrl tvAdd [[_categoryIndex], _displayName];
		_ctrl tvSetData [[_categoryIndex, _moduleIndex], _className];
		_ctrl tvSetPicture [[_categoryIndex, _moduleIndex], _icon];
		_ctrl tvSetValue [[_categoryIndex, _moduleIndex], _forEachIndex];
} forEach (getArray (configFile >> "cfgPatches" >> "ZEI" >> "units") select {getNumber (configFile >> "CfgVehicles" >> _x >> "scopeCurator") == 2});

// Resort Control + Children
_ctrl tvSort [[], FALSE];
for "_i" from 0 to ((_ctrl tvCount []) - 1) do {_ctrl tvSort [[_i], FALSE];};
