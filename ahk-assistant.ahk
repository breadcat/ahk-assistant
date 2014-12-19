
; ^ctrl #win !alt +shift


;environment
#NoEnv
#SingleInstance,Force
SetTimer, ScriptReload, 1000
SetWinDelay,2
CoordMode,Mouse
SetWorkingDir %A_MyDocuments%\..\
ProgramFilesX86 := A_ProgramFiles . (A_PtrSize=8 ? " (x86)" : "") ;pfx86 variable from http://www.autohotkey.com/board/topic/79160-a-programfiles-for-programs-in-windows-7-x86-directory/

;keystates
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
SetNumLockState, AlwaysOn

;includes
#Include, %A_ScriptDir%\appspecific.ahk ;application specific hotkeys
#Include, %A_ScriptDir%\secret.ahk ;physical and ip address completions

;hotkeys
#q::Run notepad
^q::Send !{F4} ;quit most programs
#+q::Run notepad.exe "%A_MyDocuments%\Vault\docs\faulties.txt"
#w::Run firefox.exe
#+w::Run firefox.exe -private-window
#e:: ;launch documents directory
if A_OSVersion in WIN_XP
  {
  Run explorer %A_MyDocuments%
  }
  Else
  {
  Run explorer %A_MyDocuments%\..\Downloads
  }
  Return
#+e:: ;launch dropbox directory
if A_OSVersion in WIN_XP
  {
  Run explorer %A_MyDocuments%\Vault
  }
  Else
  {
  Run explorer %A_MyDocuments%\..\Vault
  }
  Return
^!e::Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d} ;my computer
^!r::Run mstsc ;remote desktop connection
#t::Run C:\cygwin\bin\mintty.exe -
#+t::Run cmd
^!b::Run %programfiles%\TeamViewer\Version9\TeamViewer.exe
^!v::Run %programfiles%\TightVNC\tvnviewer.exe
#p:: ;putty
if A_OSVersion in WIN_XP
  {
  Run "%A_MyDocuments%\Vault\git\dotfiles\putty.exe"
  }
  Else
  {
  Run "%ProgramFilesX86%\PuTTY\putty.exe"
  }
  Return
^!k:: ;keepass
if A_OSVersion in WIN_XP
  {
  Run "%A_MyDocuments%\Vault\docs\keepass\KeePass.exe"
  }
  Else
  {
  Run "%A_MyDocuments%\..\Vault\docs\keepass\KeePass.exe"
  }
  Return
#c::Run calc
#\::SendMessage 0x112, 0xF170, 2, , Program Manager ;win+\ - screen standby
SC029::Send, 0 ;Backticks send zeroes
^SC029::Send, `` ;C-Backtick send backticks
RAlt & j::ShiftAltTab
RAlt & k::AltTab
Capslock::Backspace
!^0::SoundSet +5 ;volume up
!^9::SoundSet -5 ;volume down
^!+Up::run %A_ScriptDir%\resswitch.exe /WIDTH:1920 /HEIGHT:1080 ;1080p screen resolution
^!+Down::run %A_ScriptDir%\resswitch.exe /WIDTH:1280 /HEIGHT:720 ;720p screen resolution
XButton1::Send {Click 2} ;remap logitech m570 x1 to double click
XButton2::Send {MButton} ;remap logitech m570 x2 to wheel click
#Space:: ;date insert
  FormatTime, CurrentDateTime,, yyyy-MM-dd
  Send %CurrentDateTime%
  return
#+Space:: ;date and time insert
  FormatTime, CurrentDateTime,, yyyy-MM-dd HHmm
  Send %CurrentDateTime%
  return
#k:: ;split active and previous 2 windows side by side.
  {
  Shift("R")
  Send {AltDown}{Tab}{AltUp}
  Shift("L")
  Send {AltDown}{Tab}{AltUp}
  return
  }
Insert:: ;insert appends to clipboard
  newclipboard = %clipboard%
  Send, ^c
  clipboard = %newclipboard%`r`n%clipboard%
  return
^!t:: ;formats a copied telephone number correctly, and pastes it
  StringReplace, clipboard, clipboard, %A_SPACE%, , All ;remove spaces
  StringReplace, clipboard, clipboard, `r, , All ;remove lines
  StringReplace, clipboard, clipboard, `n, , All ;remove lines
  StringReplace, clipboard, clipboard, (, , All ;remove lbracket
  StringReplace, clipboard, clipboard, ), , All ;remove rbracket
  StringLeft, 5digits, clipboard, 5
  StringRight, 6digits, clipboard, 6
  Send %5digits% %6digits%
  return
#x:: ;hide/show taskbar toggle
if toggle := !toggle 
  {
  WinHide ahk_class Shell_TrayWnd
  WinHide, Start ahk_class Button 
  }
  else
  {
  WinShow ahk_class Shell_TrayWnd
  WinShow, Start ahk_class Button 
  }
  return
^!Space:: ;toggle between default audio output (http://ml.pe/optimizing/2013/changing-the-default-sound-device-using-autohotkey/)
    switch := !switch
    If (switch)
        usePlaybackDevice(1)
    else
        usePlaybackDevice(3)
    return
 usePlaybackDevice(device) {
    Run, mmsys.cpl
    WinWaitActive, Sound ahk_class #32770
    ControlSend, SysListView321,{Down %device%}, Sound ahk_class #32770
    ControlClick, Button2, Sound ahk_class #32770
    WinClose, Sound ahk_class #32770
}

;auto replace text with symbols
::(c)::©
::(r)::®
::(tm)::™

;text replacements
::seperated::separated
::recieved::received
::license::licence
::licenses::licences
::equivelants::equivalents
::attendent::attendant
::propogate::propagate
::refridgeration::refrigeration
;work stuff
::ctsty::Called to speak to you, their number is 
::gtacb::Called to speak to you, can you give them a call back?
::ctt::Feel free to close the ticket.
::sksu::Samsung OS7030 KSU
::s2b::Samsung OS7030 2BM
::s4t::Samsung OS7030 4TM
::s4d::Samsung OS7030 4DM
::s2d::Samsung OS7030 2DM
::s4s::Samsung OS7030 4SM
::sepm::Samsung OS7030 EPM
::smod::Samsung OS7030 Modem
::s2100b::Samsung DS-2100B
::s7b::Samsung DS5007S
::s14b::Samsung DS5014S
::s21b::Samsung DS5021S
::s38b::Samsung DS5038S
::emg80a::LG eMG80-KSUA
::emg80i::LG eMG80-KSUI
::emg80b::LG eMG80-BRIU2
::emg80p::LG eMG80-PRIU
::emg80h::LG eMG80-HYB8
::emg80c::LG eMG80-CH204
::ipecs50a::LG iPECS-LIK50A
::ipecs50b::LG iPECS-LIK50B
::l9048::LG LDP-9048DSS
::l9030::LG LDP-9030D
::l9008::LG LDP-9008D
::lip24::LG LIP-8024E
::lip12::LG LIP-8012E
::lip8::LG LIP-8008E
::lip4::LG LIP-8004D
:*:bte`t::BT Elements
:*:btd`t::BT Diverse 7110+

;auto/tab completions
:*:ytv:: ;create YT link from video ID
  send,{end}{shift down}{home}{shift up}{del}
  send,https://www.youtube.com/watch?v={ctrl down}v{ctrl up}
  return
:*:gd`t::
if A_OSVersion in WIN_XP
  {
  Send %A_MyDocuments%\Vault\docs\
  }
  Else
  {
  Send C:\Users\%A_UserName%\Vault\docs\
  }
  Return
:*:md`t::
if A_OSVersion in WIN_XP
  {
  Send %A_MyDocuments%
  }
  Else
  {
  Send C:\Users\%A_UserName%\
  }
  Return
:*:db`t::
if A_OSVersion in WIN_XP
  {
  Send %A_MyDocuments%\Vault\
  }
  Else
  {
  Send C:\Users\%A_UserName%\Vault\
  }
  Return
:*:cw`t:: ;cygwin
  {
  Send C:\cygwin\home\%A_UserName%\
  }
  Return

;tiling
#Up::WinMaximize, A
#Down::WinMinimize, A
#Left::Shift("L")
#Right::Shift("R")
#Numpad1::Shift("BL")
#Numpad2::Shift("B")
#Numpad3::Shift("BR")
#Numpad4::Shift("L")
#Numpad5::WinMaximize, A
#Numpad6::Shift("R")
#Numpad7::Shift("TL")
#Numpad8::Shift("T")
#Numpad9::Shift("TR")
Shift(Pos)
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

ScriptReload: ;auto-reload on change
{
  FileGetAttrib, FileAttribs, %A_ScriptFullPath%
  IfInString, FileAttribs, A
  {
    FileSetAttrib, -A, %A_ScriptFullPath%
    TrayTip, Reloading Script..., %A_ScriptName%, , 1
    Sleep, 1000
    Reload
    TrayTip
  }
  Return
}

;kde-windows (Easy Window Dragging -- KDE style (requires XP/2k/NT) -- by Jonny)
!LButton::
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

!RButton::
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
