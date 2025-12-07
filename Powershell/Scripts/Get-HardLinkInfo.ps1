param (
  [string]$FilePath = $PSCommandPath
)

function Get-HardLinkInfo {
  param (
    [string]$Path = $PSCommandPath
  )
    
  $item = Get-Item -LiteralPath $Path -ErrorAction Stop
    
  Write-Host "File: $Path"
  Write-Host "LinkType: $($item.LinkType)"
  
  # Try to use fsutil to get hard links (more reliable)
  try {
    $fsutilOutput = & fsutil hardlink list $Path 2>$null
    $hardLinks = @($fsutilOutput | Where-Object { $_.Trim() -ne '' })
    $hardLinkCount = $hardLinks.Count
  }
  catch {
    # Fallback to HardLinks property
    $hardLinkCount = $item.HardLinks.Count
    $hardLinks = @($item.HardLinks | ForEach-Object { $_.FullName })
  }
  
  Write-Host "Hard link count: $hardLinkCount"
    
  if ($hardLinkCount -gt 1) {
    Write-Host "This file is a hard link or has hard links pointing to it." -ForegroundColor Green
    Write-Host "`nAll hard link paths:"
        
    $otherLinks = @()
    for ($i = 0; $i -lt $hardLinks.Count; $i++) {
      $linkPath = $hardLinks[$i]
      Write-Host "  [$i] $linkPath"
            
      # If this isn't the current path, add it to other links
      if ($linkPath -ne $Path) {
        $otherLinks += $linkPath
      }
    }
        
    Write-Host "`nAdditional hard link paths:"
    if ($otherLinks.Count -gt 0) {
      $otherLinks | ForEach-Object { Write-Host "  - $_" }
      
      if ($otherLinks.Count -ge 1) {
        Write-Host "`nSecond hard link: $($otherLinks[0])" -ForegroundColor Cyan
      }
    }
    else {
      Write-Host "  (None - this is the only hard link)"
    }
        
    return $otherLinks
  }
  else {
    Write-Host "This file is NOT a hard link." -ForegroundColor Yellow
    return @()
  }
}

# Call the function
Get-HardLinkInfo -Path $FilePath
