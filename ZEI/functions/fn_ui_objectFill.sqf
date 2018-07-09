params [
		["_type", 0],
		["_pc", 30],
		["_addZeus", TRUE]
	];

// Checks if the passed object can be decorated or not.
_fnc_checkObject = {
	params [["_objToFill", objNull]];
		
	_offSet = [];
	_fromEdge = [0.1,0.05,0.1,0.05]; // Indent from XX & YY boundingBox.
	_itemSpacing = [0.2,0.2]; // Space between items.
	
	switch (typeOf _objToFill) do {
		case "Land_CashDesk_F": {_fromEdge = [0.2,0.2,0.3,0.05]; _offSet = [-0.27,-0.76,-1.26]};
		case "Land_CratesWooden_F": {_fromEdge = [1.88,0.2,0.3,0.3]; _offSet = [-0.78]};
		case "Fridge_01_open_F": {_fromEdge = [0.7,0.7,0.8,0.7]; _offSet = [-0.78,-1.33,-1.51]};
		case "Fridge_01_closed_F": {_fromEdge = [0.6,0.6,0.6,0.6]; _offSet = [-0.78]};
		case "Land_Metal_rack_F": {_fromEdge = [0.15,0.1,0.15,0.1]; _offSet = [-0.35,-0.8,-1.25,-1.7]};
		case "Land_Metal_rack_Tall_F": {_fromEdge = [0.1,0.1,0.15,0.05]; _offSet = [-0.075,-0.46,-0.84,-1.22,-1.6]};
		case "Land_Metal_wooden_rack_F": {_offSet = [0,-0.42,-0.92,-1.42,-1.92]};
		case "Land_MobileScafolding_01_F": {_offSet = [-1.125]};
		case "Land_Rack_F": {_fromEdge = [0.2,0.2,0.2,0.2]; _offSet = [-0.15,-0.53,-0.84,-1.2,-1.52]};
		case "Land_ShelvesWooden_F"; 
		case "Land_ShelvesWooden_blue_F"; 
		case "Land_ShelvesWooden_khaki_F": {_fromEdge = [0.1,0.1,0.2,0.2]; _offSet = [-0.05,-0.39,-0.71]};
		case "Land_ShelvesMetal_F": {_fromEdge = [0.24,0.1,0.1,0.1];_offSet = [-0.24,-0.595,-0.945,-1.3]};
		case "Land_TablePlastic_01_F": {_fromEdge = [0.3,0.3,0.1,0.1]; _offSet = [-0.005]};
		case "Land_ToolTrolley_01_F": {_fromEdge = [0.15,0.15,0.25,0.25]; _offSet = [-0.13,-0.48,-0.83]};
		case "Land_RattanTable_01_F"; 
		case "Land_WoodenTable_large_F"; 
		case "Land_WoodenTable_small_F": {_offSet = [-0.01]}; 
		case "Land_Workbench_01_F": {_fromEdge = [0.1,0.1,0.35,0.1]; _offSet = [-0.175]};
		case "Land_OfficeCabinet_02_F": {_fromEdge = [0.2,0.2,0.2,0.2]; _offSet = [0,-0.39,-0.74]};
		case "OfficeTable_01_new_F";
		case "OfficeTable_01_old_F": {_fromEdge = [1.1,1,0.65,0.6]; _offSet = [-0.65]};
		case "Land_TableBig_01_F":  {_fromEdge = [0.25,0.25,0.25,0.25]; _offSet = [-0.01]};
		case "Land_TableDesk_F": {_fromEdge = [0.1,0.1,0.1,0.1]; _offSet = [0]};
		case "Land_TableSmall_01_F": {_fromEdge = [0.15,0.1,0.15,0.1]; _offSet = [-0.01]};
		case "Land_CampingTable_F";
		case "Land_CampingTable_white_F": { _offSet = [-0.005]}; 	
		case "Land_CampingTable_small_F";
		case "Land_CampingTable_small_white_F": {_offSet = [0]}; 			
		case "Land_PicnicTable_01_F": { _offSet = [-0.01]};
		case "Land_WoodenCounter_01_F": {_fromEdge = [0.2,0.2,0.2,0.2]; _offSet = [-0.03,-0.77]};
	};
	
	if (_offSet isEqualTo []) exitWith { 
		[format ["No offset provided for Model!", _count], "ERROR"] call ZEI_fnc_misc_logMsg;
	};
	
	_objBB = boundingBox _objToFill;
	{
		for [{_i = ((_objBB select 0) select 0) + (_fromEdge select 0)}, {_i < ((_objBB select 1) select 0) - (_fromEdge select 1)}, {_i =  _i + (_itemSpacing select 0) + random 0.1}] do {
			for [{_j = ((_objBB select 0) select 1) + (_fromEdge select 2)}, {_j < ((_objBB select 1) select 1) - (_fromEdge select 3)}, {_j = _j + (_itemSpacing select 1) + random 0.1}] do {
				if (random 100 < _pc) then {
					[_objToFill, selectRandom _itemArray, [_i, _j, ((_objBB select 1) select 2) + _x]] call _fnc_attachItem;
				};
			};
		};
	} forEach _offSet;
};

// Spawns an item to its parent at the requested offset
_fnc_attachItem = {
	params ["_parent","_item","_itemToPos",["_forceDir",random 360]];
	
	// Get rotation for Eden / Zeus
	([_parent] call ZEI_fnc_misc_Vector2Eden) params ["_xRot", "_yRot", "_zRot"];
	
	// Spawn items depending on Zeus/Eden
	if (is3DEN) then {
		private _obj = create3DENEntity ["Object", _item, [0,0,0], TRUE];
		_obj set3DENAttribute ["position", (_parent modelToWorld _itemToPos)];
		_obj set3DENAttribute ["rotation", [ _xRot, _yRot, _zRot + _forceDir]];
		_obj set3DENAttribute ["enableSimulation", FALSE];
		_obj set3DENAttribute ["objectIsSimple", TRUE];
	} else {	
		private _obj = objNull;
		
		if (_addZeus) then {
			_obj = createVehicle [_item, [0,0,0], [], 0, "CAN_COLLIDE"];
			[_obj, FALSE] remoteExec ["enableSimulationGlobal", 2];
		} else {
			_obj =  createSimpleObject [_item, [0,0,0]];
		};
		
		_obj setPosATL (_parent modelToWorld _itemToPos);
		_obj setVectorDirAndUp [vectorDir _parent, vectorUp _parent];
		[_obj, _forceDir] call ZEI_fnc_misc_rotateAroundOwnAxisZ;
		
		{ [_x, [ [_obj], TRUE]] remoteExec ["addCuratorEditableObjects",2] } forEach allCurators;
	};
};

_classNames = [
	"Fridge_01_closed_F",
	"Fridge_01_open_F",
	"Land_CampingTable_F",
	"Land_CampingTable_small_F",
	"Land_CampingTable_small_white_F",
	"Land_CampingTable_white_F",
	"Land_CratesWooden_F",
	"Land_Metal_rack_F",
	"Land_Metal_rack_Tall_F",
	"Land_Metal_wooden_rack_F",
	"Land_MobileScafolding_01_F",
	"Land_OfficeCabinet_02_F",
	"Land_PicnicTable_01_F",
	"Land_Rack_F",
	"Land_RattanTable_01_F",
	"Land_ShelvesMetal_F",
	"Land_ShelvesWooden_F",
	"Land_ShelvesWooden_blue_F",
	"Land_ShelvesWooden_khaki_F",
	"Land_TableBig_01_F",
	"Land_TableDesk_F",
	"Land_TablePlastic_01_F",
	"Land_TableSmall_01_F",
	"Land_ToolTrolley_01_F",
	"Land_WoodenCounter_01_F",
	"Land_WoodenTable_large_F",
	"Land_WoodenTable_small_F",
	"Land_Workbench_01_F",
	"OfficeTable_01_new_F",
	"OfficeTable_01_old_F",
	"Land_CashDesk_F"];

_tmpArr = nearestObjects [(missionNamespace getVariable ["ZEI_LastPos", [0,0,0]]), _classNames, 10, TRUE];

if (_tmpArr isEqualTo []) exitWith {
	["No suitable objects found!", "ERROR"] call ZEI_fnc_misc_logMsg;
};

_foodItems = ["Land_Orange_01_F","Land_WaterBottle_01_empty_F","Land_WaterBottle_01_full_F","Land_BottlePlastic_V1_F","Land_Can_Rusty_F","Land_Can_V1_F","Land_Can_V2_F","Land_Can_V3_F","Land_TacticalBacon_F","Land_Can_Dented_F","Land_BottlePlastic_V2_F","Land_BakedBeans_F","Land_PowderedMilk_F","Land_RiceBox_F","Land_Tableware_01_stackOfNapkins_F","Land_Tableware_01_cup_F","Land_TinContainer_F"];
_healItems = ["Item_FirstAidKit","Land_Bandage_F","MedicalGarbage_01_Bandage_F","MedicalGarbage_01_Packaging_F","Land_Bandage_F","MedicalGarbage_01_Injector_F","MedicalGarbage_01_FirstAidKit_F","Land_Antibiotic_F","Land_Bandage_F","Land_DisinfectantSpray_F","Land_HeatPack_F","Land_IntravenBag_01_full_F","Land_Bandage_F","Land_PainKillers_F","Land_VitaminBottle_F","Land_WaterPurificationTablets_F"];
_deskItems = ["Land_FMradio_F","Land_PortableLongRangeRadio_F","Land_Camera_01_F","Land_HandyCam_F","Land_MobilePhone_old_F","Land_MobilePhone_smart_F","Land_Battery_F","Land_File1_F","Land_FilePhotos_F","Land_Notepad_F","Land_PenBlack_F","Land_PenRed_F","Land_PencilBlue_F","Land_PencilGreen_F","Land_PencilRed_F","Land_PensAndPencils_F","Land_Photos_V3_F","Land_Photos_V4_F","Land_Photos_V5_F","Land_Photos_V6_F","Land_Money_F"];
_toolItems = ["Land_Matches_F","Land_ButaneCanister_F","Land_ButaneTorch_F","Land_CanOpener_F","Land_DuctTape_F","Land_DustMask_F","Land_File_F","Land_GasCanister_F","Land_GasCooker_F","Land_Gloves_F","Land_MultiMeter_F","Land_Pliers_F","Land_Rope_01_F","Land_Screwdriver_V2_F","Land_Screwdriver_V1_F","Land_Meter3m_F","Land_Wrench_F"];

_itemArray = switch (_type) do {
	case 1: { _foodItems };
	case 2: { _healItems };
	case 3: { _deskItems };
	case 4: { _toolItems };
	default { _foodItems + _healItems + _deskItems + _toolItems };
};

if (is3DEN) then {
	collect3DENHistory {
		[_tmpArr select 0] call _fnc_checkObject;
		(_tmpArr select 0) set3DENAttribute ["enableSimulation", FALSE];
	};
} else {
	[_tmpArr select 0] call _fnc_checkObject;
};