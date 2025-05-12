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

To work in {{ cloud-desktop-name }}, you need to install and configure a Windows image through the QEMU virtualization system.

To configure an image you will need:

* Computer with x86-64 CPU.

* Linux OS When using other operating systems:
  * For macOS, you can use `hvf` as a QEMU accelerator.
  * For Windows, to work with QEMU:
    * Enable virtualization in BIOS/UEFI.
    * Enable Hyper-V. For server OSes, install Virtual Machine Platform.
    * Use the `whpx` accelerator.

* Windows installation image (ISO file).

* [Windows VirtIO drivers](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso).

## Installing and configuring a Windows image {#windows-installation}

1. On your computer, create a boot disk by running the following command:

    ```bash
    qemu-img create -f qcow2 image.qcow2 20480M
    ```
    
    Where:
    * `image.qcow2`: Boot disk name.
    * `20480M`: OS boot disk size in the image, MB.
    
      {% note info %}

      We recommend that you specify a size of at least `16384M`. Otherwise, your boot disk may have not enough space when installing or later configuring the OS.

      {% endnote %}

1. Start a VM to install and configure Windows:

    ```bash
    qemu-kvm -cpu "qemu64,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff,hv-time" -name win-image -device "virtio-net,netdev=user.0" -netdev user,id=user.0 -drive "file=image.qcow2,if=virtio,cache=writeback,discard=ignore,format=qcow2" -drive "file=windows.iso,media=cdrom" -drive "file=virtio-win.iso,media=cdrom" -parallel none -smp "cpus=2" -boot "once=d" -machine "type=q35,accel=kvm" -vnc "0.0.0.0:85" -m "4096M" -nic "none" -device qemu-xhci -device usb-tablet
    ```
    {% note info %}

    If configuring your image on macOS, replace `type=q35,accel=kvm` with `type=q35,accel=hvf`; if on Windows, with `type=q35,accel=whpx`.

    If you need to specify the full path to the QEMU startup file, please keep in mind that the file name may differ across operating systems and QEMU builds. The most common file names are `qemu-x86_64`, `qemu-system-x86_64`, `qemu-system-x86_64w`, `qemu-gtk`, and `qemu`.

    {% endnote %}

    If your QEMU build does not support graphical VM control, you can connect to your VM over VNC using local port `tcp/5985` (`localhost:5985`). To connect, use a VNC client of your choice, e.g., RealVNC, Remmina, or ultraVNC. In macOS, you can use its pre-installed VNC client, **Screen Sharing**.

1. Install Windows from an ISO image.

   When installing Windows, in the OS drive selection menu, select **Load driver** to load the `virtio-storage` driver (`viostor`). 

1. Once the installation is complete, log in and install the VirtIO drivers from the `virtio-win-guest-tools.exe` file located on the VirtIO drive.

1. Make sure your system has **Remote desktop connection** (RDP) installed.

1. Configure Windows to best suit the needs of your users.

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

1. Enable RDP connections requiring user authentication:

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
    Invoke-WebRequest 'https://storage.yandexcloud.net/vdi-agent-internal/install.ps1' -OutFile "$($Env:temp)\install.ps1"
    cd $($Env:temp)
    Powershell.exe -ExecutionPolicy Bypass -File .\install.ps1
    mkdir "C:\Program Files\Yandex.Cloud\Cloud Desktop\"
    cp .\desktopagentInstall\desktopagent.exe 'C:\Program Files\Yandex.Cloud\Cloud Desktop\'

    # create service
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

    ### Agent startup outside Cloud Desktop environment will fail - thus no need to do it right after install during image prepare stage 
    # Start-Service $ServiceName

    # create firewall rule
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

    ```bash
     $outNull = New-Item -Path "C:\Scripts" -ItemType Directory -Force -ErrorAction SilentlyContinue

    # Debug for 2025/11
    $Debug = Get-Item C:\Scripts | Select Attributes

    # Fix for Win24h2/11
    if($Debug.Attributes -ne "Directory") {
        $outNull = Remove-Item -Path "C:\Scripts" -Force -Confirm:$false
        Start-Sleep 2
        $outNull = New-Item -Path "C:\Scripts" -ItemType Directory -Force -Confirm:$false
    } 
    & schtasks /Create /TN "SetNetSettings" /RU System /SC ONSTART /RL HIGHEST /TR "Powershell -NoProfile -ExecutionPolicy Bypass -File \`"C:\Scripts\SetNetAdapterSettings.ps1`"" | Out-Null 
    ```

1. In the `C:\Scripts` folder, create a file named `SetNetAdapterSettings.ps1` with the contents as follows:
  
    ```bash
    # Getting IPv6 Net Adapter
    $IPv6Adapter = Get-NetAdapter | where {$_.Linklayeraddress -like "D0-1D*"}

    if($IPv6Adapter) {
        if((Get-NetAdapterBinding -Name $IPv6Adapter.Name -ComponentID ms_tcpip).Enabled -eq "True") {
            $outNull = Set-NetAdapterBinding -Name $IPv6Adapter.Name -ComponentID ms_tcpip -Enabled $false -Confirm:$false
            Start-Sleep 5
        }
    }

    if(!$(Get-Service -DisplayName "Yandex Desktop Agent") -or !$(Get-Item -Path "C:\Program Files\Yandex.Cloud\Cloud Desktop\desktopagent.exe" -ErrorAction SilentlyContinue)) {
        Invoke-WebRequest 'https://storage.yandexcloud.net/vdi-agent-internal/install.ps1' -OutFile "$($Env:temp)\install.ps1"
        cd $($Env:temp)
        Powershell.exe -ExecutionPolicy Bypass -File .\install.ps1
        mkdir "C:\Program Files\Yandex.Cloud\Cloud Desktop\"
        cp .\desktopagentInstall\desktopagent.exe 'C:\Program Files\Yandex.Cloud\Cloud Desktop\'

        # create service
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

        # create firewall rule
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
    ```

## Installing Cloudbase-Init {#cloudbase-init}

You can install [Cloudbase-Init](https://cloudbase.it/cloudbase-init/) to the image you prepared. When using an image in {{ cloud-desktop-name }}, this service automatically expands the file system and OS boot partition to the boot disk's actual size.

To install Cloudbase-Init, run these PowerShell commands:

```powershell
# Install cloudbase-init
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

1. Optionally, [generalize your image](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/sysprep--generalize--a-windows-installation) with the help of the `Sysrep` utility. This will prepare Windows for cloning and for later use on other computers.

1. Turn off the VM.

The result will be a disk image file named `image.qcow2` in QCOW2 format.


## Adding an image to {{ compute-name }} {#image-to-compute}

1. [Upload the image](../../../storage/operations/objects/upload.md) to {{ objstorage-name }}.
1. [Copy a link](../../../storage/operations/objects/link-for-download.md) to the uploaded image.
1. [Import the image](../../../compute/operations/image-create/upload.md) to {{ compute-name }}.
   
    If using the [YC CLI](../../../cli/quickstart.md), you can import the image by running the following command:

    ```bash
    yc compute image create --name <image name> --description <image description> --os-type windows --source-uri <link to image in Object Storage>
    ```

1. Check the image you added:
   1. [Create a VM](../../../compute/operations/vm-create/create-from-user-image.md) from the image.

      When you start a VM in the cloud from an image for the first time, it may take longer than a normal OS boot. If the VM is unavailable over the network for more than 20 minutes, reboot the VM and try to reconnect.

   1. Connect to the VM over RDP.


## Adding an image to {{ cloud-desktop-name }} {##image-to-desktop}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.vdi.label_desktop-images }}**.
  1. Click **{{ ui-key.yacloud.vdi.button_add-image }}**.
  1. In the **{{ ui-key.yacloud.vdi.label_image-source }}** field, select `{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}`.
  1. In the **{{ ui-key.yacloud.vdi.label_image }}** field, select the image you added earlier.
  1. Specify the image name.
  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Once the image is created, you can use it as a boot disk image for desktop groups.

If you are not using Cloudbase-Init and you want to resize the boot disk in a desktop group for it to differ in size from the original image:

1. Increase the boot disk file system size on your desktop, e.g., using the `diskmgmt.msc` utility.

1. [Create a new {{ cloud-desktop-name }} image](create-from-desktop.md) from that desktop.