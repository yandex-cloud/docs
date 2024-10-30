You can create a user and set the Administrator account password on a [VM](../../compute/concepts/vm.md) in {{ yandex-cloud }} using the [cloudbase-init](https://cloudbase-init.readthedocs.io/en/latest/) agent. To do this, create a script named `init.ps1` that the agent will run on the initial boot of the system. Variables from the `variables.tf` file will be used as credentials.

{% cut "init.ps file" %}

```cloudinit
#ps1
# ^^^ 'ps1' is only for cloudbase-init, some sort of sha-bang in linux

# logging
Start-Transcript -Path "$ENV:SystemDrive\provision.txt" -IncludeInvocationHeader -Force
"Bootstrap script started" | Write-Host

# inserting value's from terraform
$MyUserName = "${ user_name }"
$MyPlainTextPassword = "${ user_pass }"
if (-not [string]::IsNullOrEmpty($MyUserName) -and -not [string]::IsNullOrEmpty($MyPlainTextPassword)) {
    "Create user" | Write-Host
    $MyPassword = $MyPlainTextPassword | ConvertTo-SecureString -AsPlainText -Force
    $MyUser = New-LocalUser -Name $MyUserName -Password $MyPassword -PasswordNeverExpires -AccountNeverExpires
    $MyUser | Add-LocalGroupMember -Group 'Administrators'
    $MyUser | Add-LocalGroupMember -Group 'Remote Management Users'
}

# inserting value's from terraform
$MyAdministratorPlainTextPassword = "${ admin_pass }"
if (-not [string]::IsNullOrEmpty($MyAdministratorPlainTextPassword)) {
    "Set local administrator password" | Write-Host
    $MyAdministratorPassword = $MyAdministratorPlainTextPassword | ConvertTo-SecureString -AsPlainText -Force
    # S-1-5-21domain-500 is a well-known SID for Administrator
    # https://docs.microsoft.com/en-us/troubleshoot/windows-server/identity/security-identifiers-in-windows
    $MyAdministrator = Get-LocalUser | Where-Object -Property "SID" -like "S-1-5-21-*-500"
    $MyAdministrator | Set-LocalUser -Password $MyAdministratorPassword
}

"Bootstrap script ended" | Write-Host
```

{% endcut %}