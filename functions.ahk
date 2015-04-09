dirWorking() {
if A_OSVersion in WIN_XP
  {
  Run explorer %A_MyDocuments%
  }
  Else
  {
  Run explorer %A_MyDocuments%\..\Downloads
  }
  Return
  }

dirSync() {
if A_OSVersion in WIN_XP
  {
  Run explorer %A_MyDocuments%\Vault
  }
  Else
  {
  Run explorer %A_MyDocuments%\..\Vault
  }
  Return
  }

launchTerminal() {
if A_OSVersion in WIN_XP
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
if A_OSVersion in WIN_XP
  {
  Run "%A_MyDocuments%\Vault\docs\keepass\KeePass.exe"
  }
  Else
  {
  Run "%A_MyDocuments%\..\Vault\docs\keepass\KeePass.exe"
  }
  Return
  }

insertDate() {
  FormatTime, CurrentDateTime,, yyyy-MM-dd
  Send %CurrentDateTime%
  return
  }
insertDateTime() {
  FormatTime, CurrentDateTime,, yyyy-MM-dd HHmm
  Send %CurrentDateTime%
  return
  }

appendClipboard() {
  newclipboard = %clipboard%
  Send, ^c
  clipboard = %newclipboard%`r`n%clipboard%
  return
  }

pasteTelephone() {
  StringReplace, clipboard, clipboard, +44, 0, All ;translate intl codes
  StringReplace, clipboard, clipboard, %A_SPACE%,, All ;remove spaces
  StringReplace, clipboard, clipboard, %A_Tab%, `,, All ;remove tabs
  StringReplace, clipboard, clipboard, `,,, All ;remove commas
  StringReplace, clipboard, clipboard, `r,, All ;remove lines
  StringReplace, clipboard, clipboard, `n,, All ;remove lines
  StringReplace, clipboard, clipboard, -,, All ;remove hyphens
  StringReplace, clipboard, clipboard, (,, All ;remove lbracket
  StringReplace, clipboard, clipboard, ),, All ;remove rbracket
  StringLeft, 5digits, clipboard, 5
  StringRight, 6digits, clipboard, 6
  Send %5digits% %6digits%
  return
  }

typeSyncDocs() {
if A_OSVersion in WIN_XP
  {
  Send %A_MyDocuments%\Vault\docs\
  }
  Else
  {
  Send C:\Users\%A_UserName%\Vault\docs\
  }
  Return
  }
typeDocuments() {
if A_OSVersion in WIN_XP
  {
  Send %A_MyDocuments%
  }
  Else
  {
  Send C:\Users\%A_UserName%\
  }
  Return
  }
typeVault() {
if A_OSVersion in WIN_XP
  {
  Send %A_MyDocuments%\Vault\
  }
  Else
  {
  Send C:\Users\%A_UserName%\Vault\
  }
  Return
  }
typeCygwin() {
if A_OSVersion in WIN_XP
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
  return
  }

explorerUp() { ;up one folder
  if A_OSVersion in WIN_XP
  {
  Send {Backspace}
  }
  Else
  {
  Send !{Up}
  }
  Return
  }

explorerRename() {
  if A_OSVersion in WIN_XP
  {
  Send {F2}{Ctrldown}{Home}{Shiftdown}{End}{Ctrlup}{Left 4}{Shiftup} ; rename (hopefully) deselects file extension
  }
  Else
  {
  Send {F2}
  }
  Return
  }

explorerCMD() { ;open command prompt in current location
  ClipSaved := ClipboardAll
  Send !d^c
  Run, cmd /K "cd `"%clipboard%`""
  Clipboard := ClipSaved
  ClipSaved =
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
    send, {F5}
  Else PostMessage, 0x111, 28931,,, A
  Return
  }

explorerNewDir() { ;allows xp to create new folder from keypress
  if A_OSVersion in WIN_XP
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
  if A_OSVersion in WIN_XP
  {
  Send !fwt{End}{Left 4}{ShiftDown}{Home}{ShiftUp} ;new text file, and deselect file extension
  }
  Else
  {
  Send !fwt ;clever windows 7 already knows to skip file extensions
  }
  Return
  }

excelFormulaBar() { ;jumps to formula bar
  CoordMode, Mouse, Relative
  MouseMove, 180, 60
  Send {LButton}
  return
  }

borderlessFullscreen() { ;borderless fullscreen script from PCGW (http://pcgamingwiki.com/wiki/Glossary:Borderless_fullscreen_windowed#Borderless_scripts)
  WinGet, WindowID, ID, A
  WinSet, Style, -0xC40000, ahk_id %WindowID%
  WinMove, ahk_id %WindowID%, , 0, 0, A_ScreenWidth, A_ScreenHeight
  return
  }

;toggle between default audio output (http://ml.pe/optimizing/2013/changing-the-default-sound-device-using-autohotkey/)
toggleAudioDevice() {
    switch := !switch
    If (switch)
        usePlaybackDevice(1)
    else
        usePlaybackDevice(3)
    return
    }
 usePlaybackDevice(device) {
  Run, mmsys.cpl
  WinWaitActive, Sound ahk_class #32770
  ControlSend, SysListView321,{Down %device%}, Sound ahk_class #32770
  ControlClick, Button2, Sound ahk_class #32770
  WinClose, Sound ahk_class #32770
}

winSplit() { ;split active and previous window side by side, press again to swap positions
  splitToggle := !splitToggle
  If (splitToggle) {
    Tile("R")
    Sleep, 15
    Send {AltDown}{Tab}{AltUp}
    Sleep, 10
    Tile("L")
    Sleep, 15
    Send {AltDown}{Tab}{AltUp}
    }
  else {
    Send {AltDown}{Tab}{AltUp}
    Sleep, 10
    winSplit()
    }
  return
  }

kdeMove() {
  MouseGetPos,KDE_X1,KDE_Y1,KDE_id
  WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
  If KDE_Win
      WinRestore, A
  WinGetPos,KDE_WinX1,KDE_WinY1,,,ahk_id %KDE_id%
  Loop
  {
      GetKeyState,KDE_Button,LButton,P ; Break if button has been released.
      If KDE_Button = U
          break
      MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
      KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
      KDE_Y2 -= KDE_Y1
      KDE_WinX2 := (KDE_WinX1 + KDE_X2) ; Apply this offset to the window position.
      KDE_WinY2 := (KDE_WinY1 + KDE_Y2)
      WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2% ; Move the window to the new position.
  }
  return
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
      GetKeyState,KDE_Button,RButton,P ; Break if button has been released.
      If KDE_Button = U
          break
      MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
      ; Get the current window position and size.
      WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
      KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
      KDE_Y2 -= KDE_Y1
      ; Then, act according to the defined region.
      WinMove,ahk_id %KDE_id%,, KDE_WinX1 + (KDE_WinLeft+1)/2*KDE_X2  ; X of resized window
                              , KDE_WinY1 +   (KDE_WinUp+1)/2*KDE_Y2  ; Y of resized window
                              , KDE_WinW  -     KDE_WinLeft  *KDE_X2  ; W of resized window
                              , KDE_WinH  -       KDE_WinUp  *KDE_Y2  ; H of resized window
      KDE_X1 := (KDE_X2 + KDE_X1) ; Reset the initial position for the next iteration.
      KDE_Y1 := (KDE_Y2 + KDE_Y1)
  }
  return
  }

Tile(Pos)
{
  WinGetClass, class, A
  IfInString , shell_TrayWnd,Progman,Button,DV2ControlHost, %class%
  Return
  IfWinExist,ahk_class Shell_TrayWnd
    SysGet, m, MonitorWorkArea
    Else SysGet, m, Monitor
      WinGetPos, MWT_X, MWT_Y, MWT_W, MWT_H, A
      SendMessage, 0x1F,,,, A
      WinGet, MWT_active, MinMax, A
    if (MWT_active = 1)
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
Return
