class CfgFunctions {
	class ZEI {
		class Interiors {
			file = "\zei\functions";
			class addCustomHouse {};
			class addCustomTemplate {};
			class checkDetailLevel {};		// InteriorFill
			class createTemplate {};		// InteriorFill
			class garrisonUnit {};			// garrisonBuilding
			class findTemplates {};			// InteriorFill
			class isVanillaObject {};		// saveBuildingScheme
			class init { postInit = 1; };	// Zeus (Dedicated Fix)
			class misc_Vector2Eden {};
			class misc_logMsg {};
			class mod_findBPos {};			// findBPos
			class mod_garrisonBuilding {};	// garrisonBuilding
			class mod_saveBuildingScheme {};// saveBuildingScheme
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
			class zeus_addModules {};		// Zeus (Dedicated Fix)
		};
		class Rotation {
			file = "\zei\functions";
			class misc_rotateAroundOwnAxisX {};
			class misc_rotateAroundOwnAxisY {};
			class misc_rotateAroundOwnAxisZ {};
		};
	};
};