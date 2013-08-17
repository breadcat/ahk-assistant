; ^Ctrl #Win !Alt +Shift

;environment
#NoEnv
#SingleInstance,Force
#InstallKeybdHook ;not strictly necessary, kept for legacy reasons
ws_MinHeight = 25
SetWinDelay, -1
SetBatchLines, -1
SetWorkingDir, C:\Users\%A_UserName%

;keystates
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
SetNumLockState, AlwaysOn

;hotkeys
#q::Run notepad
^q::Send {ALTDOWN}{F4}{ALTUP} ;quit most programs
^!q::Run "AppData\Local\Chromium\User Data\Default\User StyleSheets\Custom.css" ;chrome global css
#w::Run "C:\Program Files (x86)\Chromium\chrome.exe"
#+w::Run "C:\Program Files (x86)\Chromium\chrome.exe" -incognito
#e::Run explorer C:\Users\%A_UserName%\Downloads ;won't work with relative paths, has to be absolute
#+e::Run explorer C:\Users\%A_UserName%\Dropbox ;won't work with relative paths, has to be absolute
^!e::Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d} ;my computer
^!r::Run mstsc ;remote desktop connection
#t::Run C:\cygwin\bin\mintty.exe -
#+t::Run cmd
#u::return
#p::Run "Dropbox\conf\putty.exe"
#c::Run calc
#\::SendMessage 0x112, 0xF170, 2, , Program Manager ;win+\ - screen standby
RAlt & j::ShiftAltTab
RAlt & k::AltTab
Capslock::Backspace

;remap logitech m570 buttons
XButton1::Send {Click}{Click} ;double click
XButton2::Send {MButton} ;wheel click

;tab completions/replacements
:*:gd`t::C:\Users\Peter\Dropbox\docs\
:*:db`t::C:\Users\Peter\Dropbox\
:*:md`t::C:\Users\Peter\Downloads\
:*:cw`t::C:\cygwin\home\Peter\

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