
Shift(Pos)
{
  WinGetClass, class, A
  IfInString , shell_TrayWnd,Progman,Button,DV2ControlHost, %class%
  Return
  IfWinExist,ahk_class Shell_TrayWnd
    SysGet, m, MonitorWorkArea
    Else SysGet, m, Monitor
      WinGetPos, MWT_X, MWT_Y, MWT_W, MWT_H, A
      SendMessage, 0x1F,,,, A
      WinGet, MWT_active, MinMax, A
    if (MWT_active = 1)
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
Return

#Up::WinMaximize, A
#Down::WinMinimize, A
#Left::Shift("L")
#Right::Shift("R")
#Numpad1::Shift("BL")
#Numpad2::Shift("B")
#Numpad3::Shift("BR")
#Numpad4::Shift("L")
#Numpad5::WinMaximize, A
#Numpad6::Shift("R")
#Numpad7::Shift("TL")
#Numpad8::Shift("T")
#Numpad9::Shift("TR")