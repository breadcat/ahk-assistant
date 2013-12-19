
;explorer
#IfWinActive ahk_class CabinetWClass
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

;font previewer
#IfWinActive ahk_class FontViewWClass
  Capslock::Send !{F4} ;quit
#IfWinActive


;photoviewer 7
#IfWinActive ahk_class Photo_Lightweight_Viewer
  Capslock::Send !{F4} ;quit
  Up::Return ;removes annoying feature where up/down stops left/right naviagation
  Down::Return
#IfWinActive

;photoviewer xp
#IfWinActive ahk_class ShImgVw:CPreviewWnd
  Capslock::Send !{F4} ;quit
#IfWinActive

;sumatrapdf
#IfWinActive ahk_class SUMATRA_PDF_FRAME
  Capslock::Send !{F4} ;quit
#IfWinActive

;mpc-hc
#IfWinActive ahk_class MediaPlayerClassicW
  1::Send 2^1 ;1 keeps borders
  Ralt & Enter::Send !{Enter} ; ralt-enter fullscreens
  Capslock::Send !{F4} ;quit
  p::Send ^7 ;p for playlist
#IfWinActive

;outlook
#IfWinActive ahk_class rctrl_renwnd32
  ^Enter::Return ;disable accidentally send email shortcut
#IfWinActive

;excel
#IfWinActive ahk_class XLMAIN
  ^+v::Send {Esc}{Up}^c{Down}^v{Esc}{Down} ;ctrl+shift+v copies above cell into current
#IfWinActive

;mstsc
#IfWinActive ahk_class #32770
  ^Enter::Send 10.0.0.5{Enter} ;tserver
  ^+Enter::Send 10.0.0.10{Enter} ;dserer
#IfWinActive

;act
#IfWinActive ahk_class WindowsForms10.Window.8.app.0.2004eee
  ^Enter::Send ^{End}{Space}-PG+{Tab 3}{Enter} ;save note with footer
  ^n::Send {F9} ;insert note
  ^f::Send !LC ;search for company
#IfWinActive

;command prompt
#IfWinActive ahk_class ConsoleWindowClass
  ^c:: ;copy
    Send {Enter}
  return
  ^v:: ;paste
    CoordMode, Mouse, Relative
    MouseMove, 100, 100
    Send {RButton}p
  return
#IfWinActive

;firefox
#IfWinActive ahk_class MozillaWindowClass
  ^+w::Send ^w ;quit window closes tab
	^q::Send ^w ;quit now closes tab, the two keys are too close for this sort of thing
	^d::Send ^f ;bookmark remapped to find
	^+n::Run firefox.exe -private-window ;remap unclose window to new private tab
#IfWinActive

;notepad2-mod
#IfWinActive ahk_class Notepad2
  !z::Return ;disable delete first char of line 'feature;
  ^0::Return ;disable annoying transparency feature
  ^Down::Send {Down} ; disable shift line down feature
  ^Up::Send {Up} ; disable shift line up feature
#IfWinActive
