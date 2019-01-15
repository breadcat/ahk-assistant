
; ahk-assistant
; ^ctrl #win !alt +shift

; environment
#NoEnv
#SingleInstance,Force
CoordMode,Mouse
SetWorkingDir %A_MyDocuments%\..\
SetWinDelay,0
SetKeyDelay,0
SetControlDelay,0
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
SetNumLockState, AlwaysOn
SetTimer, changeReload, 1000
Menu, Tray, Icon, %A_ScriptDir%\%A_ScriptName%.ico ; tray icon
Menu, tray, add ; seperator for menu
menu, tray, add, Autorun Script, scriptAutorun ; autorun tray indicator
#Include, *i %A_ScriptDir%\variables.ahk ; include physical and ip address completions, only included if exists. See .gitignore for details


; global hotkeys
#q::Run notepad
^q::Send !{F4} ; quit most programs
#w::Run firefox
#+w::Run firefox.exe -private-window
#e::Run %A_WorkingDir%\Downloads
#+e::Run %A_WorkingDir%\Vault
^!e::Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d} ; my computer
^!r::Run mstsc ; remote desktop connection
^!+r::Run mstsc /v:%serverRemoteAddress% ; rdp to a destination defined by variable file
#t::Run cmd ; useful terminal
#+t::Run putty -ssh -P %sshPort% %sshHost% ; remote terminal
#p::Run putty
#+Enter::searchCustomer()
*CapsLock::BackSpace
RWin::AppsKey ; remap key for Rosewill keyboards
#\::SendMessage 0x112, 0xF170, 2, , Program Manager ; W-\ - screen standby
^!\::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0) ; C-A-\ - system standby
^!+x::forceClose() ; C-A-S-x force close application
#c::Run calc
^+v::pasteClipboard()
^!m::ControlSend, , {Space}, ahk_exe mpv.exe ; global hotkey to toggle mpv pause/play
^!n::ControlSend, , {Space}, ahk_exe firefox.exe ; global hotkey to toggle firefox pause/play
^!Space::toggleAudioDevice()
RAlt & j::ShiftAltTab
RAlt & k::AltTab
RAlt & PgUp::Send {WheelUp}
RAlt & PgDn::Send {WheelDown}
SC029::Send, 0 ; Backtick send zeroes
+SC029::Send, `` ; S-Backtick send backticks
#SC029::Run %A_ScriptDir%\..\clickcall-dialhandler\dial.exe %clipboard%
^SC029::Send, `¬ ; C-Backtick send negations
!^0::Send {Volume_Mute} ; C-A-0 volume mute toggle
!^-::Send {Volume_Down 3} ; C-A-- volume down
!^=::Send {Volume_Up 3} ; C-A-+ volume up
Insert::appendClipboard()
#LButton::WinSet, Style, -0x840000, A ; W-Click - remove window borders
!LButton::kdeMove() ; kde style window moving
!RButton::kdeResize() ; kde style window resizing
#+Down::Send !{Esc} ; Send to bottom instead of minimise
#Numpad5::WinMaximize, A ; maximise window
#NumpadClear::WinSet, AlwaysOnTop, , A ; W-S-Num5 toggles current window to always on top


; application specific hotkeys
#IfWinActive ahk_class #32770 ; misc save/load/time-date/find boxes and more!
  CapsLock::Send !{F4} ; quit
  F1::Send, {F2} ; rename, help is useless in explorer
  /::Send, \ ; forward slashes paths aren't accepted
  !/::Send, / ; just in case you need an incorrect slash
#IfWinActive

#IfWinActive ahk_class CabinetWClass ; explorer
  CapsLock:: ; overflow
  RAlt & Up::Send {AltDown}{Up}{AltUp}
  Alt & Enter:: ; overflow
  Ralt & Enter::Send {AppsKey}{Up}{Enter} ; ralt-enter properties
  ^+Enter::Send {AppsKey}{Down 2}{Enter} ; C-S enter opens in new window
  F1:: ; overflow to rename, help is useless in explorer
  F3::Send, {F2} ; rename for fun, nobody uses F3
  F6::Send !d ; addressbar
  ^Backspace::Send ^+{Left}{Backspace} ; backspace a word
  ^f::Return ; disable search in explorer, was always pretty useless
  ^h::explorerHidden()
  ^!+n::Send !fwt ; creates a new text file
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

#IfWinActive ahk_class FM ; 7zip file manager
  !Up::Send {Backspace}
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
  q:: ; overflow
  ^w:: ; overflow
  CapsLock::Send !{F4} ; quit
  Up:: ; overflow
  Down::Return ; fixes up/down breaking left/right navigation
#IfWinActive

#IfWinActive ahk_class IrfanView
  q:: ; overflow
  ^w:: ; overflow
  CapsLock::Send !{F4} ; quit
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

#IfWinActive ahk_class XLMAIN ; excel 2003/2007
  ^!t::Send {AppsKey}f{Tab}{End}{Up 2}{Enter} ; sets cell format to text to allow leading zeroes
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
  ^Backspace::Send {CtrlDown}{ShiftDown}{Left}{CtrlUp}{ShiftUp}{Backspace} ; C-Backspace deletes word when in formula bar, can't ^!LB due to it not releasing and deleting the whole line
#IfWinActive

#IfWinActive ahk_class wxWindowNR ; hydrus client
  CapsLock::Send !{F4} ; quit
#IfWinActive

#IfWinActive ahk_class ConsoleWindowClass ; command prompt
  +Insert:: ; unix style S-insert, overflow
  ^v::cmdPaste() ; win style C-v, paste function
  ^l::Send ^c{Enter}cls{Enter} ; clear screen as in linux
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
  F2::Send {Sleep 25}{Esc}{Sleep 25}{F6}{ShiftDown}{Tab 2}{ShiftUp}{AppsKey}w{Sleep 250} ; split current tab from window
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
  ^h::send {Home}{Esc} ; return to capital city, then close home screen
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
  Send,`n`nRegards,`n%firstName%.
  Return
:*?:_kreg::
  Send,`n`nKind regards,`n%firstName%.
  Return
:*:_hem::
  Send, %homeEmailAddress%
  Return
:*:_wem::
  Send, %workEmailAddress%
  Return
:*:_wip::
  Send, %workIPAddress%
  Return
:*:_sip::
  Send, %workSIPAddress%
  Return
:*:_mac::
	Send, %remoteMAC%
	Return
:*:_htel::
  Send, %homePhoneNumber%
  Return
:*:_wtel::
  Send, %workPhoneNumber%
  Return
:*:_mob::
  Send, %mobilePhoneNumber%
  Return
:*:_xmraddr::
  Send, %xmrAddress%
  Return
:*:_xrbaddr::
  Send, %xrbAddress%
  Return
:*:_haddr::
  Send, %homeAddress%
  Return
:*:_waddr::
  Send, %workAddress%
  Return
:*:_hpc::
  Send, %homePostCode%
  Return
:*:_wpc::
  Send, %workPostCode%
  Return
:*:_salu::
  insertSalutation()
  Return
:*:_wdatfile::
  workDatFile()
  Return
:*:_wlcr::
	workLCRInsert()
	Return
:*:_db::
  Send, %A_WorkingDir%\Vault\
  Return
:*:_md::
  Send, %A_WorkingDir%
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
:c*?:(Ei)::Ë
:c*?:(ei)::ë
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
; italian
:c?*:(A\)::À
:c?*:(a\)::à
:c?*:(E\)::È
:c?*:(e\)::è
:c?*:(I\)::Ì
:c?*:(i\)::ì
:c?*:(O\)::Ò
:c?*:(o\)::ò
:c?*:(U\)::Ù
:c?*:(U\)::ù
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
:*:addon::add-on
:*:adn::and
:*:ahve::have
:*:aging::ageing
:*:aquire::acquire
:*:attendent::attendant
:*:bolognaise::bolognese
:*:bredth::breadth
:*:cinammon::cinnamon
:*:comaraderie::camaraderie
:*:competative::competitive
:*:componant::component
:*:consistant::consistent
:*:differnet::different
:*:enterance::entrance
:*:equivelant::equivalent
:*:excercise::exercise
:*:fiber::fibre
:*:fourty::forty
:*:goverment::government
:*:habe::have
:*:imediate::immediate
:*:independant::independent
:*:intermitent::intermittent
:*:liase::liaise
:*:liasing::liaising
:*:license::licence
:*:micheal::michael
:*:neice::niece
:*:occurance::occurrence
:*:occured::occurred
:*:parliment::parliament
:*:persue::pursue
:*:persuit::pursuit
:*:pronounciation::pronunciation
:*:propogate::propagate
:*:recieve::receive
:*:refridgeration::refrigeration
:*:secratery::secretary
:*:segway::segue
:*:seperate::separate
:*:sieze::seize
:*:taht::that
:*:teh ::the{space} ; space is for the rare occurence where I type tehran
:*:tehm::them
:*:tehy::they
:*:wifi::Wi-Fi
:*:yhe::the
:*:yuo::you
:c?*:i'd::I'd
:c?*:i'll::I'll
:c?*:i'm::I'm
:c?*:i've::I've

; general abbreviations
:*:afaik::as far as I know
:*:atm::at the moment
:*:bbs::be back soon
:*:brb::be right back
:*:btw::by the way
:*:fyi::for your information
:*:iirc::if I recall correctly
:*:imho::in my honest opinion
:*:imo::in my opinion
:*:tbh::to be honest
:*:tbqh::to be quite honest
:c?*:ASAP::as soon as possible

; work related abbreviations
:*:ctsty::Called to speak to you, their number is 
:*:gtacb::Called to speak to you, can you give them a call back?
:*:ccwi::Customer called regarding an issue relating to 
:*:ctt::Feel free to close the ticket.
:*:yctt::You can close this ticket.

; week day casing
:c?*:monday::Monday
:c?*:tuesday::Tuesday
:c?*:wednesday::Wednesday
:c?*:thursday::Thursday
:c?*:friday::Friday
:*:saturday::Saturday
:*:sunday::Sunday

; functions
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
    Send, %gateway%
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
		insertSignature()
    Return
	}

insertCRMFooter() {
		insertFooter()
		Send, {Tab}{Space} ; jump out of textarea and press save
    Return
	}

insertSalutation() {
		If(A_Hour <12)
			Send, Morning
		Else if (A_Hour <17)
			Send, Afternoon
		Else
			Send, Evening
	Return
	}

workDatFile() {
		global firstName
		Send order{Tab 3}`.dat file request{Tab}
		insertSalutation()
		Send, ,`n`nPlease can I get a .dat file generated for system ID: %clipboard%?`nThe order reference will be:{Space}`n`nRegards,`n%firstName%.{Up 3}{End}
	Return
	}

workLCRInsert() {
		digitsLCR := "010101"
		digitStart := "2"
		Send 1{tab}0-7{enter}{sleep 1000}{tab 3}
		loop 8 {
			Send c{tab}%digitStart%{tab 2}%digitsLCR%{tab}%digitsLCR%{tab}%digitsLCR%{tab}{sleep 50}
			digitStart++ ; increment digit by 1
		}
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
    StringReplace, clipboard, clipboard, ?,, All ; remove bullet points
    StringReplace, clipboard, clipboard, ·,, All ; remove middots
    StringReplace, clipboard, clipboard, %A_Tab%,, All ; remove tabs
    StringReplace, clipboard, clipboard, `r,, All ; remove half of line breaks
    StringReplace, clipboard, clipboard, /,%A_Space%, All ; forward slashes mess up linux paths
    StringReplace, clipboard, clipboard, `n,, All ; remove other half of line breaks
    clipboard = %clipboard% ; trim whitespace
    SendRaw %clipboard%
    Return
  }

cmdPaste() { ; pastes into cmd
    CoordMode, Mouse, Relative
    MouseMove, 100, 100
    If A_OSVersion in WIN_7
      {
        Send {RButton}p ; p for paste needed for Windows 7
      }
    Else
      {
        Send {RButton}
      }
    Return
  }

toggleFullscreen() { ;double click the window
    CoordMode, Mouse, Relative
    MouseMove, 250, 250
    Send {Click 2}
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

excelFormulaBar() { ;jumps to formula bar
    CoordMode, Mouse, Relative
    MouseMove, 250, 65
    ; Send {LButton}{End}{ShiftDown}{Home}{ShiftUp}
    Send {LButton}{End}
    Return
  }

borderlessFullscreen() { ;borderless fullscreen script from PCGW (http://pcgamingwiki.com/wiki/Glossary:Borderless_fullscreen_windowed#Borderless_scripts)
    WinGet, WindowID, ID, A
    WinSet, Style, -0xC40000, ahk_id %WindowID%
    WinMove, ahk_id %WindowID%, , 0, 0, A_ScreenWidth, A_ScreenHeight
    Return
  }

forceClose() {
    WinGet, PID, PID, % "ahk_id " WinExist("A")
    Process, Close, %PID%
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
        usePlaybackDevice(3)
    Else
        usePlaybackDevice(4)
    Return
  }

usePlaybackDevice(device) {
    Run, mmsys.cpl
    WinWaitActive, Sound ahk_class #32770
    ControlSend, SysListView321,{Down %device%}, Sound ahk_class #32770
    ControlClick, Button2, Sound ahk_class #32770
    WinClose, Sound ahk_class #32770
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

; autorun script section in tray menu
scriptAutorun:
  {
	; delete and recreate registry key
	RegDelete, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, %A_ScriptName%
	RegWrite, REG_SZ, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, %A_ScriptName%, "%A_ScriptDir%\%A_ScriptName%"
	Return
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

