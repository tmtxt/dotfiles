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
    if WinExist("ahk_exe explorer.exe")
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
    if WinExist("ahk_exe CargoWise.WindowsDesktop.exe")
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

^F6::
{
    if WinExist("ahk_exe Quick Get Latest.exe")
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

^F12::CapsLock

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


;MyGui := Gui("", "Base64 Decode")
;#!p::MyGui.Show()



; Create a GUI window
;gui := GuiCreate("Base64 Decoder", "400x200")

; Add a text box for input
;inputBox := gui.Add("Edit", "w380 h100 vInputBox")

; Add a button to decode the Base64 string
;decodeButton := gui.Add("Button", "w100 h30 vDecodeButton", "Decode")
;decodeButton.OnEvent("Click", DecodeBase64)

; Add a text box for output
;outputBox := gui.Add("Edit", "w380 h100 vOutputBox ReadOnly")

; Show the GUI
;gui.Show()

; Function to decode Base64 string
;DecodeBase64(*) {
    ;global inputBox, outputBox
    ;base64String := inputBox.Value
    ;decodedString := StrFromBase64(base64String)
    ;outputBox.Value := decodedString
;}

; Function to decode Base64 string
;StrFromBase64(base64) {
 ;   return StrGet(Clipboard := Buffer(base64, "base64"))
;}