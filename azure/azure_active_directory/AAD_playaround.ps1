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


##connecting to AzureAD
Connect-AzureAD


##display all user accounts
Get-AzureADUser

##get all info from a particular user
Get-AzureADUser -ObjectID AdeleV@wx8w4.onmicrosoft.com | Select *

##find all users with either on-prem AD or cloud native AAD
Get-AzureADUser | Where {$_.DirSyncEnabled -eq $true}
Get-AzureADUser | Where {$_.DirSyncEnabled -ne $true}


#Break glass account (incl. new user tutorial)
#Link: https://learn.microsoft.com/en-us/powershell/azure/active-directory/new-user-sample?view=azureadps-2.0

##Create password file with appropriate type 
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

##set pw
$PasswordProfile.Password = "password"

###create new user
New-AzureADUser -AccountEnabled $True -DisplayName "MC Hammer" -PasswordProfile $PasswordProfile -MailNickName "MCHammer" -UserPrincipalName "HammerMC@wx8w4.onmicrosoft.com"

##for easy working assign user to variable
$user = Get-AzureADUser -Filter "userPrincipalName eq 'HammerMC@wx8w4.onmicrosoft.com'"

##object based language, so proper way is to get role and then assign it
$roleDefinition = Get-AzureADMSRoleDefinition -Filter "displayName eq 'Global Administrator'"
$roleAssignment = New-AzureADMSRoleAssignment -DirectoryScopeId '/' -RoleDefinitionId $roleDefinition.Id -PrincipalId $user.objectId

#checking group membership
Get-AzureADUserMembership -ObjectId HammerMC@wx8w4.onmicrosoft.com

#set user account properties e.g. UsageLocation
#Link: https://learn.microsoft.com/en-us/microsoft-365/enterprise/configure-user-account-properties-with-microsoft-365-powershell?view=o365-worldwide
Get-AzureADUser -ObjectID HammerMC@wx8w4.onmicrosoft.com | Set-AzureADUser -UsageLocation US

#get all groups
Get-AzureADGroup

#adding user to a group - let's try using variables again since "Add-AzureADGroupMember" uses the cryptic ObjectIds

#get ObjectId using the Get-AzureADUse
$c_user_id = Get-AzureADUser -ObjectID HammerMC@wx8w4.onmicrosoft.com | Select ObjectID | Select-Object -ExpandProperty ObjectID -First 1
 
#get ObjectId by specifying a searchstring (can be fuzzy match) - ATTENTION: multiple groups could have same DisplayName
$loop_group_id = Get-AzureADGroup -SearchString 'Loop_Test' | Select-Object -ExpandProperty ObjectID -First 1
  
#Use Add-AzureADGroupMember with the ObjectId as the groups ObjectId and the RegObjectId as the user's ObjectId
Add-AzureADGroupMember -ObjectId $loop_group_id -RefObjectId $c_user_id 

#re-checking group membership
Get-AzureADUserMembership -ObjectId HammerMC@wx8w4.onmicrosoft.com  

##also need access ro licences/tools overall - did this via the web interface 