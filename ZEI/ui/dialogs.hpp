class Rsc_ZEI_ObjectSwitch
{
	idd=1701;
	//onLoad= "_this spawn { waitUntil { !isNull ((_this select 0) displayCtrl -1) }; sliderSetRange [20, 1, 250]; sliderSetPosition [20, 50]; { lbAdd [10, _x] } forEach ['Vanilla (Brown)', 'Apex (Green)']; if (isClass(configFile >> 'CfgPatches' >> 'CUP_Core')) then { lbAdd [10, 'CUP (Green)'] }; lbSetCurSel [10, 0];}";

	controlsBackground[]=
	{
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

	class ZEI_OS_Frame: RscFrame
	{
		idc = -1;
		x = 0.350468 * safezoneW + safezoneX;
		y = 0.357 * safezoneH + safezoneY;
		w = 0.242344 * safezoneW;
		h = 0.209 * safezoneH;
		colorBackground[] = {0,0,0,0.5};
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
		onLoad= "_this spawn { waitUntil { !isNull (_this select 0) }; { lbAdd [10, _x] } forEach ['Vanilla', 'Jungle (Apex)']; if (isClass(configFile >> 'CfgPatches' >> 'CUP_Core')) then { lbAdd [10, 'Desert (CUP)'];  lbAdd [10, 'Woodland (CUP)'] }; lbSetCurSel [10, 0]; }";
	};
	class ZEI_OS_Slider_Radius: RscSlider
	{
		idc = 20;
		x = 0.407187 * safezoneW + safezoneX;
		y = 0.456 * safezoneH + safezoneY;
		w = 0.154687 * safezoneW;
		h = 0.022 * safezoneH;
		tooltip = "Change the radius of the affected area.";
		onSliderPosChanged = "ctrlSetText [1, format['%1m', round (_this select 1)]]; hint format['%1',_this];";
		onLoad= "_this spawn { waitUntil { !isNull (_this select 0) }; sliderSetRange [ 20, 1, 250 ]; sliderSetPosition [ 20, 50 ]; };";
	};
	class ZEI_OS_Button_OK: RscButton
	{
		idc = -1;
		text = "OK"; //--- ToDo: Localize;
		onButtonClick  = "[ lbCurSel 10, sliderPosition  20 ] spawn ZEI_fnc_ui_objectSwitch; closeDialog 1;";
		x = 0.463906 * safezoneW + safezoneX;
		y = 0.533 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_OS_Button_Cancel: RscButton
	{
		idc = -1;
		text = "Cancel"; //--- ToDo: Localize;
		onButtonClick  = "closeDialog 2;";
		x = 0.530937 * safezoneW + safezoneX;
		y = 0.533 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.022 * safezoneH;
	};	
};