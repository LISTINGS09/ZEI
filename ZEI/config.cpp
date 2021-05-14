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
			"ZEI_ListBuildings",
			"ZEI_GarrisonBuilding",
			"ZEI_InteriorFill",
			"ZEI_ObjectSwitch",
			"ZEI_ObjectFill",
			"ZEI_FindBPos",
			"ZEI_SaveBuildingScheme"
		};
		weapons[] = {};
      	worlds[] = {};
	};
};

#include "CfgFactionClasses.hpp"
#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"

#include "ui\defines.hpp"
#include "ui\Rsc_ZEI_GarrisonBuilding.hpp"
#include "ui\Rsc_ZEI_InteriorFill.hpp"
#include "ui\Rsc_ZEI_ListBuildings.hpp"
#include "ui\Rsc_ZEI_ObjectFill.hpp"
#include "ui\Rsc_ZEI_ObjectSwitch.hpp"