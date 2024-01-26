# Installing the password reset agent on a Windows Server VM



To reset user passwords on Windows Server VMs using {{ yandex-cloud }}, install the password reset agent and its update software.


{% include [password-reset-linux](../../../_includes/compute/password-reset-linux.md) %}

The agent is installed using the agent update software.

To install the agent and configure its auto update:

1. [Connect to the VM via RDP](../vm-connect/rdp.md).
1. Download and set up the agent update software:

   {% list tabs group=programming_language %}

   - PowerShell {#powershell}

      1. Get the software's most recent version number:

         ```powershell
         $YCAgentUpdaterBaseUri = "https://{{ s3-storage-host }}/{{ compute-guest-agent-bucket }}"
         $YCAgentUpdaterVersion = (Invoke-RestMethod "$YCAgentUpdaterBaseUri/release/stable").Trim()
         ```

      1. Download the software and verify its checksum.

         ```powershell
         $YCAgentUpdaterDir = "C:\Program Files\Yandex.Cloud\Guest Agent Updater"
         New-Item -Path $YCAgentUpdaterDir -ItemType "directory"

         $p = @{
           Uri = "$YCAgentUpdaterBaseUri/release/$YCAgentUpdaterVersion/windows/amd64/guest-agent-updater.exe"
           OutFile = "$YCAgentUpdaterDir\guest-agent-updater.exe"
         }
         Invoke-RestMethod @p

         $YCAgentUpdaterHashOrig = (Invoke-RestMethod "$YCAgentUpdaterBaseUri/release/$YCAgentUpdaterVersion/windows/amd64/guest-agent-updater.exe.sha256").Trim()
         $YCAgentUpdaterHashCopy = (Get-Filehash -Path "$YCAgentUpdaterDir\guest-agent-updater.exe" -Algorithm SHA256 | Select-Object -ExpandProperty Hash).ToLower()
         if ($YCAgentUpdaterHashOrig -eq $YCAgentUpdaterHashCopy) {
           Write-Host "Agent updater checksum verified"
         } else {
           Write-Host "Agent updater checksum NOT verified"
         }
         ```

         Result:

         ```
         Agent updater checksum verified
         ```

      1. Install the agent:

         ```powershell
         & $YCAgentUpdaterDir\guest-agent-updater.exe update
         ```

      1. Make sure the agent is installed as a service and that the service is running:

         ```powershell
         Get-Service "yc-guest-agent"
         ```

         Result:

         ```
         Status   Name               DisplayName
         ------   ----               -----------
         Running  yc-guest-agent     yc-guest-agent
         ```

         The service status must be `Running`.

      1. If the service is not running, run it:

         ```powershell
         Start-Service "yc-guest-agent"
         ```

         To verify that the service is running, repeat step 4.

      1. Configure a job to update the agent weekly at a random time.

         ```powershell
         $YCAgentUpdaterLogFilepath = "C:\Windows\Temp\guest-agent-updater.log"
         $p = @{
           Execute = 'C:\Windows\System32\cmd.exe'
           Argument = "/c `"$YCAgentUpdaterDir\guest-agent-updater.exe`" update --log-level debug > $YCAgentUpdaterLogFilepath"
         }
         $YCAgentUpdaterAction = New-ScheduledTaskAction @p

         $RandomWeekdayNumber = Get-Random -Minimum 0 -Maximum 6
         $DaysOfWeek = @("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
         $RandomWeekday = $DaysOfWeek[$RandomWeekdayNumber]

         $RandomHour = Get-Random -Minimum 0 -Maximum 23
         $RandomMinute = Get-Random -Minimum 0 -Maximum 59
         $RandomSecond = Get-Random -Minimum 0 -Maximum 59
         $p = @{
           Weekly = $true
           At = ([datetime]::Today).AddHours($RandomHour).AddMinutes($RandomMinute).AddSeconds($RandomSecond)
           RandomDelay = New-TimeSpan -Hours 24 # with huge random delay
           DaysOfWeek = $RandomWeekday
          }
         $YCAgentUpdaterTrigger = New-ScheduledTaskTrigger @p

         $YCAgentUpdaterTaskName = "yc-guest-agent-updater"
         $p = @{
           TaskName = $YCAgentUpdaterTaskName
           Action = $YCAgentUpdaterAction
           User = 'System'
           RunLevel = 'Highest'
           Trigger = $YCAgentUpdaterTrigger
         }
         Register-ScheduledTask @p | Out-Null
         ```

      1. Run the job:

         ```powershell
         Get-ScheduledTask -TaskName $YCAgentUpdaterTaskName | Start-ScheduledTask

         $Timeout = 30
         $Deadline = ([datetime]::Now).AddSeconds($timeout)

         while ((Get-ScheduledTask $YCAgentUpdaterTaskName).State -ne "Ready") {    
           Start-Sleep -Seconds 1

           if ([datetime]::Now -gt $Deadline) {
             Write-Host "Deadline exceeded"
             break
           }
         }
         ```

   {% endlist %}