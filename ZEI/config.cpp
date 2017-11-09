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
			ZEI_CivilianUrban, 
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
		class ModuleDescription;
	};
	
	class ZEI_CivilianUrban : Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Civilian (Urban)";
		category = "zei_interiors";
		function = "ZEI_fnc_interiorCiv";
		functionPriority = 1;
		isGlobal = 0;
		isTriggerActivated = 0;
		is3DEN = 1;

		class Arguments {};
		class ModuleDescription: ModuleDescription {
			description = "Fills a building with Civilian objects.";
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
            class fillType {
				displayName = "Fill Type";
				description = "Items to spawn";
                typeName = "STRING";
                defaultValue = "ANY";
            };
		};
	};
};

class CfgFunctions {
	class ZEI {
		class Interiors {
			file = "\zei\functions";
			class interiorCiv{};
			class fillObject{};
			//class interiorMil{};
		};
	};
};