; disable alt as menu key
~Alt::Send "{Blind}{vkE8}"

; capslock to control
CapsLock::Ctrl

#`::
{
    WinActivateBottom("ahk_exe " . WinGetProcessName("A"))
}

F1::
{
    if WinExist("ahk_exe msedge.exe")
        WinActivate
}

^F1::
{
    if WinExist("ahk_exe datagrip64.exe")
        WinActivate
}

F2::
{
    if WinExist("ahk_exe emacs.exe")
        WinActivate
}

^F2::
{
    if WinExist("ahk_exe Code.exe")
        WinActivate
}

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
    if WinExist("ahk_exe CargoWise.exe")
        WinActivate
}

^F4::
{
    if WinExist("ahk_exe Quick Get Latest.exe")
        WinActivate
}

F5::
{
    if WinExist("ahk_exe WindowsTerminal.exe")
        WinActivate
}

^F5::
{
    if WinExist("ahk_exe xtadmin.exe")
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

F8::
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

; jk at the same time for Escape
; j & k::Escape
; j::Send("j")
; k & j::Escape
; k::Send("k")

#a::^a
!c::^c
#c::^c
#c::^c
!d::Delete
!+d::^Delete
!f::BackSpace
!+f::^BackSpace
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
!v::^v
#v::^v
!x::^x
#x::^x
!z::^z

; Define a hotkey to show the context menu
^+[::AppsKey

#HotIf WinActive("ahk_exe emacs.exe")
!x::!x
!c::!c
!v::!v
!s::!s
!w::!w
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
#w::^F4
!Space::!Home
^!+f::^!+f
#HotIf

#HotIf WinActive("ahk_exe datagrip64.exe")
#n::!Insert
#w::^F4
!Space::!Home
!k::Down
#HotIf

#HotIf WinActive("ahk_exe Code.exe")
!Space::!Home
#HotIf

#HotIf WinActive("ahk_exe WindowsTerminal.exe")
#t::^+t
#w::^+w
#HotIf
