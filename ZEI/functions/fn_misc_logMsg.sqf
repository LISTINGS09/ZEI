// ["text", "DEBUG"] call ZEI_fnc_misc_logMsg;
params ["_msg", "_lev"];

_lev = toUpper _lev;

if ((_lev isEqualTo "DEBUG") && !(missionNamespace getVariable ["ZEI_DEBUG", FALSE])) exitWith {};

systemChat format ["[%1] %2", _lev, _msg];
diag_log text format ["[ZEI][%1][%2] - %3", _lev, _fnc_scriptNameParent, _msg];