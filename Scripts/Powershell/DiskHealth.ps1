$arrData = @()

Get-PhysicalDisk |ForEach-Object {
    $GSRC = ($_ |Get-StorageReliabilityCounter)
    $data = @{
        'DevID'               = '{0:d2}' -f [Int]$_.DeviceId
        'StatusOp'            = $_.OperationalStatus
        'StatusHealth'        = $_.HealthStatus
        'Type'                = $_.MediaType
        'Speed'               = $_.SpindleSpeed
        'Make'                = $_.Manufacturer
        'Model'               = $_.Model
        'SerialNum'           = $_.SerialNumber
        'UID'                 = $_.UNiqueId

        'Temp'                = $GSRC.Temperature
        'Hours'               = $GSRC.PowerOnHours
        'Startups'            = $GSRC.StartStopCycleCount
        'LatencyMaxFlush'     = $GSRC.FlushLatencyMax
        'LatencyMaxRead'      = $GSRC.ReadLatencyMax
        'LatencyMaxWrite'     = $GSRC.WriteLatencyMax
        'ErrCorrectedRead'    = $GSRC.ReadErrorsCorrected
        'ErrUncorrectedRead'  = $GSRC.ReadErrorsUncorrected
        'ErrCorrectedWrite'   = $GSRC.WriteErrorsCorrected
        'ErrUncorrectedWrite' = $GSRC.WriteErrorsUncorrected
    }
    
    $arrData += New-Object PSObject -Property $data
}

$arrData |Sort-Object DevID |Format-Table -AutoSize -Property *