class Rsc_ZEI_ObjectSwitch
{
	idd=1701;

	controlsBackground[]=
	{
		ZEI_OS_Background,
		ZEI_OS_Frame,
		ZEI_OS_Text_Title,
		ZEI_OS_Text_Radius,
		ZEI_OS_Text_RadiusMeters,
		ZEI_OS_Text_Type
	};
	
	controls[]={
		ZEI_OS_Combo_Type,
		ZEI_OS_Slider_Radius,
		ZEI_OS_Button_OK,
		ZEI_OS_Button_Cancel
	};

	class ZEI_OS_Background: IGUIBack
	{
		idc = -1;
		x = 0.350468 * safezoneW + safezoneX;
		y = 0.357 * safezoneH + safezoneY;
		w = 0.242344 * safezoneW;
		h = 0.209 * safezoneH;
	};
	class ZEI_OS_Frame: RscFrame
	{
		idc = -1;
		x = 0.350468 * safezoneW + safezoneX;
		y = 0.357 * safezoneH + safezoneY;
		w = 0.242344 * safezoneW;
		h = 0.209 * safezoneH;
	};
	class ZEI_OS_Text_Title: RscText
	{
		idc = -1;
		text = "Object Switcher"; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.357 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class ZEI_OS_Text_Radius: RscText
	{
		idc = -1;
		text = "Radius"; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.456 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_OS_Text_RadiusMeters: RscText
	{
		idc = 1;
		text = "50m"; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.476 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_OS_Text_Type: RscText
	{
		idc = -1;
		text = "Convert To"; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.0464063 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_OS_Combo_Type: RscCombo
	{
		idc = 10;
		x = 0.407187 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.103125 * safezoneW;
		h = 0.022 * safezoneH;
		tooltip = "Choose the type of object to convert to.";
		onLoad= "_this spawn {\
			waitUntil { !isNull (_this select 0) };\
			{ (findDisplay 1701 displayCtrl 10) lbAdd _x } forEach ['Vanilla', 'Jungle (Apex)'];\
			if (isClass(configFile >> 'CfgPatches' >> 'CUP_Core')) then { (findDisplay 1701 displayCtrl 10) lbAdd _x } forEach [ 'Desert (CUP)', 'Woodland (CUP)'];\
			(findDisplay 1701 displayCtrl 10) lbSetCurSel 0;\
		}";
	};
	class ZEI_OS_Slider_Radius: RscSlider
	{
		idc = 20;
		x = 0.407187 * safezoneW + safezoneX;
		y = 0.456 * safezoneH + safezoneY;
		w = 0.154687 * safezoneW;
		h = 0.022 * safezoneH;
		tooltip = "Change the radius of the affected area.";
		onSliderPosChanged = "(findDisplay 1701 displayCtrl 1) ctrlSetText format['%1m', round (_this select 1)];";
		onLoad= "_this spawn { waitUntil { !isNull (_this select 0) }; (findDisplay 1701 displayCtrl 20) sliderSetRange [ 1, 250 ]; (findDisplay 1701 displayCtrl 20) sliderSetPosition 50; };";
	};
	class ZEI_OS_Button_OK: RscButton
	{
		idc = -1;
		text = "OK"; //--- ToDo: Localize;
		x = 0.463906 * safezoneW + safezoneX;
		y = 0.533 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick  = "[ lbCurSel (findDisplay 1701 displayCtrl 10), sliderPosition (findDisplay 1701 displayCtrl 20) ] spawn ZEI_fnc_ui_objectSwitch; findDisplay 1701 closeDisplay 1;";
	};
	class ZEI_OS_Button_Cancel: RscButton
	{
		idc = -1;
		text = "Cancel"; //--- ToDo: Localize;
		x = 0.530937 * safezoneW + safezoneX;
		y = 0.533 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick  = "findDisplay 1701 closeDisplay 2;";
	};	
};

class Rsc_ZEI_GarrisonBuilding
{
	idd=1702;

	controlsBackground[]=
	{
		ZEI_GB_Background,
		ZEI_GB_Frame,
		ZEI_GB_Text_Title,
		ZEI_GB_Text_Type,
		ZEI_GB_Text_Units,
		ZEI_GB_Text_DSEnabled
	};
	
	controls[]={
		ZEI_GB_Combo_Type,
		ZEI_GB_Slider_Units,
		ZEI_GB_CheckBox_DSEnabled,
		ZEI_GB_Button_OK,
		ZEI_GB_Button_Cancel
	};

	class ZEI_GB_Background: IGUIBack
	{
		idc = -1;
		x = 0.335 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.242 * safezoneH;
	};
	class ZEI_GB_Frame: RscFrame
	{
		idc = -1;
		x = 0.335 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.242 * safezoneH;
	};
	class ZEI_GB_Text_Title: RscText
	{
		idc = 1;
		text = "Garrison Building"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.19 * safezoneW;
		h = 0.033 * safezoneH;
		onLoad= "_this spawn { waitUntil { !isNull (_this select 0) }; (findDisplay 1702 displayCtrl 1) ctrlSetText format['Garrison Building - %1 (%2m)', getText(configFile >> 'CfgVehicles' >> typeOf (missionNamespace getVariable ['ZEI_LastBuilding',objNull]) >> 'displayName'), round ((missionNamespace getVariable ['ZEI_LastPos',[0,0,0]]) distance2D (missionNamespace getVariable ['ZEI_LastBuilding',objNull]))]; };";
	};
	class ZEI_GB_Combo_Type: RscCombo
	{
		idc = 10;
		x = 0.432969 * safezoneW + safezoneX;
		y = 0.368 * safezoneH + safezoneY;
		w = 0.139219 * safezoneW;
		h = 0.022 * safezoneH;
		tooltip = "Choose the faction you wish to spawn.";
		onLoad= "_this spawn ZEI_fnc_ui_garrisonCombo;";
	};
	class ZEI_GB_Text_Type: RscText
	{
		idc = -1;
		text = "Faction"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.368 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_GB_Text_Units: RscText
	{
		idc = 2;
		text = "No. of Units"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.0825 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_GB_Slider_Units: RscSlider
	{
		idc = 20;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.144375 * safezoneW;
		h = 0.033 * safezoneH;
		tooltip = "Change the number of the units.";
		onSliderPosChanged = "(findDisplay 1702 displayCtrl 2) ctrlSetText format['No. of Units (%1)', round (_this select 1)];";
		onLoad= "_this spawn {\
			waitUntil { !isNull (_this select 0) };\
			(findDisplay 1702 displayCtrl 20) sliderSetRange [ 1, (count ((missionNamespace getVariable ['ZEI_LastBuilding',objNull]) buildingPos -1)) ];\
			(findDisplay 1702 displayCtrl 20) sliderSetPosition round ((count ((missionNamespace getVariable ['ZEI_LastBuilding',objNull]) buildingPos -1)) / 3);\
			(findDisplay 1702 displayCtrl 2) ctrlSetText format['No. of Units (%1)', round ((count ((missionNamespace getVariable ['ZEI_LastBuilding',objNull]) buildingPos -1)) / 3)];\
			};";
	};
	class ZEI_GB_Text_DSEnabled: RscText
	{
		idc = -1;
		text = "Dynamic Simulation"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.467 * safezoneH + safezoneY;
		w = 0.0825 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_GB_CheckBox_DSEnabled: RscCheckbox
	{
		idc = 30;
		x = 0.422656 * safezoneW + safezoneX;
		y = 0.467 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.033 * safezoneH;
		checked = "if is3DEN then { 1 } else { 0 }";
		/*onLoad= "_this spawn { waitUntil { !isNull (_this select 0) }; if (is3DEN) then { (findDisplay 1702 displayCtrl 30) cbSetChecked true; }; };";*/
	};
	class ZEI_GB_Button_OK: RscButton
	{
		idc = -1;
		text = "OK"; //--- ToDo: Localize;
		x = 0.360781 * safezoneW + safezoneX;
		y = 0.522 * safezoneH + safezoneY;
		w = 0.04125 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick  = "[ (findDisplay 1702 displayCtrl 10) lbData (lbCurSel (findDisplay 1702 displayCtrl 10)), round (sliderPosition (findDisplay 1702 displayCtrl 20)), cbChecked (findDisplay 1702 displayCtrl 30) ] spawn ZEI_fnc_ui_garrisonBuilding; (findDisplay 1702) closeDisplay 1;";
	};
	class ZEI_GB_Button_Cancel: RscButton
	{
		idc = -1;
		text = "Cancel"; //--- ToDo: Localize;
		x = 0.494844 * safezoneW + safezoneX;
		y = 0.522 * safezoneH + safezoneY;
		w = 0.04125 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick  = "(findDisplay 1702) closeDisplay 2;";
	};
};