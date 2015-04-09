
#IfWinActive ahk_class CabinetWClass ;explorer
  Capslock:: ;up one folder
  if A_OSVersion in WIN_XP
    {
    Send {Backspace}
    }
    Else
    {
    Send !{Up}
    }
    Return
  F6::Send !d ;addressbar
  Ralt & Enter::Send {AppsKey}{Up}{Enter} ; ralt-enter properties
  F1:: ;overflow to rename, help is useless in explorer
  F2:: ;rename commands
  if A_OSVersion in WIN_XP
    {
    Send {F2}{Ctrldown}{Home}{Shiftdown}{End}{Ctrlup}{Left 4}{Shiftup} ; rename (hopefully) deselects file extension
    }
    Else
    {
    Send {F2}
    }
    Return
  F3:: ;cmd to path
    ClipSaved := ClipboardAll
    Send !d
    Sleep 10
    Send ^c
    Run, cmd /K "cd `"%clipboard%`""
    Clipboard := ClipSaved
    ClipSaved =
    Return
  ^h:: ;toggle show/hide hidden folders, stolen from http://www.autohotkey.com/board/topic/68131-turn-off-show-hidden-files-at-boot/
  RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
  If HiddenFiles_Status = 2
    RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
    Else
      RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
    WinGetClass, eh_Class,A
    If (eh_Class = "#32770" OR A_OSVersion = "WIN_VISTA" OR A_OSVersion = "WIN_7")
      send, {F5}
    Else PostMessage, 0x111, 28931,,, A
    Return
  ^+n::Send {AltDown}f{AltUp}wf ;windows xp only
#IfWinActive

#IfWinActive ahk_class FontViewWClass ;font previewer
  Capslock::Send !{F4} ;quit
#IfWinActive

#IfWinActive ahk_class SciCalc ; windows xp calc
  Capslock::Send !{F4} ;quit
#IfWinActive
#IfWinActive ahk_class CalcFrame ; windows 7 calc
  Capslock::Send !{F4} ;quit
#IfWinActive

#IfWinActive ahk_class Photo_Lightweight_Viewer ;photoviewer windows 7
  Capslock::Send !{F4} ;quit
  Up::Return ;removes annoying feature where up/down stops left/right naviagation
  Down::Return
#IfWinActive

#IfWinActive ahk_class ShImgVw:CPreviewWnd ;photoviewer windows xp
  Capslock::Send !{F4} ;quit
#IfWinActive

#IfWinActive ahk_class SUMATRA_PDF_FRAME ;sumatra pdf
  Capslock::Send !{F4} ;quit
  ^b::Send {F12} ; ctrl+b for bookmarks
  !Enter::Send ^l ;fullscreen
#IfWinActive

#IfWinActive ahk_class MediaPlayerClassicW ;mpc-hc
  1::Send 2^1 ;1 keeps borders
  Ralt & Enter::Send !{Enter} ; ralt-enter fullscreens
  Capslock::Send !{F4} ;quit
  p::Send ^7 ;p for playlist
#IfWinActive

#IfWinActive ahk_class mpv ;mpv
  Alt & Enter:: ;overflow to fullscreen below
  Ralt & Enter::Send f ; ralt-enter fullscreens
  Capslock::Send !{F4} ;quit
#IfWinActive

#IfWinActive ahk_class rctrl_renwnd32 ;outlook
  ^Enter::Return ;disable accidentally send email shortcut
#IfWinActive

#IfWinActive ahk_class XLMAIN ;excel
  ^+v::Send {Esc}{Up}^c{Down}^v{Esc}{Down} ;ctrl+shift+v copies above cell into current
  ^F2::Send {AltDown}o{AltUp}hr ;rename sheet
  F3::Send {CtrlDown}f{CtrlUp}{Enter}{Escape} ;f3 searches for the same string again
  F6:: ;jumps to formula bar
    CoordMode, Mouse, Relative
    MouseMove, 180, 60
    Send {LButton}
    return
#IfWinActive

#IfWinActive ahk_class WindowsForms10.Window.8.app.0.2004eee ;act
  ^Enter::Send ^{End}{Space}-PG+{Tab 3}{Enter} ;save note with footer
  ^n::Send {F9} ;insert note
  ^f::Send !LC ;search for company
#IfWinActive

#IfWinActive ahk_class ConsoleWindowClass ;command prompt
  ^c:: ;copy
    Send {Enter}
    return
  +Insert::
  ^v:: ;paste
    CoordMode, Mouse, Relative
    MouseMove, 100, 100
    Send {RButton}p
    return
#IfWinActive

#IfWinActive ahk_class ahk_class ahk_class MozillaWindowClass ;firefox
	^+w::Send ^w ;quit window closes tab
	^+n::Send ^+p ;new incognito window
	^q::Send ^w ;quit now closes tab, the two keys are too close for this sort of thing
	^!d::Send ^j ;why Downloads is ctrl+j while addons is ctrl+alt+a will never make sense
	^d::Send ^f ;bookmark remapped to find
	^b::Send ^v ;replace bookmarks with paste
	f6::Send ^l ;F6 jumps to address bar
	^+o::Send {AltDown}t<{AltUp}o ;ctrl+shift+o option
	#o::Send, ^c^t^v{Enter} ;copy selected uri and open, right click option fails to recognise ~50% of what I try
	+PgDn::Send {Space 4}{Down 7} ;scroll down to specific part of a specific page, not really
  +PgUp::Send {Home} ;makes sense, kinda
#IfWinActive

#IfWinActive ahk_class MSPaintApp ;mspaint
  ^=::Send {CtrlDown}{PgUp}{CtrlUp} ;zoom in
  ^-::Send {CtrlDown}{PgDn}{CtrlUp} ;zoom out
#IfWinActive

#IfWinActive ahk_class Notepad2 ;notepad2-mod
  !z::Return ;disable delete first char of line 'feature;
  ^0::Return ;disable annoying transparency feature
  !t::Return ;disable always on top
  ^+Down::
  ^Down::Send {Down} ; disable (alt) shift line down feature
  ^+Up::
  ^Up::Send {Up} ; disable (alt) shift line up feature
#IfWinActive

#IfWinActive ahk_class wxWindowClassNR ;audacity
  ^=::Send {CtrlDown}1{CtrlUp} ;zoom in
  ^-::Send {CtrlDown}3{CtrlUp} ;zoom out
  ^0::Send {CtrlDown}2{CtrlUp} ;zoom reset
#IfWinActive

#IfWinActive ahk_class civ5 ;civilization 5
  F12:: ;borderless fullscreen script from PCGW (http://pcgamingwiki.com/wiki/Glossary:Borderless_fullscreen_windowed#Borderless_scripts)
  WinGet, WindowID, ID, A
  WinSet, Style, -0xC40000, ahk_id %WindowID%
  WinMove, ahk_id %WindowID%, , 0, 0, A_ScreenWidth, A_ScreenHeight
  return
#IfWinActive
