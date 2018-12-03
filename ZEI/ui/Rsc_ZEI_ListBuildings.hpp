class Rsc_ZEI_ListBuildings
{
	idd=1703;

	controlsBackground[]=
	{
		ZEI_LB_Background,
		ZEI_LB_Frame,
		ZEI_LB_Text_Title,
		ZEI_LB_Text_Matching,
		ZEI_LB_Text_MinTemplates,
		ZEI_LB_Text_MinTemplatesCount,
		ZEI_LB_Text_ShowPositions
	};
	
	controls[]={
		ZEI_LB_Combo_Matching,
		ZEI_LB_Slider_MinTemplates,
		ZEI_LB_CheckBox_ShowPositions,
		ZEI_LB_Button_OK,
		ZEI_LB_Button_Cancel
	};

	class ZEI_LB_Background: ZEI_IGUIBack
	{
		idc = -1;
		x = 0.335 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.242 * safezoneH;
	};
	class ZEI_LB_Frame: ZEI_RscFrame
	{
		idc = -1;
		x = 0.335 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.242 * safezoneH;
	};
	class ZEI_LB_Text_Title: ZEI_RscText
	{
		idc = -1;
		text = "List Template Buildings"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.19 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class ZEI_LB_Combo_Matching: ZEI_RscCombo
	{
		idc = 10;
		x = 0.432969 * safezoneW + safezoneX;
		y = 0.368 * safezoneH + safezoneY;
		w = 0.139219 * safezoneW;
		h = 0.022 * safezoneH;
		onLoad= "_this spawn {\
			waitUntil { !isNull (_this select 0) };\
			{ (findDisplay 1703 displayCtrl 10) lbAdd _x } forEach ['All', 'Civilian', 'Military'];\
			(findDisplay 1703 displayCtrl 10) lbSetCurSel 0;\
		}";
	};
	class ZEI_LB_Text_Matching: ZEI_RscText
	{
		idc = -1;
		text = "Template Filter"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.368 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_LB_Text_MinTemplates: ZEI_RscText
	{
		idc = -1;
		text = "Number of Templates"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.0825 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_LB_Text_MinTemplatesCount: ZEI_RscText
	{
		idc = 2;
		text = "(15 or less)"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.436 * safezoneH + safezoneY;
		w = 0.0825 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_LB_Slider_MinTemplates: ZEI_RscSlider
	{
		idc = 20;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.144375 * safezoneW;
		h = 0.033 * safezoneH;
		onSliderPosChanged = "if (round (_this select 1) > 0) then { (findDisplay 1703 displayCtrl 2) ctrlSetText format['(%1 or less)', round (_this select 1)]; } else { (findDisplay 1703 displayCtrl 2) ctrlSetText '(No Template)'; };";
		onLoad= "_this spawn {\
			waitUntil { !isNull (_this select 0) };\
			(findDisplay 1703 displayCtrl 20) sliderSetRange [ 0, 15 ];\
			(findDisplay 1703 displayCtrl 20) sliderSetPosition 15;\
			};";
	};
	class ZEI_LB_Text_ShowPositions: ZEI_RscText
	{
		idc = -1;
		text = "Mark Positions"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.467 * safezoneH + safezoneY;
		w = 0.0825 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_LB_CheckBox_ShowPositions: ZEI_RscCheckBox
	{
		idc = 30;
		x = 0.422656 * safezoneW + safezoneX;
		y = 0.467 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class ZEI_LB_Button_OK: ZEI_RscButton
	{
		idc = -1;
		text = "OK"; //--- ToDo: Localize;
		x = 0.360781 * safezoneW + safezoneX;
		y = 0.522 * safezoneH + safezoneY;
		w = 0.04125 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick  = "[ lbCurSel (findDisplay 1703 displayCtrl 10), round (sliderPosition (findDisplay 1703 displayCtrl 20)), cbChecked (findDisplay 1703 displayCtrl 30) ] spawn ZEI_fnc_ui_listBuildings; (findDisplay 1703) closeDisplay 1;";
	};
	class ZEI_LB_Button_Cancel: ZEI_RscButton
	{
		idc = -1;
		text = "Cancel"; //--- ToDo: Localize;
		x = 0.494844 * safezoneW + safezoneX;
		y = 0.522 * safezoneH + safezoneY;
		w = 0.04125 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick  = "(findDisplay 1703) closeDisplay 2;";
	};
};