$Tokens = (Get-Content '_Tokens.json' |ConvertFrom-Json)

$Result = Invoke-RestMethod -Headers @{'Authorization' = "Bearer $($Tokens.PA_TOKEN)"} -Uri "https://api.smartthings.com/v1/devices/$($Tokens.DEVICE_ID)/status"

$Result.components |Format-List