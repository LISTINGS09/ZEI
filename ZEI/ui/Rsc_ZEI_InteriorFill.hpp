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
		ZEI_IF_Text_EditObject
	};
	
	controls[]={
		ZEI_IF_Combo_Type,
		ZEI_IF_Slider_Items,
		ZEI_IF_CheckBox_EditObject,
		ZEI_IF_Button_OK,
		ZEI_IF_Button_Cancel
	};

	class ZEI_IF_Background: IGUIBack
	{
		idc = -1;
		x = 0.335 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.242 * safezoneH;
	};
	class ZEI_IF_Frame: RscFrame
	{
		idc = -1;
		x = 0.335 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.242 * safezoneH;
	};
	class ZEI_IF_Text_Title: RscText
	{
		idc = -1;
		text = "Interior Type"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.324 * safezoneH + safezoneY;
		w = 0.19 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class ZEI_IF_Combo_Type: RscCombo
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
			(findDisplay 1705 displayCtrl 10) lbSetCurSel 0;\
		}";
	};
	class ZEI_IF_Text_Type: RscText
	{
		idc = -1;
		text = "Object Type"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.368 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_IF_Text_Items: RscText
	{
		idc = 1;
		text = "Radius: Nearest"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.0825 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_IF_Slider_Items: RscSlider
	{
		idc = 20;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.412 * safezoneH + safezoneY;
		w = 0.144375 * safezoneW;
		h = 0.033 * safezoneH;
		tooltip = "Radius of buildings to fill";
		onSliderPosChanged = "if (round (_this select 1) > 0) then { (findDisplay 1705 displayCtrl 1) ctrlSetText format['Radius: %1 Meters', round (_this select 1)]; } else { (findDisplay 1705 displayCtrl 1) ctrlSetText 'Radius: Nearest'; };";
		onLoad= "_this spawn {\
			waitUntil { !isNull (_this select 0) };\
			(findDisplay 1705 displayCtrl 20) sliderSetRange [ 0, 250 ];\
			(findDisplay 1705 displayCtrl 20) sliderSetPosition 0;\
		};";
	};
	class ZEI_IF_Text_EditObject: RscText
	{
		idc = -1;
		text = "Allow Edit (ZEUS Only)"; //--- ToDo: Localize;
		x = 0.340156 * safezoneW + safezoneX;
		y = 0.467 * safezoneH + safezoneY;
		w = 0.0845 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class ZEI_IF_CheckBox_EditObject: RscCheckbox
	{
		idc = 30;
		x = 0.422656 * safezoneW + safezoneX;
		y = 0.467 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.033 * safezoneH;
		tooltip = "Add objects to Curator (HAS NO EFFECT IN EDEN)";
		checked = "if is3DEN then { 0 } else { 1 }";
	};
	class ZEI_IF_Button_OK: RscButton
	{
		idc = -1;
		text = "OK"; //--- ToDo: Localize;
		x = 0.360781 * safezoneW + safezoneX;
		y = 0.522 * safezoneH + safezoneY;
		w = 0.04125 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick  = "[ lbCurSel (findDisplay 1705 displayCtrl 10), round (sliderPosition (findDisplay 1705 displayCtrl 20)), cbChecked (findDisplay 1705 displayCtrl 30) ] spawn ZEI_fnc_ui_interiorFill; (findDisplay 1705) closeDisplay 1;";
	};
	class ZEI_IF_Button_Cancel: RscButton
	{
		idc = -1;
		text = "Cancel"; //--- ToDo: Localize;
		x = 0.494844 * safezoneW + safezoneX;
		y = 0.522 * safezoneH + safezoneY;
		w = 0.04125 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick  = "(findDisplay 1705) closeDisplay 2;";
	};
};