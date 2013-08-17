; ^ctrl #Win !Alt +Shift

;environment
#NoEnv
#SingleInstance,Force
ws_MinHeight = 25
SetWinDelay, -1
SetBatchLines, -1
if A_OSVersion in WIN_NT4,WIN_95,WIN_98,WIN_ME,WIN_XP {
SetWorkingDir, %A_MyDocuments% } Else {
SetWorkingDir, C:\Users\%A_UserName% }

;keystates
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
SetNumLockState, AlwaysOn

;hotkeys
#q::Run notepad
^q::Send {ALTDOWN}{F4}{ALTUP} ;quit most programs
#w::Run "C:\Program Files (x86)\Chromium\chrome.exe"
#+w::Run "C:\Program Files (x86)\Chromium\chrome.exe" -incognito
^!r::Run mstsc ;remote desktop connection
#t::Run C:\cygwin\bin\mintty.exe -
#+t::Run cmd
#u::return
#c::Run calc
#\::SendMessage 0x112, 0xF170, 2, , Program Manager ;win+\ - screen standby
RAlt & j::ShiftAltTab
RAlt & k::AltTab
Capslock::Backspace

;remap logitech m570 buttons
XButton1::Send {Click}{Click} ;double click
XButton2::Send {MButton} ;wheel click

;bullshit ps/2 to usb adapter workarounds
#f::sendraw \
#^f::sendraw |
^+f::sendraw |

;auto replace text with symbols
::(c)::©
::(r)::®
::(tm)::™

;change screen res (resswitch.exe - http://www.naughter.com/qres.html)
^!+UP::run "%A_ScriptDir%\resswitch.exe" /WIDTH:1920 /HEIGHT:1080
^!+DOWN::run "%A_ScriptDir%\resswitch.exe" /WIDTH:1280 /HEIGHT:720

;date/time insertion
#space::
	FormatTime, CurrentDateTime,, yyyy-MM-dd
	SendInput %CurrentDateTime%
return
#+space::
	FormatTime, CurrentDateTime,, yyyy-MM-ddTHH:mm
	SendInput %CurrentDateTime%
return

;insert appends to clipboard
Insert::
	newclipboard = %clipboard%
	Send, ^c
	clipboard = %newclipboard%`r`n%clipboard%
return

;includes
#Include, %A_ScriptDir%\appspecific.ahk
#Include, %A_ScriptDir%\tiling.ahk
#Include, %A_ScriptDir%\mousewin.ahk
#Include, %A_ScriptDir%\secret.ahk ;os specific, contains personally identifiable data.
