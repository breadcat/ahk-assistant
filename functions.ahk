
dirWorking() {
    If A_OSVersion in WIN_XP
      {
        Run %A_MyDocuments%
      }
    Else
      {
        Run %A_MyDocuments%\..\Downloads
      }
    Return
  }

dirSync() {
    If A_OSVersion in WIN_XP
      {
        Run %A_MyDocuments%\Vault
        WinWaitActive ahk_class CabinetWClass ; wait for window to display
        {
					PostMessage, 0x111, 28715,,, ahk_class CabinetWClass ; enable list view to work around thumbnail no icons bug
				}
      }
    Else
      {
        Run %A_MyDocuments%\..\Vault
        WinWaitActive ahk_class CabinetWClass ; wait for window to display
        {
					PostMessage, 0x111, 28715,,, ahk_class CabinetWClass ; at this point, i just like list view
					Send, +{Tab} ; weird glitch fix where focus is on the sort columns meaning you need to press enter twice
				}

      }
    Return
  }

launchTerminal() {
    If A_OSVersion in WIN_XP
      {
        Run C:\cygwin\bin\mintty.exe -
      }
    Else
      {
        Run C:\cygwin64\bin\mintty.exe -
      }
    Return
  }

launchKeepass() {
    If A_OSVersion in WIN_XP
      {
        Run "%A_MyDocuments%\Vault\docs\keepass\KeePass.exe"
      }
    Else
      {
        Run "%A_MyDocuments%\..\Vault\docs\keepass\KeePass.exe"
      }
    Return
  }

insertGateway() {
    RunWait , %comspec% /c ipconfig > %A_Temp%\gw.txt,, Hide
    ArrayCount = 0
    Loop, Read, %A_Temp%\gw.txt
      {
        Count := RegExMatch(A_LoopReadLine, ".*Default Gateway .+ ((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)).*",ip)
        If ( %Count% != 0) {
            ArrayCount += 1
            IP_Array%ArrayCount% := ip1
            gateway := ip1
          }
      }
    FileDelete %A_Temp%\gw.txt
    Send, %gateway%
  }

insertCRMFooter() {
		insertFooter()
		Send, {F6}javascript:document.getElementById("SAVE_FOOTER").focus(){Sleep 10}{Enter}{Sleep 25}{Space}
		Return
	}

insertFooter() {
		Send, {Enter}
		insertDateTime()
		Send, {Space}
		insertSignature()
  Return
	}

insertDate() {
    FormatTime, CurrentDateTime,, yyyy-MM-dd
    Send %CurrentDateTime%
    Return
  }

insertTime() {
    FormatTime, CurrentDateTime,, HH:mm
    Send %CurrentDateTime%
    Return
  }

insertDateTime() {
    FormatTime, CurrentDateTime,, yyyy-MM-dd HH:mm
    Send %CurrentDateTime%
    Return
  }

appendClipboard() {
    backupClipboard = %clipboard%
    Send, ^c
    clipboard = %backupClipboard%`r`n%clipboard%
    backupClipboard = 
    Return
  }

insertSignature() {
    global firstName
    global lastName
    StringLeft, firstinitial, firstname, 1
    StringLeft, lastinitial, lastname, 1
    Send, %A_Space%-%firstinitial%%lastinitial%
  }

pasteClipboard() { ; manually paste clipboard, minus formatting
    StringReplace, clipboard, clipboard, %A_Tab%,, All ; remove tabs
    clipboard = %clipboard% ; trim whitespace
    SendRaw %clipboard%
    Return
  }

pasteTelephone() {
    backupClipboard = %clipboard%
    Send, ^c
    StringReplace, clipboard, clipboard, +44, 0, All ;translate intl codes
    StringReplace, clipboard, clipboard, %A_Space%,, All ;remove spaces
    StringReplace, clipboard, clipboard, %A_Tab%,, All ;remove tabs
    StringReplace, clipboard, clipboard, `,,, All ;remove commas
    StringReplace, clipboard, clipboard, `r,, All ;remove lines
    StringReplace, clipboard, clipboard, `n,, All ;remove lines
    StringReplace, clipboard, clipboard, -,, All ;remove hyphens
    StringReplace, clipboard, clipboard, (,, All ;remove lbracket
    StringReplace, clipboard, clipboard, ),, All ;remove rbracket
    StringLeft, 5Digits, clipboard, 5
    StringRight, 6Digits, clipboard, 6
    Send %5Digits% %6Digits%
    5Digits = 
    6Digits = 
    Clipboard := backupClipboard
    backupClipboard = 
    Return
  }

dialTelephone() { ;lg phone-link
    backupClipboard := Clipboard
    Send, ^c
    StringReplace, clipboard, clipboard, +44, 0, All ;translate intl codes
    Run, dial://%clipboard% ;must enable internet dialling to work
    Clipboard := backupClipboard
    backupClipboard =
    Return
  }

insertSyncDocs() {
    If A_OSVersion in WIN_XP
      {
        Send %A_MyDocuments%\Vault\docs\
      }
    Else
      {
        Send C:\Users\%A_UserName%\Vault\docs\
      }
    Return
  }

insertDocuments() {
    If A_OSVersion in WIN_XP
      {
        Send %A_MyDocuments%
      }
    Else
      {
        Send C:\Users\%A_UserName%\
      }
    Return
  }

insertSync() {
    If A_OSVersion in WIN_XP
      {
        Send %A_MyDocuments%\Vault\
      }
    Else
      {
        Send C:\Users\%A_UserName%\Vault\
      }
    Return
  }

insertCygwin() {
    If A_OSVersion in WIN_XP
      {
        Send C:\cygwin\home\%A_UserName%\
      }
    Else
      {
        Send C:\cygwin64\home\%A_UserName%\
      }
    Return
  }

cmdPaste() { ;C-v / S-insert pastes into cmd
    CoordMode, Mouse, Relative
    MouseMove, 100, 100
    Send {RButton}p
    Return
  }

toggleFullscreen() { ;double click the window
    CoordMode, Mouse, Relative
    MouseMove, 250, 250
    Send {Click 2}
    Return
  }

explorerUp() { ;up one folder
    If A_OSVersion in WIN_XP
      {
        Send {BackSpace}
      }
    Else
      {
        Send !{Up}
      }
    Return
  }

explorerRename() {
    If A_OSVersion in WIN_XP ;deselect file extension by determining final . character
      {
        backupClipboard = %Clipboard%
        Send {F2}{CtrlDown}c{CtrlUp}
        StringGetPos,ExtensionPos, Clipboard,.,R
        if (ExtensionPos != -1)
          {
            Position := StrLen(Clipboard) - ExtensionPos
            Send, {CtrlDown}{Home}{CtrlUp}{CtrlDown}{ShiftDown}{End}{CtrlUp}{Left %Position%}{ShiftUp}
          }
        Clipboard = %backupClipboard%
        backupClipboard =
      }
    Else
      {
        Send {F2}
      }
    Return
  }

explorerCMD() { ;open command prompt in current location, now with support for other drives but still a bit glitchy as ever
    backupClipboard := Clipboard
    Send !d^x{Sleep 50}
    Run, cmd /K "cd `"%clipboard%`""
    StringLeft, DriveLetter, clipboard, 2
    WinWaitActive ahk_class ConsoleWindowClass
        Send, {Sleep 100}%driveLetter% & cls{Enter}
        Return
    Clipboard := backupClipboard
    backupClipboard =
    driveLetter =
    Return
  }

explorerHidden() { ;toggle show/hide hidden folders, stolen from http://www.autohotkey.com/board/topic/68131-turn-off-show-hidden-files-at-boot/
    RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
    If HiddenFiles_Status = 2
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
    Else
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
    WinGetClass, eh_Class,A
    If (eh_Class = "#32770" OR A_OSVersion = "WIN_VISTA" OR A_OSVersion = "WIN_7")
        Send, {F5}
    Else PostMessage, 0x111, 28931,,, A
    Return
  }

explorerNewDir() { ;allows xp to create new folder from keypress
    If A_OSVersion in WIN_XP
      {
        Send !fwf
      }
    Else
      {
        Send ^+n
      }
    Return
  }

explorerNewFile() { ;create a new blank text file
    If A_OSVersion in WIN_XP
      {
        Send !fwt{CtrlDown}{Home}{ShiftDown}{End}{CtrlUp}{Left 4}{ShiftUp} ;new text file, and deselect file extension
      }
    Else
      {
        Send !fwt ;clever windows 7 already knows to skip file extensions
      }
    Return
  }

excelFormulaBar() { ;jumps to formula bar
    CoordMode, Mouse, Relative
    MouseMove, 170, 75
    Send {LButton}
    Return
  }

borderlessFullscreen() { ;borderless fullscreen script from PCGW (http://pcgamingwiki.com/wiki/Glossary:Borderless_fullscreen_windowed#Borderless_scripts)
    WinGet, WindowID, ID, A
    WinSet, Style, -0xC40000, ahk_id %WindowID%
    WinMove, ahk_id %WindowID%, , 0, 0, A_ScreenWidth, A_ScreenHeight
    Return
  }

mstscSpecific() {
    If A_OSVersion in WIN_XP
      {
        global serverLocalIPAddress
        Run mstsc /v:%serverLocalIPAddress%
      }
    Else
      {
        global serverRemoteIPAddress
        Run mstsc /v:%serverRemoteIPAddress%
      }
    Return
  }


insertRegards() {
    global firstName
    Send,`n`nRegards,`n%firstName%.
    Return
  }

insertKindRegards() {
    global firstName
    Send,`n`nKind regards,`n%firstName%.
    Return
  }

insertEmailAddress() {
    If A_OSVersion in WIN_XP
      {
        global workEmailAddress
        Send, %workEmailAddress%
      }
    Else
      {
        global homeEmailAddress
        Send, %homeEmailAddress%
      }
    Return
  }

insertWorkIP() {
    global workIPAddress
    Send, %workIPAddress%
    Return
  }

insertSIPIP() {
    global workSIPAddress
    Send, %workSIPAddress%
    Return
  }

insertTelephoneNumber() {
    If A_OSVersion in WIN_XP
      {
        global workPhoneNumber
        Send, %workPhoneNumber%
      }
    Else
      {
        global homePhoneNumber
        Send, %homePhoneNumber%
      }
    Return
  }

insertMobileNumber() {
    global mobilePhoneNumber
    Send, %mobilePhoneNumber%
    Return
  }

insertAddress() {
    If A_OSVersion in WIN_XP
      {
        global workAddress
        Send, %workAddress%
      }
    Else
      {
        global homeAddress
        Send, %homeAddress%
      }
    Return
  }

insertPostCode() {
    If A_OSVersion in WIN_XP
      {
        global workPostCode
        Send, %workPostCode%
      }
    Else
      {
        global homePostCode
        Send, %homePostCode%
      }
    Return
  }

searchCustomer() {
    global crmSearch
    backupClipboard := Clipboard
    Send, ^c
    Run, %crmSearch%%clipboard%
    Clipboard := backupClipboard
    backupClipboard =
    Return
  }

toggleAudioDevice() { ;toggle between default audio output (http://ml.pe/optimizing/2013/changing-the-default-sound-device-using-autohotkey/)
    switch := !switch
    If (switch)
        usePlaybackDevice(1)
    Else
        usePlaybackDevice(3)
    Return
  }

usePlaybackDevice(device) {
    Run, mmsys.cpl
    WinWaitActive, Sound ahk_class #32770
    ControlSend, SysListView321,{Down %device%}, Sound ahk_class #32770
    ControlClick, Button2, Sound ahk_class #32770
    WinClose, Sound ahk_class #32770
  }

winSplit() { ;split active and previous window side by side
    Tile("R")
    Send {Sleep 15}{AltDown}{Tab}{AltUp}{Sleep 10}
    Tile("L")
    Send {Sleep 15}{AltDown}{Tab}{AltUp}
  }

winSplitH() { ;split active and previous window on top of each other
    Tile("T")
    Send {Sleep 15}{AltDown}{Tab}{AltUp}{Sleep 10}
    Tile("B")
    Send {Sleep 15}{AltDown}{Tab}{AltUp}
  }

tabSplit() {
    Tile("L") ;tiles left
    Send {Sleep 50}{Esc}{F6}+{Tab 2}{AppsKey}w{Sleep 250} ;break off current tab
    WinMaximize, A ;fixes black borders on bottom
    Tile("R") ;tiles right
    Return ;and you're back in the room
  }

changeResolution(w,h) {
    VarSetCapacity(dM,156,0)
    NumPut(156,dM,36)
    NumPut(0x5c0000,dM,40)
    NumPut(w,dM,108)
    NumPut(h,dM,112)
    DllCall( "ChangeDisplaySettingsA", UInt,&dM, UInt,0 )
  }

kdeMove() { ;kde-windows (Easy Window Dragging -- KDE style (requires XP/2k/NT) -- by Jonny)
    MouseGetPos,KDE_X1,KDE_Y1,KDE_id
    WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
    If KDE_Win
        WinRestore, A
    WinGetPos,KDE_WinX1,KDE_WinY1,,,ahk_id %KDE_id%
    Loop
      {
        GetKeyState,KDE_Button,LButton,P ; Break if Button has been released.
        If KDE_Button = U
            Break
        MouseGetPos,KDE_X2,KDE_Y2 ; Get the current Mouse position.
        KDE_X2 -= KDE_X1 ; Obtain an offset from the initial Mouse position.
        KDE_Y2 -= KDE_Y1
        KDE_WinX2 := (KDE_WinX1 + KDE_X2) ; Apply this offset to the window position.
        KDE_WinY2 := (KDE_WinY1 + KDE_Y2)
        WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2% ; Move the window to the new position.
      }
    Return
  }

kdeResize() {
    MouseGetPos,KDE_X1,KDE_Y1,KDE_id
    WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
    If KDE_Win
        WinRestore, A
    ; Get the initial window position and size.
    WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
    ; Define the window region the mouse is currently in.
    ; The four regions are Up and Left, Up and Right, Down and Left, Down and Right.
    If (KDE_X1 < KDE_WinX1 + KDE_WinW / 2)
        KDE_WinLeft := 1
    Else
        KDE_WinLeft := -1
    If (KDE_Y1 < KDE_WinY1 + KDE_WinH / 2)
        KDE_WinUp := 1
    Else
        KDE_WinUp := -1
    Loop
      {
        GetKeyState,KDE_Button,RButton,P ; Break if Button has been released.
        If KDE_Button = U
            Break
        MouseGetPos,KDE_X2,KDE_Y2 ; Get the current Mouse position.
        ; Get the current window position and size.
        WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
        KDE_X2 -= KDE_X1 ; Obtain an offset from the initial Mouse position.
        KDE_Y2 -= KDE_Y1
        ; Then, act according to the defined region.
        WinMove,ahk_id %KDE_id%,, KDE_WinX1 + (KDE_WinLeft+1)/2*KDE_X2  ; X of Resized window
                , KDE_WinY1 +   (KDE_WinUp+1)/2*KDE_Y2  ; Y of resized window
                , KDE_WinW  -     KDE_WinLeft  *KDE_X2  ; W of resized window
                , KDE_WinH  -       KDE_WinUp  *KDE_Y2  ; H of resized window
        KDE_X1 := (KDE_X2 + KDE_X1) ; Reset the initial position for the next iteration.
        KDE_Y1 := (KDE_Y2 + KDE_Y1)
      }
    Return
  }

Tile(Pos) {
    WinGetClass, class, A
    IfInString , shell_TrayWnd,Progman,Button,DV2ControlHost, %class%
    Return
    IfWinExist,ahk_class Shell_TrayWnd
        SysGet, m, MonitorWorkArea
    Else SysGet, m, Monitor
    WinGetPos, MWT_X, MWT_Y, MWT_W, MWT_H, A
    SendMessage, 0x1F,,,, A
    WinGet, MWT_active, MinMax, A
    If (MWT_active = 1)
        WinRestore, A
    If (Pos = "T")
        WinMove, A,, 0, 0, mRight, mBottom/2
    If (Pos = "B")
        WinMove, A,, 0, mBottom/2, mRight, mBottom/2
    If (Pos = "L")
        WinMove, A,, 0, 0, mRight/2, mBottom
    If (Pos = "R")
        WinMove, A,, mRight/2, 0, mRight/2, mBottom
    If (Pos = "TL")
        WinMove, A,, 0, 0, mRight/2, mBottom/2
    If (Pos = "TR")
        WinMove, A,, mRight/2, 0, mRight/2, mBottom/2
    If (Pos = "BR")
        WinMove, A,, mRight/2, mBottom/2, mRight/2, mBottom/2
    If (Pos = "BL")
        WinMove, A,, 0, mBottom/2, mRight/2, mBottom/2
  }
