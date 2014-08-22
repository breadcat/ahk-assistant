
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
#IfWinActive

#IfWinActive ahk_class FontViewWClass ;font previewer
  Capslock::Send !{F4} ;quit
#IfWinActive

#IfWinActive ahk_class SciCalc ;calc
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

#IfWinActive ahk_class rctrl_renwnd32 ;outlook
  ^Enter::Return ;disable accidentally send email shortcut
#IfWinActive

#IfWinActive ahk_class XLMAIN ;excel
  ^+v::Send {Esc}{Up}^c{Down}^v{Esc}{Down} ;ctrl+shift+v copies above cell into current
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
