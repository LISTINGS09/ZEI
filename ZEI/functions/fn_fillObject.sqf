params [["_mode","",[""]],["_input",[],[[]]]];

// ["init",[(get3DENSelected "object") select 0,true,false]] execVM "fn_fillFood.sqf";

// Checks if the passed object can be decorated or not.
_fnc_checkObject = {
	params [["_obj",objNull]];
	
	if (_obj getVariable ["zei_isFilled",false]) exitWith {};
	
	// Set variable to skip future processing.
	_obj setVariable ["zei_isFilled",true];
		
	private ["_offSet"];
	
	_fillPercent = 30;
	_fromEdge = [0.1,0.05,0.1,0.05]; // Indent from XX & YY boundingBox.
	_itemSpacing = [0.2,0.2]; // Space between items.
	
	switch (typeOf _obj) do {
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
	
	if (isNil "_offSet") exitWith {};
	
	//systemChat format["[ZEI] Processing %1",typeOf _obj];
	_objBB = boundingBox _obj;
	{
		for [{_i = ((_objBB select 0) select 0)+(_fromEdge select 0)},{_i < ((_objBB select 1) select 0)-(_fromEdge select 1)},{_i =  _i + (_itemSpacing select 0) + random 0.1}] do {
			for [{_j = ((_objBB select 0) select 1)+(_fromEdge select 2)},{_j < ((_objBB select 1) select 1)-(_fromEdge select 3)},{_j = _j + (_itemSpacing select 1) + random 0.1}] do {
				if (random 100 < _fillPercent) then {
					[_obj,selectRandom _itemArray,[_i,_j,((_objBB select 1) select 2) + _x]] call _fnc_attachItem;
				};
			};
		};
	} forEach _offSet;
};

// Spawns an item to its parent at the requested offset
_fnc_attachItem = {
	params ["_parent","_item","_itemToPos",["_forceDir",random 360]];
	private ["_yRot","_xRot"];

	//diag_log text format["[DEBUG] (z_fillItems.sqf): Creating item '%1' on '%2' at %3.",_item,_parent,_itemToPos];
	
	// Get rotation
	_direction = vectorDir _parent;
	_up = vectorUp _parent;
	_aside = _direction vectorCrossProduct _up;

	if (abs (_up select 0) < 0.999999) then {
		_yRot = -asin (_up select 0);
		private _signCosY = if (cos _yRot < 0) then { -1 } else { 1 };
		_xRot = (_up select 1 * _signCosY) atan2 (_up select 2 * _signCosY);
	} else {
		if (_up select 0 < 0) then {
			_yRot = 90;
			_xRot = (_aside select 1) atan2 (_aside select 2);
		} else {
			_yRot = -90;
			_xRot = (-(_aside select 1)) atan2 (-(_aside select 2));
		};
	};
	
	_pos = _parent modelToWorld _itemToPos;
	
	// Spawn items depending on Zeus/Eden
	if (is3DEN) then {
		private _obj = create3DENEntity ["Object", _item, [0,0,0], true];
		_obj set3DENAttribute ["position", _pos];
		_obj set3DENAttribute ["rotation", [ _xRot, _yRot, _forceDir]];
		_obj set3DENAttribute ["objectIsSimple", true];
		_obj set3DENAttribute ["enableSimulation", false];
	} else {				
		// TODO: Sort x & y ROT of _bld to object.
		private _obj =  createSimpleObject [_item, [0,0,0]];
		_obj setPos (AGLtoASL _pos);
		_obj setVectorDirAndUp [_direction,_up];
		_obj setDir _forceDir;
	};
};

switch _mode do {
	case "init": {
		_input params [["_logic",objNull,[objNull]],["_isActivated",true,[true]], ["_isCuratorPlaced",false,[true]]];
						
		//systemChat format ["VAR: %1 %2 %3 %4",_logic getVariable "fillArea",  _logic getVariable ["searchRadius", _logic getVariable "fillType", _input];
		
		private _fillArea = _logic getVariable ["ZEI_fillObjectAny_fillType",false];
		private _searchRadius = _logic getVariable ["searchRadius",50];
		private _type = _logic getVariable ["fillType","any"];
		private _objArr = nearestObjects [_logic, ["Thing"], _searchRadius, true]; 
		
		if (!_fillArea && count _objArr > 1) then { _objArr resize 1; };
		
		//systemChat format["Debug: %1 %2 %3",_objArr];
		
		// Delete the module to prevent any dependencies.
		if (_logic isKindOf "Logic") then {
			if (_isCuratorPlaced) then { deleteVehicle _logic; } else { delete3DENEntities [_logic]; };
		};
		
		private _foodItems = ["Land_Orange_01_F","Land_WaterBottle_01_empty_F","Land_WaterBottle_01_full_F","Land_BottlePlastic_V1_F","Land_Can_Rusty_F","Land_Can_V1_F","Land_Can_V2_F","Land_Can_V3_F","Land_TacticalBacon_F","Land_Can_Dented_F","Land_BottlePlastic_V2_F","Land_BakedBeans_F","Land_PowderedMilk_F","Land_RiceBox_F","Land_Tableware_01_stackOfNapkins_F","Land_Tableware_01_cup_F","Land_TinContainer_F"];
		private _healItems = ["Item_FirstAidKit","Land_Bandage_F","MedicalGarbage_01_Bandage_F","MedicalGarbage_01_Packaging_F","Land_Bandage_F","MedicalGarbage_01_Injector_F","MedicalGarbage_01_FirstAidKit_F","Land_Antibiotic_F","Land_Bandage_F","Land_DisinfectantSpray_F","Land_HeatPack_F","Land_IntravenBag_01_full_F","Land_Bandage_F","Land_PainKillers_F","Land_VitaminBottle_F","Land_WaterPurificationTablets_F"];
		private _deskItems = ["Land_FMradio_F","Land_PortableLongRangeRadio_F","Land_Camera_01_F","Land_HandyCam_F","Land_MobilePhone_old_F","Land_MobilePhone_smart_F","Land_Battery_F","Land_File1_F","Land_FilePhotos_F","Land_Notepad_F","Land_PenBlack_F","Land_PenRed_F","Land_PencilBlue_F","Land_PencilGreen_F","Land_PencilRed_F","Land_PensAndPencils_F","Land_Photos_V3_F","Land_Photos_V4_F","Land_Photos_V5_F","Land_Photos_V6_F","Land_Money_F"];
		private _toolItems = ["Land_Matches_F","Land_ButaneCanister_F","Land_ButaneTorch_F","Land_CanOpener_F","Land_DuctTape_F","Land_DustMask_F","Land_File_F","Land_GasCanister_F","Land_GasCooker_F","Land_Gloves_F","Land_MultiMeter_F","Land_Pliers_F","Land_Rope_01_F","Land_Screwdriver_V2_F","Land_Screwdriver_V1_F","Land_Meter3m_F","Land_Wrench_F"];
								
		private _itemArray = switch (toUpper _type) do {
			case "FOOD": { _foodItems };
			case "HEAL": { _healItems };
			case "DESK": { _deskItems };
			case "TOOL": { _toolItems };
			default { _foodItems + _healItems + _deskItems + _toolItems };
		};
		
		if (_isCuratorPlaced) then {
			{ [_x] call _fnc_checkObject; } forEach _objArr;
		} else {
			collect3DENHistory {
				{ [_x] call _fnc_checkObject; } forEach _objArr;
			};
		};
	};
};

true