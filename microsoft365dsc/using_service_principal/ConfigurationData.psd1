@{
    AllNodes = @(
        @{
            NodeName                    = "localhost"
            PSDscAllowPlainTextPassword = $true;
            PSDscAllowDomainUser        = $true;
            #region Parameters
            # Default Value Used to Ensure a Configuration Data File is Generated
            ServerNumber = "0"

        }
    )
    NonNodeData = @(
        @{
            # Tenant's default verified domain name
            OrganizationName = "wx8w4.onmicrosoft.com"

            # Azure AD Application Id for Authentication
            ApplicationId = "598dd0a1-7b94-4e15-a4b4-5c1e14f85e1b"

            # The Id or Name of the tenant to authenticate against
            TenantId = "wx8w4.onmicrosoft.com"

            # Thumbprint of the certificate to use for authentication
            CertificateThumbprint = "7572BB84EB2B414A47B8852B78DE56E44C55499C"

        }
    )
}
