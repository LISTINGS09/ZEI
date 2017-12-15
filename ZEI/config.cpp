class CfgPatches {
	class ZEI {
		name = "Zeus Eden Interiors";
		author = "LSD";
		url = "";
		requiredVersion = 1.7;
		requiredAddons[] = {
			"A3_Modules_F",
			"A3_Modules_F_Curator"
		};
		units[] = {
			ZEI_Civilian,
			ZEI_Civilian100,
			ZEI_MilitaryGuer, 
			ZEI_MilitaryAreaGuer,
			ZEI_fillObjectAny // Arguments aren't passed in Zeus, so can't specify fillType.
		};
		weapons[] = {};
      	worlds[] = {};
	};
};

class CfgFactionClasses {
	class NO_CATEGORY;
	class zei_interiors: NO_CATEGORY {
		displayName = "Interiors (ZEI)";
	};
};

class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class AttributesBase {
			class Default;
			class Edit;
			class Combo;
			class Checkbox;
			class ModuleDescription;
		};
		
		class ModuleDescription;
	};
		
	class ZEI_Civilian : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Civilian Site";
		category = "zei_interiors";
		function = "ZEI_fnc_interiorCiv";
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
		//curatorInfoType = "RscDisplayAttributeZEI_Civilian";

		class Attributes: AttributesBase
		{
			class searchRadius: Edit
  			{
				property = "ZEI_Civilian_searchRadius";
				displayName = "Search Radius";
				tooltip = "Meters from a 2D Radius";
				typeName = "NUMBER";
				defaultValue = "50";
			};
			class fillArea: Checkbox
  			{
				property = "ZEI_Civilian_fillArea";
				displayName = "Fill Area";
				tooltip = "TRUE = Fill Area  FALSE = Nearest Building in Radius";
				typeName = "BOOL";
				defaultValue = "false";
			};
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};
		
		class ModuleDescription: ModuleDescription {
			description = "Fills Civilian building(s) with objects.";
			sync[] = {};
		};
	};
	
	class ZEI_Civilian100 : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Civilian Area (100m)";
		category = "zei_interiors";
		function = "ZEI_fnc_interiorCiv";
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
		//curatorInfoType = "RscDisplayAttributeZEI_Civilian";

		class Attributes: AttributesBase
		{
			class searchRadius: Edit
  			{
				property = "ZEI_Civilian100_searchRadius";
				displayName = "Search Radius";
				tooltip = "Meters from a 2D Radius";
				typeName = "NUMBER";
				defaultValue = "100";
			};
			class fillArea: Checkbox
  			{
				property = "ZEI_Civilian100_fillArea";
				displayName = "Fill Area";
				tooltip = "TRUE = Fill Area  FALSE = Nearest Building in Radius";
				typeName = "BOOL";
				defaultValue = "true";
			};
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};
		
		class ModuleDescription: ModuleDescription {
			description = "Fills Civilian building(s) with objects in 100m.";
			sync[] = {};
		};
	};
	
	class ZEI_MilitaryGuer : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Military Site (GUER)";
		category = "zei_interiors";
		function = "ZEI_fnc_interiorMilGuer";
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
		curatorInfoType = "RscDisplayAttributeZEI_MilitaryGuer";

		class Attributes: AttributesBase
		{
			class searchRadius: Edit
  			{
				property = "ZEI_MilitaryGuer_searchRadius";
				displayName = "Search Radius";
				tooltip = "Meters from a 2D Radius";
				typeName = "NUMBER";
				defaultValue = "50";
			};
			class fillArea: Checkbox
  			{
				property = "ZEI_MilitaryGuer_fillArea";
				displayName = "Fill Area";
				tooltip = "TRUE = Fill Area  FALSE = Nearest Building in Radius";
				typeName = "BOOL";
				defaultValue = "false";
			};
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};
		
		class ModuleDescription: ModuleDescription {
			description = "Fills nearest building with military objects.";
			sync[] = {};
		};
	};
	
	class ZEI_MilitaryAreaGuer : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Military Area (GUER)";
		category = "zei_interiors";
		function = "ZEI_fnc_interiorMilGuer";
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;
		//curatorInfoType = "RscDisplayAttributeZEI_MilitaryAreaGuer";

		class Attributes: AttributesBase
		{
			class searchRadius: Edit
  			{
				property = "ZEI_MilitaryAreaGuer_searchRadius";
				displayName = "Search Radius";
				tooltip = "Meters from a 2D Radius";
				typeName = "NUMBER";
				defaultValue = "50";
			};
			class fillArea: Checkbox
  			{
				property = "ZEI_MilitaryAreaGuer_fillArea";
				displayName = "Fill Area";
				tooltip = "TRUE = Fill Area  FALSE = Nearest Building in Radius";
				typeName = "BOOL";
				defaultValue = "true";
			};
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};
		
		class ModuleDescription: ModuleDescription {
			description = "Fills building(s) with military objects.";
			sync[] = {};
		};
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
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};
		
		class ModuleDescription: ModuleDescription {
			description = "Fills a table or shelf with objects.";
			sync[] = {};
		};
	};
	
	class ZEI_findBPos : Module_F {
		scope = 2; 
		displayName = "Mark Positions";
		category = "zei_interiors";
		function = "ZEI_fnc_findBPos";
		functionPriority = 1;
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
			class ModuleDescription: ModuleDescription{}; // Module description should be shown last
		};
		
		class ModuleDescription: ModuleDescription {
			description = "Finds and marks all building positions.";
			sync[] = {};
		};
	};
};

class CfgFunctions {
	class ZEI {
		class Interiors {
			file = "\zei\functions";
			class interiorCiv{};
			class interiorMilGuer{};
			class fillObject{};
			class findBPos{};
		};
	};
};