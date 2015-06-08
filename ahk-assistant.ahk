
; ^ctrl #win !alt +shift


;environment
#NoEnv
#SingleInstance,Force
SetTimer, ScriptReload, 1000
SetWinDelay,0
SetKeyDelay,0
SetControlDelay,0
CoordMode,Mouse
SetWorkingDir %A_MyDocuments%\..\
ProgramFilesX86 := A_ProgramFiles . (A_PtrSize=8 ? " (x86)" : "") ;pfx86 variable from http://www.autohotkey.com/board/topic/79160-a-programfiles-for-programs-in-windows-7-x86-directory/


;keystates
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
SetNumLockState, AlwaysOn

;includes
#Include, *i %A_ScriptDir%\variables.ahk ;physical and ip address completions, only included if exists. See .gitignore for details
#Include, %A_ScriptDir%\functions.ahk ;all those long winded functions

;hotkeys
#q::Run notepad
^q::Send !{F4} ;quit most programs
#+q::Run notepad "%A_MyDocuments%\Vault\docs\faulties.txt"
#w::Run firefox
#+w::Run firefox.exe -private-window
#e::dirWorking()
#+e::dirSync()
^!e::Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d} ;my computer
^!r::Run mstsc ;remote desktop connection
^!+r::mstscSpecific()
#t::launchTerminal()
#+t::Run cmd
^!t::pasteTelephone()
#Enter::dialTelephone()
#+Enter::searchCustomer()
#y::send {End}{ShiftDown}{Home}{ShiftUp}https://www.youtube.com/v/^v ;create youtube link from ID and bypass age restrictions
^!b::Run %programfiles%\TeamViewer\Version9\TeamViewer.exe
^!v::Run %programfiles%\TightVNC\tvnviewer.exe
#p::Run "%ProgramFilesX86%\PuTTY\putty.exe" ;putty
^!k::launchKeepass()
#c::Run calc
#\::SendMessage 0x112, 0xF170, 2, , Program Manager ;W-\ - screen standby
SC029::Send, 0 ;Backtick send zeroes
+SC029::Send, `` ;S-Backtick send backticks
^SC029::Send, `¬ ;C-Backtick send negations
RAlt & j::ShiftAltTab
RAlt & k::AltTab
CapsLock::BackSpace
!^0::Send {Volume_Mute} ;C-A-0 volume mute toggle
!^-::Send {Volume_Down 3} ;C-A-- volume down
!^=::Send {Volume_Up 3} ;C-A-+ volume up
^!+Up::run %A_ScriptDir%\resswitch.exe /WIDTH:1920 /HEIGHT:1080 ;1080p screen resolution
^!+Down::run %A_ScriptDir%\resswitch.exe /WIDTH:1280 /HEIGHT:720 ;720p screen resolution
XButton1::Send {Click 2} ;remap logitech m570 x1 to double click
XButton2::Send {MButton} ;remap logitech m570 x2 to wheel click
#Space::insertDate()
#+Space::insertDateTime()
Insert::appendClipboard()
^!Space::toggleAudioDevice()
!LButton::kdeMove()
!RButton::kdeResize()

;tiling
#Up::WinMaximize, A
#Down::WinMinimize, A
#+Down::Send !{Esc} ;Send to bottom instead of minimise
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
#NumpadIns::winSplitH()

;text replacements
:*?:_reg::
  insertRegards()
  Return
:*?:_kreg::
  insertKindRegards()
  Return
:*:_em::
  insertEmailAddress()
  Return
:*:_wip::
  insertWorkIP()
  Return
:*:_sip::
  insertSIPIP()
  Return
:*:_tel::
  insertTelephoneNumber()
  Return
:*:_mob::
  insertMobileNumber()
  Return
:*:_addr::
  insertAddress()
  Return
:*:_pc::
  insertPostCode()
  Return
:*:_db::
  typeSync()
  Return
:*:_gd::
  typeSyncDocs()
  Return
:*:_md::
  typeDocuments()
  Return
:*:_cw::
  typeCygwin()
  Return

;swedish
:c*?:(Ao)::Å
:c*?:(ao)::å
:c*?:(Ai)::Ä
:c*?:(ai)::ä
:c*?:(Oi)::Ö
:c*?:(oi)::ö
;norwegian
:c*?:(AE)::Æ
:c*?:(ae)::æ
:c*?:(O/)::Ø
:c*?:(o/)::ø
;german
:c*?:(Ui)::Ü
:c*?:(ui)::ü
:*?:(ss)::ß
;spanish
:c?*:(Ny)::Ñ
:c?*:(ny)::ñ
:c?*:(A-)::Á
:c?*:(a-)::á
:c?*:(E-)::É
:c*:(e-)::
	Send {ASC 130} ;C-A-e insertion for é is weird
	Return
:c?*:(I-)::Í
:c?*:(i-)::í
:c?*:(O-)::Ó
:c?*:(o-)::ó
:c?*:(U-)::Ú
:c?*:(u-)::ú
:*?:(!!)::¡
:*?:(??)::¿
;symbols
:*?:(c)::©
:*?:(r)::®
:*?:(tm)::™
:*?:(ee)::€
:*?:(deg)::°
:*?:(half)::½
:*?:(quart)::¼
:*?:(div)::÷
:*?:(micro)::µ
;stupid fingers
:*:seperated::separated
:*:seperate::separate
:*:recieve::receive
:*:recieved::received
:*:license::licence
:*:licenses::licences
:*:equivelant::equivalent
:*:equivelants::equivalents
:*:attendent::attendant
:*:consistant::consistent
:*:propogate::propagate
:*:refridgeration::refrigeration
:*:secratery::secretary
;work stuff
:*:_ctsty::Called to speak to you, their number is 
:*:_gtacb::Called to speak to you, can you give them a call back?
:*:_ctt::Feel free to close the ticket, I'll either update this or open a new ticket if need be.
:*:_sksu::Samsung OS7030 KSU
:*:_s2b::Samsung OS7030 2BM
:*:_s4t::Samsung OS7030 4TM
:*:_s4d::Samsung OS7030 4DM
:*:_s2d::Samsung OS7030 2DM
:*:_s4s::Samsung OS7030 4SM
:*:_sepm::Samsung OS7030 EPM
:*:_smod::Samsung OS7030 Modem
:*:_s2100b::Samsung DS-2100B
:*:_s7b::Samsung DS5007S
:*:_s14b::Samsung DS5014S
:*:_s21b::Samsung DS5021S
:*:_s38b::Samsung DS5038S
:*:_emg80a::LG eMG80-KSUA
:*:_emg80i::LG eMG80-KSUI
:*:_emg80b::LG eMG80-BRIU2
:*:_emg80p::LG eMG80-PRIU
:*:_emg80h::LG eMG80-HYB8
:*:_emg80c::LG eMG80-CH204
:*:_emg80w::LG eMG80-WTIB4
:*:_50a::LG iPECS-LIK50A
:*:_50b::LG iPECS-LIK50B
:*:_l9048::LG LDP-9048DSS
:*:_l9030::LG LDP-9030D
:*:_l9008::LG LDP-9008D
:*:_lip24::LG LIP-8024E
:*:_lip12::LG LIP-8012E
:*:_lip8::LG LIP-8008E
:*:_lip4::LG LIP-8004D
:*:_bte::BT Elements
:*:_btk::BT Elements 1K
:*:_btd::BT Diverse 7110+

;application specific hotkeys
#IfWinActive ahk_class #32770 ;save/load dialog
  F1:: ;overflow to rename, help is useless in explorer
  F2::explorerRename() ;rename commands
#IfWinActive

#IfWinActive ahk_class CabinetWClass ;explorer
  CapsLock::explorerUp()
  Alt & Enter:: ;overflow
  Ralt & Enter::Send {AppsKey}{Up}{Enter} ; ralt-enter properties
  F1:: ;overflow to rename, help is useless in explorer
  F2::explorerRename() ;rename commands
  F3::explorerCMD()
  F6::Send !d ;addressbar
  ^h::explorerHidden()
  ^+n::explorerNewDir()
  ^!+n::explorerNewFile()
#IfWinActive

#IfWinActive ahk_class ShockwaveFlashFullScreen ;full screen flash
  Ralt & Enter:: ;overflow
  Alt & Enter::toggleFullscreen() ;leave flash full screen with a keyboard command
#IfWinActive

#IfWinActive ahk_class #32770 ;windows xp date/time picker
  CapsLock::Send !{F4} ;quit
#IfWinActive

#IfWinActive ahk_class FontViewWClass ;font previewer
  CapsLock::Send !{F4} ;quit
#IfWinActive

#IfWinActive ahk_class SciCalc ; windows xp calc
  CapsLock::Send !{F4} ;quit
#IfWinActive

#IfWinActive ahk_class CalcFrame ; windows 7 calc
  CapsLock::Send !{F4} ;quit
#IfWinActive

#IfWinActive ahk_class ShImgVw:CPreviewWnd ;photoviewer windows xp
  CapsLock::Send !{F4} ;quit
#IfWinActive

#IfWinActive ahk_class Photo_Lightweight_Viewer ;photoviewer windows 7
  CapsLock::Send !{F4} ;quit
  Up:: ;overflow
  Down::Return ;fixes up/down breaking left/right navigation
#IfWinActive

#IfWinActive ahk_class SUMATRA_PDF_FRAME ;sumatra pdf
  CapsLock::Send !{F4} ;quit
  ^b::Send {F12} ;C-b toggles bookmarks
  ^t::Send !vt ;C-t toggles toolbar
  Alt & Enter:: ;overflow
  Ralt & Enter::Send ^l ;fullscreen
#IfWinActive

#IfWinActive ahk_class MediaPlayerClassicW ;mpc-hc
  1::Send 2^1 ;1 keeps borders
  Ralt & Enter::Send !{Enter} ; ralt-enter fullscreens
  CapsLock::Send !{F4} ;quit
  p::Send ^7 ;p for playlist
#IfWinActive

#IfWinActive ahk_class mpv ;mpv
  Alt & Enter:: ;overflow to fullscreen below
  Ralt & Enter::Send f ;ralt-Enter fullscreens
  CapsLock::Send !{F4} ;quit
#IfWinActive

#IfWinActive ahk_class rctrl_renwnd32 ;outlook
  ^Enter::Return ;disable accidentally send email shortcut
#IfWinActive

#IfWinActive ahk_class XLMAIN ;excel
  ^+v::Send ^'{Down} ;C-S-v copies above cell contents into current
  ^+n::Send !iw ;new sheet
  ^+w::Send !el ;delete current sheet
  !F2:: ;overflow
  ^F2::Send !ohr ;rename sheet
  F3::Send +{F4} ;f3 searches for the same string again
  F6::excelFormulaBar()
  F11::Send !vu ;fullscreen
  ^Tab::Send ^{PgDn} ;next sheet
  ^+Tab::Send ^{PgUp} ;prev sheet
#IfWinActive

#IfWinActive ahk_class WindowsForms10.Window.8.app.0.2004eee ;act
  ^Enter::Send ^{End}{Space}-PG+{Tab 3}{Enter} ;save note with footer
  ^n::Send {F9} ;insert note
  ^f::Send !LC ;search for company
#IfWinActive

#IfWinActive ahk_class ConsoleWindowClass ;command prompt
  ^c::Send {Enter} ;copy
  +Insert:: ;overflow to paste
  ^v::cmdPaste() ;paste
#IfWinActive

#IfWinActive ahk_class ahk_class ahk_class MozillaWindowClass ;firefox
  ^+w::Send ^w ;quit window closes tab
  ^+n::Send ^+p ;new incognito window
  ^q::Send ^w ;quit now closes tab, the two keys are too close for this sort of thing
  ^!d::Send ^j ;why Downloads is ctrl+j while addons is ctrl+alt+a will never make sense
  ^d::Send ^f ;bookmark remapped to find
  ^b::Send ^v ;replace bookmarks with paste
  F6::Send ^l ;F6 jumps to address bar
  ^+o::Send !to ;C-S-o options
  #o::Send, ^c^t^v{Enter} ;copy selected uri and open, right click option fails to recognise ~50% of what I try
  +PgDn::Send {Space 4}{Down 7} ;scroll down to specific part of a specific page, not really
  +PgUp::Send {Home} ;makes sense, kinda
  Ralt & Enter:: ;overflow
  Alt & Enter::toggleFullscreen() ;leave flash full screen with a keyboard command
#IfWinActive

#IfWinActive ahk_class MSPaintApp ;mspaint
  ^=::Send {CtrlDown}{PgUp}{CtrlUp} ;zoom in
  ^-::Send {CtrlDown}{PgDn}{CtrlUp} ;zoom out
#IfWinActive

#IfWinActive ahk_class Notepad2 ;notepad2-mod
  !z::Return ;disable delete first char of line 'feature;
  ^0::Return ;disable annoying transparency feature
  !t::Return ;disable always on top
  ^+Down:: ;overflow
  ^Down::Send {Down} ; disable (alt) shift line down feature
  ^+Up:: ;overflow
  ^Up::Send {Up} ; disable (alt) shift line up feature
#IfWinActive

#IfWinActive ahk_class wxWindowClassNR ;audacity
  ^=::Send {CtrlDown}1{CtrlUp} ;zoom in
  ^-::Send {CtrlDown}3{CtrlUp} ;zoom out
  ^0::Send {CtrlDown}2{CtrlUp} ;zoom reset
#IfWinActive

#IfWinActive ahk_class civ5 ;civilization 5
  F11::borderlessFullscreen()
#IfWinActive

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
