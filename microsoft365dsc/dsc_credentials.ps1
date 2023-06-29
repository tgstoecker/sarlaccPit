Install-Module Microsoft365DSC
Update-Module Microsoft365DSC
Import-Module Microsoft365DSC
Uninstall-M365DSCOutdatedDependencies
Update-M365DSCDependencies
#Install-Module Az.Resources


#Service Principal/Certificate

#script from - 
#https://laurakokkarinen.com/authenticating-to-office-365-apis-with-a-certificate-step-by-step/
# + lennarts very good write up cover everything

###
# Run this script as an administrator
# --- config start
$dnsName = "wx8w4.onmicrosoft.com" # Your DNS name
$password = "notsecure" # Certificate password
$folderPath = "C:\temp" # Where do you want the files to get saved to? The folder needs to exist.
$fileName = "certsfordsctests" # What do you want to call the cert files? without the file extension
$yearsValid = 10 # Number of years until you need to renew the certificate
# --- config end
$certStoreLocation = "cert:\LocalMachine\My"
$expirationDate = (Get-Date).AddYears($yearsValid)
    
$certificate = New-SelfSignedCertificate -DnsName $dnsName -CertStoreLocation $certStoreLocation -NotAfter $expirationDate -KeyExportPolicy Exportable -KeySpec Signature
    
$certificatePath = $certStoreLocation + '\' + $certificate.Thumbprint
$filePath = $folderPath + '\' + $fileName
$securePassword = ConvertTo-SecureString -String $password -Force -AsPlainText
Export-Certificate -Cert $certificatePath -FilePath ($filePath + '.cer')
Export-PfxCertificate -Cert $certificatePath -FilePath ($filePath + '.pfx') -Password $securePassword
###

#depending on what you want to do with your app you need different permissions

#Export-M365DSCConfiguration -Components @("AADTenantDetails", "AADUser")
# requires permissions that can be seen here:
Get-M365DSCCompiledPermissionList `
    -ResourceNameList @("AADTenantDetails", "AADUser") `
    -PermissionType Application -AccessType Read



Export-M365DSCConfiguration `
    -Components @("AADTenantDetails", "AADUser") `
    -Path 'C:\Users\StoeckerTy\Documents\github_dev\sarlaccPit\microsoft365dsc\using_service_principal' `
    -ApplicationId '598dd0a1-7b94-4e15-a4b4-5c1e14f85e1b' `
    -TenantId 'wx8w4.onmicrosoft.com' `
    -CertificateThumbprint '7572BB84EB2B414A47B8852B78DE56E44C55499C'
