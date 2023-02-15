Install-Module BurntToast -Scope CurrentUser

Write-Host "Listening for use of Responder..."

while ($true) {
    $LLMNR = (Resolve-DnsName -LlmnrOnly abc123 2> $Null)

    if ($LLMNR) {
        $ip = $LLMNR.IpAddress -Join ", "
        $msg = "Hostname: ${env:computername} `nRogue LLMNR Server: $ip"
        New-BurntToastNotification -Text $msg
        Write-Host " `n$msg"
    }

    Start-Sleep -Seconds 30
}
