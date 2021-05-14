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

	class ZEI_OS_Background: ZEI_IGUIBack
	{
		idc = -1;
		x = 0.350468 * safezoneW + safezoneX;
		y = 0.357 * safezoneH + safezoneY;
		w = 0.242344 * safezoneW;
		h = 0.209 * safezoneH;
	};
	class ZEI_OS_Frame: ZEI_RscFrame
	{
		idc = -1;
		x = 0.350468 * safezoneW + safezoneX;
		y = 0.357 * safezoneH + safezoneY;
		w = 0.242344 * safezoneW;
		h = 0.209 * safezoneH;
	};
	class ZEI_OS_Text_Title: ZEI_RscText
	{
		idc = -1;
		text = "Object Switcher"; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.357 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class ZEI_OS_Text_Radius: ZEI_RscText
	{
		idc = -1;
		text = "Radius"; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.456 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_OS_Text_RadiusMeters: ZEI_RscText
	{
		idc = 1;
		text = "50m"; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.476 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_OS_Text_Type: ZEI_RscText
	{
		idc = -1;
		text = "Convert To"; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.0464063 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_OS_Combo_Type: ZEI_RscCombo
	{
		idc = 10;
		x = 0.407187 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.103125 * safezoneW;
		h = 0.022 * safezoneH;
		tooltip = "Choose the type of object to convert to.";
		onLoad= "_this spawn {\
			waitUntil { !isNull (_this select 0) };\
			{ (findDisplay 1701 displayCtrl 10) lbAdd _x } forEach ['Desert (Vanilla)', 'Jungle (Apex)', 'Woodland (Contact)'];\
			if (isClass(configFile >> 'CfgPatches' >> 'CUP_Core')) then {\
				{(findDisplay 1701 displayCtrl 10) lbAdd _x } forEach [ 'Desert (CUP)', 'Woodland (CUP)' ];\
				if (isClass(configFile >> 'CfgPatches' >> 'vn_data_f')) then {\
					{(findDisplay 1701 displayCtrl 10) lbAdd _x } forEach [ 'SOG (Brown)', 'SOG (Green)' ];\
				};\
			} else {\
				if (isClass(configFile >> 'CfgPatches' >> 'vn_data_f')) then {\
					{(findDisplay 1701 displayCtrl 10) lbAdd _x } forEach [ 'Invalid (CUP)', 'Invalid (CUP)', 'SOG (Brown)', 'SOG (Green)' ];\
				};\
			};\
			(findDisplay 1701 displayCtrl 10) lbSetCurSel (missionNamespace getVariable ['ZEI_UiSwitchCombo', 0]);\
		}";
	};
	class ZEI_OS_Slider_Radius: ZEI_RscSlider
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
	class ZEI_OS_Button_OK: ZEI_RscButton
	{
		idc = -1;
		text = "OK"; //--- ToDo: Localize;
		x = 0.463906 * safezoneW + safezoneX;
		y = 0.533 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick  = "[ lbCurSel (findDisplay 1701 displayCtrl 10), sliderPosition (findDisplay 1701 displayCtrl 20) ] spawn ZEI_fnc_ui_objectSwitch; findDisplay 1701 closeDisplay 1;";
	};
	class ZEI_OS_Button_Cancel: ZEI_RscButton
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