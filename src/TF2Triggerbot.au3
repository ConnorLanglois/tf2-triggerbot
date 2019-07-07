Local $team = 0

_Main()

Func _Main()
	_Init()
	_Run()
EndFunc

Func _Init()
	; AutoItSetOption('MouseCoordMode', 2)
	HotKeySet('{END}', '_Exit')
	HotKeySet('`', '_ChangeTeam')

	_Window_Attach('Team Fortress 2')
EndFunc

Func _Run()
	Local $hWnd = WinWait('Team Fortress 2', '', 5)
	Local $mouseOffset = 5
	Local $color
	Local $colorVariation
	Local $mouse
	Local $fire
	Local $timer
	Local $nShots = 0

	While True
		$color = $team = 0 ? 0x6494B0 : $team = 1 ? 0xCD4448 : 0
		$colorVariation = $team = 0 ? 37 : $team = 1 ? 45 : 0

		ToolTip('    ' & ($team = 0 ? 'Blue' : $team = 1 ? 'Red' : 'None') & @CRLF & '    ' & $nShots, 0, 0, 'TF2 Triggerbot')

		$mouse = MouseGetPos()
		$fire = PixelSearch($mouse[0] - $mouseOffset, $mouse[1] - $mouseOffset, $mouse[0] + $mouseOffset, $mouse[1] + $mouseOffset, $color, $colorVariation, 1, $hWnd)

		If $fire <> 0  And TimerDiff($timer) >= 1500 Then
			MouseClick('primary', $mouse[0], $mouse[1], 1, 0)

			$nShots += 1
			$timer = TimerInit()
		EndIf
	WEnd
EndFunc

Func _Run2()
	Local $hWnd = WinWait('Team Fortress 2', '', 5)
	Local $mouseOffset = 50
	Local $color
	Local $colorVariation
	Local $mouse
	Local $fire
	Local $fireColor
	Local $isMouseRight

	While True
		$color = $team = 0 ? 0x6494B0 : $team = 1 ? 0xCD4448 : 0
		$colorVariation = $team = 0 ? 37 : $team = 1 ? 35 : 0
		$mouse = MouseGetPos()
		$fire = PixelSearch($mouse[0] - $mouseOffset, $mouse[1] - 5, $mouse[0] + $mouseOffset, $mouse[1] + 5, $color, $colorVariation, 1, $hWnd)

		If $fire <> 0 Then
			$fireColor = PixelGetColor($fire[0], $fire[1], $hWnd)

			While $fire <> 0
				$mouse = MouseGetPos()
				$isMouseRight = $mouse[0] >= $fire[0] ? True : False
				MouseMove($fire[0], $fire[1], 0)
				Sleep(50)

				If $isMouseRight Then
					MouseClick('primary', $mouse[0] - 4, $mouse[1] + 4, 1, 0)
				Else
					MouseClick('primary', $mouse[0] + 4, $mouse[1] + 4, 1, 0)
				EndIf

				$fire = PixelSearch($mouse[0] - $mouseOffset, $mouse[1] - 5, $mouse[0] + $mouseOffset, $mouse[1] + 5, $fireColor, 0, 1, $hWnd)

				Sleep(250)
			WEnd
		EndIf
	WEnd
EndFunc

Func _ChangeTeam()
	If $team = 1 Then
		$team = 0
	Else
		$team += 1
	EndIf
EndFunc

Func _Window_Attach($title)
	Local $hWnd = WinWait($title, '', 10)

	WinActivate($hWnd)

	If Not WinWaitActive($hWnd, '', 10) Then
		MsgBox(0, 'ERROR', 'Could not attach to window')
		_Exit()
	EndIf
EndFunc

Func _Exit()
	Exit
EndFunc
