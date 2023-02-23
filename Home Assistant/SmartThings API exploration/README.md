# TODO: Title
TODO: description

API Reference: https://developer.smartthings.com/docs/getting-started/welcome

# Nodes
$result.components: (your available nodes may be different depending on the model of refridgerator)

## `icemaker.switch.switch.value`
Icemaker enabled state?

## `cvroom.'custom.fridgeMode'.fridgeMode.value`
FlexZone (Middle Drawer)

String output: `CV_FDR_DELI`

## `cooler`, `freezer`
Seperate nodes with identical output

- contactSenor.contact.value
- temperatureMeasurement.temperature.value
- temperatureMeasurement.temperature.unit
- 'custom.thermostatSetpointControl'
    - minimumSetpoint.value
    - minimumSetpoint.unit
    - maximumSetpoint.value
    - maximumSetpoint.unit
- thermostatCoolingSetpoint.coolingSetpoint.value
- thermostatCoolingSetpoint.coolingSetpoint.unit

## `main`
- contactSenor.contact.value
- demandResponseLoadControl.drlcStatus.value
    - drlcType
    - drlcLevel
    - duration
    - override
- temperatureMeasurement.temperature.value
- temperatureMeasurement.temperature.unit
- thermostatCoolingSetpoint.coolingSetpoint.value
- thermostatCoolingSetpoint.coolingSetpoint.unit
- 'custom.deviceReportStateConfiguration'
    - reportStatePeriod.value
    - reportStateRealtime.value.state
- execute.data
    - value.payload
        - rt
        - if
        - 'x.com.samsung.rm.micomdata'
        - 'x.com.samsung.rm.micomdataLength'
    - data.href
- 'custom.waterFilter'
    - waterFilterCapacity.value
    - waterFilterLastResetDate.value
    - waterFilterUsageStep.value
    - waterFilterUsage.value
    - waterFilterStatus.value
    - waterFilterResetType.value
- powerConsumptionReport.powerConsumption.value
- refrigeration
    - defrost.value
    - rapidCooling.value
    - rapidFreezing.value
- 'custom.energyType'
    - energyType.value
    - drMaxDuration.value
    - drMaxDuration.unit
- 'samsungce.deviceIdentification'.binaryId.value
- 'samsungce.dongleSoftwareInstallation'.status.value
- 'samsungce.driverVersion'.versionNumber.value
- 'samsungce.powerCool'.activated.value
- 'samsungce.powerFreeze'.activated.value
- 'samsungce.softwareUpdate'
    - targetModule.value
    - lastUpdateDate.value
    - operatingState.value
    - progress.value
    - otnDUID.value
    - newVersionAvailable.value
    - availableModules.value
- ocf
    - st.value
    - mndt.value
    - mnfv.value
    - mnhw.value
    - di.value
    - mnsl.value
    - dmv.value
    - n.value
    - mnmo.value
    - vid.value
    - mnmn.value
    - mnml.value
    - mnpv.value
    - mnos.value
    - pi.value
    - icv.value