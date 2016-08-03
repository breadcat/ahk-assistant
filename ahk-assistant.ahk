
; ahk-assistant
; ^ctrl #win !alt +shift

; environment
#NoEnv
#SingleInstance,Force
CoordMode,Mouse
SetWorkingDir %A_MyDocuments%\..\
ProgramFilesX86 := A_ProgramFiles . (A_PtrSize=8 ? " (x86)" : "") ; pfx86 variable from http://www.autohotkey.com/board/topic/79160-a-programfiles-for-programs-in-windows-7-x86-directory/
SetWinDelay,0
SetKeyDelay,0
SetControlDelay,0
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
SetNumLockState, AlwaysOn
SetTimer, changeReload, 1000
Menu, Tray, Icon, %A_ScriptDir%\ahk-assistant.ico ; tray icon
#Include, *i %A_ScriptDir%\variables.ahk ; include physical and ip address completions, only included if exists. See .gitignore for details
#Include, *i %A_ScriptDir%\buggy_mouse.ahk ; r.secsrv.net/AutoHotkey/Scripts/Buggy-Mouse super useful for my logitech m570, only included if exists


; global hotkeys
#q::Run notepad
^q::Send !{F4} ; quit most programs
#+q::Run wordpad
#w::Run firefox
#+w::Run firefox.exe -private-window
#e::dirWorking()
#+e::dirSync()
^!e::Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d} ; my computer
^!r::Run mstsc ; remote desktop connection
^!+r::mstscSpecific() ; remote desktop to a destination defined by variable file
#t::launchTerminal() ; useful terminal
#+t::Run cmd ; less useful terminal
^!t::pasteTelephone()
#p::Run "%ProgramFilesX86%\PuTTY\putty.exe" ; putty
#Enter::dialTelephone()
#+Enter::searchCustomer()
*CapsLock::BackSpace
^!k::Run "%A_MyDocuments%\..\Vault\docs\keepass\KeePass.exe"
#\::SendMessage 0x112, 0xF170, 2, , Program Manager ; W-\ - screen standby
^!\::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0) ; C-A-\ - system standby
#c::Run calc
^!v::Run %ProgramFilesX86%\TightVNC\tvnviewer.exe
^+v::pasteClipboard()
^!m::ControlSend, , {Space}, ahk_exe mpv.exe ; global hotkey to toggle mpv pause/play
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
XButton1::Send {Click 2} ; remap logitech m570 x1 to double click
XButton2::Send {MButton} ; remap logitech m570 x2 to wheel click
Insert::appendClipboard()
#LButton::WinSet, Style, -0x840000, A ; W-Click - remove window borders
^!+Up::changeResolution(1920,1080) ; change screen resolution native 1080p
^!+Down::changeResolution(1280,720) ; change screen res low-res 720p
!LButton::kdeMove() ; kde style window moving
!RButton::kdeResize() ; kde style window resizing
#Up::WinMaximize, A ; maximise
#Down::WinMinimize, A ; minimise
#+Down::Send !{Esc} ; Send to bottom instead of minimise
#Left::Tile("L") ; left
#Right::Tile("R") ; right
#Numpad1::Tile("BL") ; bottom left
#Numpad2::Tile("B") ; bottom 50%
#Numpad3::Tile("BR") ; bottom right
#Numpad4::Tile("L") ; left
#Numpad5::WinMaximize, A ; maximise window
#NumpadClear::WinSet, AlwaysOnTop, , A ; W-S-Num5 toggles current window to always on top
#Numpad6::Tile("R") ; right
#Numpad7::Tile("TL") ; top left
#Numpad8::Tile("T") ; top 50%
#Numpad9::Tile("TR") ; top right
#Numpad0::winSplit() ; W-num0 tile windows vertically
#NumpadIns::winSplitH() ; W-S-num0 tile windows horizontally


; application specific hotkeys
#IfWinActive ahk_class #32770 ; misc save/load/time-date/find boxes and more!
	CapsLock::Send !{F4} ; quit
  F1:: ; overflow to rename, help is useless in explorer
  F2::explorerRename() ; rename commands
  /::Send, \ ; forward slashes paths aren't accepted
  !/::Send, / ; just in case you need an incorrect slash
#IfWinActive

#IfWinActive ahk_class CabinetWClass ; explorer
  CapsLock::explorerUp()
  Alt & Enter:: ; overflow
  Ralt & Enter::Send {AppsKey}{Up}{Enter} ; ralt-enter properties
  ^Enter::explorerSplit()
  ^+Enter::Send {AppsKey}{Down 2}{Enter} ; C-S enter opens in new window
  F1:: ; overflow to rename, help is useless in explorer
  F2::explorerRename() ; rename commands
  F3::explorerCMD()
  F6::Send !d ; addressbar
  ^Backspace::Send ^+{Left}{Backspace} ; backspace a word
  ^f::Return ; disable search in explorer, was always pretty useless
  ^h::explorerHidden()
  ^+n::explorerNewDir()
  ^!+n::explorerNewFile()
  ^p::Send, !p ; C-p also works for toggle preview
  ^s::Send !vb ; view > status bar
  ^0::Send !vd ; view > details
  ^-::Send ^{WheelDown 2} ; zoom out
  ^=::Send ^{WheelUp 2} ; zoom in
#IfWinActive

#IfWinActive ahk_class ShockwaveFlashFullScreen ; full screen flash
  Ralt & Enter:: ; overflow
  Alt & Enter::toggleFullscreen() ; leave flash full screen with a keyboard command
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
  ^w:: ; overflow
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
  ^!+v::pasteClipboard() ; C-A-S-v past clipboard as above steals C-A-v
  ^+n::Send !iw ; new sheet
  ^+w::Send !el ; delete current sheet
  !F2:: ; overflow
  ^F2::Send !ohr ; rename sheet
  F3::Send +{F4} ; f3 searches for the same string again
  F6::excelFormulaBar()
  F11::Send !vu ; fullscreen
  ^Tab::Send ^{PgDn} ; next sheet
  ^+Tab::Send ^{PgUp} ; prev sheet
  ^0::Send !vz1{Enter} ; reset zoom
  ^-::Send ^{WheelDown} ; zoom out
  ^=::Send ^{WheelUp} ; zoom in
#IfWinActive

#IfWinActive ahk_class wxWindowNR ; hydrus client
  CapsLock::Send !{F4} ; quit
#IfWinActive

#IfWinActive ahk_class ConsoleWindowClass ; command prompt
  +Insert:: ; unix style S-insert, overflow
  ^v::cmdPaste() ; win style C-v, paste function
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
  ^+o::Send, !t{sleep 150}o ; C-S-o options
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
  ^0::Send ^/ ; remap transparency feature to reset zoom level, in keeping with other hotkeys
  !t::Return ; disable always on top
  ^+Down:: ; overflow
  ^Down::Send {Down} ; disable (alt) shift line down feature
  ^+Up:: ; overflow
  ^Up::Send {Up} ; disable (alt) shift line up feature
  !u::Send ^a!o ; remap delete last character to sort lines, after selecting everything
#IfWinActive

#IfWinActive ahk_class wxWindowClassNR ; audacity
  ^=::Send ^1 ; zoom in
  ^-::Send ^3 ; zoom out
  ^0::Send ^2 ; zoom reset
#IfWinActive

#IfWinActive ahk_class WinClass_FXS ; civilization 5
  F11::borderlessFullscreen()
#IfWinActive

#IfWinActive ahk_class LaunchUnrealUWindowsClient ; viscera cleanup detail
  F11::borderlessFullscreen()
#IfWinActive


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
:*?:_week::
  insertWeek()
  Return
:*?:_gw::
  insertGateway()
  Return
:*?:_lip::
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
:*:_mac::
	insertRemoteMAC()
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
  insertCygPath()
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
:*:kronor::kroner
; german
:c*?:(Ui)::Ü
:c*?:(ui)::ü
:*?:(ss)::ß
; dutch and/or maxïmo park
:c*?:(Ii)::Ï
:c*?:(II)::Ï
:c*?:(ii)::ï
; icelandic/faroese
:c*?:(-D)::Ð
:c*?:(-d)::ð
:c*?:(/P)::Þ
:c*?:(/p)::þ
:c*?:(Y-)::Ý
:c*?:(y-)::ý
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

; typos and common mistakes
:*:adn::and
:*:aging::ageing
:*:aquire::acquire
:*:attendent::attendant
:*:cinammon::cinnamon
:*:competative::competitive
:*:componant::component
:*:consistant::consistent
:*:enterance::entrance
:*:equivelant::equivalent
:*:excercise::exercise
:*:fiber::fibre
:*:forth::fourth
:*:fourty::forty
:*:goverment::government
:*:habe::have
:*:i'::I' ; fix common casing
:*:imediate::immediate
:*:liase::liaise
:*:liasing::liaising
:*:license::licence
:*:micheal::michael
:*:occurance::occurence
:*:parliment::parliament
:*:persu::pursu
:*:propogate::propagate
:*:recieve::receive
:*:refridgeration::refrigeration
:*:secratery::secretary
:*:seperate::separate
:*:sieze::seize
:*:taht::that
:*:teh ::the{space} ; space is for the rare occurence where I type tehran
:*:tehy::they

; general abbreviations
:*:afaik::as far as I know
:*:iirc::if I recall correctly
:*:imho::in my honest opinion
:*:imo::in my opinion

; work related abbreviations
:*:ctsty::Called to speak to you, their number is 
:*:gtacb::Called to speak to you, can you give them a call back?
:*:ccwi::Customer called regarding an issue relating to 
:*:ctt::Feel free to close the ticket.
:*:yctt::You can close this ticket.


; functions
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

insertRemoteMAC() {
		global remoteMAC
    Send, %remoteMAC%
	}

insertCygPath() {
    Send, %A_WinDir%\..\cygwin\home\
  }

launchTerminal() {
    IfNotExist, %SystemDrive%\cygwin\
      Run, C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -
    Else
      Run, C:\cygwin\bin\mintty.exe -i /Cygwin-Terminal.ico -
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
    Send, %gateway%{del} ; del is for auto complete filling in the rest of the address bar unecessarily
  }

insertSignature() {
    global firstName
    global lastName
    StringLeft, firstInitial, firstname, 1
    StringLeft, lastInitial, lastname, 1
    Send, %A_Space%-%firstInitial%%lastInitial%
  }

insertFooter() {
		Send, {Enter}
		insertDateTime()
		Send, {Space}
		insertSignature()
    Return
	}

insertCRMFooter() {
		insertFooter()
		Send, {Tab}{Space} ; jump out of textarea and press save
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

insertWeek() {
    yearWeek = %A_YDay%
    yearWeek /= 7
    yearWeek++ ; Convert from 0-base to 1-base 
    Send %yearWeek%
  }

appendClipboard() {
    backupClipboard = %clipboard%
    Send, ^c
    clipboard = %backupClipboard%`r`n%clipboard%
    backupClipboard = 
    Return
  }

pasteClipboard() { ; manually paste clipboard, minus most formatting
    StringReplace, clipboard, clipboard, •,, All ; remove bullet points
    StringReplace, clipboard, clipboard, ·,, All ; remove middots
    StringReplace, clipboard, clipboard, %A_Tab%,, All ; remove tabs
    StringReplace, clipboard, clipboard, `r,, All ; remove half of line breaks
    StringReplace, clipboard, clipboard, `n,, All ; remove other half of line breaks
    clipboard = %clipboard% ; trim whitespace
    SendRaw %clipboard%
    Return
  }

formatNumber() {
    StringReplace, clipboard, clipboard, +44 `(0`), 0, All ; translate incorrect intl code
    StringReplace, clipboard, clipboard, +44, 0, All ; translate intl codes
    StringReplace, clipboard, clipboard, %A_Space%,, All ; remove spaces
    StringReplace, clipboard, clipboard, %A_Tab%,, All ; remove tabs
    StringReplace, clipboard, clipboard, `,,, All ; remove commas
    StringReplace, clipboard, clipboard, `r,, All ; remove lines
    StringReplace, clipboard, clipboard, `n,, All ; remove lines
    StringReplace, clipboard, clipboard, -,, All ; remove hyphens
    StringReplace, clipboard, clipboard, (,, All ; remove lbracket
    StringReplace, clipboard, clipboard, ),, All ; remove rbracket
    Return
  }

pasteTelephone() {
    backupClipboard = %clipboard%
    formatNumber()
    StringLeft, 5Digits, clipboard, 5 ; area code
    ; if %5Digits% = "01298" ; if area code is buxton
    StringRight, 6Digits, clipboard, 6
    Send %5Digits% %6Digits%
    Clipboard := backupClipboard
    backupClipboard = 
    5Digits = 
    6Digits = 
    Return
  }

dialTelephone() { ; mondago/lg phone-link
    backupClipboard := Clipboard
    Send, ^c{Sleep 50} ; sometimes won't work nicely without a pause
    formatNumber()
    Run, dial://%clipboard% ; send dial command, probably needs enable internet dialling to work
    ToolTip, Dialling %clipboard% ; flash tooltip showing number sent
    sleep, 1500 ; janky close function avoiding timers
    ToolTip ; close tooltip
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

cmdPaste() { ; pastes into cmd
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

explorerSplit() {
    Send {AppsKey}{Down 2}{Enter}{Sleep 100}
    winSplit()
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
    If A_OSVersion in WIN_XP ; deselect file extension by determining final . character
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

explorerCMD() { ; open command prompt in current location, now with support for other drives but still a bit glitchy as ever
    backupClipboard = %Clipboard%
    Send !d^c ; jump to address bar and copy string
    StringLeft, driveLetter, clipboard, 2 ; extract drive letter from address
    Run, cmd ; run command prompt
    WinWaitActive ahk_class ConsoleWindowClass
        Send, popd %driveLetter%{Enter}%driveLetter%{Enter}cd "%clipboard%"{Enter}cls{Enter} ; jump to a network drive location too
        Return
    Clipboard = %backupClipboard%
    backupClipboard =
    driveLetter =
    Return
  }

explorerHidden() { ; toggle show/hide hidden folders, stolen from http://www.autohotkey.com/board/topic/68131-turn-off-show-hidden-files-at-boot/
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

explorerNewDir() { ; allows xp to create new folder from keypress
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

explorerNewFile() { ; create a new blank text file
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
    MouseMove, 250, 65
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
    global serverRemoteIPAddress
    Run mstsc /v:%serverRemoteIPAddress%
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
    Send {Sleep 50}{Esc}{F6}{ShiftDown}{Tab 2}{ShiftUp}{AppsKey}w{Sleep 250} ;break off current tab
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

; auto-reload script on source change
changeReload:
  {
    FileGetAttrib, FileAttribs, %A_ScriptFullPath%
    IfInString, FileAttribs, A
      {
        FileSetAttrib, -A, %A_ScriptFullPath%
        TrayTip, Reloading Script..., %A_ScriptName%, , 1
        Reload
        Sleep, 5000
        TrayTip
      }
    Return
  }
