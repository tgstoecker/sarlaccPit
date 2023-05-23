##adding alert on (breakglass) user login
#Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true

#need connection to security and connection powershell
Import-Module ExchangeOnlineManagement

#might need ippss connection (next step) first to install?
#no #Import-Module ExchangePowerSHell

#might need to reconnect after a while since it disconnects automatically?
Connect-IPPSSession -UserPrincipalName tyll@wx8w4.onmicrosoft.com
##
Connect-ExchangeOnline

#create new protection alert
New-ProtectionAlert -Name hammerfall -AggregationType None -Category Supervision -Threattype Activity `
-NotifyUser tyll.stoecker@outlook.de -Operation {userloggedin} -Filter "Activity.UserId -eq 'HammerMC@wx8w4.onmicrosoft.com'" -Severity High

#change existing
Set-ProtectionAlert -Identity "hammerfall"  -NotifyUser tyll@wx8w4.onmicrosoft.com

#alternative? create new activity alert
New-ActivityAlert -Name hammersmall -Type Custom -Category Supervision `
-NotifyUser tyll.stoecker@outlook.de -Operation {userloggedin} -UserId HammerMC@wx8w4.onmicrosoft.com -Severity Medium
