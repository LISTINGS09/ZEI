// Called from ZEI_fnc_createTemplate
params ["_item", "_detailLevel"];

// If the detailLevel is at maximum, just exitWith true to save time
if( _detailLevel == 1) exitWith { TRUE };

private _classList = switch(_detailLevel) do {
	case 0: { ["BagFence_base_F", "BagBunker_base_F", "Land_Shoot_House_Wall_F"] };
	
	// TODO: Could be expanded with intermediate detail levels, e.g.:
	// case 1: { ["Building"] };

	default { ["All"] };
};

_classList findIf { _item isKindOf [_x, configFile >> "CfgVehicles"] } != -1