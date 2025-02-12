Images of all Windows versions and editions for {{ yandex-cloud }} deployments come with enabled PowerShell Remoting Protocol (PSRP) with HTTPS access. You will be able to connect to a VM with the `RUNNING` status via PSRP. It may take some time for all services to initialize after the VM [starts](../../compute/operations/vm-control/vm-stop-and-start.md#start). If you get a connection error, try again in a few minutes.

VM [security groups](../../vpc/concepts/security-groups.md) must allow incoming TCP traffic on port 5986.

To connect via PSRP, specify the public IP address or fully qualified domain name ([FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name)). You can use FQDN to access a VM from another {{ yandex-cloud }} VM if both are connected to the same network. To get the IP address and FQDN, use the management console: go to the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section on the VM page.

To connect to a VM:

1. Start PowerShell.

1. Create an object named `Credentials`, replacing `<password>` with `Administrator` password you specified when creating the VM:

    ```powershell
    $myUserName = "Administrator"
    $myPlainTextPassword = "<password>"
    $myPassword = $MyPlainTextPassword | ConvertTo-SecureString -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($MyUserName, $myPassword)
    ```

1. Make sure the username and password entered in the object are correct:

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

1. Create a variable for the VM IP address:

    ```powershell
    $ipAddress = "<IP_address>"
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
    [<IP_address>]: PS C:\Users\$myUserName\Documents>
    ```

    Terminate the session:

    ```powershell
    Exit-PSSession
    ```

1. Create a non-interactive session:

    ```powershell
    $session = New-PSSession @psSession
    ```

    Get a list of active sessions:

    ```powershell
    Get-PSSession
    ```

    Result:

    ```text
    Id Name            ComputerName    ComputerType    State         ConfigurationName     Availability
    -- ----            ------------    ------------    -----         -----------------     ------------
     2 WinRM2          <IP_address>    RemoteMachine   Opened        Microsoft.PowerShell     Available
    ```

    Run this command on a remote VM:

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
        249      13     4248      16200       0.11   4176   2 conhost                        <IP_address>
        283      12     1888       4220       0.20    420   0 csrss                          <IP_address>
    ...
    ```

#### See also {#see-also}

* [PowerShell sessions (PSSessions)](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pssessions)
