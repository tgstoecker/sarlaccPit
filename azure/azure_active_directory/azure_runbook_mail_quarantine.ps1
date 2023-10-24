#whole tutorial here:
#https://www.shudnow.io/2022/07/22/azure-automation-runbooks-and-connecting-to-exchange-online/


# Updates der ExchangeOnlineManagement Moduls machen das Laden dieser Module ebenfalls notwendig
# müssen vorab manuell als Module beim AutomationAccount hinzugefügt werden
Import-Module PackageManagement
Import-Module PowerShellGet

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity).context

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext


# Import the ExchangeOnlineManagement Module we imported into the Automation Account
Import-Module ExchangeOnlineManagement


# Obtain a copy of the certificate
$ExchangeOnlineCertThumbPrint = (Get-AzAutomationCertificate -ResourceGroupName "quarantine_fun" -AutomationAccountName "ExOnlineMailAutomation" -Name "ExchangeOnlineCert").Thumbprint

# Connect to Exchange Online using the Certificate Thumbprint of the Certificate imported into the Automation Account
Connect-ExchangeOnline -CertificateThumbPrint $ExchangeOnlineCertThumbPrint -AppID "31d2fc60-eeab-4981-90df-1fc182e20b1b" -Organization "wx8w4.onmicrosoft.com"

#anscheinend gab es in der Vergangenheit Probleme mit dem Thumbprint - backup code
#$ExchangeOnlineCert = (Get-AzAutomationCertificate -ResourceGroupName "quarantine_fun" -AutomationAccountName "ExOnlineMailAutomation" -Name "ExchangeOnlineCert")
#Connect-ExchangeOnline -Certificate $ExchangeOnlineCert -AppID "31d2fc60-eeab-4981-90df-1fc182e20b1b" -Organization "wx8w4.onmicrosoft.com"


#definiere wie weit zurückliegend in der Quarantäne Liste gecheckt wird
#dieser Rückblick sollte bei einer wiederkehrenden Analyse dem Skript-Ausführungsintervall entprechen
#definition des Zeitintervalls
$timeintervall = 12
$filterDate = (Get-Date).AddHours(-$timeintervall)

$new_quarantine_messages = Get-QuarantineMessage | Where-Object {$_.ReceivedTime -ge $filterDate}

#die Zahl neuer Mails, die in die Quarantäne gesendet wurden
$n_new_quarantine_messages  = $new_quarantine_messages | Measure-Object | Select-Object -ExpandProperty Count

# Output the Results for the Mailbox

Write-Output $n_new_quarantine_messages