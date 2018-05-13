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
			ZEI_GarrisonBuilding,
			ZEI_InteriorAreaModul_CIV,
			ZEI_InteriorAreaModul_MIL,
			ZEI_InteriorBuildingModul_CIV,
			ZEI_InteriorBuildingModul_MIL,
			ZEI_ObjectSwitch,
			ZEI_fillObjectAny,
			ZEI_fillObjectDesk,
			ZEI_fillObjectFood,
			ZEI_fillObjectHeal,
			ZEI_fillObjectTool,
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
			
			class addCustomHouse {};
			class addCustomTemplate {};
			class civTemplates {};
			class createTemplate {};
			class debug {};
			class fillObject {};
			class findBPos {};
			class garrisonBuilding {};
			class garrisonUnit {};
			class getBuildingScheme {};
			class interior {};
			class isVanillaObject {};
			class milTemplates {};
			class objectSwitch {};
			class randomiseObject {};
			class templateCanSpawn {};
			class ui_garrisonBuilding {};
			class ui_garrisonCombo {};
			class ui_objectSwitch {};
		};
	};
};

#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
#include "ui\defines.hpp"
#include "ui\dialogs.hpp"