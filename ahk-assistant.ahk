
; ahk-assistant
; ^ctrl #win !alt +shift


; environment
#NoEnv
#SingleInstance,Force
SetTimer, changeReload, 1000
CoordMode,Mouse
SetWorkingDir %A_MyDocuments%\..\
ProgramFilesX86 := A_ProgramFiles . (A_PtrSize=8 ? " (x86)" : "") ; pfx86 variable from http://www.autohotkey.com/board/topic/79160-a-programfiles-for-programs-in-windows-7-x86-directory/
SetWinDelay,0
SetKeyDelay,0
SetControlDelay,0
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
SetNumLockState, AlwaysOn
#Include, *i %A_ScriptDir%\variables.ahk ; physical and ip address completions, only included if exists. See .gitignore for details
#Include, %A_ScriptDir%\functions.ahk ; all those long winded functions


; global hotkeys
#q::Run notepad
^q::Send !{F4} ; quit most programs
#+q::Run notepad "%A_MyDocuments%\Vault\docs\faulties.txt"
#w::Run firefox
#+w::Run firefox.exe -private-window
#e::dirWorking()
#+e::dirSync()
^!e::Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d} ; my computer
^!r::Run mstsc ; remote desktop connection
^!+r::mstscSpecific()
#t::launchTerminal()
#+t::Run cmd
^!t::pasteTelephone()
#p::Run "%ProgramFilesX86%\PuTTY\putty.exe" ; putty
#Enter::dialTelephone()
#+Enter::searchCustomer()
*CapsLock::BackSpace
^!k::launchKeepass()
#\::SendMessage 0x112, 0xF170, 2, , Program Manager ; W-\ - screen standby
^!\::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0) ; C-A-\ - system standby
#c::Run calc
^!v::Run %ProgramFilesX86%\TightVNC\tvnviewer.exe
^+v::pasteClipboard()
^!Space::toggleAudioDevice()
RAlt & j::ShiftAltTab
RAlt & k::AltTab
RAlt & PgUp::Send {WheelUp}
RAlt & PgDn::Send {WheelDown}
SC029::Send, 0 ; Backtick send zeroes
+SC029::Send, `` ; S-Backtick send backticks
^SC029::Send, `¬ ; C-Backtick send negations
!^0::Send {Volume_Mute} ; C-A-0 volume mute toggle
!^-::Send {Volume_Down 3} ; C-A-- volume down
!^=::Send {Volume_Up 3} ; C-A-+ volume up
^!+Up::changeResolution(1920,1080)
^!+Down::changeResolution(1280,720)
XButton1::Send {Click 2} ; remap logitech m570 x1 to double click
XButton2::Send {MButton} ; remap logitech m570 x2 to wheel click
Insert::appendClipboard()
#LButton::WinSet, Style, -0x840000, A ; W-Click - remove window borders
!LButton::kdeMove()
!RButton::kdeResize()
;tiling
#Up::WinMaximize, A
#Down::WinMinimize, A
#+Down::Send !{Esc} ; Send to bottom instead of minimise
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
#NumpadIns::winSplitH() ; W-S-Num0


; text insertion/replacements
:*?:_date::
  insertDate()
  Return
:*?:_time::
  insertTime()
  Return
:*?:_dtime::
  insertDateTime()
  Return
:*?:_gw::
  insertGateway()
  Return
:*?:_ip::
  Send, %A_IPAddress1%
  Return
:*?:_sig::
  insertSignature()
  Return
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
  insertSync()
  Return
:*:_gd::
  insertSyncDocs()
  Return
:*:_md::
  insertDocuments()
  Return
:*:_cw::
  insertCygwin()
  Return
:*?:_foot::
	insertFooter()
	Return
; special character insertion
; swedish
:c*?:(Ao)::Å
:c*?:(AO)::Å
:c*?:(ao)::å
:c*?:(Ai)::Ä
:c*?:(ai)::ä
:c*?:(Oi)::Ö
:c*?:(oi)::ö
; norwegian/danish
:c*?:(AE)::Æ
:c*?:(Ae)::Æ
:c*?:(ae)::æ
:c*?:(O/)::Ø
:c*?:(o/)::ø
; german
:c*?:(Ui)::Ü
:c*?:(ui)::ü
:*?:(ss)::ß
; spanish
:c?*:(N~)::Ñ
:c?*:(n~)::ñ
:c?*:(A-)::Á
:c?*:(a-)::á
:c?*:(E-)::É
:c?*:(e-)::
	Send {ASC 130} ; C-A-e insertion for é is weird
	Return
:c?*:(I-)::Í
:c?*:(i-)::í
:c?*:(O-)::Ó
:c?*:(o-)::ó
:c?*:(U-)::Ú
:c?*:(u-)::ú
:*?:(!!)::¡
:*?:(??)::¿
; symbols
:*?:(c)::©
:*?:(r)::®
:*?:(tm)::™
:*?:(ee)::€
:*?:(deg)::°
:*?:(half)::½
:*?:(quart)::¼
:*?:(div)::÷
:*?:(micro)::µ
:*?:(bull)::•
:*?:(middot)::·
; stupid fingers
:*:i'::I'
:*:adn::and
:*:teh::the
:*:tehy::they
:*:taht::that
:*:seperate::separate
:*:recieve::receive
:*:license::licence
:*:equivelant::equivalent
:*:attendent::attendant
:*:consistant::consistent
:*:propogate::propagate
:*:occurance::occurence
:*:refridgeration::refrigeration
:*:secratery::secretary
:*:cinammon::cinnamon
:*:competative::competitive
:*:fiber::fibre
:*:liase::liaise
:*:liasing::liaising
:*:sieze::seize
:*:imediate::immediate
:*:excercise::exercise
; work stuff
:*:ctsty::Called to speak to you, their number is 
:*:gtacb::Called to speak to you, can you give them a call back?
:*:ctt::Feel free to close the ticket.
:*:sksu::Samsung OS7030 KSU
:*:s2b::Samsung OS7030 2BM
:*:s4t::Samsung OS7030 4TM
:*:s4d::Samsung OS7030 4DM
:*:s2d::Samsung OS7030 2DM
:*:s4s::Samsung OS7030 4SM
:*:sepm::Samsung OS7030 EPM
:*:smod::Samsung OS7030 Modem
:*:s2100b::Samsung DS-2100B
:*:s7b::Samsung DS5007S
:*:s14b::Samsung DS5014S
:*:s21b::Samsung DS5021S
:*:s38b::Samsung DS5038S
:*:emg80a::LG eMG80-KSUA
:*:emg80e::LG eMG80-EKSU
:*:emg80i::LG eMG80-KSUI
:*:emg80b::LG eMG80-BRIU2
:*:emg80p::LG eMG80-PRIU
:*:emg80h::LG eMG80-HYB8
:*:emg80c::LG eMG80-CH204
:*:emg80w::LG eMG80-WTIB4
:*:i50a::LG iPECS-LIK50A
:*:i50b::LG iPECS-LIK50B
:*:l9048::LG LDP-9048DSS
:*:l9030::LG LDP-9030D
:*:l9008::LG LDP-9008D
:*:lip24::LG LIP-8024E
:*:lip12::LG LIP-8012E
:*:lip8::LG LIP-8008E
:*:lip4::LG LIP-8004D
:*:bte::BT Elements
:*:btk::BT Elements 1K
:*:btd::BT Diverse 7110+


; application specific hotkeys
#IfWinActive ahk_class #32770 ; save/load dialog
  F1:: ; overflow to rename, help is useless in explorer
  F2::explorerRename() ; rename commands
#IfWinActive

#IfWinActive ahk_class CabinetWClass ; explorer
  CapsLock::explorerUp()
  Alt & Enter:: ; overflow
  Ralt & Enter::Send {AppsKey}{Up}{Enter} ; ralt-enter properties
  F1:: ; overflow to rename, help is useless in explorer
  F2::explorerRename() ; rename commands
  F3::explorerCMD()
  F6::Send !d ; addressbar
  ^Backspace::Send ^+{Left}{Backspace} ; backspace a word
  ^h::explorerHidden()
  ^+n::explorerNewDir()
  ^!+n::explorerNewFile()
  ^s::Send !vb ; view > status bar
  ^0::Send !vd ; view > details
  ^-::Send ^{WheelDown 2} ; zoom out
  ^=::Send ^{WheelUp 2} ; zoom in
#IfWinActive

#IfWinActive ahk_class ShockwaveFlashFullScreen ; full screen flash
  Ralt & Enter:: ; overflow
  Alt & Enter::toggleFullscreen() ; leave flash full screen with a keyboard command
#IfWinActive

#IfWinActive ahk_class #32770 ; windows xp date/time picker
  CapsLock::Send !{F4} ; quit
#IfWinActive

#IfWinActive ahk_class FontViewWClass ; font previewer
  CapsLock::Send !{F4} ; quit
#IfWinActive

#IfWinActive ahk_class SciCalc ; windows xp calc
  CapsLock::Send !{F4} ; quit
#IfWinActive

#IfWinActive ahk_class CalcFrame ; windows 7 calc
  CapsLock::Send !{F4} ; quit
#IfWinActive

#IfWinActive ahk_class ShImgVw:CPreviewWnd ; photoviewer windows xp
  CapsLock::Send !{F4} ; quit
  ^-::Send {-} ; zoom out
  ^=::Send {+} ; zoom in
#IfWinActive

#IfWinActive ahk_class Photo_Lightweight_Viewer ; photoviewer windows 7
  ^w:: ; overflow
  CapsLock::Send !{F4} ; quit
  Up:: ; overflow
  Down::Return ; fixes up/down breaking left/right navigation
#IfWinActive

#IfWinActive ahk_class SUMATRA_PDF_FRAME ; sumatra pdf
  CapsLock::Send !{F4} ; quit
  ^b::Send {F12} ; C-b toggles bookmarks
  ^t::Send !vt ; C-t toggles toolbar
  Alt & Enter:: ; overflow
  Ralt & Enter::Send ^l ; fullscreen
#IfWinActive

#IfWinActive ahk_class MediaPlayerClassicW ; mpc-hc
  1::Send 2^1 ; 1 keeps borders
  Ralt & Enter::Send !{Enter} ; ralt-enter fullscreens
  CapsLock::Send !{F4} ; quit
  p::Send ^7 ; p for playlist
#IfWinActive

#IfWinActive ahk_class mpv ; mpv
  Alt & Enter:: ; overflow to fullscreen below
  Ralt & Enter::Send f ; ralt-Enter fullscreens
  CapsLock::Send !{F4} ; quit
#IfWinActive

#IfWinActive ahk_class rctrl_renwnd32 ; outlook
  ^Enter::Return ; disable accidentally send email shortcut
  ^f::Send ^e ; C-f finds instead of forwards
  ^t::Send !go ; C-t goes to today, on calendar view
#IfWinActive

#IfWinActive ahk_class OpusApp ; word 2003
  ^=::Send ^{WheelUp} ; zoom in
  ^-::Send ^{WheelDown} ; zoom out
  ^0::Send !vzp{Enter} ; fit to page zoom
#IfWinActive

#IfWinActive ahk_class XLMAIN ; excel 2003
  ^+v::Send ^'{Down} ; C-S-v copies above cell contents into current
  ^+n::Send !iw ; new sheet
  ^+w::Send !el ; delete current sheet
  !F2:: ; overflow
  ^F2::Send !ohr ; rename sheet
  F3::Send +{F4} ; f3 searches for the same string again
  F6::excelFormulaBar()
  F11::Send !vu ; fullscreen
  ^Tab::Send ^{PgDn} ; next sheet
  ^+Tab::Send ^{PgUp} ; prev sheet
#IfWinActive

#IfWinActive ahk_class ConsoleWindowClass ; command prompt
  +Insert:: ; overflow to paste
  ^v::cmdPaste() ; paste
#IfWinActive

#IfWinActive ahk_class ahk_class ahk_class MozillaWindowClass ; firefox
  ^+w::Send ^w ; quit window closes tab
  ^+n::Send ^+p ; new incognito window
  ^q::Send ^w ; quit now closes tab, the two keys are too close for this sort of thing
  ^!d::Send ^j ; why Downloads is ctrl+j while addons is ctrl+alt+a will never make sense
  ^d::Send ^f ; bookmark remapped to find
  ^b::Send ^v ; replace bookmarks with paste
  #o::Send, ^c{F6}^v{Enter} ; copy selected uri and open in current tab
  #+o::Send, ^c^t^v{Enter} ; copy selected uri and open in new tab
  ^+o::Send, !t{sleep 25}o ; C-S-o options
  F1:: ; overflow
  F2::tabSplit() ; split current tab from window and tile, kinda flakey and in need of improvement
  F7:: ; overflow
  F6::Send ^l ; F6 jumps to address bar
  +PgDn::Send {Space 4}{Down 5} ; scroll down to specific part of a specific page, not really
  +PgUp::Send {Home} ; makes sense, kinda
  Ralt & Enter:: ; overflow
  Alt & Enter::toggleFullscreen() ; leave flash full screen with a keyboard command
  :*?:_crm::
		insertCRMFooter()
		return
#IfWinActive

#IfWinActive ahk_class MSPaintApp ; mspaint
  ^=::Send ^{PgUp} ; zoom in
  ^-::Send ^{PgDn} ; zoom out
#IfWinActive

#IfWinActive ahk_class Notepad2 ; notepad2-mod
  ^0::Return ; disable annoying transparency feature
  !t::Return ; disable always on top
  ^+Down:: ; overflow
  ^Down::Send {Down} ; disable (alt) shift line down feature
  ^+Up:: ; overflow
  ^Up::Send {Up} ; disable (alt) shift line up feature
#IfWinActive

#IfWinActive ahk_class wxWindowClassNR ; audacity
  ^=::Send ^1 ; zoom in
  ^-::Send ^3 ; zoom out
  ^0::Send ^2 ; zoom reset
#IfWinActive

#IfWinActive ahk_class civ5 ; civilization 5
  F11::borderlessFullscreen()
#IfWinActive


changeReload: ; auto-reload script on source change
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
