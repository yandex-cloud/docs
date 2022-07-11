# Creating a Windows Server-based product image to upload to {{ marketplace-name }}

To add a product for {{ compute-full-name }} to the Marketplace, you need to upload the image to {{ yandex-cloud }}. You can create products for {{ compute-full-name }} that run on Linux and Windows Server. This section will help you create an image based on Windows Server. To create a Linux-based image, follow the instructions [{#T}](create-image.md).

If you wish to add a product for {{ managed-k8s-full-name }}, follow the [relevant instructions](create-container.md).

## Creating a VM {#create}

To create your Windows Server-based product images, use basic images from the [public folder](../../compute/operations/images-with-pre-installed-software/get-list.md). They are already prepared to run in {{ yandex-cloud }}.

If you don't have a VM that you would like to use as your basic VM, [create](../../compute/operations/vm-create/create-windows-vm.md) one.

## General recommendations for creating images {#advices}

* Install the applications before launching the [`sysprep` utility]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Sysprep){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Sysprep){% endif %}, if they support this.
* If `sysprep` affects an installed application, but the effects can be fixed, use [SetupComplete](#setupcomplete) or [TaskScheduler](#taskscheduler) to set up the application when you run the OS environment for the first time.
* If an application can't be installed before running `sysprep` and the startup configuration doesn't help, use SetupComplete or TaskScheduler to install the application the first time the OS environment starts up.
* To make sure that your image is available from an external network, use SetupComplete or TaskScheduler to set `passwordneverexpires` for your local admin account. The password can't be reset from outside the VM.

## Image requirements {#requirements}

After you install the applications, make sure that the image you are creating still meets the following requirements:

* The image has the `cloudbase-init` utility installed and configured to work with our [metadata service](../../compute/operations/vm-info/get-info.md#inside-instance), as well as the `virtIO` drivers for network and disk devices.
* RDP protocol is enabled in the system registry.
* In the system firewall settings, be sure to open ports used by your applications. Make sure to create rules allowing ICMP and WinRM packets over HTTPS. Besides that, configure rules to allow RDP protocol and open a port for RDP (TCP port 3389 by default).

For a complete list of basic image transformations, see [Changes to Windows VM images](../../microsoft/list-of-instances.md#changes).

## Preparing the image for deployment {#preparing-image}

Before uploading an image to Marketplace, prepare the image using the `sysprep` utility and clear it once more of temporary files and personal data.

### Preparing the answer file {#preparing-file}

Each Windows version has its own `sysprep` copy installed. Run the local utility found in `$env:SystemRoot\System32\Sysprep\Sysprep.exe` with the options `/oobe /generalize /quiet /quit /unattend:<unattend_answer_file_path>`, where `<unattend_answer_file_path>` is the path to the [answer file]({{ ms.docs }}/windows-hardware/manufacture/desktop/use-answer-files-with-sysprep). You need an answer file to configure and automate OS depersonalization. If at `sysprep` launch you do not specify an explicit path to an answer file, the utility will attempt to find a previous answer file in the cache or run without it. Launching `sysprep` without an answer file may damage the image you prepared.

{% cut "Sample contents of the answer file" %}

```xml
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
    <settings pass="generalize">
        <component name="Microsoft-Windows-PnpSysprep" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <PersistAllDeviceInstalls>true</PersistAllDeviceInstalls>
        </component>
    </settings>
    <settings pass="oobeSystem">
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
            <OOBE>
                <HideEULAPage>true</HideEULAPage>
                <HideLocalAccountScreen>true</HideLocalAccountScreen>
                <HideOEMRegistrationScreen>true</HideOEMRegistrationScreen>
                <HideOnlineAccountScreens>true</HideOnlineAccountScreens>
                <HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
                <NetworkLocation>Work</NetworkLocation>
                <ProtectYourPC>1</ProtectYourPC>
                <SkipMachineOOBE>true</SkipMachineOOBE>
                <SkipUserOOBE>true</SkipUserOOBE>
            </OOBE>
            <TimeZone>UTC</TimeZone>
        </component>
    </settings>
    <settings pass="specialize">
        <component name="Microsoft-Windows-Deployment" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <RunSynchronous>
                <RunSynchronousCommand wcm:action="add">
                    <Order>1</Order>
                    <Path>cmd.exe /c ""C:\Program Files\Cloudbase Solutions\Cloudbase-Init\Python\Scripts\cloudbase-init.exe" --config-file "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init-unattend.conf" &amp;&amp; exit 1 || exit 2"</Path>
                    <Description>Run Cloudbase-Init to set the hostname</Description>
                </RunSynchronousCommand>
            </RunSynchronous>
        </component>
    </settings>
</unattend>  
```

{% endcut %}

The above example of the answer file:
* Preserves installed drivers that are not included in the OS distribution package.
* Includes answers for the [OOBE](https://en.wikipedia.org/wiki/Out-of-box_experience) (Out-of-box Experience is an initial system configuration tool that requests answers immediately on Windows installation).
* Includes settings to run the [cloubase-init](https://cloudbase-init.readthedocs.io/en/latest/tutorial.html) utility which automates configuring of the first OS startup.

You might need to run a powershell script at the _specialize_ stage of the setup process. To do this, use the section:

```xml
    <settings pass="specialize">
        <component name="Microsoft-Windows-Deployment" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <RunSynchronous>
                <RunSynchronousCommand wcm:action="add">
                    <Order>1</Order>
                    <Path>%WinDir%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -NoLogo -ExecutionPolicy Unrestricted -File c:\example\script\path.ps1</Path>
                </RunSynchronousCommand>
            </RunSynchronous>
        </component>
    </settings>
```

Steps of a stage can be described as either synchronous or asynchronous actions. For more information about the methods of running commands, see Microsoft's [official documentation](https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-deployment-runsynchronous).

{% note info %}

At the _specialize_ stage, actions are run in a restricted environment. For example, you can't control the firewall from a powershell script.

{% endnote %}

### Running sysprep {#run-sysprep}

1. Before running `sysprep`, delete the previous tag file:

   ```powershell
   if (Test-Path "C:\Windows\System32\Sysprep\Sysprep_succeeded.tag") {
     "Found sysprep succeeded tag, removing it" | Out-Default
     rm "C:\Windows\System32\Sysprep\Sysprep_succeeded.tag" -Confirm:$false -ea:Stop
   }
   ```

1. Run `sysprep` and wait for the `IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE` state.

   ```powershell
   & $env:SystemRoot\System32\Sysprep\Sysprep.exe /oobe /generalize /quiet /quit /unattend:"<path to the answer file>"
   while ($true) {
     Start-Sleep -s 5
     $ImageState = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State" | `
       Select-Object -ExpandProperty ImageState    
     $ImageState | Out-Default
     if($ImageState -eq 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { break }
   }
   ```

1. Locate the tag file created in the previous stage to make sure that the OS is ready to reboot:

   ```powershell
   while ( -not (Test-Path $global:__SETUP_SYSPREP_TAG) ) {
     "Sysprep succeeded tag not yet exist, wait 5s..." | Out-Default
     Start-Sleep -s 5
   }
   ```

1. Shut down the OS after the last logs are recorded:

   ```powershell
   & shutdown /s /t 0
   ```

### Final OS setup {#advanced-configure}

After running `sysprep`, you may need to additionally configure your image, especially if your applications aren't running as expected.

#### SetupComplete {#setupcomplete}

After `sysprep` ends, Windows boots with a full-fledged environment. At the initial run, the OS will search for the `$env:SystemRoot\Setup\Scripts\SetupComplete.cmd` file to execute it. You can use it to set up your image ([example](https://github.com/yandex-cloud/examples/tree/master/packer-ansible-windows/setup_complete)).

#### TaskScheduler {#taskscheduler}

TaskScheduler might also be useful when configuring an image.

For example, the following command will create a script execution task in the `user-data` field of the `metadata` service:

```powershell
& schtasks /Create /TN "userdata" /RU SYSTEM /SC ONSTART /RL HIGHEST /TR "Powershell -NoProfile -ExecutionPolicy Bypass -Command \`"& {iex (irm -H @{\\\`"Metadata-Flavor\\\`"=\\\`"Google\\\`"} \\\`"http://169.254.169.254/computeMetadata/v1/instance/attributes/user-data\\\`")}\`"" | Out-Null
```

## Creating an image {#create-image}

Create an image from the VM's boot disk.

{% list tabs %}

- CLI

   ```powershell
     yc compute image create `
     --name             my_image_for_marketplace `
     --source-disk-name my_bootdisk_of_my_instance
   ```

{% endlist %}
