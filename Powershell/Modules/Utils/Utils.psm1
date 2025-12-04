function Read-MultiLineInput {
  $inputLines = @()
  $endMarker = ""
  Write-Host "Enter multiple lines of input (type 'Ctrl+D and then Enter' on a new line to finish):"

  while ($true) {
    $line = Read-Host
    if ($line -eq $endMarker) {
      break
    }
    $inputLines += $line
  }

  return $inputLines -join "`n"
}

Function uuidv4 {
  (New-Guid).Guid.ToUpper() | Set-Clipboard
  Write-Output "New uuidv4 (upper-case) copied to clipboard"
}

Export-ModuleMember -Function Read-MultiLineInput, uuidv4