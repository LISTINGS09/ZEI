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
			ZEI_InteriorFill,
			ZEI_ObjectSwitch,
			ZEI_ObjectFill,
			ZEI_FindBPos,
			ZEI_GetBuildingScheme
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
			class interior {};				// Redundant?
			class isVanillaObject {};
			class milTemplates {};
			class randomiseObject {};
			class templateCanSpawn {};
			class mod_interiorFill {};		// InteriorFill
			class ui_interiorFill {};		// InteriorFill
			class mod_findBPos {};			// findBPos
			class mod_getBuildingScheme {};	// getBuildingScheme
			class mod_objectFill {};		// objectFill
			class ui_objectFill {};			// objectFill
			class mod_objectSwitch {};		// objectSwitch
			class ui_objectSwitch {};		// objectSwitch
			class mod_garrisonBuilding {};	// garrisonBuilding
			class garrisonUnit {};			// garrisonBuilding
			class ui_garrisonBuilding {};	// garrisonBuilding
			class ui_garrisonCombo {};		// garrisonBuilding
			class mod_listBuildings {};		// listBuildings
			class ui_listBuildings {};		// listBuildings
			class misc_debug {};
			class misc_Vector2Eden {};
		};
		class Rotation {
			file = "\zei\functions";
			class misc_rotateAroundOwnAxisX {};
			class misc_rotateAroundOwnAxisY {};
			class misc_rotateAroundOwnAxisZ {};
			class misc_rotateObject {};
			class misc_rotateObjectX {};
			class misc_rotateObjectY {};
			class misc_rotateObjectZ {};
		};
	};
};

#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
#include "ui\defines.hpp"
#include "ui\Rsc_ZEI_GarrisonBuilding.hpp"
#include "ui\Rsc_ZEI_InteriorFill.hpp"
#include "ui\Rsc_ZEI_ListBuildings.hpp"
#include "ui\Rsc_ZEI_ObjectFill.hpp"
#include "ui\Rsc_ZEI_ObjectSwitch.hpp"