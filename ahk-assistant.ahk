
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
#Include, %A_ScriptDir%\functions.ahk ;all those long winded functions
#Include, *i %A_ScriptDir%\secret.ahk ;physical and ip address completions, only included if exists.

;hotkeys
#q::Run notepad
^q::Send !{F4} ;quit most programs
#+q::Run notepad.exe "%A_MyDocuments%\Vault\docs\faulties.txt"
#w::Run firefox.exe
#+w::Run firefox.exe -private-window
#e:: dirWorking()
#+e:: dirSync()
^!e::Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d} ;my computer
^!r::Run mstsc ;remote desktop connection
#t:: launchTerminal()
#+t::Run cmd
^!t::pasteTelephone()
^!b::Run %programfiles%\TeamViewer\Version9\TeamViewer.exe
^!v::Run %programfiles%\TightVNC\tvnviewer.exe
#p::Run "%ProgramFilesX86%\PuTTY\putty.exe" ;putty
^!k:: launchKeepass()
#c::Run calc
#\::SendMessage 0x112, 0xF170, 2, , Program Manager ;win+\ - screen standby
SC029::Send, 0 ;Backtick send zeroes
+SC029::Send, `` ;S-Backtick send backticks
^SC029::Send, `¬ ;C-Backtick send negations
RAlt & j::ShiftAltTab
RAlt & k::AltTab
Capslock::Backspace
!^0::SoundSet +5 ;volume up
!^9::SoundSet -5 ;volume down
^!+Up::run %A_ScriptDir%\resswitch.exe /WIDTH:1920 /HEIGHT:1080 ;1080p screen resolution
^!+Down::run %A_ScriptDir%\resswitch.exe /WIDTH:1280 /HEIGHT:720 ;720p screen resolution
XButton1::Send {Click 2} ;remap logitech m570 x1 to double click
XButton2::Send {MButton} ;remap logitech m570 x2 to wheel click
#Space:: insertDate()
#+Space::insertDateTime()
Insert::appendClipboard()
^!Space::toggleAudioDevice()

;kde-windows (Easy Window Dragging -- KDE style (requires XP/2k/NT) -- by Jonny)
!LButton::kdeMove()
!RButton::kdeResize()

;tiling
#Up::WinMaximize, A
#Down::WinMinimize, A
#Left::Tile("L")
#Right::Tile("R")
#Numpad1::Tile("BL")
#Numpad2::Tile("B")
#Numpad3::Tile("BR")
#Numpad4::Tile("L")
#Numpad5::WinMaximize, A
#Numpad6::Tile("R")
#Numpad7::Tile("TL")
#Numpad8::Tile("T")
#Numpad9::Tile("TR")
#Numpad0::winSplit()

;auto replace text with symbols
:*:(c)::©
:*:(r)::®
:*:(tm)::™

;text replacements
::seperated::separated
::seperate::separate
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
::emg80w::LG eMG80-WTIB4
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
:*:ytv::createYoutubeLink()
:*:gd`t::typeSyncDocs()
:*:md`t::typeDocuments()
:*:db`t::typeSync()
:*:cw`t::typeCygwin()

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
