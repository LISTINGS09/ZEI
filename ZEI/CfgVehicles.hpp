class CfgVehicles {
	class Logic;
	class Module_F: Logic {};
	
	class ZEI_ListBuildings : Module_F {
		scope = 2;
		scopeCurator = 1; 
		displayName = "List Buildings";
		category = "zei_interiors_dev";
		function = "ZEI_fnc_mod_listBuildings";
		functionPriority = 1;
		icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa";
		isGlobal = 1;
		isTriggerActivated = 0;
		is3DEN = 1;
	};
	
	class ZEI_GarrisonBuilding : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Garrison Building";
		category = "zei_interiors";
		function = "ZEI_fnc_mod_garrisonBuilding";
		functionPriority = 1;
		icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa";
		isGlobal = 1;
		isTriggerActivated = 0;
		is3DEN = 1;
	};
	
	class ZEI_ObjectFill : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Object Fill";
		category = "zei_interiors";
		function = "ZEI_fnc_mod_objectFill";
		functionPriority = 1;
		icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\box_ca.paa";
		isGlobal = 1;
		isTriggerActivated = 0;
		is3DEN = 1;
	};
	
	class ZEI_ObjectSwitch : Module_F {
		scope = 2;
		scopeCurator = 2;
		displayName = "Object Switch";
		category = "zei_interiors";
		function = "ZEI_fnc_mod_objectSwitch";
		functionPriority = 1;
		icon = "\A3\Modules_f\data\portraitRespawn_ca.paa";
		isGlobal = 1;
		isTriggerActivated = 0;
		is3DEN = 1;
	};
	
	class ZEI_InteriorFill : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Interior Fill";
		category = "zei_interiors";
		function = "ZEI_fnc_mod_interiorFill";
		functionPriority = 1;
		icon = "\A3\modules_f\data\portraitModule_ca.paa";
		isGlobal = 1;
		isTriggerActivated = 0;
		is3DEN = 1;
	};
	
	class ZEI_FindBPos : Module_F {
		scope = 2; 
		displayName = "Mark Positions";
		category = "zei_interiors_dev";
		function = "ZEI_fnc_mod_findBPos";
		functionPriority = 1;
		icon = "\A3\modules_f\data\portraitStrategicMapMission_ca.paa";
		isGlobal = 1;
		isTriggerActivated = 0;
		is3DEN = 1;
	};
	
	class ZEI_SaveBuildingScheme : Module_F {
		scope = 2;
		displayName = "Save Building Scheme";
		category = "zei_interiors_dev";
		function = "ZEI_fnc_mod_saveBuildingScheme";
		functionPriority = 1;
		icon = "\a3\Modules_F\Data\iconSavegame_ca.paa";
		isGlobal = 1;
		isTriggerActivated = 0;
		is3DEN = 1;
	};
};
