# Generated with Microsoft365DSC version 1.23.517.1
# For additional information on how to use Microsoft365DSC, please visit https://aka.ms/M365DSC
param (
    [parameter()]
    [System.Management.Automation.PSCredential]
    $Credential
)

Configuration M365TenantConfig
{
    param (
        [parameter()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    if ($null -eq $Credential)
    {
        <# Credentials #>
        $Credscredential = Get-Credential -Message "Credentials"

    }
    else
    {
        $CredsCredential = $Credential
    }

    $OrganizationName = $CredsCredential.UserName.Split('@')[1]

    Import-DscResource -ModuleName 'Microsoft365DSC' -ModuleVersion '1.23.517.1'

    Node localhost
    {
        AADConditionalAccessPolicy "AADConditionalAccessPolicy-Block legacy authentication"
        {
            ApplicationEnforcedRestrictionsIsEnabled = $False;
            BuiltInControls                          = @("block");
            ClientAppTypes                           = @("exchangeActiveSync","other");
            CloudAppSecurityIsEnabled                = $False;
            CloudAppSecurityType                     = "";
            Credential                               = $Credscredential;
            CustomAuthenticationFactors              = @();
            DeviceFilterRule                         = "";
            DisplayName                              = "Block legacy authentication";
            Ensure                                   = "Present";
            ExcludeApplications                      = @();
            ExcludeExternalTenantsMembers            = @();
            ExcludeExternalTenantsMembershipKind     = "";
            ExcludeGroups                            = @();
            ExcludeLocations                         = @();
            ExcludePlatforms                         = @();
            ExcludeRoles                             = @();
            ExcludeUsers                             = @("tyll@$OrganizationName");
            GrantControlOperator                     = "OR";
            Id                                       = "d2c09fb7-6b0f-4739-b9de-0be394313dd6";
            IncludeApplications                      = @("All");
            IncludeExternalTenantsMembers            = @();
            IncludeExternalTenantsMembershipKind     = "";
            IncludeGroups                            = @();
            IncludeLocations                         = @();
            IncludePlatforms                         = @();
            IncludeRoles                             = @();
            IncludeUserActions                       = @();
            IncludeUsers                             = @("All");
            PersistentBrowserIsEnabled               = $False;
            PersistentBrowserMode                    = "";
            SignInFrequencyIsEnabled                 = $False;
            SignInFrequencyType                      = "";
            SignInRiskLevels                         = @();
            State                                    = "disabled";
            UserRiskLevels                           = @();
        }
    }
}

M365TenantConfig -ConfigurationData .\ConfigurationData.psd1 -Credential $Credential
