params [
		["_type", 0],
		["_searchRadius", 50]
	];
	
if (!(isClass(configFile >> 'CfgPatches' >> 'CUP_Core')) && _type in [3,4]) exitWith { systemChat "ERROR - Required MOD is not present" };
if (!(isClass(configFile >> 'CfgPatches' >> 'vn_data_f')) && _type in [5,6]) exitWith { systemChat "ERROR - Required MOD is not present" };
		
// Need to pass logic pos info to GUI somehow?
private _pos = screenToWorld getMousePosition;

[format["Passed: Type: %1 - Radius: %2 - Pos: %3", _type, _searchRadius, _pos], "DEBUG"] call ZEI_fnc_misc_logMsg;

// A3 Desert
private _typeVanilla = 	[
	"Land_BagFence_Corner_F","Land_BagFence_Long_F","Land_BagFence_Short_F","Land_BagFence_End_F","Land_BagFence_Round_F","CamoNet_BLUFOR_F","CamoNet_BLUFOR_open_F","CamoNet_BLUFOR_big_F","CamoNet_OPFOR_F","CamoNet_OPFOR_open_F","CamoNet_OPFOR_big_F","CamoNet_INDP_F","CamoNet_INDP_open_F","CamoNet_INDP_big_F",
	"Land_HBarrier_1_F","Land_HBarrier_3_F","Land_HBarrier_5_F","Land_HBarrier_Big_F","Land_BagBunker_Small_F","Land_BagBunker_Large_F","Land_BagBunker_Tower_F","Land_HBarrierWall_corridor_F","Land_HBarrierWall_corner_F","Land_HBarrierWall6_F","Land_HBarrierWall4_F","Land_HBarrierTower_F",
	"Land_Cargo_Patrol_V3_F","Land_Cargo_House_V3_F","Land_Cargo_HQ_V3_F","Land_Cargo_Tower_V3_F","Land_SandbagBarricade_01_half_F","Land_SandbagBarricade_01_F","Land_SandbagBarricade_01_hole_F",
	"Box_Syndicate_Ammo_F","Box_Syndicate_Wps_F","Box_Syndicate_WpsLaunch_F","Land_PaperBox_01_small_closed_brown_IDAP_F","Land_PaperBox_01_small_closed_brown_food_F","Land_PaperBox_01_small_closed_white_med_F","Land_PaperBox_01_small_closed_white_IDAP_F",
	"Land_BatteryPack_01_battery_sand_F","Land_BatteryPack_01_closed_sand_F","Land_BatteryPack_01_open_sand_F","Land_Computer_01_sand_F","Land_DeskChair_01_sand_F","Land_IPPhone_01_sand_F","Land_Laptop_03_sand_F","Land_MultiScreenComputer_01_closed_sand_F","Land_MultiScreenComputer_01_sand_F",
	"Land_PortableCabinet_01_4drawers_sand_F","Land_PortableCabinet_01_7drawers_sand_F","Land_PortableCabinet_01_bookcase_sand_F","Land_PortableCabinet_01_closed_sand_F","Land_PortableCabinet_01_lid_sand_F","Land_PortableDesk_01_panel_sand_F","Land_PortableDesk_01_sand_F","Land_PortableGenerator_01_sand_F","Land_PortableLight_02_double_sand_F","Land_PortableLight_02_folded_sand_F","Land_PortableLight_02_quad_sand_F","Land_PortableLight_02_single_folded_sand_F","Land_PortableLight_02_single_sand_F","Land_PortableServer_01_cover_sand_F","Land_PortableServer_01_sand_F","Land_PortableSolarPanel_01_folded_sand_F","Land_PortableSolarPanel_01_sand_F","Land_PortableWeatherStation_01_sand_F","Land_Router_01_sand_F","Land_SolarPanel_04_sand_F","Land_TripodScreen_01_dual_v1_sand_F","Land_TripodScreen_01_dual_v2_sand_F","Land_TripodScreen_01_large_sand_F","Land_laptop_03_closed_sand_F","OmniDirectionalAntenna_01_sand_F","SatelliteAntenna_01_Sand_F","SatelliteAntenna_01_Small_Mounted_Sand_F","SatelliteAntenna_01_Small_Sand_F",
	"Land_PlasticCase_01_large_F","Land_PlasticCase_01_medium_F","Land_PlasticCase_01_small_F","Land_PlasticCase_01_large_CBRN_F","Land_PlasticCase_01_medium_CBRN_F","Land_PlasticCase_01_small_CBRN_F",
	"Land_ConnectorTent_01_NATO_closed_F","Land_ConnectorTent_01_NATO_cross_F","Land_ConnectorTent_01_NATO_open_F","Land_DeconTent_01_NATO_F","Land_MedicalTent_01_NATO_generic_closed_F","Land_MedicalTent_01_NATO_generic_inner_F","Land_MedicalTent_01_NATO_generic_open_F","Land_MedicalTent_01_NATO_generic_outer_F","Land_MedicalTent_01_MTP_closed_F",
	"Land_ConnectorTent_01_CSAT_brownhex_closed_F","Land_ConnectorTent_01_CSAT_brownhex_cross_F","Land_ConnectorTent_01_CSAT_brownhex_open_F","Land_DeconTent_01_CSAT_brownhex_F","Land_MedicalTent_01_CSAT_brownhex_generic_closed_F","Land_MedicalTent_01_CSAT_brownhex_generic_inner_F","Land_MedicalTent_01_CSAT_brownhex_generic_open_F","Land_MedicalTent_01_CSAT_brownhex_generic_outer_F","Land_MedicalTent_01_brownhex_closed_F",
	"Land_ConnectorTent_01_AAF_closed_F","Land_ConnectorTent_01_AAF_cross_F","Land_ConnectorTent_01_AAF_open_F","Land_DeconTent_01_AAF_F","Land_MedicalTent_01_AAF_generic_closed_F","Land_MedicalTent_01_AAF_generic_inner_F","Land_MedicalTent_01_AAF_generic_open_F","Land_MedicalTent_01_AAF_generic_outer_F","Land_MedicalTent_01_digital_closed_F"
];
// A3 Jungle
private _typeAPEX = [
	"Land_BagFence_01_corner_green_F","Land_BagFence_01_long_green_F","Land_BagFence_01_short_green_F","Land_BagFence_01_end_green_F","Land_BagFence_01_round_green_F","CamoNet_BLUFOR_F","CamoNet_BLUFOR_open_F","CamoNet_BLUFOR_big_F","CamoNet_ghex_F","CamoNet_ghex_open_F","CamoNet_ghex_big_F","CamoNet_INDP_F","CamoNet_INDP_open_F","CamoNet_INDP_big_F",
	"Land_HBarrier_01_line_1_green_F","Land_HBarrier_01_line_3_green_F","Land_HBarrier_01_line_5_green_F","Land_HBarrier_01_big_4_green_F","Land_BagBunker_01_small_green_F","Land_BagBunker_01_large_green_F","Land_HBarrier_01_tower_green_F","Land_HBarrier_01_wall_corridor_green_F","Land_HBarrier_01_wall_corner_green_F","Land_HBarrier_01_wall_6_green_F","Land_HBarrier_01_wall_4_green_F","Land_HBarrier_01_big_tower_green_F",
	"Land_Cargo_Patrol_V4_F","Land_Cargo_House_V4_F","Land_Cargo_HQ_V4_F","Land_Cargo_Tower_V4_F","Land_SandbagBarricade_01_half_F","Land_SandbagBarricade_01_F","Land_SandbagBarricade_01_hole_F",
	"Box_Syndicate_Ammo_F","Box_Syndicate_Wps_F","Box_Syndicate_WpsLaunch_F","Land_PaperBox_01_small_closed_brown_IDAP_F","Land_PaperBox_01_small_closed_brown_food_F","Land_PaperBox_01_small_closed_white_med_F","Land_PaperBox_01_small_closed_white_IDAP_F",
	"Land_BatteryPack_01_battery_olive_F","Land_BatteryPack_01_closed_olive_F","Land_BatteryPack_01_open_olive_F","Land_Computer_01_olive_F","Land_DeskChair_01_olive_F","Land_IPPhone_01_olive_F","Land_Laptop_03_olive_F","Land_MultiScreenComputer_01_closed_olive_F","Land_MultiScreenComputer_01_olive_F",
	"Land_PortableCabinet_01_4drawers_olive_F","Land_PortableCabinet_01_7drawers_olive_F","Land_PortableCabinet_01_bookcase_olive_F","Land_PortableCabinet_01_closed_olive_F","Land_PortableCabinet_01_lid_olive_F","Land_PortableDesk_01_panel_olive_F","Land_PortableDesk_01_olive_F","Land_PortableGenerator_01_F","Land_PortableLight_02_double_olive_F","Land_PortableLight_02_folded_olive_F","Land_PortableLight_02_quad_olive_F","Land_PortableLight_02_single_folded_olive_F","Land_PortableLight_02_single_olive_F","Land_PortableServer_01_cover_olive_F","Land_PortableServer_01_olive_F","Land_PortableSolarPanel_01_folded_olive_F","Land_PortableSolarPanel_01_olive_F","Land_PortableWeatherStation_01_olive_F","Land_Router_01_olive_F","Land_SolarPanel_04_olive_F","Land_TripodScreen_01_dual_v1_F","Land_TripodScreen_01_dual_v2_F","Land_TripodScreen_01_large_F","Land_laptop_03_closed_olive_F","OmniDirectionalAntenna_01_olive_F","SatelliteAntenna_01_olive_F","SatelliteAntenna_01_Small_Mounted_olive_F","SatelliteAntenna_01_Small_olive_F",
	"Land_PlasticCase_01_large_olive_F","Land_PlasticCase_01_medium_olive_F","Land_PlasticCase_01_small_olive_F","Land_PlasticCase_01_large_olive_CBRN_F","Land_PlasticCase_01_medium_olive_CBRN_F","Land_PlasticCase_01_small_olive_CBRN_F",
	"Land_ConnectorTent_01_NATO_tropic_closed_F","Land_ConnectorTent_01_NATO_tropic_cross_F","Land_ConnectorTent_01_NATO_tropic_open_F","Land_DeconTent_01_NATO_tropic_F","Land_MedicalTent_01_NATO_tropic_generic_closed_F","Land_MedicalTent_01_NATO_tropic_generic_inner_F","Land_MedicalTent_01_NATO_tropic_generic_open_F","Land_MedicalTent_01_NATO_tropic_generic_outer_F","Land_MedicalTent_01_tropic_closed_F",
	"Land_ConnectorTent_01_CSAT_greenhex_closed_F","Land_ConnectorTent_01_CSAT_greenhex_cross_F","Land_ConnectorTent_01_CSAT_greenhex_open_F","Land_DeconTent_01_CSAT_greenhex_F","Land_MedicalTent_01_CSAT_greenhex_generic_closed_F","Land_MedicalTent_01_CSAT_greenhex_generic_inner_F","Land_MedicalTent_01_CSAT_greenhex_generic_open_F","Land_MedicalTent_01_CSAT_greenhex_generic_outer_F","Land_MedicalTent_01_greenhex_closed_F",
	"Land_ConnectorTent_01_AAF_closed_F","Land_ConnectorTent_01_AAF_cross_F","Land_ConnectorTent_01_AAF_open_F","Land_DeconTent_01_AAF_F","Land_MedicalTent_01_AAF_generic_closed_F","Land_MedicalTent_01_AAF_generic_inner_F","Land_MedicalTent_01_AAF_generic_open_F","Land_MedicalTent_01_AAF_generic_outer_F","Land_MedicalTent_01_digital_closed_F"
];
// A3 Woodland
private _typeContact = [
	"Land_BagFence_01_corner_green_F","Land_BagFence_01_long_green_F","Land_BagFence_01_short_green_F","Land_BagFence_01_end_green_F","Land_BagFence_01_round_green_F","CamoNet_BLUFOR_F","CamoNet_BLUFOR_open_F","CamoNet_BLUFOR_big_F","CamoNet_ghex_F","CamoNet_ghex_open_F","CamoNet_ghex_big_F","CamoNet_wdl_F","CamoNet_wdl_open_F","CamoNet_wdl_big_F",
	"Land_HBarrier_01_line_1_green_F","Land_HBarrier_01_line_3_green_F","Land_HBarrier_01_line_5_green_F","Land_HBarrier_01_big_4_green_F","Land_BagBunker_01_small_green_F","Land_BagBunker_01_large_green_F","Land_HBarrier_01_tower_green_F","Land_HBarrier_01_wall_corridor_green_F","Land_HBarrier_01_wall_corner_green_F","Land_HBarrier_01_wall_6_green_F","Land_HBarrier_01_wall_4_green_F","Land_HBarrier_01_big_tower_green_F",
	"Land_Cargo_Patrol_V1_F","Land_Cargo_House_V1_F","Land_Cargo_HQ_V1_F","Land_Cargo_Tower_V1_F","Land_SandbagBarricade_01_half_F","Land_SandbagBarricade_01_F","Land_SandbagBarricade_01_hole_F",
	"Box_Syndicate_Ammo_F","Box_Syndicate_Wps_F","Box_Syndicate_WpsLaunch_F","Land_PaperBox_01_small_closed_brown_IDAP_F","Land_PaperBox_01_small_closed_brown_food_F","Land_PaperBox_01_small_closed_white_med_F","Land_PaperBox_01_small_closed_white_IDAP_F",
	"Land_BatteryPack_01_battery_black_F","Land_BatteryPack_01_closed_black_F","Land_BatteryPack_01_open_black_F","Land_Computer_01_black_F","Land_DeskChair_01_black_F","Land_IPPhone_01_black_F","Land_Laptop_03_black_F","Land_MultiScreenComputer_01_closed_black_F","Land_MultiScreenComputer_01_black_F",
	"Land_PortableCabinet_01_4drawers_black_F","Land_PortableCabinet_01_7drawers_black_F","Land_PortableCabinet_01_bookcase_black_F","Land_PortableCabinet_01_closed_black_F","Land_PortableCabinet_01_lid_black_F","Land_PortableDesk_01_panel_black_F","Land_PortableDesk_01_black_F","Land_PortableGenerator_01_black_F","Land_PortableLight_02_double_black_F","Land_PortableLight_02_folded_black_F","Land_PortableLight_02_quad_black_F","Land_PortableLight_02_single_folded_black_F","Land_PortableLight_02_single_black_F","Land_PortableServer_01_cover_black_F","Land_PortableServer_01_black_F","Land_PortableSolarPanel_01_folded_olive_F","Land_PortableSolarPanel_01_olive_F","Land_PortableWeatherStation_01_white_F","Land_Router_01_black_F","Land_SolarPanel_04_black_F","Land_TripodScreen_01_dual_v1_black_F","Land_TripodScreen_01_dual_v2_black_F","Land_TripodScreen_01_large_black_F","Land_laptop_03_closed_black_F","OmniDirectionalAntenna_01_black_F","SatelliteAntenna_01_black_F","SatelliteAntenna_01_Small_Mounted_black_F","SatelliteAntenna_01_Small_black_F",
	"Land_PlasticCase_01_large_black_F","Land_PlasticCase_01_medium_black_F","Land_PlasticCase_01_small_black_F","Land_PlasticCase_01_large_black_CBRN_F","Land_PlasticCase_01_medium_black_CBRN_F","Land_PlasticCase_01_small_black_CBRN_F",
	"Land_ConnectorTent_01_wdl_closed_F","Land_ConnectorTent_01_wdl_cross_F","Land_ConnectorTent_01_wdl_open_F","Land_DeconTent_01_wdl_F","Land_MedicalTent_01_wdl_generic_closed_F","Land_MedicalTent_01_wdl_generic_inner_F","Land_MedicalTent_01_wdl_generic_open_F","Land_MedicalTent_01_wdl_generic_outer_F","Land_MedicalTent_01_wdl_closed_F",
	"Land_ConnectorTent_01_CSAT_greenhex_closed_F","Land_ConnectorTent_01_CSAT_greenhex_cross_F","Land_ConnectorTent_01_CSAT_greenhex_open_F","Land_DeconTent_01_CSAT_greenhex_F","Land_MedicalTent_01_CSAT_greenhex_generic_closed_F","Land_MedicalTent_01_CSAT_greenhex_generic_inner_F","Land_MedicalTent_01_CSAT_greenhex_generic_open_F","Land_MedicalTent_01_CSAT_greenhex_generic_outer_F","Land_MedicalTent_01_greenhex_closed_F",
	"Land_ConnectorTent_01_wdl_closed_F","Land_ConnectorTent_01_wdl_cross_F","Land_ConnectorTent_01_wdl_open_F","Land_DeconTent_01_wdl_F","Land_MedicalTent_01_wdl_generic_closed_F","Land_MedicalTent_01_wdl_generic_inner_F","Land_MedicalTent_01_wdl_generic_open_F","Land_MedicalTent_01_wdl_generic_outer_F","Land_MedicalTent_01_wdl_closed_F"
];
// CUP Desert
private _typeCUP_D = [
	"Land_BagFenceCorner","Land_BagFenceLong","Land_BagFenceShort","Land_BagFenceEnd","Land_BagFenceRound","Land_CamoNet_NATO_EP1","Land_CamoNetVar_NATO_EP1","Land_CamoNetB_NATO_EP1","Land_CamoNet_EAST_EP1","Land_CamoNetVar_EAST_EP1","Land_CamoNetB_EAST_EP1","Land_CamoNet_EAST_EP1","Land_CamoNetVar_EAST_EP1","Land_CamoNetB_EAST_EP1",
	"Land_HBarrier1","Land_HBarrier3","Land_HBarrier5","Land_HBarrier_large","Land_fortified_nest_small_EP1","Land_fortified_nest_big_EP1","Land_Fort_Watchtower_EP1","Land_HBarrierWall_corridor_F","Land_HBarrierWall_corner_F","Land_HBarrierWall6_F","Land_HBarrierWall4_F","Land_HBarrierTower_F",
	"Land_Cargo_Patrol_V3_F","Land_Cargo_House_V3_F","Land_Cargo_HQ_V3_F","Land_Cargo_Tower_V3_F","Land_SandbagBarricade_01_half_F","Land_SandbagBarricade_01_F","Land_SandbagBarricade_01_hole_F",
	"Box_Syndicate_Ammo_F","Box_Syndicate_Wps_F","Box_Syndicate_WpsLaunch_F","Land_PaperBox_01_small_closed_brown_IDAP_F","Land_PaperBox_01_small_closed_brown_food_F","Land_PaperBox_01_small_closed_white_med_F","Land_PaperBox_01_small_closed_white_IDAP_F",
	"Land_BatteryPack_01_battery_sand_F","Land_BatteryPack_01_closed_sand_F","Land_BatteryPack_01_open_sand_F","Land_Computer_01_sand_F","Land_DeskChair_01_sand_F","Land_IPPhone_01_sand_F","Land_Laptop_03_sand_F","Land_MultiScreenComputer_01_closed_sand_F","Land_MultiScreenComputer_01_sand_F",
	"Land_PortableCabinet_01_4drawers_sand_F","Land_PortableCabinet_01_7drawers_sand_F","Land_PortableCabinet_01_bookcase_sand_F","Land_PortableCabinet_01_closed_sand_F","Land_PortableCabinet_01_lid_sand_F","Land_PortableDesk_01_panel_sand_F","Land_PortableDesk_01_sand_F","Land_PortableGenerator_01_sand_F","Land_PortableLight_02_double_sand_F","Land_PortableLight_02_folded_sand_F","Land_PortableLight_02_quad_sand_F","Land_PortableLight_02_single_folded_sand_F","Land_PortableLight_02_single_sand_F","Land_PortableServer_01_cover_sand_F","Land_PortableServer_01_sand_F","Land_PortableSolarPanel_01_folded_sand_F","Land_PortableSolarPanel_01_sand_F","Land_PortableWeatherStation_01_sand_F","Land_Router_01_sand_F","Land_SolarPanel_04_sand_F","Land_TripodScreen_01_dual_v1_sand_F","Land_TripodScreen_01_dual_v2_sand_F","Land_TripodScreen_01_large_sand_F","Land_laptop_03_closed_sand_F","OmniDirectionalAntenna_01_sand_F","SatelliteAntenna_01_Sand_F","SatelliteAntenna_01_Small_Mounted_Sand_F","SatelliteAntenna_01_Small_Sand_F",
	"Land_PlasticCase_01_large_F","Land_PlasticCase_01_medium_F","Land_PlasticCase_01_small_F","Land_PlasticCase_01_large_CBRN_F","Land_PlasticCase_01_medium_CBRN_F","Land_PlasticCase_01_small_CBRN_F",
	"Land_ConnectorTent_01_NATO_closed_F","Land_ConnectorTent_01_NATO_cross_F","Land_ConnectorTent_01_NATO_open_F","Land_DeconTent_01_NATO_F","Land_MedicalTent_01_NATO_generic_closed_F","Land_MedicalTent_01_NATO_generic_inner_F","Land_MedicalTent_01_NATO_generic_open_F","Land_MedicalTent_01_NATO_generic_outer_F","Land_MedicalTent_01_MTP_closed_F",
	"Land_ConnectorTent_01_NATO_tropic_closed_F","Land_ConnectorTent_01_NATO_tropic_cross_F","Land_ConnectorTent_01_NATO_tropic_open_F","Land_DeconTent_01_NATO_tropic_F","Land_MedicalTent_01_NATO_tropic_generic_closed_F","Land_MedicalTent_01_NATO_tropic_generic_inner_F","Land_MedicalTent_01_NATO_tropic_generic_open_F","Land_MedicalTent_01_NATO_tropic_generic_outer_F","Land_MedicalTent_01_tropic_closed_F",
	"Land_ConnectorTent_01_NATO_tropic_closed_F","Land_ConnectorTent_01_NATO_tropic_cross_F","Land_ConnectorTent_01_NATO_tropic_open_F","Land_DeconTent_01_NATO_tropic_F","Land_MedicalTent_01_NATO_tropic_generic_closed_F","Land_MedicalTent_01_NATO_tropic_generic_inner_F","Land_MedicalTent_01_NATO_tropic_generic_open_F","Land_MedicalTent_01_NATO_tropic_generic_outer_F","Land_MedicalTent_01_tropic_closed_F"
];
// CUP Woodland
private _typeCUP_W = [
	"Land_BagFenceCorner","Land_BagFenceLong","Land_BagFenceShort","Land_BagFenceEnd","Land_BagFenceRound","Land_CamoNet_NATO","Land_CamoNetVar_NATO","Land_CamoNetB_NATO","Land_CamoNet_EAST","Land_CamoNetVar_EAST","Land_CamoNetB_EAST","CamoNet_wdl_F","CamoNet_wdl_open_F","CamoNet_wdl_big_F",
	"Land_HBarrier_1_F","Land_HBarrier_3_F","Land_HBarrier_5_F","Land_HBarrier_Big_F","Fort_Nest","Land_fortified_nest_big","Land_Fort_Watchtower","Land_HBarrierWall_corridor_F","Land_HBarrierWall_corner_F","Land_HBarrierWall6_F","Land_HBarrierWall4_F","Land_HBarrierTower_F",
	"Land_Cargo_Patrol_V1_F","Land_Cargo_House_V1_F","Land_Cargo_HQ_V1_F","Land_Cargo_Tower_V1_F","Land_SandbagBarricade_01_half_F","Land_SandbagBarricade_01_F","Land_SandbagBarricade_01_hole_F",
	"Box_Syndicate_Ammo_F","Box_Syndicate_Wps_F","Box_Syndicate_WpsLaunch_F","Land_PaperBox_01_small_closed_brown_IDAP_F","Land_PaperBox_01_small_closed_brown_food_F","Land_PaperBox_01_small_closed_white_med_F","Land_PaperBox_01_small_closed_white_IDAP_F",
	"Land_BatteryPack_01_battery_black_F","Land_BatteryPack_01_closed_black_F","Land_BatteryPack_01_open_black_F","Land_Computer_01_black_F","Land_DeskChair_01_black_F","Land_IPPhone_01_black_F","Land_Laptop_03_black_F","Land_MultiScreenComputer_01_closed_black_F","Land_MultiScreenComputer_01_black_F",
	"Land_PortableCabinet_01_4drawers_black_F","Land_PortableCabinet_01_7drawers_black_F","Land_PortableCabinet_01_bookcase_black_F","Land_PortableCabinet_01_closed_black_F","Land_PortableCabinet_01_lid_black_F","Land_PortableDesk_01_panel_black_F","Land_PortableDesk_01_black_F","Land_PortableGenerator_01_black_F","Land_PortableLight_02_double_black_F","Land_PortableLight_02_folded_black_F","Land_PortableLight_02_quad_black_F","Land_PortableLight_02_single_folded_black_F","Land_PortableLight_02_single_black_F","Land_PortableServer_01_cover_black_F","Land_PortableServer_01_black_F","Land_PortableSolarPanel_01_folded_olive_F","Land_PortableSolarPanel_01_olive_F","Land_PortableWeatherStation_01_white_F","Land_Router_01_black_F","Land_SolarPanel_04_black_F","Land_TripodScreen_01_dual_v1_black_F","Land_TripodScreen_01_dual_v2_black_F","Land_TripodScreen_01_large_black_F","Land_laptop_03_closed_black_F","OmniDirectionalAntenna_01_black_F","SatelliteAntenna_01_black_F","SatelliteAntenna_01_Small_Mounted_black_F","SatelliteAntenna_01_Small_black_F",
	"Land_PlasticCase_01_large_black_F","Land_PlasticCase_01_medium_black_F","Land_PlasticCase_01_small_black_F","Land_PlasticCase_01_large_black_CBRN_F","Land_PlasticCase_01_medium_black_CBRN_F","Land_PlasticCase_01_small_black_CBRN_F",
	"Land_ConnectorTent_01_wdl_closed_F","Land_ConnectorTent_01_wdl_cross_F","Land_ConnectorTent_01_wdl_open_F","Land_DeconTent_01_wdl_F","Land_MedicalTent_01_wdl_generic_closed_F","Land_MedicalTent_01_wdl_generic_inner_F","Land_MedicalTent_01_wdl_generic_open_F","Land_MedicalTent_01_wdl_generic_outer_F","Land_MedicalTent_01_wdl_closed_F",
	"Land_ConnectorTent_01_NATO_tropic_closed_F","Land_ConnectorTent_01_NATO_tropic_cross_F","Land_ConnectorTent_01_NATO_tropic_open_F","Land_DeconTent_01_NATO_tropic_F","Land_MedicalTent_01_NATO_tropic_generic_closed_F","Land_MedicalTent_01_NATO_tropic_generic_inner_F","Land_MedicalTent_01_NATO_tropic_generic_open_F","Land_MedicalTent_01_NATO_tropic_generic_outer_F","Land_MedicalTent_01_tropic_closed_F",
	"Land_ConnectorTent_01_wdl_closed_F","Land_ConnectorTent_01_wdl_cross_F","Land_ConnectorTent_01_wdl_open_F","Land_DeconTent_01_wdl_F","Land_MedicalTent_01_wdl_generic_closed_F","Land_MedicalTent_01_wdl_generic_inner_F","Land_MedicalTent_01_wdl_generic_open_F","Land_MedicalTent_01_wdl_generic_outer_F","Land_MedicalTent_01_wdl_closed_F"
];
// SOG Brown
private _typeSOGB = [
	"Land_vn_bagfence_corner_f","Land_vn_bagfence_long_f","Land_vn_bagfence_short_f","Land_vn_bagfence_end_f","Land_vn_bagfence_round_f","vn_camonet_blufor_f","vn_camonet_blufor_open_f","vn_camonet_blufor_big_f","Land_vn_camonet_east","CamoNet_BLUFOR_open_F","Land_vn_camonetb_east","CamoNet_wdl_F","CamoNet_wdl_open_F","CamoNet_wdl_big_F",
	"Land_HBarrier_01_line_1_green_F","Land_HBarrier_01_line_3_green_F","Land_HBarrier_01_line_5_green_F","Land_HBarrier_01_big_4_green_F","Land_vn_bagbunker_small_f","Land_vn_bagbunker_large_f","Land_BagBunker_Tower_F","Land_HBarrier_01_wall_corridor_green_F","Land_HBarrier_01_wall_corner_green_F","Land_HBarrier_01_wall_6_green_F","Land_HBarrier_01_wall_4_green_F","Land_HBarrier_01_big_tower_green_F",
	"Land_Cargo_Patrol_V2_F","Land_Cargo_House_V2_F","Land_Cargo_HQ_V2_F","Land_Cargo_Tower_V2_F","Land_vn_sandbagbarricade_01_half_f","Land_vn_sandbagbarricade_01_f","Land_vn_sandbagbarricade_01_hole_f",
	"Land_vn_pavn_ammo","Land_vn_pavn_weapons_wide","Land_vn_pavn_launchers","Land_vn_paperbox_01_small_closed_brown_idap_f","Land_vn_paperbox_01_small_closed_brown_food_f","Land_vn_paperbox_01_small_closed_white_med_f","Land_vn_paperbox_01_small_closed_white_idap_f",
	"Land_BatteryPack_01_battery_olive_F","Land_BatteryPack_01_closed_olive_F","Land_BatteryPack_01_open_olive_F","Land_Computer_01_olive_F","Land_DeskChair_01_olive_F","Land_IPPhone_01_olive_F","Land_Laptop_03_olive_F","Land_MultiScreenComputer_01_closed_olive_F","Land_MultiScreenComputer_01_olive_F",
	"Land_PortableCabinet_01_4drawers_olive_F","Land_PortableCabinet_01_7drawers_olive_F","Land_PortableCabinet_01_bookcase_olive_F","Land_PortableCabinet_01_closed_olive_F","Land_PortableCabinet_01_lid_olive_F","Land_PortableDesk_01_panel_olive_F","Land_PortableDesk_01_olive_F","Land_PortableGenerator_01_F","Land_PortableLight_02_double_olive_F","Land_PortableLight_02_folded_olive_F","Land_PortableLight_02_quad_olive_F","Land_PortableLight_02_single_folded_olive_F","Land_PortableLight_02_single_olive_F","Land_PortableServer_01_cover_olive_F","Land_PortableServer_01_olive_F","Land_PortableSolarPanel_01_folded_olive_F","Land_PortableSolarPanel_01_olive_F","Land_PortableWeatherStation_01_olive_F","Land_Router_01_olive_F","Land_SolarPanel_04_olive_F","Land_TripodScreen_01_dual_v1_F","Land_TripodScreen_01_dual_v2_F","Land_TripodScreen_01_large_F","Land_laptop_03_closed_olive_F","OmniDirectionalAntenna_01_olive_F","SatelliteAntenna_01_olive_F","SatelliteAntenna_01_Small_Mounted_olive_F","SatelliteAntenna_01_Small_olive_F",
	"Land_PlasticCase_01_large_olive_F","Land_PlasticCase_01_medium_olive_F","Land_PlasticCase_01_small_olive_F","Land_PlasticCase_01_large_olive_CBRN_F","Land_PlasticCase_01_medium_olive_CBRN_F","Land_PlasticCase_01_small_olive_CBRN_F",
	"Land_ConnectorTent_01_NATO_tropic_closed_F","Land_ConnectorTent_01_NATO_tropic_cross_F","Land_ConnectorTent_01_NATO_tropic_open_F","Land_DeconTent_01_NATO_tropic_F","Land_MedicalTent_01_NATO_tropic_generic_closed_F","Land_MedicalTent_01_NATO_tropic_generic_inner_F","Land_MedicalTent_01_NATO_tropic_generic_open_F","Land_MedicalTent_01_NATO_tropic_generic_outer_F","Land_MedicalTent_01_tropic_closed_F",
	"Land_ConnectorTent_01_CSAT_greenhex_closed_F","Land_ConnectorTent_01_CSAT_greenhex_cross_F","Land_ConnectorTent_01_CSAT_greenhex_open_F","Land_DeconTent_01_CSAT_greenhex_F","Land_MedicalTent_01_CSAT_greenhex_generic_closed_F","Land_MedicalTent_01_CSAT_greenhex_generic_inner_F","Land_MedicalTent_01_CSAT_greenhex_generic_open_F","Land_MedicalTent_01_CSAT_greenhex_generic_outer_F","Land_MedicalTent_01_greenhex_closed_F",
	"Land_ConnectorTent_01_AAF_closed_F","Land_ConnectorTent_01_AAF_cross_F","Land_ConnectorTent_01_AAF_open_F","Land_DeconTent_01_AAF_F","Land_MedicalTent_01_AAF_generic_closed_F","Land_MedicalTent_01_AAF_generic_inner_F","Land_MedicalTent_01_AAF_generic_open_F","Land_MedicalTent_01_AAF_generic_outer_F","Land_MedicalTent_01_digital_closed_F"
];
// SOG Green
_typeSOGG = [
	"Land_vn_bagfence_01_corner_green_f","Land_vn_bagfence_01_long_green_f","Land_vn_bagfence_01_short_green_f","Land_vn_bagfence_01_end_green_f","Land_vn_bagfence_01_round_green_f","vn_camonet_blufor_f","vn_camonet_blufor_open_f","vn_camonet_blufor_big_f","Land_vn_camonet_east","CamoNet_BLUFOR_open_F","Land_vn_camonetb_east","CamoNet_wdl_F","CamoNet_wdl_open_F","CamoNet_wdl_big_F",
	"Land_HBarrier_01_line_1_green_F","Land_HBarrier_01_line_3_green_F","Land_HBarrier_01_line_5_green_F","Land_HBarrier_01_big_4_green_F","Land_vn_bunker_small_01","Land_vn_bunker_big_01","Land_HBarrier_01_tower_green_F","Land_HBarrier_01_wall_corridor_green_F","Land_HBarrier_01_wall_corner_green_F","Land_HBarrier_01_wall_6_green_F","Land_HBarrier_01_wall_4_green_F","Land_HBarrier_01_big_tower_green_F",
	"Land_Cargo_Patrol_V1_F","Land_Cargo_House_V1_F","Land_Cargo_HQ_V1_F","Land_Cargo_Tower_V1_F","Land_vn_sandbagbarricade_01_half_f","Land_vn_sandbagbarricade_01_f","Land_vn_sandbagbarricade_01_hole_f",
	"Land_vn_us_ammo","Land_vn_us_weapons","Land_vn_us_launchers","Land_vn_paperbox_01_small_closed_brown_idap_f","Land_vn_paperbox_01_small_closed_brown_food_f","Land_vn_paperbox_01_small_closed_white_med_f","Land_vn_paperbox_01_small_closed_white_idap_f",
	"Land_BatteryPack_01_battery_black_F","Land_BatteryPack_01_closed_black_F","Land_BatteryPack_01_open_black_F","Land_Computer_01_black_F","Land_DeskChair_01_black_F","Land_IPPhone_01_black_F","Land_Laptop_03_black_F","Land_MultiScreenComputer_01_closed_black_F","Land_MultiScreenComputer_01_black_F",
	"Land_PortableCabinet_01_4drawers_black_F","Land_PortableCabinet_01_7drawers_black_F","Land_PortableCabinet_01_bookcase_black_F","Land_PortableCabinet_01_closed_black_F","Land_PortableCabinet_01_lid_black_F","Land_PortableDesk_01_panel_black_F","Land_PortableDesk_01_black_F","Land_PortableGenerator_01_black_F","Land_PortableLight_02_double_black_F","Land_PortableLight_02_folded_black_F","Land_PortableLight_02_quad_black_F","Land_PortableLight_02_single_folded_black_F","Land_PortableLight_02_single_black_F","Land_PortableServer_01_cover_black_F","Land_PortableServer_01_black_F","Land_PortableSolarPanel_01_folded_olive_F","Land_PortableSolarPanel_01_olive_F","Land_PortableWeatherStation_01_white_F","Land_Router_01_black_F","Land_SolarPanel_04_black_F","Land_TripodScreen_01_dual_v1_black_F","Land_TripodScreen_01_dual_v2_black_F","Land_TripodScreen_01_large_black_F","Land_laptop_03_closed_black_F","OmniDirectionalAntenna_01_black_F","SatelliteAntenna_01_black_F","SatelliteAntenna_01_Small_Mounted_black_F","SatelliteAntenna_01_Small_black_F",
	"Land_PlasticCase_01_large_black_F","Land_PlasticCase_01_medium_black_F","Land_PlasticCase_01_small_black_F","Land_PlasticCase_01_large_black_CBRN_F","Land_PlasticCase_01_medium_black_CBRN_F","Land_PlasticCase_01_small_black_CBRN_F",
	"Land_ConnectorTent_01_wdl_closed_F","Land_ConnectorTent_01_wdl_cross_F","Land_ConnectorTent_01_wdl_open_F","Land_DeconTent_01_wdl_F","Land_MedicalTent_01_wdl_generic_closed_F","Land_MedicalTent_01_wdl_generic_inner_F","Land_MedicalTent_01_wdl_generic_open_F","Land_MedicalTent_01_wdl_generic_outer_F","Land_MedicalTent_01_wdl_closed_F",
	"Land_ConnectorTent_01_CSAT_greenhex_closed_F","Land_ConnectorTent_01_CSAT_greenhex_cross_F","Land_ConnectorTent_01_CSAT_greenhex_open_F","Land_DeconTent_01_CSAT_greenhex_F","Land_MedicalTent_01_CSAT_greenhex_generic_closed_F","Land_MedicalTent_01_CSAT_greenhex_generic_inner_F","Land_MedicalTent_01_CSAT_greenhex_generic_open_F","Land_MedicalTent_01_CSAT_greenhex_generic_outer_F","Land_MedicalTent_01_greenhex_closed_F",
	"Land_ConnectorTent_01_wdl_closed_F","Land_ConnectorTent_01_wdl_cross_F","Land_ConnectorTent_01_wdl_open_F","Land_DeconTent_01_wdl_F","Land_MedicalTent_01_wdl_generic_closed_F","Land_MedicalTent_01_wdl_generic_inner_F","Land_MedicalTent_01_wdl_generic_open_F","Land_MedicalTent_01_wdl_generic_outer_F","Land_MedicalTent_01_wdl_closed_F"
];


// Save UI Settings for next time
ZEI_UiSwitchCombo = _type;

private _replaceType = switch (_type) do {
	case 0: { _typeVanilla };
	case 1: { _typeAPEX };
	case 2: { _typeContact };
	case 3: { _typeCUP_D };
	case 4: { _typeCUP_W };
	case 5: { _typeSOGB };
	case 6: { _typeSOGG };
};

private _searchType = ([_typeVanilla, _typeAPEX, _typeContact, _typeCUP_D, _typeCUP_W, _typeSOGB, _typeSOGG]) - [_replaceType];

if !(isClass(configFile >> 'CfgPatches' >> 'CUP_Core')) then { _searchType = _searchType - [_typeCUP_D,_typeCUP_W] };
if !(isClass(configFile >> 'CfgPatches' >> 'vn_data_f')) then { _searchType = _searchType - [_typeSOGB, _typeSOGG] };

if (count _replaceType == 0) exitWith { 
	["No objects loaded to replace.","ERROR"] call ZEI_fnc_misc_logMsg;
};

private _toReplace = [];

// Iterate array of found objects in the radius.
{	
	private _foundObj = _x;
	private _foundType = typeOf _x;
	
	// Iterate array containing searchable objects.
	{
		private _index = _x findIf { _x == _foundType };
		
		if (_index >= 0) exitWith {
			private _replaceClass = _replaceType select _index;
			
			if (isClass (configFile >> "CfgVehicles" >> _replaceClass)) then {
					if (_foundType != (configName (configFile >> "CfgVehicles" >> _replaceClass))) then {
						_toReplace pushBack [_foundObj, _replaceClass];
					};
				} else {
					[format["Object Switch - Invalid Object: %1",_replaceClass], "ERROR"] call ZEI_fnc_misc_logMsg;
				};
		};
	} forEach _searchType;
} forEach (nearestObjects [_pos, [], _searchRadius, TRUE]);

if (count _toReplace == 0) exitWith { 
	["No objects to replace","INFO"] call ZEI_fnc_misc_logMsg;
};

private _count = 0;

if (is3DEN) then {
	collect3DENHistory {
		{ 
			_x params ["_original","_replacement"];
			[_original] set3DENObjectType _replacement;
		} forEach _toReplace;
	};
} else {
	{ 
		_x params ["_original","_replacement"];
		_obj = createVehicle [_replacement, getPosATL _original, [], 0, "CAN_COLLIDE"];
		_obj setVectorDirAndUp [vectorDir _original, vectorUp _original];
		deleteVehicle _original;
	} forEach _toReplace;
};

[format["Converted %1 Objects", count _toReplace], "INFO"] call ZEI_fnc_misc_logMsg;