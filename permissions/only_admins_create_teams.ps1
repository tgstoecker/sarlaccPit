#how to allow only a specific set of accounts (a special group) to create teams in Teams?

#Via default setting or policy is not (yet) possible to prevent.
#However, since the general possibility already exists in AAD that the creation of security groups and M365 group is restricted, 
#it is assumed that this will also be extended by Microsoft to Teams Teams if necessary.


#currently June 2023 the required cmdlets are available as part of AzureADPreview Module
#Uninstall-Module AzureAD -Force
#Install-Module AzureADPreview
Update-Module AzureADPreview
Import-Module AzureADPreview


#first let's look at the Status Quo
Connect-AzureAD

Get-AzureADDirectorySettingTemplate

#before proceeding we need to create a base set of settings at directory level, which apply to all Microsoft 365 groups in the directory.
#https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-settings-cmdlets
#To add a usage guideline URL, first you need to get the SettingsTemplate object that defines the usage guideline URL value; 
#that is, the Group.Unified template:
$TemplateId = (Get-AzureADDirectorySettingTemplate | where { $_.DisplayName -eq "Group.Unified" }).Id
$Template = Get-AzureADDirectorySettingTemplate | where -Property Id -Value $TemplateId -EQ

#Next, create a new settings object based on that template:
$Setting = $Template.CreateDirectorySetting()

#Then update the settings object with a new value. 
#The two examples below change the usage guideline value and enable sensitivity labels. 
#Set these or any other setting in the template as required
$Setting["UsageGuidelinesUrl"] = "https://guideline.example.com"
$Setting["EnableMIPLabels"] = "True"

#applying the setting:
New-AzureADDirectorySetting -DirectorySetting $Setting

#reading the setting
$Setting.Values


#with this we arble to check the current setup
$settingsObjectID = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).id
(Get-AzureADDirectorySetting -Id $settingsObjectID).Values
(Get-AzureADDirectorySetting).Values

#standard is:
#GroupCreationAllowedGroupId    "null - nothing is displayed here"
#EnableGroupCreation            false


#Restricting users in creating teams means the stopping the ability to create Microsoft365 groups.
#create a security group (+ Owner & Members) in AAD, which controls the right to create groups.
#For example "sg_enable_create_groups" or "S_o365_Teams_Group_Creators".
#then the following PowerShell script can be executed:
$GroupName = "sg_enable_create_groups" 
$AllowGroupCreation = $False 

#Connect-AzureAD 
$settingsObjectID = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).id 

#if not yet existing, create group
if (!(Get-AzureADGroup).DisplayName.contains($GroupName)) 
{
    New-AzureADMSGroup -DisplayName $GroupName `
                       -Description "Only group allowed to create new teams!" `
                       -MailEnabled $false `
                       -SecurityEnabled $true `
                       -MailNickName "team_creators" `
                       -IsAssignableToRole $true
}


#if not happened before the necessary base settings steps outlined above
if(!$settingsObjectID) 
{ 
    $template = Get-AzureADDirectorySettingTemplate | Where-object {$_.displayname -eq "group.unified"} 
    $Setting = $template.CreateDirectorySetting() 
    New-AzureADDirectorySetting -DirectorySetting $Setting 
    $settingsObjectID = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).id 
} 

$Setting = Get-AzureADDirectorySetting -Id $settingsObjectID 
$Setting["EnableGroupCreation"] = $AllowGroupCreation 

if($GroupName) 
{ 
    $Setting["GroupCreationAllowedGroupId"] = (Get-AzureADGroup -SearchString $GroupName).objectid 
} else { 
    $Setting["GroupCreationAllowedGroupId"] = $GroupName 
} 
Set-AzureADDirectorySetting -Id $settingsObjectID -DirectorySetting $Setting 
(Get-AzureADDirectorySetting -Id $settingsObjectID).Values



##some group operations
#getting group ObjectId
$group_object_id = Get-AzureADGroup | where {$_.DisplayName -eq $GroupName} | select -ExpandProperty ObjectId

#getting main admin account ObjectId
$user_account_object_id = Get-AzureADUser | where {$_.UserPrincipalName -eq "tyll@wx8w4.onmicrosoft.com"} | select -ExpandProperty ObjectId

#add user to group
Add-AzureADGroupMember -ObjectId $group_object_id -RefObjectId $user_account_object_id

#checking who are the current group members
Get-AzureADGroupMember -ObjectId $group_object_id


##to change everything back to standard settings we can rerun the script but with two mods
#$GroupName = ""
#$AllowGroupCreation = $true

$Setting["EnableGroupCreation"] = $true 
$GroupName = ""

if($GroupName) 
{ 
    $Setting["GroupCreationAllowedGroupId"] = (Get-AzureADGroup -SearchString $GroupName).objectid 
} else { 
    $Setting["GroupCreationAllowedGroupId"] = $GroupName 
} 
Set-AzureADDirectorySetting -Id $settingsObjectID -DirectorySetting $Setting 
(Get-AzureADDirectorySetting -Id $settingsObjectID).Values
