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
			class createTemplate {};		// InteriorFill
			class garrisonUnit {};			// garrisonBuilding
			class findTemplates {};			// InteriorFill
			class isVanillaObject {};		// getBuildingScheme
			class misc_Vector2Eden {};
			class misc_logMsg {};
			class mod_findBPos {};			// findBPos
			class mod_garrisonBuilding {};	// garrisonBuilding
			class mod_getBuildingScheme {};	// getBuildingScheme
			class mod_interiorFill {};		// InteriorFill
			class mod_listBuildings {};		// listBuildings
			class mod_objectFill {};		// objectFill
			class mod_objectSwitch {};		// objectSwitch
			class randomiseObject {};		// InteriorFill
			class templateCanSpawn {};		// InteriorFill
			class ui_garrisonBuilding {};	// garrisonBuilding
			class ui_garrisonCombo {};		// garrisonBuilding
			class ui_interiorFill {};		// InteriorFill
			class ui_listBuildings {};		// listBuildings
			class ui_objectFill {};			// objectFill
			class ui_objectSwitch {};		// objectSwitch
			class getFurnitureData {};		// get furniture data for new scheme
		};
		class Rotation {
			file = "\zei\functions";
			class misc_rotateAroundOwnAxisX {};
			class misc_rotateAroundOwnAxisY {};
			class misc_rotateAroundOwnAxisZ {};
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