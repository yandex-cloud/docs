---
title: "How to verify password reset agent operation on a Windows Server VM"
description: "This tutorial describes how to verify password reset agent operation on a Windows Server VM."
---

# Verifying password reset operation on a Windows Server virtual machine

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

      * If the agent is installed but is not running, it will show up on the list as `Stopped`. To run the agent, use the command below:

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
        LastRunTime        : 3/15/2023 2:39:39 PM
        LastTaskResult     : 2147946720
        NextRunTime        : 3/20/2023 6:36:36 AM 12:10:10 AM
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
   1. To use the **CTRL** + **F** keyboard shortcut to search, enable **Raw mode** in the upper-right corner.

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

   To get the serial port output, use the [getSerialPortOutput](../../api-ref/Instance/getSerialPortOutput.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/GetSerialPortOutput](../../api-ref/grpc/instance_service.md#GetSerialPortOutput) gRPC API call. Set the `port` field to `4`.

{% endlist %}