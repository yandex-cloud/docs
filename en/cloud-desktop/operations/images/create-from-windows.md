---
title: How to create a Windows image and add it to {{ cloud-desktop-name }}
description: Follow this guide to add an image based on a custom Windows image.
---

# Create a Windows-based image

In {{ cloud-desktop-name }}, you can create desktops from pre-installed [system images](../../concepts/images.md) or your own [custom images](../../concepts/images.md#custom-images). Custom images may be [Linux](create-from-compute-linux.md) or Windows-based.

Creating a custom Windows image requires a Windows image licensed to you. Before installing, you should check with Microsoft to see if your license is suitable for cloud environments. The licensing relationship exists solely between you as a client and Microsoft as a license vendor. You are fully responsible for complying with the Microsoft license [terms and conditions](https://www.microsoft.com/en-us/legal).

{% note info %}

The information in this article is not legally binding and is provided for reference only.

{% endnote %}

To create an image in {{ cloud-desktop-name }}:

1. [Get your equipment ready](#prerequisites).
1. [Install and configure a Windows image](#windows-installation) for your users.
1. [Configure your Windows image](#windows-cloud) to operate in the cloud.
1. [Install the cloud agent](#agent-install).
1. Optionally, [install Cloudbase-Init](#cloudbase-init).
1. Optionally, [generalize your image](#generalize).
1. [Add the image to {{ compute-name }}](#image-to-compute).
1. [Create an image in {{ cloud-desktop-name }}](#image-to-desktop).

## Prerequisites {#prerequisites}

To use an image with a Windows OS in {{ cloud-desktop-name }}, you will create and configure it using the [QEMU](https://www.qemu.org/) virtualizer.

To configure an image, you will need:

* Computer with x86-64 CPU.
* Linux OS When using other operating systems:

    * For macOS, you can use `hvf` as a QEMU accelerator.
    * For Windows, to work with QEMU:
        * Enable virtualization in BIOS/UEFI.
        * Enable Hyper-V. For server OSes, install Virtual Machine Platform.
        * Use the `whpx` accelerator.
* Windows installation image ([ISO](https://en.wikipedia.org/wiki/Optical_disc_image) file).
* [Windows VirtIO drivers](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso).

{% note warning %}

Make sure the OS in the image you are creating supports remote desktop connections over [Remote Desktop Protocol](https://{{ lang }}.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

{% endnote %}

## Installing and configuring a Windows image {#windows-installation}

1. Create a file for the boot disk image on your computer by running this command:

    ```bash
    qemu-img create -f qcow2 image.qcow2 20480M
    ```

    Where:
    * `image.qcow2`: Name of the boot disk image file.
    * `20480M`: OS boot disk size in the image, MB.

        {% note info %}

        We recommend that you specify a size of at least `16384M`. Otherwise, your boot disk may not have enough space when installing or later configuring the OS.

        {% endnote %}

1. Start a VM to install and configure Windows by running this command:

    ```bash
    qemu-kvm \
      -cpu "qemu64,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff,hv-time" \
      -name win-image \
      -device "virtio-net,netdev=user.0" \
      -netdev user,id=user.0 \
      -drive "file=image.qcow2,if=virtio,cache=writeback,discard=ignore,format=qcow2" \
      -drive "file=windows.iso,media=cdrom" \
      -drive "file=virtio-win.iso,media=cdrom" \
      -parallel none -smp "cpus=2" \
      -boot "once=d" \
      -machine "type=q35,accel=kvm" \
      -m "4096M" \
      -nic "none" \
      -device qemu-xhci \
      -device usb-tablet \
      -vnc "0.0.0.0:85"
    ```

    Where:

    * `file=image.qcow2`: Path to the boot disk image file you created earlier.
    * `file=windows.iso`: Path to the ISO file with the Windows installation image.
    * `file=virtio-win.iso`: Path to the ISO file with `Windows VirtIO` drivers.
    * `-vnc "0.0.0.0:85"`: Optional parameter. Use it if your QEMU build does not support graphical VM control. 

    {% note info %}

    If configuring your image on macOS, replace `type=q35,accel=kvm` with `type=q35,accel=hvf`; for Windows, use `type=q35,accel=whpx`.

    If you need to specify the full path to the QEMU startup file, please keep in mind that the file name may vary across operating systems and QEMU builds. The most common file names are `qemu-x86_64`, `qemu-system-x86_64`, `qemu-system-x86_64w`, `qemu-gtk`, and `qemu`.

    {% endnote %}

    If your QEMU build does not support graphical VM control, you can connect to your VM over [VNC](https://en.wikipedia.org/wiki/VNC) using local port `tcp/5985` (`localhost:5985`). To connect, use a VNC client of your choice, e.g., `RealVNC`, `Remmina`, or `ultraVNC`. In macOS, you can use its pre-installed VNC client, **Screen Sharing**.

1. Follow the on-screen instructions to install Windows from the ISO.

    When prompted to select a storage for OS installation, select **Load driver** to install the `virtio-storage` driver.

    {% note tip %}

    The driver is located in the `viostor` directory on the virtual CD-ROM where the ISO file with `Windows VirtIO` drivers is mounted. In the `viostor` directory, select a subdirectory that corresponds to your OS version.

    {% endnote %}

1. Once the OS installation is complete, log in and install the required hardware drivers by running `virtio-win-guest-tools.exe` from the root of the mounted CD with `Windows VirtIO` drivers.
1. Make sure your OS has **Remote desktop connection** (RDP) installed and running.
1. Configure Windows and install software to best suit the needs of your users.

## Configuring an image to work in {{ yandex-cloud }} {#windows-cloud}

1. Run `cmd` as an administrator.
1. Activate `serial console` for the OS bootloader.

    ```cmd
    bcdedit /ems "{current}" on
    bcdedit /emssettings EMSPORT:2 EMSBAUDRATE:115200
    ```
1. Disable power saving settings:

    ```cmd
    powercfg -setactive "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
    powercfg -change -monitor-timeout-ac 0
    powercfg -change -standby-timeout-ac 0
    powercfg -change -hibernate-timeout-ac 0
    ```
1. Run `PowerShell` as an administrator.
1. For virtualized hardware clocks, set the time format to UTC:

    ```powershell
    #ps1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Value 1 -Type DWord -Force
    ```
1. Disable automatic local IPv4 addressing (APIPA) for network interfaces that got no IP address assigned:

    ```powershell
    #ps1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "IPAutoconfigurationEnabled" -Value 0 -Type DWord -Force
    ```
1. Allow OS shutdown if there are no active user sessions:

    ```powershell
    #ps1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ShutdownWithoutLogon" -Value 1
    ```
1. Set the minimum OS shutdown warning display time when there are active user processes:

    ```powershell
    #ps1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" -Name "ShutdownWarningDialogTimeout" -Value 1
    ```
1. Disable automatic disk optimization (defragmentation/TRIM):

    ```powershell
    #ps1
    Get-ScheduledTask -TaskName "ScheduledDefrag" | Disable-ScheduledTask
    ```
1. Allow ICMPv4 traffic (if Windows Firewall is not disabled):

    ```powershell
    #ps1
    Get-NetFirewallRule -Name "vm-monitoring-icmpv4" | Enable-NetFirewallRule
    ```
1. Optionally, enable RDP connections requiring user authentication:

    {% note info %}

    The commands below enable connections to a built-in RDP server in a Windows OS. If the RDP server is unavailable in your OS, the command will return an error.

    In Russian versions of Windows, the `Remote Desktop` firewall rule group may have a localized name. If the command with the `-DisplayGroup "Remote Desktop"` parameter fails, specify the localized group name.

    {% endnote %}

    ```powershell
    #ps1
    Get-CimInstance -ClassName Win32_TSGeneralSetting -Namespace root\cimv2\terminalservices | Invoke-CimMethod -MethodName SetUserAuthenticationRequired -Arguments @{ UserAuthenticationRequired = 1 }
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    ```

## Installing the cloud agent {#agent-install}

1. Run `PowerShell` as an administrator.
1. Install the cloud agent:

    ```powershell
    Invoke-WebRequest 'https://{{ s3-storage-host }}/yandexcloud-vdi-agent/install.ps1' -OutFile "$($Env:temp)\install.ps1"
    cd $($Env:temp)
    Powershell.exe -ExecutionPolicy Bypass -File .\install.ps1
    mkdir "C:\Program Files\Yandex.Cloud\Cloud Desktop\"
    cp .\desktopagentInstall\desktopagent.exe 'C:\Program Files\Yandex.Cloud\Cloud Desktop\'

    # Create Desktop Agent service
    $ServiceName = "cloud-desktop-agent"
    $ServicePort = 5050
    $ServicePath = "C:\Program Files\Yandex.Cloud\Cloud Desktop\desktopagent.exe"

    $p = @{
        Name = $ServiceName
        DisplayName = "Yandex Desktop Agent"
        BinaryPathName = "$ServicePath start --address :$ServicePort"
        Description = "Yandex Desktop Agent, automates actions from Yandex Desktop control plane service."
        StartupType = "Automatic"
    }
    New-Service @p

    & sc.exe config $ServiceName start= delayed-auto
    & sc.exe failure $ServiceName reset= 86400 actions= restart/1000/restart/1000/restart/1000

    ### The agent startup is commented because starting the agent outside the Cloud Desktop will fail. Do not start the agent during the image preparation stage.
    # Start-Service $ServiceName

    # Create firewall rule for Desktop Agent
    if ($Rule = Get-NetFirewallRule -Name "DESKTOP-AGENT-HTTPS-In-TCP" -ErrorAction SilentlyContinue) {
        $Rule | Remove-NetFirewallRule
    }

    New-NetFirewallRule `
        -Group "Yandex Desktop Agent" `
        -DisplayName "Yandex Desktop Agent (HTTPS-In)" `
        -Name "DESKTOP-AGENT-HTTPS-In-TCP" `
        -LocalPort $ServicePort `
        -Action "Allow" `
        -Protocol "TCP" `
        -Program "$ServicePath"
    ```
1. Create a task for the VM to run correctly after it is first started:

    ```powershell
    & mkdir "C:\Scripts"
    & schtasks /Create /TN "SetNetSettings" /RU System /SC ONSTART /RL HIGHEST /TR "Powershell -NoProfile -ExecutionPolicy Bypass -File \`"C:\Scripts\StartupSettings.ps1`"" | Out-Null
    ```
1. In the `C:\Scripts` folder, create a file named `StartupSettings.ps1` with the following contents:
  
    ```powershell
    # Find the default gateway to route metadata service to it
    $output = Get-WmiObject -Class Win32_IP4RouteTable | Where-Object { $_.Destination -eq '0.0.0.0' -and $_.Mask -eq '0.0.0.0' } | Sort-Object Metric1 | Select-Object -ExpandProperty NextHop

    if (-not $output) {
        # Practically unreachable
        Write-Error "Default gateway was not found!"
        exit
    }

    # If a route for the metadata address already exists, we will replace it
    $routeToRemove = Get-WmiObject -Class Win32_IP4RouteTable | Where-Object { $_.Destination -eq '169.254.169.254' } | Select-Object -ExpandProperty Destination

    if ($routeToRemove) {
        Write-Output "Route for 169.254.169.254 already exists"
        $routeToRemove | ForEach-Object {
          route delete $routeToRemove
        }
        Write-Output "Deleted old route for metadata address"
    }

    route -p add 169.254.169.254 mask 255.255.255.255 $output metric 1

    # Getting IPv6 Net Adapter
    $IPv6Adapter = Get-NetAdapter | where {$_.Linklayeraddress -like "D0-1D*"}

    if($IPv6Adapter) {
        if((Get-NetAdapterBinding -Name $IPv6Adapter.Name -ComponentID ms_tcpip).Enabled -eq "True") {
            $outNull = Set-NetAdapterBinding -Name $IPv6Adapter.Name -ComponentID ms_tcpip -Enabled $false -Confirm:$false
            Start-Sleep 5
        }
    }

    if(!$(Get-Service -DisplayName "Yandex Desktop Agent") -or !$(Get-Item -Path "C:\Program Files\Yandex.Cloud\Cloud Desktop\desktopagent.exe" -ErrorAction SilentlyContinue)) {
        Invoke-WebRequest 'https://{{ s3-storage-host }}/yandexcloud-vdi-agent/install.ps1' -OutFile "$($Env:temp)\install.ps1"
        cd $($Env:temp)
        Powershell.exe -ExecutionPolicy Bypass -File .\install.ps1
        mkdir "C:\Program Files\Yandex.Cloud\Cloud Desktop\"
        cp .\desktopagentInstall\desktopagent.exe 'C:\Program Files\Yandex.Cloud\Cloud Desktop\'

        # Create Desktop Agent service
        $ServiceName = "cloud-desktop-agent"
        $ServicePort = 5050
        $ServicePath = "C:\Program Files\Yandex.Cloud\Cloud Desktop\desktopagent.exe"

        $p = @{
            Name = $ServiceName
            DisplayName = "Yandex Desktop Agent"
            BinaryPathName = "$ServicePath start --address :$ServicePort"
            Description = "Yandex Desktop Agent, automates actions from Yandex Desktop control plane service."
            StartupType = "Automatic"
        }
        New-Service @p

        & sc.exe config $ServiceName start= delayed-auto
        & sc.exe failure $ServiceName reset= 86400 actions= restart/1000/restart/1000/restart/1000

        Start-Service $ServiceName

        # Create firewall rule for Desktop Agent
        if ($Rule = Get-NetFirewallRule -Name "DESKTOP-AGENT-HTTPS-In-TCP" -ErrorAction SilentlyContinue) {
            $Rule | Remove-NetFirewallRule
        }

        New-NetFirewallRule `
            -Group "Yandex Desktop Agent" `
            -DisplayName "Yandex Desktop Agent (HTTPS-In)" `
            -Name "DESKTOP-AGENT-HTTPS-In-TCP" `
            -LocalPort $ServicePort `
            -Action "Allow" `
            -Protocol "TCP" `
            -Program "$ServicePath"
    }
    
    # Stores Windows RE (WinRE) configuration info $nfo string
    [string]$nfo = reagentc /info

    # Checks if Windows RE (WinRE) is enabled and extracts its disk/partition info
    # If enabled, disables WinRE via reagentc and deletes its partition using DiskPart
    if($nfo -match ".*Windows RE status:.*Enabled.*"){
        # Locate the disk number it is on
        $nfo -match ".*Windows RE location.*harddisk(\d+)" | Out-Null
        $disk = $Matches[1]
        # Locate the partition it is on
        $nfo -match ".*Windows RE location.*partition(\d+)" | Out-Null
        $partition = $Matches[1]

        $WinREInfo = New-Object -TypeName psobject -Property $([ordered]@{Enabled='True';Disk=$disk;Partition=$partition;Resizable=(((Get-Disk -Number $disk | Get-Partition).PartitionNumber | Measure-Object -Maximum).Maximum -eq $partition);CurrentSize=([string]((Get-Disk -Number $disk | Get-Partition | Where-Object PartitionNumber -eq $partition).Size / 1MB) +'MB');A1_Key=[System.GUID]::NewGuid()})
    } else {
        $WinREInfo = New-Object -TypeName psobject -Property $([ordered]@{Enabled='False';Disk='N/A';Partition='N/A';Resizable='N/A';CurrentSize='N/A';A1_Key=[System.GUID]::NewGuid()})
    }

    if($WinREInfo.Enabled -eq "True" -and $WinREInfo.Partition -ne "N/A") {
        & reagentc /disable
        $outScript = "select disk $($WinREInfo.Disk)
    select partition $($WinREInfo.Partition)
    delete partition override
    exit
    "
        $outScript | Out-File C:\Scripts\winre.txt -Encoding ascii
        & diskpart /s C:\Scripts\winre.txt
        $outNull = Remove-Item "C:\Scripts\winre.txt" -Force -Confirm:$false
    }

    # Force extend partition
    $DiskSpace = Get-PartitionSupportedSize -DriveLetter "C"
    if((Get-Partition -DriveLetter "C").Size -lt $DiskSpace.SizeMax) {
        $outNull = Resize-Partition -DriveLetter "C" -Size $DiskSpace.SizeMax
    }

    # Format RAW disks
    $RAWDisks = Get-Disk | where {$_.PartitionStyle -eq "RAW"} 
    if($RAWDisks) { 
        foreach($RAWDisk in $RAWDisks) { 
            $outNull = Initialize-Disk -Number $RAWDisk.Number -PartitionStyle GPT -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "UserData" -Confirm:$false
        } 
    }  


    if ($LASTEXITCODE -eq 0) {
        Write-Output "Successfully create route for metadata service"
    } else {
        Write-Error "Error on creating route for metadata service! Exit code: $LASTEXITCODE"
    }
    ```

    The above script contains settings for startup and operation of the {{ cloud-desktop-name }} cloud agent’s system service as well as settings of the network route to the [metadata service](../../../compute/concepts/vm-metadata.md) available from inside the VM.

    {% note warning %}

    The metadata service is available at `http://169.254.169.254`.
    
    Do not restrict network access to this address from your OS. {{ cloud-desktop-name }} requires access to VM metadata to work correctly.

    {% endnote %}


## Installing Cloudbase-Init {#cloudbase-init}

You can install [Cloudbase-Init](https://cloudbase.it/cloudbase-init/) to the image you prepared. When using an image in {{ cloud-desktop-name }}, this service automatically expands the file system and OS boot partition to the boot disk's actual size.

To install Cloudbase-Init, run the following commands in PowerShell as an administrator:

```powershell
# Install Cloudbase-Init
$WorkDirectory = "C:\Scripts"
$outNull = Start-BITSTransfer -Source "https://www.cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi" -Destination $WorkDirectory
$outNull = Start-Process -FilePath 'msiexec.exe' -ArgumentList "/i $WorkDirectory\CloudbaseInitSetup_Stable_x64.msi /qn" -Wait
Start-Sleep 60

$outScript = "[DEFAULT]
username=Admin
groups=Administrators
inject_user_password=true
config_drive_raw_hhd=true
config_drive_cdrom=true
config_drive_vfat=true
bsdtar_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\bin\bsdtar.exe
mtools_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\bin\
verbose=true
debug=true
logdir=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\log\
logfile=cloudbase-init-unattend.log
default_log_levels=comtypes=INFO,suds=INFO,iso8601=WARN,requests=WARN
logging_serial_port_settings=COM1,115200,N,8
mtu_use_dhcp_config=true
ntp_use_dhcp_config=true
local_scripts_path=C:\Program Files\Cloudbase Solutions\Cloudbase-Init\LocalScripts\
metadata_services=cloudbaseinit.metadata.services.ec2service.EC2Service
plugins=cloudbaseinit.plugins.common.mtu.MTUPlugin,cloudbaseinit.plugins.common.sethostname.SetHostNamePlugin,cloudbaseinit.plugins.windows.extendvolumes.ExtendVolumesPlugin,cloudbaseinit.plugins.common.userdata.UserDataPlugin
allow_reboot=false
stop_service_on_exit=false
check_latest_version=false"
$outScript | Out-File -FilePath "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" -Confirm:$false -Force
$outScript | Out-File -FilePath "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init-unattend.conf" -Confirm:$false -Force
```

## Finalizing the image {#generalize}

After you are done with configuration, we recommend you to [generalize your image](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/sysprep--generalize--a-windows-installation) with the help of the `Sysrep` utility. This will prepare Windows for cloning and for later use on other computers. 

To generalize the image, start PowerShell as an administrator and run the following commands:

```powershell
# Global vars
$WorkDirectory = "C:\sysprep"

# Download the unattend.xml file for Sysprep
New-Item -Path $WorkDirectory -ItemType Directory
Start-BitsTransfer https://{{ s3-storage-host }}/cloudbase/sysprepunattend-cloudbase-init.xml -Destination $WorkDirectory\unattend.xml

# Start Sysprep
& $env:SystemRoot\System32\Sysprep\Sysprep.exe /oobe /generalize /quiet /quit /unattend:"$WorkDirectory\unattend.xml"

# Wait for correct system state
do {
    Start-Sleep -s 5
    $SetupState = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State"
    $ImageState = $SetupState | Select-Object -ExpandProperty ImageState
} while ($ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE')

Remove-Item $WorkDirectory -Recurse -Force
Remove-Item "C:\Windows\Setup\Scripts\*" -Force -ErrorAction SilentlyContinue

# Wait for Sysprep tag
while (-not (Test-Path 'C:\Windows\System32\Sysprep\Sysprep_succeeded.tag') ) {
    Start-Sleep -s 1
}

Stop-Computer -Force
```

Upon completion, the script’s final command will stop the VM and save the VM boot image locally to the previously created `image.qcow2` file, in [QCOW2](https://en.wikipedia.org/wiki/Qcow) format.

## Adding an image to {{ compute-name }} {#image-to-compute}

1. [Upload the image](../../../storage/operations/objects/upload.md) to {{ objstorage-full-name }}.
1. [Get a link](../../../storage/operations/objects/link-for-download.md) to the uploaded image.
1. [Import the image](../../../compute/operations/image-create/upload.md) to {{ compute-full-name }}.

    If using the [{{ yandex-cloud }} CLI](../../../cli/quickstart.md), you can import the image by running the following command and specifying the link you got earlier:

    {% list tabs group=instructions %}

    - {{ yandex-cloud }} CLI {#cli}

      ```bash
      yc compute image create \
        --name <image_name> \
        --description <image_description> \
        --os-type windows \
        --source-uri "<link_to_image_in_Object_Storage>"
      ```

    {% endlist %}

## Adding an image to {{ cloud-desktop-name }} {#image-to-desktop}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to create your image. 
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.vdi.label_desktop-images }}**.
  1. Click **{{ ui-key.yacloud.vdi.button_add-image }}**.
  1. In the **{{ ui-key.yacloud.vdi.label_image-source }}** field, select `{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}`.
  1. In the **{{ ui-key.yacloud.vdi.label_image }}** field, select the image you added earlier.
  1. Specify a name for the new image.
  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Once the image is created, you can use it as a boot disk image for desktop groups.

## Resizing boot disk without Cloudbase-Init {#resize-disk}

If you are not using Cloudbase-Init and you want to resize the boot disk in a desktop group:

1. Increase the boot disk file system size on your desktop, e.g., using the `diskmgmt.msc` snap-in.
1. [Create](create-from-desktop.md) a new {{ cloud-desktop-name }} image from that desktop.
1. Use the new image as a boot disk image for desktop groups.