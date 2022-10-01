class Rsc_ZEI_InteriorFill
{
	idd=1705;
	// Fill Type Mil/Civ
	// Fill Area (nearest = 0 or meters)

	controlsBackground[]=
	{
		ZEI_IF_Background,
		ZEI_IF_Frame,
		ZEI_IF_Text_Title,
		ZEI_IF_Text_Type,
		ZEI_IF_Text_Items,
		ZEI_IF_Text_Detail,
		ZEI_IF_Text_EditObject,
		ZEI_IF_Text_AllowDamage
	};
	
	controls[]={
		ZEI_IF_Combo_Type,
		ZEI_IF_Slider_Items,
		ZEI_IF_Combo_Detail,
		ZEI_IF_CheckBox_EditObject,
		ZEI_IF_CheckBox_AllowDamage,
		ZEI_IF_Button_OK,
		ZEI_IF_Button_Cancel
	};

	class ZEI_IF_Background: ZEI_IGUIBack
	{
		idc = -1;
		x = 0.335 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.252 * safezoneH;
	};
	class ZEI_IF_Frame: ZEI_RscFrame
	{
		idc = -1;
		x = 0.335 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.252 * safezoneH;
	};
	class ZEI_IF_Text_Title: ZEI_RscText
	{
		idc = 1;
		text = "Interior Fill"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.19 * safezoneW;
		h = 0.033 * safezoneH;
		onLoad= "_this spawn { waitUntil { !isNull (_this select 0) }; (findDisplay 1705 displayCtrl 1) ctrlSetText format['Interior Fill - %1 (%2m)', getText(configFile >> 'CfgVehicles' >> typeOf (missionNamespace getVariable ['ZEI_UiLastBuilding',objNull]) >> 'displayName'), round ((screenToWorld getMousePosition) distance2D (missionNamespace getVariable ['ZEI_UiLastBuilding',objNull]))]; };";
	};
	class ZEI_IF_Combo_Type: ZEI_RscCombo
	{
		idc = 10;
		x = 0.432969 * safezoneW + safezoneX;
		y = 0.368 * safezoneH + safezoneY;
		w = 0.139219 * safezoneW;
		h = 0.022 * safezoneH;
		tooltip = "Type of interior to fill";
		onLoad= "_this spawn {\
			waitUntil { !isNull (_this select 0) };\
			{ (findDisplay 1705 displayCtrl 10) lbAdd _x } forEach ['Military', 'Civilian'];\
			(findDisplay 1705 displayCtrl 10) lbSetCurSel (missionNamespace getVariable ['ZEI_UiInteriorType', 0]);\
		}";
	};
	class ZEI_IF_Text_Type: ZEI_RscText
	{
		idc = -1;
		text = "Object Type"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.368 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_IF_Text_Items: ZEI_RscText
	{
		idc = 2;
		text = "Radius: Nearest"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.0825 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_IF_Slider_Items: ZEI_RscSlider
	{
		idc = 20;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.144375 * safezoneW;
		h = 0.033 * safezoneH;
		tooltip = "Radius of buildings to fill";
		onSliderPosChanged = "if (round (_this select 1) > 0) then { (findDisplay 1705 displayCtrl 2) ctrlSetText format['Radius: %1 Meters', round (_this select 1)]; } else { (findDisplay 1705 displayCtrl 2) ctrlSetText 'Radius: Nearest'; };";
		onLoad= "_this spawn {\
			waitUntil { !isNull (_this select 0) };\
			(findDisplay 1705 displayCtrl 20) sliderSetRange [ 0, 250 ];\
			(findDisplay 1705 displayCtrl 20) sliderSetPosition 0;\
		};";
	};
	class ZEI_IF_Text_Detail: ZEI_RscText
	{
		idc = 5;
		text = "Level of Detail";
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.457 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_IF_Combo_Detail: ZEI_RscCombo
	{
		idc = 50;
		x = 0.432969 * safezoneW + safezoneX;
		y = 0.457 * safezoneH + safezoneY;
		w = 0.139219 * safezoneW;
		h = 0.022 * safezoneH;
		tooltip = "Level of complexity for interiors";
		onLoad= "_this spawn {\
			waitUntil { !isNull (_this select 0) };\
			{ (findDisplay 1705 displayCtrl 50) lbAdd _x } forEach ['Defences Only', 'Full'];\
			(findDisplay 1705 displayCtrl 50) lbSetCurSel (missionNamespace getVariable ['ZEI_UiInteriorDetail', 1]);\
		}";
	};
	class ZEI_IF_Text_EditObject: ZEI_RscText
	{
		idc = 3;
		text = "Edit Objects"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.501 * safezoneH + safezoneY;
		w = 0.0845 * safezoneW;
		h = 0.022 * safezoneH;
		onLoad= "_this spawn { waitUntil { !isNull (_this select 0) };\
			if is3DEN then { (findDisplay 1705 displayCtrl 3) ctrlShow FALSE; };\
		}";
	};
	class ZEI_IF_CheckBox_EditObject: ZEI_RscCheckBox
	{
		idc = 30;
		x = 0.422656 * safezoneW + safezoneX;
		y = 0.501 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.033 * safezoneH;
		tooltip = "Add the spawned objects to Curator\nIf disabled, they cannot be moved or edited by Zeus.";
		checked = 1;
		onLoad= "_this spawn { waitUntil { !isNull (_this select 0) };\
			(findDisplay 1705 displayCtrl 30) cbSetChecked (missionNamespace getVariable ['ZEI_UiInteriorEdit', TRUE]);\
			if is3DEN then { (findDisplay 1705 displayCtrl 30) ctrlShow FALSE; };\
		}";
	};
	class ZEI_IF_Text_AllowDamage: ZEI_RscText
	{
		idc = 4;
		text = "Allow Damage"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.545 * safezoneH + safezoneY;
		w = 0.0845 * safezoneW;
		h = 0.022 * safezoneH;
		onLoad= "_this spawn { waitUntil { !isNull (_this select 0) };\
			if is3DEN then { (findDisplay 1705 displayCtrl 4) ctrlShow FALSE; };\
		}";
	};
	class ZEI_IF_CheckBox_AllowDamage: ZEI_RscCheckBox
	{
		idc = 40;
		x = 0.422656 * safezoneW + safezoneX;
		y = 0.545 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.033 * safezoneH;
		tooltip = "Allow the building to be damaged.\nIf enabled, all objects inside the building may be left 'floating' when damaged/destroyed.";
		onLoad= "_this spawn { waitUntil { !isNull (_this select 0) };\
			(findDisplay 1705 displayCtrl 40) cbSetChecked (missionNamespace getVariable ['ZEI_UiInteriorDamage', FALSE]);\
			if is3DEN then { (findDisplay 1705 displayCtrl 40) ctrlShow FALSE; };\
		}";
	};
	class ZEI_IF_Button_OK: ZEI_RscButton
	{
		idc = -1;
		text = "OK"; //--- ToDo: Localize;
		x = 0.360781 * safezoneW + safezoneX;
		y = 0.599 * safezoneH + safezoneY;
		w = 0.04125 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick  = "[ lbCurSel (findDisplay 1705 displayCtrl 10), round (sliderPosition (findDisplay 1705 displayCtrl 20)), cbChecked (findDisplay 1705 displayCtrl 30), cbChecked (findDisplay 1705 displayCtrl 40), lbCurSel (findDisplay 1705 displayCtrl 50) ] spawn ZEI_fnc_ui_interiorFill; (findDisplay 1705) closeDisplay 1;";
	};
	class ZEI_IF_Button_Cancel: ZEI_RscButton
	{
		idc = -1;
		text = "Cancel"; //--- ToDo: Localize;
		x = 0.494844 * safezoneW + safezoneX;
		y = 0.599 * safezoneH + safezoneY;
		w = 0.04125 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick  = "(findDisplay 1705) closeDisplay 2;";
	};
};