# Configuration
$serverInstance = "localhost"
$database = "Odyssey"  # Update this with your database name

# Query to read the current value
$selectQuery = @"
SELECT TOP 1 
    CONVERT(nvarchar(4000), CONVERT(varbinary(8000), SD_BinaryValue)) AS BinaryValueAsString
FROM StmData
WHERE SD_Name = 'DATABASE_SCHEMA_VERSION'
"@

try {
  # Read current value
  $result = Invoke-Sqlcmd -ServerInstance $serverInstance -Database $database -Query $selectQuery -ErrorAction Stop
    
  if ($null -eq $result) {
    Write-Error "No rows found in StmData table"
    exit 1
  }
    
  # Parse to integer and decrement
  $currentValue = [int]$result.BinaryValueAsString
  $newValue = $currentValue - 1
    
  Write-Host "Current value: $currentValue"
  Write-Host "New value: $newValue"
    
  # Update query
  $updateQuery = @"
UPDATE StmData 
SET SD_BinaryValue = Convert(image, convert(varbinary(8000), N'$newValue'))
WHERE SD_Name = 'DATABASE_SCHEMA_VERSION'
"@
    
  # Execute update
  Invoke-Sqlcmd -ServerInstance $serverInstance -Database $database -Query $updateQuery -ErrorAction Stop
    
  Write-Host "Successfully updated value to $newValue"
}
catch {
  Write-Error "An error occurred: $_"
  exit 1
}
