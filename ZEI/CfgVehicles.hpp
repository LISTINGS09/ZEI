class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class AttributesBase {
			class Default;
			class Edit;
			class Combo;
			class Checkbox;
		};
	};
	
	class ZEI_DebugBuildings : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Buildings Output";
		category = "zei_interiors_dev";
		function = "ZEI_fnc_debugBuildings";
		functionPriority = 1;
		icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa";
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
	};
	
	class ZEI_GarrisonBuilding : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Garrison Building";
		category = "zei_interiors";
		function = "ZEI_fnc_GarrisonBuilding";
		functionPriority = 1;
		icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa";
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
	};
	
	class ZEI_ObjectSwitch : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Object Switch";
		category = "zei_interiors";
		function = "ZEI_fnc_objectSwitch";
		functionPriority = 1;
		icon = "\a3\Modules_f\data\portraitRespawn_ca.paa";
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
	};
	
	class ZEI_InteriorBuildingModul_CIV : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Civilian Site";
		category = "zei_interiors";
		function = "ZEI_fnc_interior";
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;

		interiorsType = 1; //1 = civilian, 0 = military
		searchRadius = 40;
		fillArea = 0; //1 = Fill Area, 0 = Nearest Building in Radius
	};
	
	class ZEI_InteriorAreaModul_CIV : ZEI_InteriorBuildingModul_CIV {
		displayName = "Civilian Area (100m)";

		searchRadius = 100;
		fillArea = 1;
	};
	
	class ZEI_InteriorBuildingModul_MIL : ZEI_InteriorBuildingModul_CIV {
		displayName = "Military Site";

		interiorsType = 0;
	};
	
	class ZEI_InteriorAreaModul_MIL : ZEI_InteriorAreaModul_CIV {
		displayName = "Military Area (100m)";

		interiorsType = 0;
	};
	
	class ZEI_fillObjectFood : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Object Fill (Food)";
		category = "zei_interiors";
		function = "ZEI_fnc_fillObject";
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
		
		class Arguments {
            class fillType {
				displayName = "Fill Type";
				description = "Items to spawn";
                typeName = "STRING";
                defaultValue = "FOOD";
            };
		};
	};
	
	class ZEI_fillObjectDesk : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Object Fill (Office)";
		category = "zei_interiors";
		function = "ZEI_fnc_fillObject";
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
		
		class Arguments {
            class fillType {
				displayName = "Fill Type";
				description = "Items to spawn";
                typeName = "STRING";
                defaultValue = "DESK";
            };
		};
	};
	
	class ZEI_fillObjectHeal : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Object Fill (Medical)";
		category = "zei_interiors";
		function = "ZEI_fnc_fillObject";
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
		
		class Arguments {
            class fillType {
				displayName = "Fill Type";
				description = "Items to spawn";
                typeName = "STRING";
                defaultValue = "HEAL";
            };
		};
	};
	
	class ZEI_fillObjectTool : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Object Fill (Tools)";
		category = "zei_interiors";
		function = "ZEI_fnc_fillObject";
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
		
		class Arguments {
            class fillType {
				displayName = "Fill Type";
				description = "Items to spawn";
                typeName = "STRING";
                defaultValue = "TOOL";
            };
		};
	};
	
	class ZEI_fillObjectAny : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Object Fill (Random)";
		category = "zei_interiors";
		function = "ZEI_fnc_fillObject";
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
		
		class Arguments {
            class ZEI_fillObjectAny_fillType {
				displayName = "Fill Type";
				description = "Items to spawn";
                typeName = "STRING";
                defaultValue = "ANY";
            };
		};
		class Attributes: AttributesBase
		{
			class searchRadius: Edit
  			{
				//property = "ZEI_fillObjectAny_searchRadius";
				displayName = "Search Radius";
				tooltip = "Meters from a 2D Radius";
				typeName = "NUMBER";
				defaultValue = "50";
			};
			class fillArea: Checkbox
  			{
				//property = "ZEI_fillObjectAny_fillArea";
				displayName = "Fill Area";
				tooltip = "TRUE = Fill Area  FALSE = Nearest Building in Radius";
				typeName = "BOOL";
				defaultValue = "false";
			};
		};
	};
	
	class ZEI_findBPos : Module_F {
		scope = 2; 
		displayName = "Mark Positions";
		category = "zei_interiors_dev";
		function = "ZEI_fnc_findBPos";
		functionPriority = 1;
		icon = "\A3\modules_f\data\portraitStrategicMapMission_ca.paa";
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;

		class Attributes: AttributesBase
		{
			class searchRadius: Edit
  			{
				property = "ZEI_findBPos_searchRadius";
				displayName = "Search Radius";
				tooltip = "Meters from a 2D Radius";
				typeName = "NUMBER";
				defaultValue = "50";
			};
			class fillArea: Checkbox
  			{
				property = "ZEI_findBPos_fillArea";
				displayName = "Fill Area";
				tooltip = "TRUE = Fill Area  FALSE = Nearest Building in Radius";
				typeName = "BOOL";
				defaultValue = "false";
			};
		};
	};
	
	class ZEI_getBuildingScheme : Module_F {
		scope = 2;
		scopeCurator = 2;
		displayName = "Save Building Scheme";
		category = "zei_interiors_dev";
		function = "ZEI_fnc_getBuildingScheme";
		functionPriority = 1;
		icon = "\a3\Modules_F\Data\iconSavegame_ca.paa";
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
	};
};
