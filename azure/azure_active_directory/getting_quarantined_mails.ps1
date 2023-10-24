Set-ExecutionPolicy RemoteSigned
Import-Module ExchangeOnlineManagement
#Import-Module ExchangePowerShell
Import-Module Microsoft.Graph

Connect-ExchangeOnline -UserPrincipalName tyll@wx8w4.onmicrosoft.com
Disconnect-Graph
Connect-MgGraph -Scopes “ChannelMessage.Send, Group.ReadWrite.All”
Import-Module Microsoft.Graph.Users.Actions


#für geringst-notwendige Berechtigungen - Microsoft Graph App
#Tutorial:
#https://gadgetrevo.com/send-email-using-microsoft-graph-api-and-powershell/

##### FOLGENDER CODE DIENT NUR DER EINRICHTUNG UND MUSS NICHT WIEDERHOLT LAUFEN! ######

#Mail.Send - wäre für Mail genug, allerdings käuft das in dev tenants in Probleme...
#Team.ReadBasic.All, TeamSettings.Read.All, TeamSettings.ReadWrite.All
#Channel.ReadBasic.All,ChannelSettings.Read.All,ChannelSettings.ReadWrite.All
#Teamwork.Migrate.All

# Zertifikat generieren - self-signed
$certSplat = @{
	Subject = 'PSGraphMailApp'
	NotBefore = ((Get-Date).AddDays(-1))
	NotAfter = ((Get-Date).AddYears(5))
	CertStoreLocation = "Cert:\CurrentUser\My"
	Provider = "Microsoft Enhanced RSA and AES Cryptographic Provider"
	HashAlgorithm = "SHA256"
	}
$selfSignedCertificate = New-SelfSignedCertificate @certSplat

# Details anzeigen
$selfSignedCertificate | Format-List PSParentPath, ThumbPrint, Subject, NotAfter

# Create the directory to save the certificate
mkdir C:\cert -Force
# Export the public certificate (no private key)
Export-Certificate -Cert $selfSignedCertificate -FilePath 'C:\Cert\PSGraphMailApp.cer'

##### Vorheriger CODE DIENT NUR DER EINRICHTUNG UND MUSS NICHT WIEDERHOLT LAUFEN! ######





# get certificate
$selfSignedCertificate = Get-ChildItem -Path 'Cert:\CurrentUser\My' | Where-Object {$_.Subject -Match "PSGraphMailApp"}

#Applikations ID
$app_id = '4823dd12-7b6d-416c-8865-e57b741215c1'

#Verzeichnis ID
$tenant_id = '436d1067-e059-4fd7-b993-1e1d324b9a51'

#Thumbprint ID
$thumbprint_id = $selfSignedCertificate | Select-Object ThumbPrint -ExpandProperty Thumbprint


Connect-MgGraph `
-ClientId $app_id `
-TenantId $tenant_id `
-CertificateThumbprint $thumbprint_id



#definiere wie weit zurückliegend in der Quarantäne Liste gecheckt wird
#dieser Rückblick sollte bei einer wiederkehrenden Analyse dem Skript-Ausführungsintervall entprechen
$filterDate = (Get-Date).AddMinutes(-30000)

$new_quarantine_messages = Get-QuarantineMessage | Where-Object {$_.ReceivedTime -ge $filterDate}
$new_quarantine_messages

#die Zahl neuer Mails, die in die Quarantäne gesendet wurden
$n_new_quarantine_messages  = $new_quarantine_messages | Measure-Object | Select-Object -ExpandProperty Count
$n_new_quarantine_messages

#Email an Administrator Konto mit der Zahl neuer Mails in Quarantäne; variable muss noch eingepflegt werden ...
$params = @{
	Message = @{
		Subject = "Quarantine Mails Update"
		Body = @{
			ContentType = "Text"
			Content = "TestTest"
		}
		ToRecipients = @(
			@{
				EmailAddress = @{
					Address = "hammermc@wx8w4.onmicrosoft.com"
				}
			}
		)
	}
	SaveToSentItems = "false"
}
# A UPN can also be used as -UserId.
Send-MgUserMail -UserId 'tyll.stoecker@outlook.de' -BodyParameter $params

#sollte klappen - mit trial license kriegt man allerdings ein delivery problem und error message
#https://learn.microsoft.com/en-us/exchange/troubleshoot/email-delivery/ndr/fix-error-code-5-7-700-through-5-7-750#57708-access-denied-traffic-not-accepted-from-this-ip




Import-Module Microsoft.Graph.Teams

$params = @{
	ChatType = "Group"
	Members = @(
		@{
			"@odata.type" = "#microsoft.graph.aadUserConversationMember"
			Roles = @(
				"owner"
			)
			"User@odata.bind" = "https://graph.microsoft.com/v1.0/users('xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx')"
		}
		@{
			"@odata.type" = "#microsoft.graph.aadUserConversationMember"
			Roles = @(
				"owner"
			)
			"User@odata.bind" = "https://graph.microsoft.com/v1.0/users('yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyy')"
		}
	)
}

$myChatSession=New-MgChat -BodyParameter $params



$params = @{
	body = @{
		content = "Hello World2"
	}
}

New-MgTeamChannelMessage -ChannelId $channel_id -TeamId $team_Id -BodyParameter $params


$team_Id = Get-MgTeam | Where-Object {$_.DisplayName -Match "Admin Alerts"} | Select-Object Id -ExpandProperty Id 

$channel_Id =  Get-MgTeamChannel -TeamId $admin_alerts_team_id | `
  Where-Object {$_.DisplayName -Match "Quarantine Mail Alert"} | `
  Select-Object Id -ExpandProperty Id


$a = $team_Id
$b = $channel_Id

.\LogGenerator.ps1 `
  -Log "sample_access.log" `
  -Type "API" `
  -Table "mail_quarantine_CL" `
  -DcrImmutableId "dcr-9cf30edaf14f4c3f85a2c47d82d27ffd" `
  -DceUri "https://mail-quarantine-collection-endpoint-szlr.germanywestcentral-1.ingest.monitor.azure.com"

##############################
##############################



# Create certificate
$mycert = New-SelfSignedCertificate -DnsName "quarantine_mail_fun.io" -CertStoreLocation "cert:\CurrentUser\My" -NotAfter (Get-Date).AddYears(1) -KeySpec KeyExchange

# Export certificate to .pfx file
$mycert | Export-PfxCertificate -FilePath mycert.pfx -Password $(ConvertTo-SecureString -String "P@ssw0rd1234" -AsPlainText -Force)

# Export certificate to .cer file
$mycert | Export-Certificate -FilePath mycert.cer


#notes
#hinzufügen der module packagemanagement und (danach) powershellget notwendig!



$mycert = New-SelfSignedCertificate -DnsName "alert_mail.io" -CertStoreLocation "cert:\CurrentUser\My" -NotAfter (Get-Date).AddYears(1) -KeySpec KeyExchange

# Exportieren als .pfx Datei
$mycert | Export-PfxCertificate -FilePath mycert.pfx -Password $(ConvertTo-SecureString -String "JDNP@ssw0rd" -AsPlainText -Force)

# Exportieren als .cer Datei
$mycert | Export-Certificate -FilePath mycert.cer 