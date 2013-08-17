
; ^ctrl #win !alt +shift

;environment
#NoEnv
#SingleInstance,Force
SetWorkingDir, C:\Users\%A_UserName%

;keystates
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
SetNumLockState, AlwaysOn

;hotkeys
#q::Run notepad
^q::Send !{F4} ;quit most programs
^!q::Run "AppData\Local\Chromium\User Data\Default\User StyleSheets\Custom.css" ;chrome global css
#w::Run "C:\Program Files (x86)\Chromium\chrome.exe"
#+w::Run "C:\Program Files (x86)\Chromium\chrome.exe" -incognito
#e::Run explorer C:\Users\%A_UserName%\Downloads ;won't work with relative paths, has to be absolute
#+e::Run explorer C:\Users\%A_UserName%\Dropbox ;won't work with relative paths, has to be absolute
^!e::Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d} ;my computer
^!r::Run mstsc ;remote desktop connection
#t::Run C:\cygwin\bin\mintty.exe -
#+t::Run cmd
#p::Run "Dropbox\conf\putty.exe"
#c::Run calc
#\::SendMessage 0x112, 0xF170, 2, , Program Manager ;win+\ - screen standby
RAlt & j::ShiftAltTab
RAlt & k::AltTab
Capslock::Backspace

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

;change screen res (resswitch.exe - http://www.naughter.com/qres.html)
^!+Up::run %A_ScriptDir%\resswitch.exe /WIDTH:1920 /HEIGHT:1080
^!+Down::run %A_ScriptDir%\resswitch.exe /WIDTH:1280 /HEIGHT:720

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