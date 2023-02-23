$Tokens = (Get-Content '_Tokens.json' |ConvertFrom-Json)
$Result = Invoke-RestMethod -Headers @{'Authorization' = "Bearer $($Tokens.PA_TOKEN)"} -Uri "https://api.smartthings.com/v1/devices/$($Tokens.DEVICE_ID)/status"
$Data = [PSCustomObject]@{
    'Cooler'                    = [PSCustomObject]@{
        'Door'        = $Result.components.cooler.contactSensor.contact.value
        'Setpoint'    = $Result.components.cooler.thermostatCoolingSetpoint.coolingSetpoint.value
        'SetpointMax' = $Result.components.cooler.'custom.thermostatSetpointControl'.maximumSetpoint.value
        'SetpointMin' = $Result.components.cooler.'custom.thermostatSetpointControl'.minimumSetpoint.value
        'Temperature' = $Result.components.cooler.temperatureMeasurement.temperature.value
    }
    'DemandResponseLoadControl' = [PSCustomObject]@{
        'Duration' = $Result.components.main.demandResponseLoadControl.drlcStatus.value.duration
        'Level'    = $Result.components.main.demandResponseLoadControl.drlcStatus.value.drlcLevel
        'Override' = $Result.components.main.demandResponseLoadControl.drlcStatus.value.override
        'Type'     = $Result.components.main.demandResponseLoadControl.drlcStatus.value.drlcType
    }
    'ExecutePayload'            = [PSCustomObject]@{
        'DataHRef'        = $Result.components.main.execute.data.data.href
        'IF'              = $Result.components.main.execute.data.value.payload.if[0]
        'MicomData'       = $Result.components.main.execute.data.value.payload.'x.com.samsung.rm.micomdata'
        'MicomDataLength' = $Result.components.main.execute.data.value.payload.'x.com.samsung.rm.micomdataLength'
        'RT'              = $Result.components.main.execute.data.value.payload.rt[0]
    }
    'FlexZoneMode'              = $Result.components.cvroom.'custom.fridgeMode'.fridgeMode.value
    'Freezer'                   = [PSCustomObject]@{
        'Door'        = $Result.components.freezer.contactSensor.contact.value
        'Setpoint'    = $Result.components.freezer.thermostatCoolingSetpoint.coolingSetpoint.value
        'SetpointMax' = $Result.components.freezer.'custom.thermostatSetpointControl'.maximumSetpoint.value
        'SetpointMin' = $Result.components.freezer.'custom.thermostatSetpointControl'.minimumSetpoint.value
        'Temperature' = $Result.components.freezer.temperatureMeasurement.temperature.value
    }
    'Icemaker'                  = $Result.components.icemaker.switch.switch.value
    'Main'                      = [PSCustomObject]@{
        'Defrost'                   = $Result.components.main.refrigeration.defrost.value
        'DeviceBinaryID'            = $Result.components.main.'samsungce.deviceIdentification'.binaryId.value
        'Door'                      = $Result.components.main.contactSensor.contact.value
        'DriverVersion'             = $Result.components.main.'samsungce.driverVersion'.versionNumber.value
        'DRMaxDuration'             = $Result.components.main.'custom.energyType'.drMaxDuration.value
        'DRMaxDurationUnit'         = $Result.components.main.'custom.energyType'.drMaxDuration.unit
        'EnergyType'                = $Result.components.main.'custom.energyType'.energyType.value
        'PowerCool'                 = $Result.components.main.'samsungce.powerCool'.activated.value ?? $Result.components.main.refrigeration.rapidCooling.value
        'PowerFreeze'               = $Result.components.main.'samsungce.powerFreeze'.activated.value ?? $Result.components.main.refrigeration.rapidFreezing.value
        'PowerReport'               = $Result.components.main.powerConsumptionReport.powerConsumption.value
        'Setpoint'                  = $Result.components.main.thermostatCoolingSetpoint.coolingSetpoint.value
        'SWInstallStatus'           = $Result.components.main.'samsungce.dongleSoftwareInstallation'.status.value
        'Temperature'               = $Result.components.main.temperatureMeasurement.temperature.value
    }
    'OCF'                       = [PSCustomObject]@{
        'DI'   = $Result.components.main.ocf.di.value
        'DMV'  = $Result.components.main.ocf.dmv.value
        'ICV'  = $Result.components.main.ocf.icv.value
        'MNDT' = $Result.components.main.ocf.mndt.value
        'MNFV' = $Result.components.main.ocf.mnfv.value
        'MNHW' = $Result.components.main.ocf.mnhw.value
        'MNML' = $Result.components.main.ocf.mnml.value
        'MNMN' = $Result.components.main.ocf.mnmn.value
        'MNMO' = $Result.components.main.ocf.mnmo.value
        'MNOS' = $Result.components.main.ocf.mnos.value
        'MNPV' = $Result.components.main.ocf.mnpv.value
        'MNSL' = $Result.components.main.ocf.mnsl.value
        'N'    = $Result.components.main.ocf.n.value
        'PI'   = $Result.components.main.ocf.pi.value
        'ST'   = $Result.components.main.ocf.st.value
        'VID'  = $Result.components.main.ocf.vid.value
    }
    'ReportStateConfig'         = [PSCustomObject]@{
        'Period'   = $Result.components.main.'custom.deviceReportStateConfiguration'.reportStatePeriod.value
        'Realtime' = $Result.components.main.'custom.deviceReportStateConfiguration'.reportStateRealtime.value
    }
    'SoftwareUpdates'           = [PSCustomObject]@{
        'AvailableModules'    = $Result.components.main.'samsungce.softwareUpdate'.availableModules.value -join ', '
        'LastUpdateDate'      = $Result.components.main.'samsungce.softwareUpdate'.lastUpdateDate.value
        'NewVersionAvailable' = $Result.components.main.'samsungce.softwareUpdate'.newVersionAvailable.value
        'OperatingState'      = $Result.components.main.'samsungce.softwareUpdate'.operatingState.value
        'OTNDUID'             = $Result.components.main.'samsungce.softwareUpdate'.otnDUID.value
        'Progress'            = $Result.components.main.'samsungce.softwareUpdate'.progress.value
        'TargetModule'        = $Result.components.main.'samsungce.softwareUpdate'.targetModule.value
    }
    'WaterFilter'               = [PSCustomObject]@{
        'Capacity'      = $Result.components.main.'custom.waterFilter'.waterFilterCapacity.value
        'LastResetDate' = $Result.components.main.'custom.waterFilter'.waterFilterLastResetDate.value
        'ResetType'     = $Result.components.main.'custom.waterFilter'.waterFilterResetType.value[0]
        'Status'        = $Result.components.main.'custom.waterFilter'.waterFilterStatus.value
        'Usage'         = $Result.components.main.'custom.waterFilter'.waterFilterUsage.value
        'UsageStep'     = $Result.components.main.'custom.waterFilter'.waterFilterUsageStep.value
    }
}

$Data |ConvertTo-Json