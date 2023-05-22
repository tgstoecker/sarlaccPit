tips from here:  
[https://dev.to/ofhouse/add-a-bash-like-autocomplete-to-your-powershell-4257](https://dev.to/ofhouse/add-a-bash-like-autocomplete-to-your-powershell-4257)

Better (more bash-like) PowerShell autocomplete:
```
# Create profile when not exist
if (!(Test-Path -Path $PROFILE.CurrentUserAllHosts)) {
  New-Item -ItemType File -Path $PROFILE.CurrentUserAllHosts -Force
}

# Open the profile with an editor - here I open from inside VS code
code $PROFILE.CurrentUserAllHosts

## Adding the following lines to the profile

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
```

Add the open command from MacOS to your PowerShell
On MacOS there is the powerful open command to open folders in Finder (the file explorer from MacOS) or files with their default application from the terminal.
PowerShell also has this command built-in which is called ii (Which stands for Invoke-Item).
Because I find the term ii hard to remember I added an open alias for it which makes it more convenient when switching between the platforms.

Adding a new alias to the PowerShell profile is really simple with the New-Alias command, so simply edit your profile and add the following line:
```
# New-Alias <alias> <aliased-command>
New-Alias open ii
```