class CfgPatches {
	class ZEI {
		name = "Zeus Eden Interiors";

		author = "LSD";
		authors[] = {"LSD", "shukari"};
		url = "";
		
		requiredVersion = 1.82;
		requiredAddons[] = {
			"A3_Modules_F",
			"A3_Modules_F_Curator"
		};
		
		units[] = {
			ZEI_InteriorBuildingModul_CIV,
			ZEI_InteriorAreaModul_CIV,
			ZEI_InteriorBuildingModul_MIL,
			ZEI_InteriorAreaModul_MIL,
			ZEI_fillObjectFood,
			ZEI_fillObjectDesk,
			ZEI_fillObjectHeal,
			ZEI_fillObjectTool,
			ZEI_fillObjectAny,
			ZEI_findBPos,
			ZEI_getBuildingScheme
		};
		weapons[] = {};
      	worlds[] = {};
	};
};

class CfgFunctions {
	class ZEI {
		class Interiors {
			file = "\zei\functions";
			
			class civTemplates {};
			class createTemplate {};
			class fillObject {};
			class findBPos {};
			class getBuildingScheme {};
			class interior {};
			class milTemplates {};
			class randomiseObject {};
			class isVanillaObject {};
			class templateCanSpawn {};
			class addCustomTemplate {};
			class debug {};
			class addCustomHouse {};
		};
	};
};

#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
