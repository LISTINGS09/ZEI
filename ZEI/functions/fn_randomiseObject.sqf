params ["_item", ["_doRandom", TRUE]];

private _objectsList = [];

// Pop array with vanilla replaceable objects.
_objectsList pushBack ["Land_Rug_01_Traditional_F","Land_Rug_01_F"];
_objectsList pushBack ["Land_GasTank_01_blue_F","Land_GasTank_01_yellow_F","Land_GasTank_01_khaki_F"];
_objectsList pushBack ["Land_FlowerPot_01_F","Land_FlowerPot_01_Flower_F"];
_objectsList pushBack ["Land_Sleeping_bag_brown_F","Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F"];
_objectsList pushBack ["Land_Sleeping_bag_blue_folded_F","Land_Sleeping_bag_brown_folded_F","Land_Sleeping_bag_folded_F"];
_objectsList pushBack ["Land_Ground_sheet_blue_F","Land_Ground_sheet_F","Land_Ground_sheet_khaki_F","Land_Ground_sheet_yellow_F"];
_objectsList pushBack ["Land_Ground_sheet_folded_blue_F","Land_Ground_sheet_folded_F","Land_Ground_sheet_folded_khaki_F","Land_Ground_sheet_folded_yellow_F"];
_objectsList pushBack ["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"];
_objectsList pushBack ["Land_ShelvesWooden_F","Land_ShelvesWooden_blue_F","Land_ShelvesWooden_khaki_F"];
_objectsList pushBack ["Fridge_01_open_F","Fridge_01_closed_F"];
_objectsList pushBack ["Land_MetalCase_01_small_F","Land_PlasticCase_01_small_gray_F","Land_PlasticCase_01_small_F","Land_PlasticCase_01_small_idap_F"];
_objectsList pushBack ["Land_MetalCase_01_medium_F","Land_PlasticCase_01_medium_gray_F","Land_PlasticCase_01_medium_F","Land_PlasticCase_01_medium_idap_F"];
_objectsList pushBack ["Land_MetalCase_01_large_F","Land_PlasticCase_01_large_gray_F","Land_PlasticCase_01_large_F","Land_PlasticCase_01_large_idap_F"];
_objectsList pushBack ["Land_Can_Rusty_F","Land_Can_V1_F","Land_Can_V2_F","Land_Can_V3_F","Land_TacticalBacon_F"];
_objectsList pushBack ["Land_PaperBox_01_small_closed_brown_F","Land_PaperBox_01_small_closed_brown_IDAP_F","Land_PaperBox_01_small_closed_white_med_F","Land_PaperBox_01_small_closed_white_IDAP_F","Land_PaperBox_01_small_closed_brown_food_F"];
_objectsList pushBack ["Land_PaperBox_01_open_boxes_F","Land_PaperBox_01_open_empty_F","Land_PaperBox_01_open_water_F","Land_PaperBox_open_empty_F","Land_PaperBox_open_full_F","Land_Pallet_MilBoxes_F","Land_Pallets_F","Land_Pallet_F"];
_objectsList pushBack ["Land_CanisterFuel_F","Land_CanisterFuel_Blue_F","Land_CanisterFuel_Red_F","Land_CanisterFuel_White_F"];
_objectsList pushBack ["Land_FoodContainer_01_White_F","Land_PlasticBucket_01_closed_F","Land_PlasticBucket_01_open_F","Land_FoodContainer_01_F"];
_objectsList pushBack ["Land_Bucket_painted_F","Land_Bucket_clean_F","Land_Bucket_F"];
_objectsList pushBack ["Land_BarrelEmpty_F","Land_BarrelEmpty_grey_F","Land_BarrelWater_F","Land_BarrelWater_grey_F","Land_Basket_F","Land_CanisterPlastic_F","Land_Sack_F","Land_MetalBarrel_empty_F"];
_objectsList pushBack ["Land_Basket_F","Land_CratesShabby_F","Land_Sacks_heap_F"];
_objectsList pushBack ["Land_WaterBottle_01_stack_F","Land_PaperBox_01_small_stacked_F"];
_objectsList pushBack ["Land_FoodSacks_01_large_brown_F","Land_FoodSacks_01_large_white_idap_F","Land_FoodSacks_01_large_brown_idap_F"];
_objectsList pushBack ["Land_Orange_01_F","Land_WaterBottle_01_empty_F","Land_WaterBottle_01_full_F","Land_BottlePlastic_V1_F","Land_Can_Rusty_F","Land_Can_V1_F","Land_Can_V2_F","Land_Can_V3_F","Land_TacticalBacon_F","Land_Can_Dented_F","Land_BottlePlastic_V2_F","Land_BakedBeans_F","Land_PowderedMilk_F","Land_RiceBox_F","Land_Tableware_01_stackOfNapkins_F","Land_Tableware_01_cup_F","Land_TinContainer_F"];
_objectsList pushBack ["Land_Cargo10_IDAP_F","Land_Cargo10_blue_F","Land_Cargo10_brick_red_F","Land_Cargo10_cyan_F","Land_Cargo10_grey_F","Land_Cargo10_light_blue_F","Land_Cargo10_light_green_F","Land_Cargo10_military_green_F","Land_Cargo10_orange_F","Land_Cargo10_red_F","Land_Cargo10_sand_F","Land_Cargo10_yellow_F","Land_Cargo10_white_F"];
_objectsList pushBack ["Land_Cargo20_IDAP_F","Land_Cargo20_blue_F","Land_Cargo20_brick_red_F","Land_Cargo20_cyan_F","Land_Cargo20_grey_F","Land_Cargo20_light_blue_F","Land_Cargo20_light_green_F","Land_Cargo20_military_green_F","Land_Cargo20_orange_F","Land_Cargo20_red_F","Land_Cargo20_sand_F","Land_Cargo20_yellow_F","Land_Cargo20_white_F"];
_objectsList pushBack ["Land_Cargo40_IDAP_F","Land_Cargo40_blue_F","Land_Cargo40_brick_red_F","Land_Cargo40_cyan_F","Land_Cargo40_grey_F","Land_Cargo40_light_blue_F","Land_Cargo40_light_green_F","Land_Cargo40_military_green_F","Land_Cargo40_orange_F","Land_Cargo40_red_F","Land_Cargo40_sand_F","Land_Cargo40_yellow_F","Land_Cargo40_white_F"];
_objectsList pushBack ["Land_WoodenCrate_01_stack_x5_F","Land_WoodenCrate_01_stack_x3_F"];
_objectsList pushBack ["Land_WoodenCrate_01_stack_x5_F","Land_WoodenCrate_01_stack_x3_F"];

// If CUP is active, add additional items.
if (isClass(configFile >> 'CfgPatches' >> 'CUP_Core')) then {
	_objectsList pushBack ["Barrel1","Barrel2","Barrel3","Barrel4","Barrel5"];
	_objectsList pushBack ["Land_CratesWooden_F","Land_transport_crates_EP1"];
};

// If GM is active, OVERWRITE additional items (no futuristic items).
if (isClass(configFile >> 'CfgPatches' >> 'gm_core')) then {
	_objectsList = [["","land_gm_sandbags_01_window_01","land_gm_sandbags_01_window_02"]];
	_objectsList pushBack ["","land_gm_euro_misc_awning_01","land_gm_euro_misc_awning_02","land_gm_euro_misc_awning_03","land_gm_euro_misc_awning_04","land_gm_euro_misc_awning_05"];
	_objectsList pushBack ["Land_Basket_F","Land_CratesShabby_F","Land_Sacks_heap_F"];
	_objectsList pushBack ["Land_PaperBox_01_small_open_brown_F","Land_PaperBox_01_small_ransacked_brown_F"];
	_objectsList pushBack ["Land_Orange_01_F","Land_WaterBottle_01_empty_F","Land_WaterBottle_01_full_F","Land_BottlePlastic_V1_F","Land_Can_Rusty_F","Land_Can_V1_F","Land_Can_V2_F","Land_Can_V3_F","Land_TacticalBacon_F","Land_Can_Dented_F","Land_BottlePlastic_V2_F","Land_BakedBeans_F","Land_PowderedMilk_F","Land_RiceBox_F","Land_Tableware_01_stackOfNapkins_F","Land_Tableware_01_cup_F","Land_TinContainer_F"];
	_objectsList pushBack ["Land_Cargo10_blue_F","Land_Cargo10_brick_red_F","Land_Cargo10_grey_F","Land_Cargo10_light_blue_F","Land_Cargo10_light_green_F","Land_Cargo10_military_green_F","Land_Cargo10_orange_F","Land_Cargo10_red_F","Land_Cargo10_sand_F","Land_Cargo10_yellow_F","Land_Cargo10_white_F"];
	_objectsList pushBack ["Land_Cargo20_blue_F","Land_Cargo20_brick_red_F","Land_Cargo20_grey_F","Land_Cargo20_light_blue_F","Land_Cargo20_light_green_F","Land_Cargo20_military_green_F","Land_Cargo20_orange_F","Land_Cargo20_red_F","Land_Cargo20_sand_F","Land_Cargo20_yellow_F","Land_Cargo20_white_F"];
	_objectsList pushBack ["Land_Cargo40_blue_F","Land_Cargo40_brick_red_F","Land_Cargo40_grey_F","Land_Cargo40_light_blue_F","Land_Cargo40_light_green_F","Land_Cargo40_military_green_F","Land_Cargo40_orange_F","Land_Cargo40_red_F","Land_Cargo40_sand_F","Land_Cargo40_yellow_F","Land_Cargo40_white_F"];
};

// If SOG is active, OVERWRITE additional items (no futuristic items).
if (isClass(configFile >> 'CfgPatches' >> 'vn_data_f')) then {
	_objectsList pushBack ["vn_b_prop_cot_01","vn_b_prop_cot_02"];
	_objectsList pushBack ["Land_vn_paperbox_01_small_closed_brown_f","Land_vn_paperbox_01_small_closed_brown_idap_f","Land_vn_paperbox_01_small_closed_brown_food_f","Land_vn_paperbox_01_small_closed_white_idap_f","Land_vn_paperbox_01_small_closed_white_med_f"];
	_objectsList pushBack ["Land_vn_stretcher","Land_vn_b_prop_litter_01","Land_vn_b_prop_litter_01_02","Land_vn_b_prop_litter_body_01","Land_vn_b_prop_litter_body_01_02","Land_vn_b_prop_litter_body_02_02","Land_vn_b_prop_litter_body_02","Land_vn_b_prop_litter_02","Land_vn_b_prop_litter_02_02"];
	_objectsList pushBack ["Land_vn_b_prop_footlocker_01_01","Land_vn_rubasicammo","Land_vn_us_ammo","Land_vn_pavn_ammo","Land_vn_pavn_weapons"];
	_objectsList pushBack ["Land_vn_paperbox_closed_f","Land_vn_paperbox_01_open_boxes_f","Land_vn_paperbox_01_open_water_f","Land_vn_paperbox_01_open_empty_f"];	
	_objectsList pushBack ["vn_b_ammobox_supply_01","vn_b_ammobox_supply_02","vn_b_ammobox_supply_06"];
	_objectsList pushBack ["Land_vn_missile_trolley_02_02_f","Land_vn_missile_trolley_02_01_f","Land_vn_missile_trolley_02_f","Land_vn_missile_trolley_02_03_f","Land_vn_bomb_trolley_01_04_f","Land_vn_bomb_trolley_01_02_f","Land_vn_bomb_trolley_01_f","Land_vn_bomb_trolley_01_01_f","Land_vn_bomb_trolley_01_03_f"];
	_objectsList pushBack ["Land_vn_ch_mod_c","Land_ChairWood_F","Land_CampingChair_V2_F"];
};

// If item is present, replace it with a random variant.
{
	if (_item in _x && {_doRandom}) exitWith {_item = selectRandom _x};
} forEach _objectsList;

if (!(isClass (configFile >> "CfgVehicles" >> _item)) && _item != "") then {
	[format ["Invalid Classname (%1)", _item], "ERROR"] call ZEI_fnc_misc_logMsg;
	_item = "";
};

_item;
