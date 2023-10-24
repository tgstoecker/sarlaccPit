#language can be set for a user; problem is that some services of M365 just use browser or pc language
#on top of that tenant/org settings sometimes veto choices also
#with the following code you can force a specific language for the admin sites

#Install-Module MSOnline
Import-Module MSOnline

Connect-MsolService
Get-MsolUser -UserPrincipalName tyll@wx8w4.onmicrosoft.com | Set-MsolUser -PreferredLanguage "de-de"
Get-MsolUser -UserPrincipalName tyll@wx8w4.onmicrosoft.com | Set-MsolUser  –UsageLocation DE