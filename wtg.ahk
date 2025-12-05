; Run this script as Admin

; ------------------------------------------------------------
; General bindings

; temporarily disable this, cause problem is VSCode
; disable alt as menu key
; ~Alt::Send "{Blind}{vkE8}"

; capslock to control
CapsLock::Ctrl

; Macos style: cycle through windows in the same app
#`::
{
    WinActivateBottom("ahk_exe " . WinGetProcessName("A"))
}

; Define a hotkey to show the context menu
^+[::AppsKey

; need this when the computer is in high load, sometimes AHK cannot respond and then accidentally turn on Caplocks
^F12::CapsLock

; ------------------------------------------------------------
; Fast app switching
F1::
{
    if WinExist("ahk_exe msedge.exe")
        WinActivate
}

^F1::
{
    if WinExist("ahk_exe explorer.exe")
        WinActivate
}

F2::
{
    if WinExist("ahk_exe emacs.exe")
        WinActivate
}

; ^F2::
; {
;     if WinExist("ahk_exe Code.exe")
;         WinActivate
; }

F3::
{
    if WinExist("ahk_exe rider64.exe")
        WinActivate
}

^F3::
{
    if WinExist("ahk_exe devenv.exe")
        WinActivate
}

F4::
{
    if WinExist("ahk_exe CargoWise.WindowsDesktop.exe")
        WinActivate
}

^F4::
{
    if WinExist("ahk_exe CargoWise.exe")
        WinActivate
}

F5::
{
    if WinExist("ahk_exe WindowsTerminal.exe")
        WinActivate
}

F6::
{
    if WinExist("ahk_exe AppleMusic.exe")
        WinActivate
}

F7::
{
    if WinExist("ahk_exe olk.exe")
        WinActivate
}

^F7::
{
    if WinExist("ahk_exe AppleMusic.exe")
        WinActivate
}

; F8::
; {
;     if WinExist("ahk_exe datagrip64.exe")
;         WinActivate
; }

F8::
{
    if WinExist("ahk_exe Code.exe")
        WinActivate
}

^F8::
{
    if WinExist("ahk_exe Ssms.exe")
        WinActivate
}

F9::
{
    if WinExist("ahk_exe WINWORD.EXE")
        WinActivate
}

^F9::
{
    if WinExist("ahk_exe EXCEL.EXE")
        WinActivate
}

F10::
{
    if WinExist("ahk_exe ms-teams.exe")
        WinActivateBottom
}

; ------------------------------------------------------------
; Ergonomic key bindings
; Set these globally in all apps and in the system, except these apps
; - Emacs: I have my own ergonomic key bindings already, better to use that,
;   more compatible with other Emacs feature
; - Datagrip: has a weird overlay issue so the Alt key will be stuck,
;   better to leave it default and then map inside the app
; - VSCode: has the same weird overlay shit, making the Alt combination mismatch
;   with Ctrl sometimes, disable and then use the mapping inside the application.
;   not all key bindings have problem, so put only the ones having problem here and then remap in VSCode

#HotIf !WinActive("ahk_exe Code.exe") && !WinActive("ahk_exe emacs.exe") ; && !WinActive("ahk_exe datagrip64.exe")
!c::^c
!v::^v
#HotIf

; these keys are set globally
#a::^a
#c::^c
!d::Delete
!+d::^Delete
!f::BackSpace
!+f::^BackSpace
^g::Escape
^+g::^+g
!g::Escape
!+g::!+g
!i::Up
!+i::PgUp
^!i::+Up
^!+i::+PgUp
!j::Left
!+j::Home
^!j::+Left
^!+j::+Home
!k::Down
!+k::PgDn
^!k::+Down
^!+k::+PgDn
!l::Right
!+l::End
^!l::+Right
^!+l::+End
!m::Enter
!n::^Home
!+n::^End
!o::^Right
!+o::!+o
^!o::^+Right
#q::!F4
!s::^s
#s::^s
#+s::#+s ; for snipping tool
^!s::^!s
!u::^Left
!+u::!+u
^!u::^+Left
#v::^v
#w::!F4
!x::^x
#x::^x
!z::^z
^!+f::^!+f

#HotIf WinActive("ahk_exe emacs.exe")
!x::!x
!s::!s
!w::!w
^g::^g
#HotIf

#HotIf WinActive("ahk_exe ms-teams.exe")
#k::^e
#HotIf

#HotIf WinActive("ahk_exe msedge.exe")
!+p::^F6
#r::^r
#t::^t
#w::^w
!w::^w
#+t::^+t
#HotIf

#HotIf WinActive("ahk_exe rider64.exe")
#n::!Insert
#w::!w
!Space::!Home
^!+f::^!+f
#HotIf

; #HotIf WinActive("ahk_exe datagrip64.exe")
; #n::!Insert
; #w::!w
; !Space::!Home

; ; Need to revert these keys to their original function because pressing the Alt key in Rider will send the Alt key twice but doesn't happen for Rider, weird!
; ; Instead, map these manually in DataGrip's keymap
; ; Open DataGrip settings > Kepmap, look for Up/Down/Left/Right and map to !i/k/j/l
; ; https://intellij-support.jetbrains.com/hc/en-us/community/posts/205418310-Keymapping-Issues-with-alt-letter
; ; https://www.reddit.com/r/AutoHotkey/comments/574tay/how_to_get_worked_key_combination_with_alt/
; !i::!i
; !k::!k
; !j::!j
; !l::!l
; !f::!f
; !d::!d
; !w::!w
; !v::!v
; ;!y::!y
; !;::!;
; !o::!o
; !u::!u
; #HotIf

#HotIf WinActive("ahk_exe Code.exe")
!Space::!Home
#HotIf

#HotIf WinActive("ahk_exe WindowsTerminal.exe")
#t::^+t
#w::^+w
#HotIf

#HotIf WinActive("ahk_exe WINWORD.exe")
#+p::
{
    Send("!j")
    Send("p")
}
#HotIf

^!g::
{
    psScript := "
    (
        [Reflection.Assembly]::LoadWithPartialName('System.Web')
        $Today = (Get-Date).Date

        $Monday = $Today.AddDays(1 - $Today.DayOfWeek.value__)
        $Yesterday = $Today.AddDays(-1).ToString('yyyy-MM-dd') + 'T00:00:00'
        $Today = $Today.ToString('yyyy-MM-dd') + 'T00:00:00'
        $Monday = $Monday.ToString('yyyy-MM-dd') + 'T00:00:00'

        $MyStaffGUID = '92682df0-f3c2-4ff3-9a4c-c4e74a847d60'

        $StringProcess = 'edient:Command=RunReport&LicenceCode=EDIAUSSYD&ReportPK=cb3c41a9-c84d-48fb-a728-3dc30ba83267&Hash=`%2bv4`%2fR2`%2fFpmB6uCn`%2f`%2b2vL`%2fLl1PcgOXXJ5q&Configuration=Default+Configuration{2}+See+Configuration+tab+to+modify&Staff={3}&Start+Date={0}&End+Date={1}&Domain=wtg.zone&Instance=ediProd' -f [System.Web.HttpUtility]::UrlEncode($Monday),[System.Web.HttpUtility]::UrlEncode($Yesterday),[System.Web.HttpUtility]::UrlEncode(':'),$MyStaffGUID
        'Process {0}' -f $StringProcess

        Start-Process $StringProcess
    )"
    Run("powershell -NoProfile -Command &{" psScript " }", , "HIDE")
}
^!+g::
{
    psScript := "
    (
        [Reflection.Assembly]::LoadWithPartialName('System.Web')
        $Today = (Get-Date).Date

        $Monday = $Today.AddDays(1 - $Today.DayOfWeek.value__)
        $Yesterday = $Today.AddDays(-1).ToString('yyyy-MM-dd') + 'T00:00:00'
        $Today = $Today.ToString('yyyy-MM-dd') + 'T00:00:00'
        $Monday = $Monday.ToString('yyyy-MM-dd') + 'T00:00:00'

        $MyStaffGUID = '92682df0-f3c2-4ff3-9a4c-c4e74a847d60'

        $StringProcess = 'edient:Command=RunReport&LicenceCode=EDIAUSSYD&ReportPK=cb3c41a9-c84d-48fb-a728-3dc30ba83267&Hash=`%2bv4`%2fR2`%2fFpmB6uCn`%2f`%2b2vL`%2fLl1PcgOXXJ5q&Configuration=Default+Configuration{2}+See+Configuration+tab+to+modify&Staff={3}&Start+Date={0}&End+Date={1}&Domain=wtg.zone&Instance=ediProd' -f [System.Web.HttpUtility]::UrlEncode($Monday),[System.Web.HttpUtility]::UrlEncode($Today),[System.Web.HttpUtility]::UrlEncode(':'),$MyStaffGUID
        'Process {0}' -f $StringProcess

        Start-Process $StringProcess
    )"
    Run("powershell -NoProfile -Command &{" psScript " }", , "HIDE")
}
