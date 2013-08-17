
;explorer -win7
#IfWinActive ahk_class CabinetWClass
	Capslock::SendInput {ALTDOWN}{UP}{ALTUP} ;capslock goes up a folder
	F6::Send {ALTDOWN}d{ALTUP} ;addressbar
	F1::Send {F2} ;disable help, enable rename
#IfWinActive

;command prompt -winxp
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

;photoviewer -win7
#IfWinActive ahk_class Photo_Lightweight_Viewer
	Capslock::SendInput {ALTDOWN}{F4}{ALTUP} ;quits
	Up::Return ;removes annoying feature where up/down stops left/right naviagation
	Down::Return
#IfWinActive

;mpc-hc -win7
#IfWinActive ahk_class MediaPlayerClassicW
	1::Send 2{ctrldown}1{ctrlup} ;1 keeps borders
	Ralt & Enter::Send {altdown}{enter}{altup} ; ralt-enter fullscreens
	Capslock::Send {altdown}{f4}{altup} ;quit
	p::Send {ctrldown}7{ctrlup} ;p for playlist
#IfWinActive

;chrome/chromium -win7
#IfWinActive ahk_class Chrome_WidgetWin_1
  ^+w::Send {CTRLDOWN}w{CTRLUP}
	^q::Send {CTRLDOWN}w{CTRLUP} ;quit now closes tab, the two keys are too close for this sort of thing
	^d::Send {CTRLDOWN}f{CTRLUP} ;useless bookmark > useful find
	^+h::Send {CTRLDOWN}t{CTRLUP}chrome://chrome/settings/clearBrowserData{ENTER} ;delete history page
#IfWinActive

;remote desktop -winxp
#IfWinActive ahk_class #32770
	^enter::Send 10.0.0.5{enter} ;tserver
	^+enter::Send 10.0.0.10{enter} ;dserer
#IfWinActive

;act -winxp
#IfWinActive ahk_class WindowsForms10.Window.8.app.0.2004eee
	^enter::Send {CONTROLDOWN}{END}{CONTROLUP}{SPACE}-PG{SHIFTDOWN}{TAB 3}{SHIFTUP}{ENTER} ;save note with footer
	^n::Send {F9} ;insert note
	^f::Send {ALTDOWN}L{ALTUP}C ;search for company
#IfWinActive

;outlook -winxp
#IfWinActive ahk_class rctrl_renwnd32
	^enter::Return ;disable accidentally send email shortcut
#IfWinActive

;excel -winxp
#IfWinActive ahk_class XLMAIN
	^+v::Send {ESC}{UP}{CTRLDOWN}c{CTRLUP}{DOWN}{CTRLDOWN}v{CTRLUP}{ESC}{DOWN} ;ctrl+shift+v copies above cell into current
#IfWinActive

;notepad2 -win7
#IfWinActive ahk_class Notepad2
	!z::Return ;disable delete first char of line 'feature;
  ^Down::Send {Down} ; disable shift line down feature
  ^Up::Send {Up} ; disable shift line up feature
#IfWinActive