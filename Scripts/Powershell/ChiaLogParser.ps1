# Setup
# $regexDT = '[adeFhiMnorSTtuW]{3} [AabcDeFgJlMNnOoprStuvy]{3} \d{2} [\d:]{8} \d{4}'
# $strDTParse = 'ddd MMM dd HH:mm:ss yyyy'

$strLogFolder = '\\Vault\Storage\Logs'

# Set up the output array
$arrData = @()

Get-ChildItem -Path $strLogFolder -Filter *.log |ForEach-Object{
    # Read logfile contents
    $Content = Get-Content -Path $_.FullName

    # Check for a complete logfile
    If (($Content |Select-String -Pattern '^Copy time') -eq $Null) {
        Write-Host "Skipping $($_.FullName)"
    } Else {
        # Add to output array
        $arrData += New-Object PSObject -Property @{
            # Process Info
            'Host'       = [String]($_.BaseName -split '_')[0]
            'ID'         = [String]($Content |Select-String -Pattern '^ID: ([a-f0-9]+)$').Matches[0].Groups[1].Value
            'PlotSize'   = [Int]   ($Content |Select-String -Pattern '^Plot size is: (\d+)$').Matches[0].Groups[1].Value
            'BufferSize' = [Int]   ($Content |Select-String -Pattern '^Buffer size is: (\d+)[KMG]iB$').Matches[0].Groups[1].Value
            'Buckets'    = [Int]   ($Content |Select-String -Pattern '^Using (\d+) buckets$').Matches[0].Groups[1].Value
            'Threads'    = [Int]   ($Content |Select-String -Pattern '^Using (\d+) threads.*$').Matches[0].Groups[1].Value
            'PID'        = [Int]   ($Content |Select-String -Pattern '^Process ID is: (\d+)$').Matches[0].Groups[1].Value

            # Total Seconds
            'P1Time'         = [Int]($Content |Select-String -Pattern '^Time for phase 1 = (\d+).*$').Matches[0].Groups[1].Value
            'P2Time'         = [Int]($Content |Select-String -Pattern '^Time for phase 2 = (\d+).*$').Matches[0].Groups[1].Value
            'P3Time'         = [Int]($Content |Select-String -Pattern '^Time for phase 3 = (\d+).*$').Matches[0].Groups[1].Value
            'P4Time'         = [Int]($Content |Select-String -Pattern '^Time for phase 4 = (\d+).*$').Matches[0].Groups[1].Value
            'TotalPhaseTime' = [Int]($Content |Select-String -Pattern '^Total time = (\d+).*$').Matches[0].Groups[1].Value
            'CopyTime'       = [Int]($Content |Select-String -Pattern '^Copy time = (\d+).*$').Matches[0].Groups[1].Value
<# Don't need these
            # Explicit DTs
            'P1Start'   = [DateTime]::ParseExact(($Content |Select-String -Pattern "^Starting phase 1\/\d:.* ($($regexDT))$").Matches[0].Groups[1].Value, $strDTParse, $Null)
            'P1End'     = [DateTime]::ParseExact(($Content |Select-String -Pattern "^Time for phase 1.* ($($regexDT))$").Matches[0].Groups[1].Value, $strDTParse, $Null)
            'P2Start'   = [DateTime]::ParseExact(($Content |Select-String -Pattern "^Starting phase 2\/\d:.* ($($regexDT))$").Matches[0].Groups[1].Value, $strDTParse, $Null)
            'P2End'     = [DateTime]::ParseExact(($Content |Select-String -Pattern "^Time for phase 2.* ($($regexDT))$").Matches[0].Groups[1].Value, $strDTParse, $Null)
            'P3Start'   = [DateTime]::ParseExact(($Content |Select-String -Pattern "^Starting phase 3\/\d:.* ($($regexDT))$").Matches[0].Groups[1].Value, $strDTParse, $Null)
            'P3End'     = [DateTime]::ParseExact(($Content |Select-String -Pattern "^Time for phase 3.* ($($regexDT))$").Matches[0].Groups[1].Value, $strDTParse, $Null)
            'P4Start'   = [DateTime]::ParseExact(($Content |Select-String -Pattern "^Starting phase 4\/\d:.* ($($regexDT))$").Matches[0].Groups[1].Value, $strDTParse, $Null)
            'P4End'     = [DateTime]::ParseExact(($Content |Select-String -Pattern "^Time for phase 4.* ($($regexDT))$").Matches[0].Groups[1].Value, $strDTParse, $Null)
            'CopyStart' = [DateTime]::ParseExact(($Content |Select-String -Pattern "^Total time.* ($($regexDT))$").Matches[0].Groups[1].Value, $strDTParse, $Null)
            'CopyEnd'   = [DateTime]::ParseExact(($Content |Select-String -Pattern "^Copy time.* ($($regexDT))$").Matches[0].Groups[1].Value, $strDTParse, $Null)
#>
        }
    }
}

# Output
$arrData |Select-Object Host,BufferSize,Threads,P1Time,P2Time,P3Time,P4Time,TotalPhaseTime,CopyTime |Out-GridView