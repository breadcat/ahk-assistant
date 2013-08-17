
;explorer
#IfWinActive ahk_class CabinetWClass
  Capslock::Send !{Up} ;capslock goes up a folder
  F6::Send !d ;addressbar
  F1::Send {F2} ;disable help, enable rename
#IfWinActive

;photoviewer
#IfWinActive ahk_class Photo_Lightweight_Viewer
  Capslock::Send !{F4} ;quit
  Up::Return ;removes annoying feature where up/down stops left/right naviagation
  Down::Return
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

;chrome/chromium
#IfWinActive ahk_class Chrome_WidgetWin_1
  ^+w::Send ^w
	^q::Send ^w ;quit now closes tab, the two keys are too close for this sort of thing
	^d::Send ^f ;useless bookmark > useful find
	^+h::Send ^tchrome://chrome/settings/clearBrowserData{Enter} ;delete history page
#IfWinActive

;notepad2
#IfWinActive ahk_class Notepad2
	!z::Return ;disable delete first char of line 'feature;
  ^Down::Send {Down} ; disable shift line down feature
  ^Up::Send {Up} ; disable shift line up feature
#IfWinActive