; disable alt as menu key
~Alt::Send "{Blind}{vkE8}"

; capslock to control
CapsLock::Ctrl

F1::
{
    if WinExist("ahk_exe msedge.exe")
        WinActivate
}

F2::
{
    if WinExist("ahk_exe Code.exe")
        WinActivate
}

F3::
{
    if WinExist("ahk_exe rider64.exe")
        WinActivate
}

F4::
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

F10::
{
    if WinExist("ahk_exe ms-teams.exe")
        WinActivate
}

!c::^c
#c::^c
!d::Delete
!+d::^Delete
!f::BackSpace
!+f::^BackSpace
!i::Up
!+i::PgUp
!j::Left
!+j::Home
!k::Down
!+k::PgDn
!l::Right
!+l::End
!m::Enter
!n::^Home
!+n::^End
!s::^s
#s::^s
!v::^v
#v::^v
!x::^x
#x::^x
!z::^z
#z::^z
