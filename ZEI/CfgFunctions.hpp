class CfgFunctions {
	class ZEI {
		class common {
			file = "zei\functions\common";
			class init { postInit = 1; };	// Zeus (Dedicated Fix)
			class zeus_addModules {};		// Zeus (Dedicated Fix)
			class mod_findBPos {};			// findBPos
			class addCustomHouse {};
			class addCustomTemplate {};
			class misc_Vector2Eden {};
			class misc_logMsg {};
		};
		class garrisonBuilding {
			file = "zei\functions\garrisonBuilding";					
			class garrisonUnit {};
			class mod_garrisonBuilding {};
			class ui_garrisonBuilding {};
			class ui_garrisonCombo {};
		};
		class interiorFill {
			file = "zei\functions\interiorFill";					
			class mod_interiorFill {};
			class ui_interiorFill {};
			class randomiseObject {};
			class templateCanSpawn {};
			class checkDetailLevel {};
			class createTemplate {};
			class findTemplates {};
		};
		class saveBuildingScheme {
			file = "zei\functions\saveBuildingScheme";					
			class mod_saveBuildingScheme {};
			class isVanillaObject {};
		};
		class listBuildings {
			file = "zei\functions\listBuildings";					
			class mod_listBuildings {};
			class ui_listBuildings {};
		};
		class objectFill {
			file = "zei\functions\objectFill";					
			class mod_objectFill {};
			class ui_objectFill {};
		};
		class objectSwitch {
			file = "zei\functions\objectSwitch";					
			class mod_objectSwitch {};
			class ui_objectSwitch {};
		};
		class rotation {
			file = "zei\functions\rotation";
			class rotateAroundOwnAxisX {};
			class rotateAroundOwnAxisY {};
			class rotateAroundOwnAxisZ {};
		};
	};
};