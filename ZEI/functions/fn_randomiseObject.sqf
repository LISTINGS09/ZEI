params ["_item", ["_doRandom", true]];
	
private _rug = ["Land_Rug_01_Traditional_F","Land_Rug_01_F"];
private _gasTank = ["Land_GasTank_01_blue_F","Land_GasTank_01_yellow_F","Land_GasTank_01_khaki_F"];
private _plants = ["Land_FlowerPot_01_F","Land_FlowerPot_01_Flower_F"];
private _sleepingBag = ["Land_Sleeping_bag_brown_F","Land_Sleeping_bag_F","Land_Sleeping_bag_blue_F"];
private _sleepingBagFolded = ["Land_Sleeping_bag_blue_folded_F","Land_Sleeping_bag_brown_folded_F","Land_Sleeping_bag_folded_F"];
private _sleepingMat = ["Land_Ground_sheet_blue_F","Land_Ground_sheet_F","Land_Ground_sheet_khaki_F","Land_Ground_sheet_yellow_F"];
private _sleepingMatFolded = ["Land_Ground_sheet_folded_blue_F","Land_Ground_sheet_folded_F","Land_Ground_sheet_folded_khaki_F","Land_Ground_sheet_folded_yellow_F"];
private _pillows = ["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"];
private _shelves = ["Land_ShelvesWooden_F","Land_ShelvesWooden_blue_F","Land_ShelvesWooden_khaki_F"];
private _fridge = ["Fridge_01_open_F","Fridge_01_closed_F"];
private _caseS = ["Land_MetalCase_01_small_F","Land_PlasticCase_01_small_gray_F","Land_PlasticCase_01_small_F","Land_PlasticCase_01_small_idap_F"];
private _caseM = ["Land_MetalCase_01_medium_F","Land_PlasticCase_01_medium_gray_F","Land_PlasticCase_01_medium_F","Land_PlasticCase_01_medium_idap_F"];
private _caseL = ["Land_MetalCase_01_large_F","Land_PlasticCase_01_large_gray_F","Land_PlasticCase_01_large_F","Land_PlasticCase_01_large_idap_F"];
private _cans = ["Land_Can_Rusty_F","Land_Can_V1_F","Land_Can_V2_F","Land_Can_V3_F","Land_TacticalBacon_F"];
private _boxS = ["Land_PaperBox_01_small_closed_brown_F","Land_PaperBox_01_small_closed_brown_IDAP_F","Land_PaperBox_01_small_closed_white_med_F","Land_PaperBox_01_small_closed_white_IDAP_F","Land_PaperBox_01_small_closed_brown_food_F"];
private _boxL = ["Land_PaperBox_closed_F","Land_PaperBox_01_open_boxes_F","Land_PaperBox_01_open_empty_F","Land_PaperBox_01_open_water_F","Land_PaperBox_open_empty_F","Land_PaperBox_open_full_F"];
private _gas = ["Land_CanisterFuel_F","Land_CanisterFuel_Blue_F","Land_CanisterFuel_Red_F","Land_CanisterFuel_White_F"];
private _container = ["Land_FoodContainer_01_White_F","Land_PlasticBucket_01_closed_F","Land_PlasticBucket_01_open_F","Land_FoodContainer_01_F"];
private _bucket = ["Land_Bucket_painted_F","Land_Bucket_clean_F","Land_Bucket_F"];
private _miscS = ["Land_BarrelEmpty_F","Land_BarrelEmpty_grey_F","Land_BarrelWater_F","Land_BarrelWater_grey_F","Land_Basket_F","Land_CanisterPlastic_F","Land_Sack_F","Land_MetalBarrel_empty_F"] + _container + _plants;
private _miscM = ["Land_Basket_F","Land_CratesShabby_F","Land_LuggageHeap_01_F","Land_LuggageHeap_02_F","Land_LuggageHeap_03_F","Land_Sacks_heap_F"] + _fridge;
private _aidStack = ["Land_WaterBottle_01_stack_F","Land_PaperBox_01_small_stacked_F"];
private _aidPallet = ["Land_FoodSacks_01_large_brown_F","Land_FoodSacks_01_large_white_idap_F","Land_FoodSacks_01_large_brown_idap_F"] + _boxL;
private _foodItems = ["Land_Orange_01_F","Land_WaterBottle_01_empty_F","Land_WaterBottle_01_full_F","Land_BottlePlastic_V1_F","Land_Can_Rusty_F","Land_Can_V1_F","Land_Can_V2_F","Land_Can_V3_F","Land_TacticalBacon_F","Land_Can_Dented_F","Land_BottlePlastic_V2_F","Land_BakedBeans_F","Land_PowderedMilk_F","Land_RiceBox_F","Land_Tableware_01_stackOfNapkins_F","Land_Tableware_01_cup_F","Land_TinContainer_F"];
private _containerS = ["Land_Cargo10_IDAP_F","Land_Cargo10_blue_F","Land_Cargo10_brick_red_F","Land_Cargo10_cyan_F","Land_Cargo10_grey_F","Land_Cargo10_light_blue_F","Land_Cargo10_light_green_F","Land_Cargo10_military_green_F","Land_Cargo10_orange_F","Land_Cargo10_red_F","Land_Cargo10_sand_F","Land_Cargo10_yellow_F","Land_Cargo10_white_F"];
private _containerM = ["Land_Cargo20_IDAP_F","Land_Cargo20_blue_F","Land_Cargo20_brick_red_F","Land_Cargo20_cyan_F","Land_Cargo20_grey_F","Land_Cargo20_light_blue_F","Land_Cargo20_light_green_F","Land_Cargo20_military_green_F","Land_Cargo20_orange_F","Land_Cargo20_red_F","Land_Cargo20_sand_F","Land_Cargo20_yellow_F","Land_Cargo20_white_F"];
private _containerL = ["Land_Cargo40_IDAP_F","Land_Cargo40_blue_F","Land_Cargo40_brick_red_F","Land_Cargo40_cyan_F","Land_Cargo40_grey_F","Land_Cargo40_light_blue_F","Land_Cargo40_light_green_F","Land_Cargo40_military_green_F","Land_Cargo40_orange_F","Land_Cargo40_red_F","Land_Cargo40_sand_F","Land_Cargo40_yellow_F","Land_Cargo40_white_F"];
private _tanoaCrate = ["Land_WoodenCrate_01_stack_x5_F","Land_WoodenCrate_01_stack_x3_F"];

// If item is present, replace it with a random variant.
{
	if (_item in _x && {_doRandom}) exitWith {_item = selectRandom _x};
} forEach [_rug,_gasTank,_plants,_sleepingBag,_sleepingBagFolded,_sleepingMat,_sleepingMatFolded,_pillows,_shelves,
			_fridge,_caseS,_caseM,_caseL,_cans,_boxS,_boxL,_gas,_container,_bucket,_miscS,_miscM,_aidStack,_aidPallet,_foodItems,
			_containerS,_containerM,_containerL,_tanoaCrate];

if !(isClass (configFile >> "CfgVehicles" >> _item)) then {
	diag_log text format["[ZEI] ERROR - Invalid Classname (%1)", _item];
	_item = "Land_HelipadEmpty_F";
};

_item;
