# Scan interval to detect Responder in seconds
$SCAN_INTERVAL = 30

# Bogous LLMNR request
$REQUEST = "honeytask"

################################################################################

Install-Module BurntToast -Scope CurrentUser

Write-Host "Listening for use of Responder..."

# If Responder is detected
while ($true) {
    $LLMNR = (Resolve-DnsName -LlmnrOnly $REQUEST 2> $Null)

    if ($LLMNR) {
        $ip = $LLMNR.IpAddress -Join ", "
        $msg = "Hostname: ${env:computername} `nRogue LLMNR Server: $ip"
        New-BurntToastNotification -Text $msg
        Write-Host " `n$msg"
    }

    Start-Sleep -Seconds $SCAN_INTERVAL
}
