Informations

- Only houses with defined building positions ( https://community.bistudio.com/wiki/buildingPos ) for AI positions are by default supported
	- if you want other buildings that have no building positions use the function ZEI_fnc_addCustomHouse
		-> for example: ["Land_Dome_Small_F"] call ZEI_fnc_addCustomHouse
		-> now you can get a custom building template/scheme from the building and you can set the interior
		
- We are really happy when you send us your templates, because so this mod gets more awesome, but if you send us your template it needs
		quite some time to release the next version
	- if you want to test and use your own templates/schemes instantly use the function ZEI_fnc_addCustomTemplate
		-> for example a civilian building: ['civ', 'Land_Dome_Small_F: [["Land_CampingChair_V2_white_F",[1.40308,-5.02515,-6.9708],-118]]'] call ZEI_fnc_addCustomHouse
		-> or a military:					['mil', 'Land_Dome_Small_F: [["Land_CampingChair_V1_white_F",[3.10308,-7.02515,-1.9708],30]]'] call ZEI_fnc_addCustomHouse
		-> the first parameter is 'civ' or 'mil' to decide the type
		-> the second parameter is the value you get from the "get building scheme" module
			-> IMPORTANT: You MUST use ' around the value NOT " -> 'COPY_VALUE'
			
- How many templates get filtered or why some cant be spawned... all informations you get with the debuge mode on
		-> use: ZEI_debug = true

- How create/capture a template/scheme
	- remember the house and go to the editor the select the VR map, place the building and build the interior
	- you can capture the template/scheme in the eden editor or in zeus
		-> you build anything and the drag the "get building scheme" module direct over the building (it needs to be highlighted if you drag it over)
		-> now you have the template/scheme at your clipboard save it to a file or directly send it the author in the biforum
		-> now you can use/test the template/scheme with the ZEI_fnc_addCustomTemplate function (more info above)