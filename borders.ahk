
;doesn't work via include, must run standalone

GoSub, HookWindow

HookWindow:
    ; New Window Hook
    Gui +LastFound
    hWnd := WinExist()

    DllCall( "RegisterShellHookWindow", UInt,hWnd )
    MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
    OnMessage( MsgNum, "ShellMessage" )

    ShellMessage(wParam,lParam) {
        If (wParam = 1) ;  HSHELL_WINDOWCREATED := 1
        {
            Sleep, 10
            AdjustWindow(lParam)
        }
    }
Return

AdjustWindow(id)
{
    WinId := id
    WinTitle := id = "A" ? "A" : "ahk_id " . id

    ; This is to check if the window is shown in the alt-tab menu, you don't want to do it on every single frame
    WinGet, WinExStyle, ExStyle, %WinTitle%
    If (WinExStyle & 0x80)
    {
        Return
    }

    WinGetClass, WinClass, %WinTitle%
    WinGet, WinProcess, ProcessName, %WinTitle%

    If WinClass In % "CabinetWClass"
    If WinProcess In % "explorer.exe"
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinClass In % "ShImgVw:CPreviewWnd" ;windows xp image viewer
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinClass In % "MMCMainFrame" ;windows xp mmc panes
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinClass In % "MozillaWindowClass" ;firefox
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinProcess In % "Photoshop.exe"
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinProcess In % "sumatrapdf.exe"
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinProcess In % "mintty.exe"
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinProcess In % "7zFM.exe" ;7zip
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinProcess In % "msaccess.exe"
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinProcess In % "excel.exe"
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinProcess In % "Notepad2.exe"
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinProcess In % "outlook.exe"
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
    If WinProcess In % "winword.exe"
    {
        WinSet, Style, -0xC00000, %WinTitle%
    }
}