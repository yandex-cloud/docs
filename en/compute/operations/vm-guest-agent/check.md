---
title: How to check password reset agent operation on a Windows Server VM
description: This article describes how to check password reset agent operation on a Windows Server VM.
---

# Checking password reset agent operation on a Windows Server VM

## Checking that the agent is installed {#check-installation}

1. [Connect to the VM via RDP](../vm-connect/rdp.md).
1. Make sure the agent is installed and running as the `yc-guest-agent` service:

   {% list tabs group=programming_language %}

   - PowerShell {#powershell}

     ```powershell
     Get-Service "yc-guest-agent"
     ```

     * If installed and running, the agent will be listed as `Running`:

       ```
       Status   Name               DisplayName
       ------   ----               -----------
       Running  yc-guest-agent     yc-guest-agent
       ```

     * If installed but not running, the agent will be listed as `Stopped`. To run the agent, use this command:

       ```powershell
       Start-Service "yc-guest-agent"
       ```

       After that, check if the agent is now running.

     * If the agent is not installed, it will not appear in the list. Use [this guide](install.md) to install it.

   {% endlist %}

## Checking for agent updates {#check-updater}

1. [Connect to the VM via RDP](../vm-connect/rdp.md).
1. Make sure the agent updater is configured and running properly:

   {% list tabs group=programming_language %}

   - PowerShell {#powershell}

     1. Make sure the agent update job is running:

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

        If the most recent update was successful, you will see `0` in the `LastTaskResult` field.

   {% endlist %}

## Getting agent logs {#get-logs}

You can get password reset agent logs on serial port 4 (COM4) or directly from the agent in PowerShell.

To get logs:

{% list tabs group=instructions %}

- Management console {#console}

  1. Select the folder the VM belongs to.
  1. Select **{{ compute-name }}**.
  1. Click the line with the VM in question.
  1. Go to the **Serial port** tab.
  1. Select **COM4** as your port.
  1. To use the **CTRL** + **F** shortcut to search, enable **Raw mode** in the top-right corner.

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Run the following command:

  ```
  yc compute instance get-serial-port-output <VM_name> --port 4 > output.txt
  ```

  The logs will be saved to a file named `output.txt`.

- PowerShell {#powershell}

  1. Stop the agent:

     ```powershell
     Stop-Service "yc-guest-agent"
     ```

  1. Restart the agent with the required logging level as specified in the `--log-level` parameter. Here is an example:

     ```powershell
     & "C:\Program Files\Yandex.Cloud\Guest Agent\guest-agent.exe" start --log-level debug
     ```

- API {#api}

  To get the serial port output, use the [getSerialPortOutput](../../api-ref/Instance/getSerialPortOutput.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/GetSerialPortOutput](../../api-ref/grpc/Instance/getSerialPortOutput.md) gRPC API call. Set `port` to `4`.

{% endlist %}