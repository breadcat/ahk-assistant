; ahk-assistant
; ^ctrl #win !alt +shift

; environment
#NoEnv
#SingleInstance,Force
#Include, *i %A_ScriptDir%\variables.ahk ; include physical and ip address completions, only included if exists. See .gitignore for details
CoordMode,Mouse
SetWorkingDir %A_MyDocuments%\..\
SetWinDelay,0
SetKeyDelay,0
SetControlDelay,0
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
SetNumLockState, AlwaysOn
SetTimer, changeReload, 1000

; custom tray menu
menu, tray, icon, %A_ScriptDir%\%A_ScriptName%.ico ; tray icon
menu, tray, nostandard
menu, tray, add, Edit script source, scriptEdit ; edit scriptname.ahk
menu, tray, add, Edit variable source, scriptEditVariables ; edit variable.ahk
menu, tray, add, Autorun Script, scriptAutorun ; autorun tray indicator
menu, tray, add ; seperator for menu
menu, tray, standard

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
#t:: ; overflow
#Enter::Run cmd ; command prompt
#p:: ; overflow
#+Enter:: Run putty
*CapsLock::BackSpace
RWin::AppsKey ; remap key for Rosewill keyboards
#\::SendMessage 0x112, 0xF170, 2, , Program Manager ; W-\ - screen standby
^!\::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0) ; C-A-\ - system standby
^!+x::forceClose() ; C-A-S-x force close application
#c::Run calc
^+v::pasteClipboard()
^!m::ControlSend, , {Space}, ahk_exe mpv.exe ; global hotkey to toggle mpv pause/play
^!n::dailyNotes()
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
!^-::Send {Volume_Down 1} ; C-A-- volume down
!^=::Send {Volume_Up 1} ; C-A-+ volume up
Insert::appendClipboard()
#LButton::WinSet, Style, -0x840000, A ; W-Click - remove window borders
!LButton::kdeMove() ; kde style window moving
!RButton::kdeResize() ; kde style window resizing
#+Down::Send !{Esc} ; Send to bottom instead of minimise
#Numpad5::WinMaximize, A ; maximise window
#NumpadClear::WinSet, AlwaysOnTop, , A ; W-S-Num5 toggles current window to always on top

; spotify global hotkeys
^Numpad7::PostMessage, 0x319,, 0xC0000,, ahk_exe Spotify.exe ; prev track spotify
^Numpad8::PostMessage, 0x319,, 0xE0000,, ahk_exe Spotify.exe ; pause toggle spotify
^Numpad9::PostMessage, 0x319,, 0xB0000,, ahk_exe Spotify.exe ; next track spotify


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
^+Enter::Send {AppsKey}e ; C-S-enter opens in new window
F1:: ; overflow to rename, help is useless in explorer
F3::Send, {F2} ; rename for fun, nobody uses F3
F6::Send !d ; addressbar
^Backspace::Send ^+{Left}{Backspace} ; backspace a word
^f::Return ; disable search in explorer, was always pretty useless
^h::explorerHidden()
^p::Send, !p ; C-p also works for toggle preview
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

#IfWinActive ahk_exe 7zFM.exe ; 7zip file manager
!Up::Send {Backspace}
#IfWinActive

#If WinActive("ahk_exe AppMgrEX.exe") or WinActive("ahk_exe AppMgr.exe") or WinActive("ahk_exe AppMgrPx.exe") ; NEC programming tools
global necUsername
global necPassword
global necPort
:*?:__login::
   Send tech{Tab}12345678{Enter}
Return
Alt & Enter:: ; connect, paste IP, enter credentials, connect
Send {F5}{Sleep 250}{Tab 5}{Sleep 250}
pasteClipboard()
Send {Tab}{Enter}{Tab}%necPort%{Tab 2}{Enter}{Tab}%necUsername%{Tab}%necPassword%{Tab}{Enter}{Sleep 250}{Enter}
Return
#If

#If WinActive("ahk_class SciCalc") or WinActive("ahk_class CalcFrame") ; windows xp or windows 7 calculator
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

#IfWinActive ahk_exe nomacs.exe
q:: ; overflow
^w:: ; overflow
CapsLock::Send !{F4} ; quit
!Left::Send {AltDown}e9{AltUp} ; CCW rotation
!Right::Send, {AltDown}e0{AltUp} ; CW rotation
#IfWinActive

#IfWinActive ahk_class IrfanView
q:: ; overflow
^w:: ; overflow
CapsLock::Send !{F4} ; quit
!Left::Send l
!Right::Send r
#IfWinActive

#IfWinActive ahk_class FullScreenClass ; irfanview fullscreen-o-mode
q:: ; overflow
^w:: ; overflow
CapsLock::Send !{F4}{sleep 15}!{F4} ; quit
#IfWinActive

#IfWinActive ahk_exe SumatraPDF.exe ; sumatra pdf
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

#If WinActive("ahk_exe mpv.exe") or WinActive("ahk_exe mpvnet.exe") ; mpv and mpv.net
Alt & Enter:: ; overflow to fullscreen below
Ralt & Enter::Send f ; ralt-Enter fullscreens
q:: ; overflow to quit, for mpv.net
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
F6::Send {F2} ; shortcut to formula bar
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
^l::Send ^c{Enter}cls{Enter} ; clear screen as in linux
#IfWinActive

#IfWinActive ahk_class MozillaWindowClass ; firefox
^+w::Send ^w ; quit window closes tab
^+n::Send ^+p ; new incognito window
^q::Send ^w ; quit now closes tab, the two keys are too close for this sort of thing
^!d::Send ^j ; why Downloads is ctrl+j while addons is ctrl+alt+a will never make sense
^d::Send ^f ; bookmark remapped to find
^b::Send ^v ; replace bookmarks with paste
^+m::Send, ^+n ; why is this feature even a thing
#o::Send, ^c{F6}^v{Enter} ; copy selected uri and open in current tab
#+o::Send, ^c^t^v{Enter} ; copy selected uri and open in new tab
^+o::Send, !t{sleep 150}s ; C-S-o options
F1:: ; overflow
F2::Send {Sleep 25}{Esc}{Sleep 25}{F6}{ShiftDown}{Tab 2}{ShiftUp}{AppsKey}w{Sleep 250} ; split current tab from window
F7:: ; overflow
F6::Send ^l ; F6 jumps to address bar
+PgDn::Send {Space 4}{Down 5} ; scroll down to specific part of a specific page, not really
+PgUp::Send {Home} ; makes sense, kinda
RAlt & Left::Send, !{Left}
RAlt & Right::Send, !{Right}
Ralt & Enter:: ; overflow
Alt & Enter::toggleFullscreen() ; leave flash full screen with a keyboard command
:*?:_crm::
   insertCRMFooter()
return
#IfWinActive

#IfWinActive ahk_exe mspaint.exe ; mspaint
^=::Send ^{PgUp} ; zoom in
^-::Send ^{PgDn} ; zoom out
#IfWinActive

#If WinActive("ahk_class Notepad2") or WinActive("ahk_class Notepad3") ; notepad 2 and 3
^0::Send ^/ ; remap transparency feature to reset zoom level, in keeping with other hotkeys
!t::Return ; disable always on top
^+Down:: ; overflow
^Down::Send {Down} ; disable (alt) shift line down feature
^+Up:: ; overflow
^Up::Send {Up} ; disable (alt) shift line up feature
!u::Send ^a!o ; remap delete last character to sort lines, after selecting everything
#IfWinActive

#IfWinActive ahk_exe calibre-parallel.exe ; calibre reader
q:: ; overflow
CapsLock::Send !{F4} ; quit
#IfWinActive

#IfWinActive ahk_exe audacity.exe ; audacity
^=::Send ^1 ; zoom in
^-::Send ^3 ; zoom out
^0::Send ^2 ; zoom reset
#IfWinActive

#IfWinActive ahk_class WinClass_FXS ; civilization 5
F11::borderlessFullscreen()
^h::send {Home}{Esc} ; return to capital city, then close home screen
#IfWinActive

#IfWinActive ahk_exe Teams.exe ; i hate ms teams
^a::Send {End}{ShiftDown}{Home}{ShiftUp}
#IfWinActive

; text insertion/replacements
:*?:_date::
   insertDate()
Return
:*?:_time::
   insertTime()
Return
:*?:_dttime::
   insertBlogDateTime()
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
:*:_cbip::
   Send, %workCBIPAddress%
Return
:*:_ntp::
   Send, 0.uk.pool.ntp.org
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
:*:_wddi::
   Send, %workPhoneNumberDDI%
Return
:*:_mob::
   Send, %mobilePhoneNumber%
Return
:*:_wmob::
   Send, %workMobilePhoneNumber%
Return
:*:_xmraddr::
   Send, %xmrAddress%
Return
:*:_xrbaddr::
   Send, %xrbAddress%
Return
:*:_banaddr::
   Send, %banAddress%
Return
:*:_proid::
   Send, %prolificID%
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
:*:(norquote)::«»{Left}
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
; ...latin?
:c*?:(OE)::Œ
:c*?:(Oe)::Œ
:c*?:(oe)::œ

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

; typos, abbreviations and common mistakes
:*:addon::add-on
:*:adn::and
:*:afaik::as far as I know
:*:aging::ageing
:*:ahve::have
:*:aquire::acquire
:*:atm ::at the moment{space} ; space is for when I type atmosphere
:*:attendent::attendant
:*:bbs::be back soon
:*:bene ::been{space} ; space is for when typing benefit
:*:bolognaise::bolognese
:*:brb::be right back
:*:bredth::breadth
:*:btw::by the way
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
:*:fyi::for your information
:*:goverment::government
:*:habe::have
:*:iirc::if I recall correctly
:*:imediate::immediate
:*:imho::in my honest opinion
:*:imo::in my opinion
:*:independant::independent
:*:intermitent::intermittent
:*:liase::liaise
:*:liasing::liaising
:*:license::licence
:*:liek::like
:*:micheal::michael
:*:neice::niece
:*:occurance::occurrence
:*:occured::occurred
:*:ommitted::omitted
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
:*:supercede::supersede
:*:taht::that
:*:tbh::to be honest
:*:tbqh::to be quite honest
:*:teh ::the{space} ; space is for the rare occurence where I type tehran
:*:tehm::them
:*:tehy::they
:*:wifi::Wi-Fi
:*:woth::with
:*:yhe::the
:*:yuo::you
:c?*:ASAP::as soon as possible
:c?*:i'd::I'd
:c?*:i'll::I'll
:c?*:i'm::I'm
:c?*:i've::I've
:c?*:paypal::PayPal

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
      }}
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
   Else If (A_Hour <17)
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

insertBlogDateTime() {
   FormatTime, CurrentDateTime,, yyyy-MM-ddTHH:mm:00
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

pasteClipboard() {
   ; manually paste clipboard, minus most formatting
   tempClipboard = %clipboard%
   StringReplace, tempClipboard, tempClipboard, ?,, All ; remove bullet points
   StringReplace, tempClipboard, tempClipboard, ·,, All ; remove middots
   StringReplace, tempClipboard, tempClipboard, %A_Tab%,, All ; remove tabs
   StringReplace, tempClipboard, tempClipboard, /,%A_Space%, All ; forward slashes mess up linux paths
   StringReplace, tempClipboard, tempClipboard, +44,0, All ; remove international dialling code without a space
   StringReplace, tempClipboard, tempClipboard, `r,, All ; remove half of line breaks
   StringReplace, tempClipboard, tempClipboard, `n,, All ; remove other half of line breaks
   tempClipboard = %tempClipboard% ; trim whitespace
   SendRaw %tempClipboard%
   tempClipboard =
   Return
}

toggleFullscreen() {
   ;double click the window
   CoordMode, Mouse, Relative
   MouseMove, 250, 250
   Send {Click 2}
   Return
}

explorerHidden() {
   ; toggle show/hide hidden folders, stolen from http://www.autohotkey.com/board/topic/68131-turn-off-show-hidden-files-at-boot/
   RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
   If HiddenFiles_Status = 2
   RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
   Else
      RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
   WinGetClass, eh_Class,A
   Send, {F5}
   Return
}

borderlessFullscreen() {
   ;borderless fullscreen script from PCGW (http://pcgamingwiki.com/wiki/Glossary:Borderless_fullscreen_windowed#Borderless_scripts)
   WinGet, WindowID, ID, A
   WinSet, Style, -0xC40000, ahk_id %WindowID%
   WinMove, ahk_id %WindowID%, , 0, 0, A_ScreenWidth, A_ScreenHeight
   Return
}

forceClose() {
   WinGet, PID, PID, % "ahk_id " WinExist("A")
   Process, Close, %PID%
}

dailyNotes() {
   formattime, todaysDate,, yyyy-MM-dd
   noteFilename := A_WorkingDir . "\Vault\docs\wfh\notes " . todaysDate . ".txt"
   Run notepad "%noteFilename%"
   Return
}

toggleAudioDevice() {
   ;toggle between default audio output (http://ml.pe/optimizing/2013/changing-the-default-sound-device-using-autohotkey/)
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

kdeMove() {
   ;kde-windows (Easy Window Dragging -- KDE style (requires XP/2k/NT) -- by Jonny)
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

scriptEdit:
{
   Run notepad "%A_ScriptDir%\%A_ScriptName%"
   Return
}

scriptEditVariables:
{
   Run notepad "%A_ScriptDir%\variables.ahk"
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