
; ^ctrl #win !alt +shift


;environment
#NoEnv
#SingleInstance,Force
SetTimer, ScriptReload, 1000
SetWinDelay,2
CoordMode,Mouse
return
SetWorkingDir, C:\Users\%A_UserName%


;keystates
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
SetNumLockState, AlwaysOn


;hotkeys
#q::Run notepad
^q::Send !{F4} ;quit most programs
#+q::Run notepad.exe "C:\Dropbox\docs\faulties.txt"
^!q:: ;chromium global CSS
if A_OSVersion in WIN_XP
  {
  Run notepad.exe "%A_AppData%\..\Local Settings\Application Data\Chromium\User Data\Default\User StyleSheets\Custom.css"
  }
  Else
  {
  Run "AppData\Local\Chromium\User Data\Default\User StyleSheets\Custom.css" ;chrome global css
  }
  Return
#w::Run "C:\Program Files (x86)\Chromium\chrome.exe"
#+w::Run "C:\Program Files (x86)\Chromium\chrome.exe" -incognito
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
  Run explorer C:\Dropbox
  }
  Else
  {
  Run explorer %A_MyDocuments%\..\Dropbox
  }
  Return
^!e::Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d} ;my computer
^!r::Run mstsc ;remote desktop connection
#t::Run C:\cygwin\bin\mintty.exe -
#+t::Run cmd
#p::
if A_OSVersion in WIN_XP
  {
  Run "C:\Dropbox\conf\putty.exe"
  }
  Else
  {
  Run "Dropbox\conf\putty.exe"
  }
  Return
#c::Run calc
#\::SendMessage 0x112, 0xF170, 2, , Program Manager ;win+\ - screen standby
RAlt & j::ShiftAltTab
RAlt & k::AltTab
Capslock::Backspace
;change screen res (resswitch.exe - http://www.naughter.com/qres.html)
^!+Up::run %A_ScriptDir%\resswitch.exe /WIDTH:1920 /HEIGHT:1080
^!+Down::run %A_ScriptDir%\resswitch.exe /WIDTH:1280 /HEIGHT:720

;remap logitech m570 buttons
XButton1::Send {Click 2} ;double click
XButton2::Send {MButton} ;wheel click


;bullshit ps/2 to usb adapter workarounds
#f::sendraw \
#^f::sendraw |
^+f::sendraw |


;auto replace text with symbols
::(c)::©
::(r)::®
::(tm)::™


;date/time insertion
#Space::
	FormatTime, CurrentDateTime,, yyyy-MM-dd
	SendInput %CurrentDateTime%
return
#+Space::
	FormatTime, CurrentDateTime,, yyyy-MM-ddTHH:mm
	SendInput %CurrentDateTime%
return


;insert appends to clipboard
Insert::
	newclipboard = %clipboard%
	Send, ^c
	clipboard = %newclipboard%`r`n%clipboard%
return


;typo corrections
::seperated::separated
::recieved::received
::license::licence
::licenses::licences
::equivelants::equivalents

;auto/tab completions
:*:gd`t::
if A_OSVersion in WIN_XP
  {
  Send C:\Dropbox\docs\
  }
  Else
  {
  Send C:\Users\%A_UserName%\docs\
  }
  Return
:*:md`t::
if A_OSVersion in WIN_XP
  {
  Send C:\Documents and Settings\%A_UserName%\Documents\
  }
  Else
  {
  Send C:\Users\%A_UserName%\
  }
  Return
:*:db`t::
if A_OSVersion in WIN_XP
  {
  Send C:\Dropbox\
  }
  Else
  {
  Send C:\Users\%A_UserName%\Dropbox\
  }
  Return
:*:cw`t::
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


;includes
#Include, %A_ScriptDir%\appspecific.ahk ;too many to include in index, deserves separating
#Include, %A_ScriptDir%\functions.ahk ;functions don't belong in index


;auto-reload on change
ScriptReload:
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
