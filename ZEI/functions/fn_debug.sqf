if (isNil "ZEI_debug" || {!ZEI_debug}) exitWith {};

private _msg = format ["[%1] - %2", _fnc_scriptNameParent, format _this];

diag_log _msg;
systemChat _msg;
