# Verifying password reset operation on a Windows virtual machine

## Checking that the agent is installed {#check-installation}

1. [Connect to the VM via RDP](../vm-connect/rdp.md).
1. Make sure that the agent is installed and running as the `yc-guest-agent` service:

   {% list tabs %}

   - PowerShell

      ```powershell
      Get-Service "yc-guest-agent"
      ```

      * If the agent is installed and running, it will show up on the list as `Running`:

         ```
         Status   Name               DisplayName
         ------   ----               -----------
         Running  yc-guest-agent     yc-guest-agent
         ```

      * If the agent is installed, but isn't running, it will show up on the list as `Stopped`. To run the agent, execute the command below:

         ```powershell
         Start-Service "yc-guest-agent"
         ```

         Afterwards, check again that the agent is running.

      * If the agent is not installed, it will not show up. Follow the [instructions](install.md) to install it.

   {% endlist %}

## Verifying agent updates {#check-updater}

1. [Connect to the VM via RDP](../vm-connect/rdp.md).
1. Make sure that the agent update is configured and running properly:

   {% list tabs %}

   - PowerShell

      1. Make sure that the agent update job is running:

         ```powershell
         Get-ScheduledTask "yc-guest-agent-updater" -OutVariable Task
         ```

         Result:

         ```
         TaskPath           TaskName                          State
         --------           --------                          -----
         \                  yc-guest-agent-updater            Ready
         ```

         The `yc-guest-agent-updater` job must have the `Ready` status.

      1. Get information about the most recent job run.

         ```powershell
         $Task | Get-ScheduledTaskInfo
         ```

         Result:

         ```
         LastRunTime        : 11/8/2021 1:26:26 PM
         LastTaskResult     : 0
         NextRunTime        : 11/15/2021 12:10:10 AM
         NumberOfMissedRuns : 0
         TaskName           : yc-guest-agent-updater
         TaskPath           : \
         PSComputerName     :
         ```

         If the most recent update was successful, the value in the `LastTaskResult` field will be `0`.

   {% endlist %}

## Retrieving agent logs {#get-logs}

You can retrieve password reset agent logs on serial port 4 (COM4) or directly from the agent in PowerShell.

To get logs:

{% list tabs %}

- Management console

   1. Select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Click on the line with the VM you need.
   1. Go to the **Serial port** tab.
   1. Select **COM4** as your port.
   1. To use the **CTRL**+**F** keyboard shortcut to search, enable **Raw mode** in the upper-right corner.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Run the following command:

   ```
   yc compute instance get-serial-port-output <VM name> --port 4 > output.txt
   ```

   The logs will be saved to a file named `output.txt`

- PowerShell

   1. Stop the agent:

      ```powershell
      Stop-Service "yc-guest-agent"
      ```

   1. Restart the agent with the required logging level as specified in the `--log-level` parameter. For example:

      ```powershell
      & "C:\Program Files\Yandex.Cloud\Guest Agent\guest-agent.exe" start --log-level debug
      ```

- API

   To capture the serial port output, use the gRPC API [InstanceService/GetSerialPortOutput](../../api-ref/grpc/instance_service.md#GetSerialPortOutput) call or the REST API [getSerialPortOutput](../../api-ref/Instance/getSerialPortOutput.md) method. Set the `port` field to `4`.

{% endlist %}