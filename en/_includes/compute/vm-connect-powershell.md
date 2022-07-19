PowerShell Remoting Protocol (PSRP) with access via HTTPS is enabled for images of all versions and editions of the Windows operating system prepared for {{ yandex-cloud }}. When the VM starts (its status is `RUNNING`), you can connect to it using PSRP.

[Security groups](../../vpc/concepts/security-groups.md) of the VM must allow incoming TCP traffic to port 5986.

  {% include [security-groups-note](../../compute/_includes_service/security-groups-note.md) %}

To do this, specify its public IP address or fully qualified domain name ([FQDN]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/FQDN){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Fully_qualified_domain_name){% endif %}). Access using FQDN is possible from another {{ yandex-cloud }} VM if it's connected to the same network. You can find out the IP address and FQDN in the management console. Go to the **Network** section on the virtual machine's page.

To connect to the VM:

1. Open the PowerShell console.

1. Create an object named `Credentials` and replace the `<password>` password with that of the `Administrator` user, which you specified when creating the VM:

    ```powershell
    $myUserName = "Administrator"
    $myPlainTextPassword = "<password>"
    $myPassword = $MyPlainTextPassword | ConvertTo-SecureString -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($MyUserName, $myPassword)
    ```

1. Make sure that the username and password entered in the object are correct:

    ```powershell
    $networkCredential = $credential.GetNetworkCredential()
    $networkCredential | Select-Object UserName, Password
    ```

    Result:

    ```text
    UserName      Password
    --------      --------
    Administrator <password>
    ```

1. Create a variable for the VM's IP address:

    ```powershell
    $ipAddress = "<ip-address>"
    ```

1. Create an object named `SessionOption`. In the object, specify the checks to skip:

    ```powershell
    $sessionOption = New-PSSessionOption `
      -SkipCACheck `
      -SkipCNCheck `
      -SkipRevocationCheck
    ```

1. Connect to an interactive session:

    ```powershell
    $psSession = @{
      ComputerName = $ipAddress
      UseSSL = $true
      Credential = $credential
      SessionOption = $sessionOption
    }
    Enter-PSSession @psSession
    ```

    Result:

    ```text
    [<ip-address>]: PS C:\Users\$myUserName\Documents>
    ```

    Terminate the session:

    ```powershell
    Exit-PSSession
    ```

1. Create a session for non-interactive command execution:

    ```powershell
    $session = New-PSSession @psSession
    ```

    Get a list of open sessions:

    ```powershell
    Get-PSSession
    ```

    Result:

    ```text
    Id Name            ComputerName    ComputerType    State         ConfigurationName     Availability
    -- ----            ------------    ------------    -----         -----------------     ------------
     2 WinRM2          <ip-address>    RemoteMachine   Opened        Microsoft.PowerShell     Available
    ```

    Run the command on a remote VM:

    ```powershell
    $scriptBlock = { Get-Process }
    $invokeCommand = @{
      ScriptBlock = $scriptBlock
      Session = $session
    }
    Invoke-Command @invokeCommand
    ```

    Result:

    ```text
    Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName                    PSComputerName
    -------  ------    -----      -----     ------     --  -- -----------                    --------------
        249      13     4248      16200       0.11   4176   2 conhost                        <ip-address>
        283      12     1888       4220       0.20    420   0 csrss                          <ip-address>
    ...
    ```

#### See also {#see-also}

* [PowerShell sessions (PSSessions)](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pssessions)

