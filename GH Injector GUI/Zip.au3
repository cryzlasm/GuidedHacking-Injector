#include <Array.au3>

; Full credits to torels_ (https://www.autoitscript.com/forum/topic/73425-zipau3-udf-in-pure-autoit/)

Func _Zip_UnzipAll($hZipFile, $hDestPath)

	If (_Zip_DllChk() <> 0) Then
		Return
	EndIf

	If (NOT FileExists($hZipFile)) Then
		Return
	EndIf

	If (NOT FileExists($hDestPath)) Then
		DirCreate($hDestPath)
	EndIf

	Local $aArray[1]
	$oApp = ObjCreate("Shell.Application")
	$oApp.Namespace($hDestPath).CopyHere($oApp.Namespace($hZipFile).Items)

	For $item In $oApp.Namespace($hZipFile).Items
		_ArrayAdd($aArray, $item)
	Next

	While True
		_Hide()
		If (FileExists($hDestPath & "\" & $aArray[UBound($aArray) - 1])) Then
			ExitLoop
		EndIf
		Sleep(500)
	WEnd

EndFunc

Func _Zip_DllChk()

	If NOT FileExists(@SystemDir & "\zipfldr.dll") Then Return 1
	If NOT RegRead("HKEY_CLASSES_ROOT\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}", "") Then Return 3

	Return 0

EndFunc

Func _Hide()

	If (ControlGetHandle("[CLASS:#32770]", "", "[CLASS:SysAnimate32; INSTANCE:1]") <> "" And WinGetState("[CLASS:#32770]") <> @SW_HIDE) Then
		$hWnd = WinGetHandle("[CLASS:#32770]")
		WinSetState($hWnd, "", @SW_HIDE)
	EndIf

EndFunc