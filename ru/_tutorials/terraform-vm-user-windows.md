Чтобы создать пользователя и установить пароль учётной записи Administrator на ВМ в {{ yandex-cloud }} можно использовать агент [cloudbase-init](https://cloudbase-init.readthedocs.io/en/latest/). Для этого создайте скрипт `init.ps1`, который будет выполняться агентом при первой загрузке системы. В качестве учетных сведений будут использоваться переменные из файла `variables.tf`.

{% cut "Файл init.ps1" %}

```
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
