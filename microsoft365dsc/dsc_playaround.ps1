#desired state config and AAD user handling playaround

##install modules
Install-Module ExchangeOnlineManagement
Install-Module Microsoft365DSC
Install-Module AzureAD

##updates and load
#Update-Module ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement

#Update-Module Microsoft365DSC
Import-Module Microsoft365DSC
Update-M365DSCDependencies

#Update-Module AzureAD
Import-Module AzureAD

##might need to set execution policies, e.g.
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

##
Connect-ExchangeOnline

##list all Graph, SharePoint or Exchange permissions required for the specified resources, both for reading/updating and Delegated/Applications
Get-M365DSCCompiledPermissionList -ResourceNameList @('AADConditionalAccessPolicy') -PermissionType Delegated -AccessType Read

##Reverse function that extracts the DSC configuration from an existing Microsoft 365 Tenant.
Export-M365DSCConfiguration -Path C:\Users\StoeckerTy\Desktop\powershell_test_scripts -components 'AADConditionalAccessPolicy'
