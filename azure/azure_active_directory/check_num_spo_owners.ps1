## Simple ways of getting identity and number of sharepoint site owners

#great resources on this: 
#https://www.sharepointdiary.com/2018/02/get-sharepoint-online-site-owner-using-powershell.html
#https://techcommunity.microsoft.com/t5/windows-powershell/sharepoint-online-get-the-site-owner-using-powershell/m-p/3751913


### Simple SharePoint parsing

$AdminCenterURL = "https://wx8w4-admin.sharepoint.com/" 
#Connect to SharePoint Online
Connect-SPOService -url $AdminCenterURL
#Get Site owners of all site collections
Get-SPOSite -limit ALL | Select URL, owner

### If Office/Microsoft 365 groups
#While the above approach works fine with sites without Office/Microsoft 365 groups, 
#we can change the script a bit to get site owners of an Office 365 group connected site collections, 
#as the site owner is set as the group owner

#The line by line output could easily be added to a csv file or parsed directly for e.g. sites with <2 owners etc.

Import-Module Microsoft.Online.SharePoint.PowerShell
Import-Module AzureAD

Connect-SPOService -url $AdminCenterURL
Connect-AzureAD


#Install-Module PnP.PowerShell -RequiredVersion 1.12.0 -Force
Import-Module PnP.PowerShell

#"Interactive flag" needed for MFA
Connect-PnPOnline -Url $Site -Interactive
$SitesCollection = Get-PnPTenantSite

ForEach($Site in $SitesCollection)
{
    Write-host -F Green "Site Owner(s) of the site: " $Site.Url
    Connect-PnPOnline -Url $Site.Url -Interactive
    
    If($Site.Template -like 'GROUP*')
    {
        #Get Group Owners
        $GroupOwners = (Get-PnPMicrosoft365GroupOwners -Identity ($Site.GroupId)  | Select -ExpandProperty Email) -join "; "
    }
    Else
    {
        #Get Site Owner
        $GroupOwners = $Site.Owner
    }
 
    #powershell script to get sharepoint online site owners
    Write-host $GroupOwners
}


