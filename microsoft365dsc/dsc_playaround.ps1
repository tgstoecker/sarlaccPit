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
Update-M365DSCModule
Update-M365DSCDependencies
Uninstall-M365DSCOutdatedDependencies

#Update-Module AzureAD
Import-Module AzureAD

##might need to set execution policies, e.g.
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

##
#Connect-ExchangeOnline

##list all Graph, SharePoint or Exchange permissions required for the specified resources, both for reading/updating and Delegated/Applications
Get-M365DSCCompiledPermissionList -ResourceNameList @('AADConditionalAccessPolicy') -PermissionType Delegated -AccessType Read

#connect to Graph with all permissions
Connect-MgGraph -Scopes "Agreement.Read.All Group.Read.All Policy.Read.All RoleManagement.Read.Directory User.Read.All"
# Application.ReadWrite.All DelegatedPermissionGrant.ReadWrite.All

$Credential = Get-Credential

##Reverse function that extracts the DSC configuration from an existing Microsoft 365 Tenant.
Export-M365DSCConfiguration `
-Path C:\Users\StoeckerTy\Documents\github_dev\sarlaccPit\microsoft365dsc `
-components 'AADConditionalAccessPolicy' `
-Credential $Credential



Connect-SPOService
Import-Module PnP.PowerShell
Connect-PnPOnline -Url "https://wx8w4-admin.sharepoint.com/" -Interactive 

Connect-MgGraph -Scopes "Application.Read.All Domain.Read.All"


###
#wenn komplett dann fehler weil 2 Faktor Authentifizierung
#auskommentieren läuft surch und erzeugt mof datei ...

Configuration CredentialsExample
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [PSCredential] $Credential
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        SPOSite 'SiteWithCredentials'
        {
            Url        = "https://wx8w4.sharepoint.com/sites/credentialssite"
            Owner      = "tyll@wx8w4.onmicrosoft.com"
            Title      = "TestSite"
            Template   = "STS#3"
            TimeZoneId = 13
            Ensure     = "Present"
            Credential = $Credential
        }
    }
}

$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowPlainTextPassword = $true
        }
    )
}

CredentialsExample -ConfigurationData $cd

Start-DSCConfiguration -Path C:\Users\StoeckerTy\Documents\github_dev\sarlaccPit\CredentialsExample -Wait -Verbose -Force


####

#if you are an admin and want to give permission to users for using e.g. Graph you can this via permission grants
#via powershell one can create these objects based on which allowed user permissions for a client application can be set

#-ApplicationId '0fc7a67b-797c-4144-925a-6597cb20d1c4' `
#-TenantId 'wx8w4.onmicrosoft.com' `

Connect-AzAccount
Get-AzADServicePrincipal

#search for either 
#Microsoft Graph
#or
#AppId=00000003-0000-0000-c000-000000000000

$params = @{

    "ClientId" = "0fc7a67b-797c-4144-925a-6597cb20d1c4"
    "ConsentType" = "AllPrincipals"
    "ResourceId" = "2728ba4f-a775-4219-9f25-6d952a82ef43"
    "Scope" = "Agreement.Read.All Group.Read.All Policy.Read.All RoleManagement.Read.Directory User.Read.All Application.ReadWrite.All DelegatedPermissionGrant.ReadWrite.All"
    "startTime"   = "2019-10-19T10:37:00Z"
    "expiryTime"  = "2024-10-19T10:37:00Z"
  }

Connect-MgGraph

#create new
New-MgOauth2PermissionGrant -BodyParameter $params | 
    Format-List Id, ClientId, ConsentType, ResourceId, Scope

#Getting existing
Get-MgOauth2PermissionGrant
Get-MgOauth2PermissionGrant | Select-Object Id,Scope

#updating e.g. scope
Update-MgOauth2PermissionGrant -OAuth2PermissionGrantId e6bHD3x5REGSWmWXyyDRxE-6KCd1pxlCnyVtlSqC70M `
  -Scope "Agreement.Read.All Group.Read.All Policy.Read.All RoleManagement.Read.Directory User.Read.All"