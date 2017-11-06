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
		units[] = {ZEI_InteriorCiv};
		weapons[] = {};
      	worlds[] = {};
	};
};

class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class ModuleDescription;
	};
	
	class ZEI_InteriorCiv: Module_F {
		scope = 2;
		scopeCurator = 2; 
		displayName = "Interior - Civilian";
		category = "Environment";
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
};

class CfgFunctions {
	class ZEI {
		class Interiors {
			file = "\zei\functions";
			class interiorCiv{};
			//class interiorMil{};
		};
	};
};