# Deleting the password reset agent from a Windows Server virtual machine

1. [Connect to the VM via RDP](../vm-connect/rdp.md).
1. Stop the Windows Server service and delete the agent:

   {% list tabs %}

   - PowerShell

      1. Stop `yc-guest-agent`:

         ```powershell
         Stop-Service -Name "yc-guest-agent"
         ```

      1. Verify that the service has been stopped:

         ```powershell
         Get-Service "yc-guest-agent"
         ```

         Result:

         ```
         Status   Name               DisplayName
         ------   ----               -----------
         Stopped  yc-guest-agent     yc-guest-agent
         ```

         The service status must be `Stopped`.

      1. Delete the agent:

         ```powershell
         & "C:\Program Files\Yandex.Cloud\Guest Agent\guest-agent.exe" uninstall
         ```

         Result:

         ```
         2023-03-16T14:47:00.248Z        INFO    uninstall windows service: yc-guest-agent       {"server": "windows"}
         ```

   {% endlist %}