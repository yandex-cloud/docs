PowerShell Remoting Protocol (PSRP) with access via HTTPS is enabled for images of all versions and editions of the Windows operating system prepared for {{ yandex-cloud }}. You can connect to a virtual machine with the `RUNNING` status over PSRP. Some time may be required to initialize all the services after the VM [starts](../../compute/operations/vm-control/vm-stop-and-start.md#start). If there is a connection error, retry after a few minutes.

Virtual machine [security groups](../../vpc/concepts/security-groups.md) must allow incoming TCP traffic to port 5986.

To do this, specify its public IP address or fully qualified domain name (Fully Qualified Domain Name, [FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name)). Access using FQDN is possible from another {{ yandex-cloud }} VM if it is connected to the same network. You can find out the IP address and FQDN in the management console. Go to the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section on the virtual machine's page.

To connect to the VM:

1. Open the PowerShell console.

1. Create an object named `Credentials` replacing the `<password>` with the one of the `Administrator` user you specified when creating the VM:

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
     2 WinRM2          <IP_address>    RemoteMachine   Opened        Microsoft.PowerShell     Available
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
        249      13     4248      16200       0.11   4176   2 conhost                        <IP_address>
        283      12     1888       4220       0.20    420   0 csrss                          <IP_address>
    ...
    ```

#### See also {#see-also}

* [PowerShell sessions (PSSessions)](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pssessions)
