if !(missionNamespace getVariable ["ZEI_DEBUG", FALSE]) exitWith {};

private _msg = format ["[%1] - %2", _fnc_scriptNameParent, format _this];

diag_log _msg;
systemChat _msg;
