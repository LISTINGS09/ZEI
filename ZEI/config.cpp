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
			ZEI_ListBuildings,
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
			class getBuildingScheme {};
			class interior {};
			class isVanillaObject {};
			class milTemplates {};
			class randomiseObject {};
			class templateCanSpawn {};
			class misc_XYRot {};
		};
		class objectSwitch {
			file = "\zei\functions";
			class objectSwitch {};
			class ui_objectSwitch {};
		};
		class garrisonBuilding {
			file = "\zei\functions";
			class garrisonBuilding {};
			class garrisonUnit {};
			class ui_garrisonBuilding {};
			class ui_garrisonCombo {};
		};
		class listBuildings {
			file = "\zei\functions";
			class listBuildings {};
			class ui_listBuildings {};
		};
	};
};

#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
#include "ui\defines.hpp"
#include "ui\Rsc_ZEI_GarrisonBuilding.hpp"
#include "ui\Rsc_ZEI_ObjectSwitch.hpp"
#include "ui\Rsc_ZEI_ListBuildings.hpp"