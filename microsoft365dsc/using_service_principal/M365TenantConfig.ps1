# Generated with Microsoft365DSC version 1.23.621.1
# For additional information on how to use Microsoft365DSC, please visit https://aka.ms/M365DSC
param (
)

Configuration M365TenantConfig
{
    param (
    )

    $OrganizationName = $ConfigurationData.NonNodeData.OrganizationName

    Import-DscResource -ModuleName 'Microsoft365DSC' -ModuleVersion '1.23.621.1'

    Node localhost
    {
        AADTenantDetails "AADTenantDetails"
        {
            ApplicationId                        = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint                = $ConfigurationData.NonNodeData.CertificateThumbprint;
            IsSingleInstance                     = "Yes";
            MarketingNotificationEmails          = @();
            SecurityComplianceNotificationMails  = @();
            SecurityComplianceNotificationPhones = @();
            TechnicalNotificationMails           = @("tyll.stoecker@outlook.de");
            TenantId                             = $OrganizationName;
        }
        AADUser "AADUser-Adele Vance"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Bellevue";
            Country               = "United States";
            Department            = "Retail";
            DisplayName           = "Adele Vance";
            Ensure                = "Present";
            FirstName             = "Adele";
            LastName              = "Vance";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "18/2111";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "98004";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "WA";
            StreetAddress         = "205 108th Ave. NE, Suite 400";
            TenantId              = $OrganizationName;
            Title                 = "Retail Manager";
            UsageLocation         = "US";
            UserPrincipalName     = "AdeleV@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Alex Wilber"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "San Diego";
            Country               = "United States";
            Department            = "Marketing";
            DisplayName           = "Alex Wilber";
            Ensure                = "Present";
            FirstName             = "Alex";
            LastName              = "Wilber";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "131/1104";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "92121";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "CA";
            StreetAddress         = "9256 Towne Center Dr., Suite 400";
            TenantId              = $OrganizationName;
            Title                 = "Marketing Assistant";
            UsageLocation         = "US";
            UserPrincipalName     = "AlexW@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Diego Siciliani"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Birmingham";
            Country               = "United States";
            Department            = "HR";
            DisplayName           = "Diego Siciliani";
            Ensure                = "Present";
            FirstName             = "Diego";
            LastName              = "Siciliani";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "14/1108";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "35243";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "AL";
            StreetAddress         = "3535 Gradview Parkway Suite 335";
            TenantId              = $OrganizationName;
            Title                 = "HR Manager";
            UsageLocation         = "US";
            UserPrincipalName     = "DiegoS@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Grady Archie"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Bloomington";
            Country               = "United States";
            Department            = "R&D";
            DisplayName           = "Grady Archie";
            Ensure                = "Present";
            FirstName             = "Grady";
            LastName              = "Archie";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "19/2109";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "61704";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "IL";
            StreetAddress         = "2203 E. Empire St., Suite J";
            TenantId              = $OrganizationName;
            Title                 = "Designer";
            UsageLocation         = "US";
            UserPrincipalName     = "GradyA@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-MC Hammer"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            DisplayName           = "MC Hammer";
            Ensure                = "Present";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            Roles                 = @("Global Administrator");
            TenantId              = $OrganizationName;
            UsageLocation         = "US";
            UserPrincipalName     = "HammerMC@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Henrietta Mueller"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Fort Lauderdale";
            Country               = "United States";
            Department            = "R&D";
            DisplayName           = "Henrietta Mueller";
            Ensure                = "Present";
            FirstName             = "Henrietta";
            LastName              = "Mueller";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "18/1106";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "33309";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "FL";
            StreetAddress         = "6750 North Andrews Ave., Suite 400";
            TenantId              = $OrganizationName;
            Title                 = "Developer";
            UsageLocation         = "US";
            UserPrincipalName     = "HenriettaM@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Isaiah Langer"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Tulsa";
            Country               = "United States";
            Department            = "Sales";
            DisplayName           = "Isaiah Langer";
            Ensure                = "Present";
            FirstName             = "Isaiah";
            LastName              = "Langer";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "20/1101";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "74133";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "OK";
            StreetAddress         = "7633 E. 63rd Place, Suite 300";
            TenantId              = $OrganizationName;
            Title                 = "Sales Rep";
            UsageLocation         = "US";
            UserPrincipalName     = "IsaiahL@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Johanna Lorenz"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Louisville";
            Country               = "United States";
            Department            = "Engineering";
            DisplayName           = "Johanna Lorenz";
            Ensure                = "Present";
            FirstName             = "Johanna";
            LastName              = "Lorenz";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "23/2102";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "40223";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "KY";
            StreetAddress         = "9900 Corporate Campus Dr., Suite 3000";
            TenantId              = $OrganizationName;
            Title                 = "Senior Engineer";
            UsageLocation         = "US";
            UserPrincipalName     = "JohannaL@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Joni Sherman"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Charlotte";
            Country               = "United States";
            Department            = "Legal";
            DisplayName           = "Joni Sherman";
            Ensure                = "Present";
            FirstName             = "Joni";
            LastName              = "Sherman";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "20/1109";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "28273";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "NC";
            StreetAddress         = "8055 Microsoft Way";
            TenantId              = $OrganizationName;
            Title                 = "Paralegal";
            UsageLocation         = "US";
            UserPrincipalName     = "JoniS@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Lee Gu"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Overland Park";
            Country               = "United States";
            Department            = "Manufacturing";
            DisplayName           = "Lee Gu";
            Ensure                = "Present";
            FirstName             = "Lee";
            LastName              = "Gu";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "23/3101";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "66210";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "KS";
            StreetAddress         = "10801 Mastin Blvd., Suite 620";
            TenantId              = $OrganizationName;
            Title                 = "Director";
            UsageLocation         = "US";
            UserPrincipalName     = "LeeG@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Lidia Holloway"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Tulsa";
            Country               = "United States";
            Department            = "Engineering";
            DisplayName           = "Lidia Holloway";
            Ensure                = "Present";
            FirstName             = "Lidia";
            LastName              = "Holloway";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "20/2107";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "74133";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "OK";
            StreetAddress         = "7633 E. 63rd Place, Suite 300";
            TenantId              = $OrganizationName;
            Title                 = "Product Manager";
            UsageLocation         = "US";
            UserPrincipalName     = "LidiaH@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Lynne Robbins"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Tulsa";
            Country               = "United States";
            Department            = "Retail";
            DisplayName           = "Lynne Robbins";
            Ensure                = "Present";
            FirstName             = "Lynne";
            LastName              = "Robbins";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "20/1104";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "74133";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "OK";
            StreetAddress         = "7633 E. 63rd Place, Suite 300";
            TenantId              = $OrganizationName;
            Title                 = "Planner";
            UsageLocation         = "US";
            UserPrincipalName     = "LynneR@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Megan Bowen"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Pittsburgh";
            Country               = "United States";
            Department            = "Marketing";
            DisplayName           = "Megan Bowen";
            Ensure                = "Present";
            FirstName             = "Megan";
            LastName              = "Bowen";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "12/1110";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "15212";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "PA";
            StreetAddress         = "30 Isabella St., Second Floor";
            TenantId              = $OrganizationName;
            Title                 = "Marketing Manager";
            UsageLocation         = "US";
            UserPrincipalName     = "MeganB@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Miriam Graham"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "San Diego";
            Country               = "United States";
            Department            = "Sales & Marketing";
            DisplayName           = "Miriam Graham";
            Ensure                = "Present";
            FirstName             = "Miriam";
            LastName              = "Graham";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "131/2103";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "92121";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "CA";
            StreetAddress         = "9255 Towne Center Dr., Suite 400";
            TenantId              = $OrganizationName;
            Title                 = "Director";
            UsageLocation         = "US";
            UserPrincipalName     = "MiriamG@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Nestor Wilke"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Seattle";
            Country               = "United States";
            Department            = "Operations";
            DisplayName           = "Nestor Wilke";
            Ensure                = "Present";
            FirstName             = "Nestor";
            LastName              = "Wilke";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "36/2121";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "98109";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "WA";
            StreetAddress         = "320 Westlake Ave N. Thomas St.";
            TenantId              = $OrganizationName;
            Title                 = "Director";
            UsageLocation         = "US";
            UserPrincipalName     = "NestorW@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-no_mfa_admin"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            DisplayName           = "no_mfa_admin";
            Ensure                = "Present";
            FirstName             = "no_mfa_admin";
            LicenseAssignment     = @("DEVELOPERPACK_E5","FLOW_FREE");
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PasswordPolicies      = "None";
            Roles                 = @("Global Administrator");
            TenantId              = $OrganizationName;
            UsageLocation         = "DE";
            UserPrincipalName     = "no_mfa_admin@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Patti Fernandez"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Louisville";
            Country               = "United States";
            Department            = "Executive Management";
            DisplayName           = "Patti Fernandez";
            Ensure                = "Present";
            FirstName             = "Patti";
            LastName              = "Fernandez";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "15/1102";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PostalCode            = "40223";
            PreferredLanguage     = "en-US";
            Roles                 = @();
            State                 = "KY";
            StreetAddress         = "9900 Corporate Campus Dr., Suite 3000";
            TenantId              = $OrganizationName;
            Title                 = "President";
            UsageLocation         = "US";
            UserPrincipalName     = "PattiF@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Pradeep Gupta"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            City                  = "Cairo";
            Country               = "Egypt";
            Department            = "Finance";
            DisplayName           = "Pradeep Gupta";
            Ensure                = "Present";
            FirstName             = "Pradeep";
            LastName              = "Gupta";
            LicenseAssignment     = @("DEVELOPERPACK_E5");
            Office                = "98/2202";
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PreferredLanguage     = "en-US";
            Roles                 = @();
            StreetAddress         = "Smart Village, Kilo 28, Cairo/Alex Desert Road";
            TenantId              = $OrganizationName;
            Title                 = "Accountant";
            UsageLocation         = "US";
            UserPrincipalName     = "PradeepG@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-Tyll Outlook"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            DisplayName           = "Tyll Outlook";
            Ensure                = "Present";
            FirstName             = "Tyll";
            LastName              = "Outlook";
            LicenseAssignment     = @();
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PreferredLanguage     = "en-US";
            Roles                 = @("Global Administrator","Exchange Administrator","Exchange Recipient Administrator");
            TenantId              = $OrganizationName;
            UserPrincipalName     = "tyll.stoecker_outlook.de#EXT#@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
        AADUser "AADUser-FNU LNU"
        {
            ApplicationId         = $ConfigurationData.NonNodeData.ApplicationId;
            CertificateThumbprint = $ConfigurationData.NonNodeData.CertificateThumbprint;
            DisplayName           = "FNU LNU";
            Ensure                = "Present";
            FirstName             = "FNU";
            LastName              = "LNU";
            LicenseAssignment     = @("FLOW_FREE","DEVELOPERPACK_E5");
            Password              = New-Object System.Management.Automation.PSCredential('Password', (ConvertTo-SecureString 'Pass@word!11' -AsPlainText -Force));;
            PasswordNeverExpires  = $False;
            PreferredLanguage     = "en";
            Roles                 = @("Global Administrator");
            TenantId              = $OrganizationName;
            UsageLocation         = "US";
            UserPrincipalName     = "tyll@wx8w4.onmicrosoft.com";
            UserType              = "Member";
        }
    }
}

M365TenantConfig -ConfigurationData .\ConfigurationData.psd1
