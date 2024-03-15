# Scan interval to detect Responder in seconds
$SCAN_INTERVAL = 30

# Bogus randomized LLMNR request (16 chars). Change below for default.
# $REQUEST = "honeytask"
$REQUEST = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 16 | ForEach-Object { [char]$_ })

################################################################################

Install-Module BurntToast -Scope CurrentUser

Clear-Host

Write-Host "    __  __                       __             __  "
Write-Host "   / / / /___  ____  ___  __  __/ /_____ ______/ /__"
Write-Host "  / /_/ / __ \/ __ \/ _ \/ / / / __/ __ `/ ___/ //_/"
Write-Host " / __  / /_/ / / / /  __/ /_/ / /_/ /_/ (__  ) ,<   "
Write-Host "/_/ /_/\____/_/ /_/\___/\__, /\__/\__,_/____/_/|_|  "
Write-Host "                       /____/                       "
write-Host "****************************************************"
Write-Host "Using Bogus Request: $REQUEST"
Write-Host ""
Write-Host "Listening for use of Responder..."

# If Responder is detected
while ($true) {
    $LLMNR = (Resolve-DnsName -LlmnrOnly $REQUEST 2> $Null)

    if ($LLMNR) {
        $ip = $LLMNR.IpAddress -Join ", "
        $msg = "Hostname: ${env:computername} `nRogue LLMNR Server: $ip"
        New-BurntToastNotification -Text $msg
        Write-Host -ForegroundColor DarkRed -BackgroundColor DarkYellow "`n$msg"
    }

    Start-Sleep -Seconds $SCAN_INTERVAL
}
