# Deploying Microsoft Exchange


{% include [ms-disclaimer](../../_includes/ms-disclaimer.md) %}



This tutorial describes how to deploy Microsoft Exchange servers in {{ yandex-cloud }}. You will install two Microsoft Exchange mail servers, two Active Directory servers, and two Edge Transport servers in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones. A network load balancer will distribute load across the servers. To manage the servers, you will use a separate VM with internet access hosted in the `{{ region-id }}-d` availability zone.

1. [Get your cloud ready](#before-you-begin).
1. [Create a cloud network and subnets](#create-network).
1. [Create a script to manage a local administrator account](#admin-script).
1. [Create a VM for Active Directory](#ad-vm).
1. [Create a VM for File Share Witness](#ad-fsw-vm).
1. [Install and configure Active Directory](#install-ad).
1. [Configure the second domain controller](#install-ad-2).
1. [Install Microsoft Exchange](#install-exchange).
1. [Set up Microsoft Exchange servers](#create-ms-exchange-servers).
1. [Create a database availability group](#create-dag).
1. [Configure Client Access](#configure-access).
1. [Configure a network load balancer](#set-up-load-balancer).
1. [Configure accepted domains and the email address policy](#set-up-accepted-domains).
1. [Create and configure a VM for Edge Transport servers](#create-edge-vm).
1. [Configure Edge Transport servers](#set-up-edge-transport).
1. [Add Edge Transport servers to Exchange](#add-edges-to-exchange).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [ms-additional-data-note](../_tutorials_includes/ms-additional-data-note.md) %}

### Required paid resources {#paid-resources}

The cost of running a Microsoft Exchange instance includes:

* Fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for load balancing (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).
* Fee for using dynamic or static public IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for {{ yandex-cloud }} outbound internet traffic (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

## Create a cloud network and subnets {#create-network}

Create a cloud network named `exchange-network` with subnets in all availability zones that will host your VMs.

1. Create a cloud network:

   {% list tabs group=instructions %}

   - Management console {#console}

     To create a [cloud network](../../vpc/concepts/network.md):

     1. Open the **{{ vpc-name }}** section in the folder where you want to create a cloud network.
     1. Click **Create network**.
     1. Specify `exchange-network` as the network name.
     1. Click **Create network**.

   - CLI {#cli}

     To create a cloud network, run this command:

     ```
     yc vpc network create --name exchange-network
     ```

   {% endlist %}

1. Create three subnets in `exchange-network`:

   {% list tabs group=instructions %}

   - Management console {#console}

      To create a subnet:

      1. Open the **{{ vpc-name }}** section in the folder where you want to create a subnet.
      1. Click the name of your cloud network.
      1. Click **Add subnet**.
      1. Specify `exchange-subnet-a` as the name and select the `{{ region-id }}-a` availability zone from the drop-down list.
      1. Enter the subnet CIDR: IP address and subnet mask `10.1.0.0/16`. For more information about IP address ranges, see [Cloud networks and subnets](../../vpc/concepts/network.md).
      1. Click **Create subnet**.

      Repeat these steps for two more subnets, `exchange-subnet-b` and `exchange-subnet-d`, in the `{{ region-id }}-b` and `{{ region-id }}-d` availability zones with `10.2.0.0/16` and `10.3.0.0/16` as the CIDR, respectively.

   - CLI {#cli}

      To create subnets, run these commands:

      ```
      yc vpc subnet create \
        --name exchange-subnet-a \
        --zone {{ region-id }}-a \
        --network-name exchange-network \
        --range 10.1.0.0/16

      yc vpc subnet create \
        --name exchange-subnet-b \
        --zone {{ region-id }}-b \
        --network-name exchange-network \
        --range 10.2.0.0/16

      yc vpc subnet create \
        --name exchange-subnet-d \
        --zone {{ region-id }}-d \
        --network-name exchange-network \
        --range 10.3.0.0/16
      ```

   {% endlist %}


## Create a script to manage a local administrator account {#admin-script}

Create a file named `setpass` with a script that will set a password for the local administrator account when you create VMs via the CLI:

```
#ps1
Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<your_password>" -AsPlainText -Force)
```

The password must meet the [complexity requirements]({{ ms.docs }}/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#reference).

To learn about the best practices for securing Active Directory, see [this MS article]({{ ms.docs }}/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

## Create a VM for Active Directory {#ad-vm}

Create two virtual machines for Active Directory. These VMs will not have internet access.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the folder dashboard in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
      * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create }}** in the window that opens.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then, the **Windows Server 2016 Datacenter** image from the list below. For more information on how to upload your own image for Microsoft products, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, set `50 {{ ui-key.yacloud.common.units.label_gigabyte }}` as your boot [disk](../../compute/concepts/disk.md) size.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and RAM size:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, specify:

      * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `exchange-subnet-a`.
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `ad-vm-a`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

  Repeat these steps for `ad-vm-b` in the `{{ region-id }}-b` availability zone and connect it to `exchange-subnet-b`.

- CLI {#cli}

  ```
  yc compute instance create \
    --name ad-vm-a \
    --hostname ad-vm-a \
    --memory 8 \
    --cores 4 \
    --zone {{ region-id }}-a \
    --network-interface subnet-name=exchange-subnet-a,ipv4-address=10.1.0.3 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
    --metadata-from-file user-data=setpass

  yc compute instance create \
    --name ad-vm-b \
    --hostname ad-vm-b \
    --memory 8 \
    --cores 4 \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=exchange-subnet-b,ipv4-address=10.2.0.3 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
    --metadata-from-file user-data=setpass
  ```

  {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

{% endlist %}

## Create a VM for File Share Witness {#ad-fsw-vm}

You will use a file server with internet access to configure VMs with Active Directory.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the folder dashboard in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
      * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create }}** in the window that opens.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then, the **Windows Server 2016 Datacenter** image from the list below. For more information on how to upload your own image for Microsoft products, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, set `50 {{ ui-key.yacloud.common.units.label_gigabyte }}` as your boot disk size.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
  
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `exchange-subnet-d`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, leave `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `fsw-vm`.

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

- CLI {#cli}

  ```
  yc compute instance create \
    --name fsw-vm \
    --hostname fsw-vm \
    --memory 4 \
    --cores 2 \
    --zone {{ region-id }}-d \
    --network-interface subnet-name=exchange-subnet-d,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
    --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Install and configure Active Directory {#install-ad}

Active Directory VMs do not have internet access. To configure them, use `fsw-vm` through RDP.

1. Connect to `fsw-vm` through [RDP](../../compute/operations/vm-connect/rdp.md). Use `Administrator` as your username and enter your password.
1. On `fsw-vm`, run RDP and connect to `ad-vm-a`. Use `Administrator` as your username and enter your password.
1. Run PowerShell on `ad-vm-a` and set a static address:

   ```powershell
   netsh interface ip set address "eth0" static 10.1.0.3 255.255.255.0 10.1.0.1
   ```

1. Create a temporary folder:

   ```powershell
   mkdir C:\Windows\temp
   ```

1. Assign Active Directory roles:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
   ```

   Result:

   ```powershell
   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    No             Success        {Active Directory Domain Services, Group P...
   ```

1. Create an Active Directory forest:

   ```powershell
   Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
   ```

   Windows will restart automatically. After the reboot, connect to `ad-vm-a` using the `yantoso\Administrator` account and your password. Relaunch PowerShell.

1. Rename the default site to `{{ region-id }}-a`:

   ```powershell
   Get-ADReplicationSite 'Default-First-Site-Name' | Rename-ADObject -NewName '{{ region-id }}-a'
   ```

1. Create two more sites for the other availability zones:

   ```powershell
   New-ADReplicationSite '{{ region-id }}-b'
   New-ADReplicationSite '{{ region-id }}-d'
   ```

1. Create subnets and link them to the sites:

   ```powershell
   New-ADReplicationSubnet -Name '10.1.0.0/16' -Site '{{ region-id }}-a'
   New-ADReplicationSubnet -Name '10.2.0.0/16' -Site '{{ region-id }}-b'
   New-ADReplicationSubnet -Name '10.3.0.0/16' -Site '{{ region-id }}-d'
   ```

1. Rename the site link and configure replication:

   ```powershell
   Get-ADReplicationSiteLink 'DEFAULTIPSITELINK' | `
       Set-ADReplicationSiteLink -SitesIncluded @{Add='{{ region-id }}-b'} -ReplicationFrequencyInMinutes 15 -PassThru | `
       Set-ADObject -Replace @{options = $($_.options -bor 1)} -PassThru | `
       Rename-ADObject -NewName '{{ region-id }}'
   ```

1. Set the DNS server forwarder:

   ```powershell
   Set-DnsServerForwarder '10.1.0.2'
   ```

1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.2.0.3,127.0.0.1"
   ```

## Configure the second domain controller {#install-ad-2}

1. Connect to `fsw-vm` through [RDP](../../compute/operations/vm-connect/rdp.md). Use `Administrator` as your username and enter your password.
1. On `fsw-vm`, run RDP and connect to `ad-vm-b`. Use `Administrator` as your username and enter your password.
1. Create a temporary folder:

   ```
   mkdir C:\Windows\temp
   ```

1. Assign Active Directory roles:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
   ```

   Result:

   ```powershell
   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    No             Success        {Active Directory Domain Services, Group P...
   ```

1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3,127.0.0.1"
   ```

1. Configure a static IP address:

   ```powershell
   netsh interface ip set address "eth0" static 10.2.0.3 255.255.255.0 10.2.0.1
   ```

1. Add the controller to the domain:

   ```powershell
   Install-ADDSDomainController `
       -Credential (Get-Credential "yantoso\Administrator") `
       -DomainName 'yantoso.net' `
       -Force:$true
   ```

   Windows will restart automatically. After the reboot, connect to `ad-vm-b` using the `yantoso\Administrator` account and your password. Relaunch PowerShell.

1. Set the DNS server forwarder:

   ```powershell
   Set-DnsServerForwarder '10.2.0.2'
   ```

## Install Microsoft Exchange {#install-exchange}

1. Connect to `fsw-vm` using RDP and run PowerShell.
1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3,10.2.0.3"
   ```

1. Add the server to the domain:

   ```powershell
   $Credentials = Get-Credential # yantoso\Administrator
   Add-Computer -DomainName yantoso.net -DomainCredential $Credentials -Force -Restart
   ```

   Windows will restart automatically. After the reboot, connect to `fsw-vm` using the `yantoso\Administrator` account and your password. Relaunch PowerShell.

1. Create the `distrib` folder:

   ```powershell
   mkdir c:\distrib
   ```

1. Download the [Exchange Server distribution](https://www.microsoft.com/en-us/download/confirmation.aspx?id=58395) kit and required dependencies:
   1. [.NET Framework 4.7.2](https://go.microsoft.com/fwlink/p/?linkid=863265).
   1. [Visual C++ Redistributable Package for Visual Studio 2012](https://go.microsoft.com/fwlink/?linkid=327788). Rename the downloaded file to `vcredist_x64_2012.exe`.
   1. [Visual C++ Redistributable Package for Visual Studio 2013](https://go.microsoft.com/fwlink/?linkid=2002913). Rename the downloaded file to `vcredist_x64_2013.exe`.
   1. [Microsoft Unified Communications Managed API 4.0, Core Runtime 64-bit](https://go.microsoft.com/fwlink/p/?linkId=258269).

   Place the distribution kits in the `C:\distrib` directory.

1. Grant shared access from the domain to the distribution directory:

   ```powershell
   New-SmbShare -ReadAccess 'yantoso\domain users' -Path 'c:\distrib' -Name 'distrib'
   ```

## Set up Microsoft Exchange servers {#create-ms-exchange-servers}

### Set up the first Exchange server {#create-exchange-vm-a}

1. Create a VM named `vm-exchange-a`:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. On the folder dashboard in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

         * Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
         * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create }}** in the window that opens.
         * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then, the **Windows Server 2016 Datacenter** image from the list below. For more information on how to upload your own image for Microsoft products, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
         * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
         * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

     1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:

         * Set the boot [disk](../../compute/concepts/disk.md) size: `100 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
         * Click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}** and add another `250 {{ ui-key.yacloud.common.units.label_gigabyte }}` SSD named `db-a`.

     1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

         * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
         * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `8`.
         * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
         * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `32 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

     1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, specify:

         * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `exchange-subnet-a`.
         * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.

     1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vm-exchange-a`.
     1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

     {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

   - CLI {#cli}

     ```
     yc compute instance create \
       --name vm-exchange-a \
       --hostname vm-exchange-a \
       --memory 32 \
       --cores 8 \
       --zone {{ region-id }}-a \
       --network-interface subnet-name=exchange-subnet-a \
       --create-boot-disk size=100,image-folder-id=standard-images,image-family=windows-2016-gvlk \
       --create-disk type=network-ssd,size=250,auto-delete=false \
       --metadata-from-file user-data=setpass
     ```

   {% endlist %}

1. Connect to `fsw-vm` through RDP.
1. Run RDP on `fsw-vm` and connect to `vm-exchange-a`. Use `Administrator` as your username and enter your password. Launch PowerShell.
1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3"
   ```

1. Add `vm-exchange-a` to the domain:

   ```powershell
   $Credentials = Get-Credential # yantoso\Administrator
   Add-Computer -DomainName yantoso.net -DomainCredential $Credentials -Force -Restart
   ```

   After the reboot, log in to the VM with the `yantoso\Administrator` account and your password. Relaunch PowerShell.

1. Install the downloaded dependencies in the following order:
   1. `& \\fsw-vm\distrib\vcredist_x64_2012.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\vcredist_x64_2013.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\UcmaRuntimeSetup.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart`
1. Restart the VM: `Restart-Computer -Force`.

   After the reboot, log in to the VM with the `yantoso\Administrator` account and your password. Relaunch PowerShell.

1. Install Exchange Mailbox Server on `vm-exchange-a`. Mount the distribution image from the shared folder containing the distribution kits:

   ```powershell
   Mount-DiskImage \\fsw-vm\distrib\ExchangeServer2016-x64-cu13.iso
   ```

1. Install Exchange Mailbox Server:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:Mailbox /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   Restart-Computer -Force
   ```

   After the installation is complete, the VM will restart automatically.

### Create the second Exchange server {#create-exchange-vm-b}

1. Create a VM named `vm-exchange-b`:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. On the folder dashboard in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

         * Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
         * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create }}** in the window that opens.
         * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then, the **Windows Server 2016 Datacenter** image from the list below. For more information on how to upload your own image for Microsoft products, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
         * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
         * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
     1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-b` [availability zone](../../overview/concepts/geo-scope.md).
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:

         * Set the boot [disk](../../compute/concepts/disk.md) size: `100 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
         * Click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}** and add another `250 {{ ui-key.yacloud.common.units.label_gigabyte }}` SSD named `db-b`.

     1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

         * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
         * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `8`.
         * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
         * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `32 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

     1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, specify:

         * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `exchange-subnet-b`.
         * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.

     1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vm-exchange-b`.
     1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

     {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

   - CLI {#cli}

     ```
     yc compute instance create \
       --name vm-exchange-b \
       --hostname vm-exchange-b \
       --memory 32 \
       --cores 8 \
       --zone {{ region-id }}-b \
       --network-interface subnet-name=exchange-subnet-b \
       --create-boot-disk size=100,image-folder-id=standard-images,image-family=windows-2016-gvlk \
       --create-disk type=network-ssd,size=250,auto-delete=false \
       --metadata-from-file user-data=setpass
     ```

   {% endlist %}

1. Connect to `fsw-vm` through RDP.
1. Run RDP on `fsw-vm` and connect to `vm-exchange-b`. Use `Administrator` as your username and enter your password. Launch PowerShell.
1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3"
   ```

1. Add `vm-exchange-a` to the domain:

   ```powershell
   $Credentials = Get-Credential # yantoso\Administrator
   Add-Computer -DomainName yantoso.net -DomainCredential $Credentials -Force -Restart
   ```

   After the reboot, log in to the VM with the `yantoso\Administrator` account and your password. Relaunch PowerShell.

1. Install the downloaded dependencies in the following order:
   1. `& \\fsw-vm\distrib\vcredist_x64_2012.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\vcredist_x64_2013.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\UcmaRuntimeSetup.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart`

1. Restart the VM: `Restart-Computer -Force`.

   After the reboot, log in to the VM with the `yantoso\Administrator` account and your password. Relaunch PowerShell.

1. Install Exchange Mailbox Server on `vm-exchange-b`. Mount the distribution image from the shared folder containing the distribution kits:

   ```powershell
   Mount-DiskImage \\fsw-vm\distrib\ExchangeServer2016-x64-cu13.iso
   ```

1. Install Exchange Mailbox Server:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:Mailbox /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   Restart-Computer -Force
   ```

   After the installation is complete, the VM will restart automatically.

## Create a database availability group {#create-dag}

A database availability group ensures fault tolerance for mailbox servers via DB replication and automatic DB failover in the event of a crash.

1. Connect to `fsw-vm` through RDP.
1. Grant the `yantoso\Exchange Trusted Subsystem` group administrator permissions for `fsw-vm`:

   ```powershell
   Add-LocalGroupMember -Group 'Administrators' -Member 'yantoso\Exchange Trusted Subsystem'
   ```

### Create disks for VM databases {#create-db-disks}

1. Run RDP on `fsw-vm` and connect to `vm-exchange-a`. Use `yantoso\Administrator` as your username and enter your password.
1. Create a secondary disk and format it:

   ```powershell
   Get-Disk | `
       Where-Object PartitionStyle -eq raw | `
       Initialize-Disk -PartitionStyle GPT -PassThru | `
       New-Partition -DriveLetter 'Z' -UseMaximumSize | `
       Format-Volume -FileSystem NTFS -NewFileSystemLabel "mdb" -Confirm:$false -AllocationUnitSize 65536
   ```

1. Install the `Failover-Clustering` role:

   ```powershell
   Install-WindowsFeature -Name 'Failover-Clustering' -IncludeManagementTools
   ```

Repeat these commands for `vm-exchange-b`.

### Configure the database availability group {#dag-configuration}

1. Run RDP on `fsw-vm` and connect to `vm-exchange-a` through RDP. Use `yantoso\Administrator` as your username and enter your password.
1. Run the Exchange Management Shell.
1. Create a database availability group:

   ```powershell
   New-DatabaseAvailabilityGroup `
       -Name ycdag `
       -WitnessServer fsw-vm `
       -DatabaseAvailabilityGroupIpAddresses 255.255.255.255
   ```

1. Add the `vm-exchange-a` and `vm-exchange-b` servers to the DAG:

   ```powershell
   Add-DatabaseAvailabilityGroupServer -Identity ycdag -MailboxServer vm-exchange-a
   Add-DatabaseAvailabilityGroupServer -Identity ycdag -MailboxServer vm-exchange-b
   ```

1. Check the status of your servers; both should be in the `Operational Servers` column:

   ```powershell
   Get-DatabaseAvailabilityGroup -Status
   ```

   Result:

   ```powershell
   Name             Member Servers                                      Operational Servers
   ----             --------------                                      -------------------
   ycdag            {VM-EXCHANGE-A, VM-EXCHANGE-B}                    {VM-EXCHANGE-A, VM-EXCHANGE-B}
   ```

1. Create a mailbox server database:

   ```powershell
   New-MailboxDatabase -Name yamdb -EdbFilePath 'Z:\MDB\yamdb\yamdb.edb' -LogFolderPath 'Z:\MDB\yamdb\log' -Server vm-exchange-a
   ```

1. Mount this database:

   ```powershell
   Mount-Database yamdb
   ```

1. Create a copy of this database on the second server:

   ```powershell
   Add-MailboxDatabaseCopy -Identity yamdb -MailboxServer vm-exchange-b -SeedingPostponed
   Update-MailboxDatabasecopy yamdb\vm-exchange-b –CatalogOnly
   ```

1. Check the DB status:

   ```powershell
   Get-MailboxDatabaseCopyStatus -Server vm-exchange-a
   Get-MailboxDatabaseCopyStatus -Server vm-exchange-b
   ```

## Configure Client Access {#configure-access}

To work with various client applications, you need to create virtual directories.

1. Set the mail domain:

   ```powershell
   $MailDomain = "mail.yantoso.net"
   ```

1. ECP:

   ```powershell
   Get-EcpVirtualDirectory | Set-EcpVirtualDirectory -ExternalUrl "https://$MailDomain/ecp"
   ```

1. EWS:

   ```powershell
   Get-WebServicesVirtualDirectory | Set-WebServicesVirtualDirectory -ExternalUrl "https://$MailDomain/ews/exchange.asmx"
   ```

1. Active Sync:

   ```powershell
   Get-ActiveSyncVirtualDirectory | Set-ActiveSyncVirtualDirectory -ExternalUrl "https://$MailDomain/Microsoft-Server-ActiveSync"
   ```

1. OAB:

   ```powershell
   Get-OabVirtualDirectory | Set-OabVirtualDirectory -ExternalUrl "https://$MailDomain/OAB"
   ```

1. OWA:

   ```powershell
   Get-OwaVirtualDirectory | Set-OwaVirtualDirectory -ExternalUrl "https://$MailDomain/owa"
   ```

1. PowerShell:

   ```powershell
   Get-PowerShellVirtualDirectory | Set-PowerShellVirtualDirectory -ExternalUrl "https://$MailDomain/powershell"
   ```

1. MAPI:

   ```powershell
   Get-MapiVirtualDirectory | Set-MapiVirtualDirectory -ExternalUrl "https://$MailDomain/mapi"
   ```

## Configure a network load balancer {#set-up-load-balancer}

It will distribute the load across the Exchange servers in various availability zones.

{% list tabs group=instructions %}

- Management console {#console}

  To create a [network load balancer](../../network-load-balancer/concepts/index.md):

  1. Open the **Load Balancer** section in the folder where you want to create a load balancer.
  1. Click **Create network load balancer**.
  1. Enter the load balancer name: `exchange-lb`.
  1. In the **Public address** field, select **Auto**.
  1. Click **Add listener** under **Listeners**.
  1. Enter the listener name: `yassl`.
  1. Set `443` as the listener port and target port and click **Add**.
  1. Under **Target groups**, click **Add target group**.
  1. In the **Target group** field, open the drop-down list and select **Create target group**.
  1. Enter `exchange-tg` as the target group name.
  1. Select `vm-exchange-a` and `vm-exchange-b` and click **Create**.
  1. Click **Configure**.
  1. Enter `exchange-hc` as the health check name.
  1. Select the **TCP** check.
  1. Set the port to `443`.
  1. Leave the default values for the other properties and click **Apply**.
  1. Click **Create**.

- CLI {#cli}

  1. Create a network load balancer:

     ```
     yc lb nlb create --name exchange-lb
     ```

  1. Create a target group:

     ```
     yc lb tg create --name exchange-tg
     ```

  1. Get information about the mailbox servers:

     ```
     yc compute instance get vm-exchange-a
     yc compute instance get vm-exchange-b
     ```

     Copy the VM subnet IP addresses and IDs.

  1. Add the servers to the target group:

     ```
     yc lb tg update --name exchange-tg \
       --target address=<vm-exchange-a_IP_address>,subnet-id=<vm-exchange-a_subnet_ID> \
       --target address=<vm-exchange-b_IP_address>,subnet-id=<vm-exchange-b_subnet_ID>
     ```

  1. Add the listener to the network load balancer:

     ```
     yc lb nlb add-listener --name exchange-lb --listener name=yassl,port=443,target-port=443,external-ip-version=ipv4
     ```

  1. Get information about the target groups:

     ```
     yc lb tg list
     ```

     Copy the ID of the target group you created.

  1. Connect the target group to the network load balancer using the target group ID:

     ```
     yc lb nlb attach-target-group \
       --name exchange-lb \
       --target-group target-group-id=<target_group_ID>,healthcheck-name=exchange-hc,healthcheck-tcp-port=443
     ```

{% endlist %}

## Configure accepted domains and the email address policy {#set-up-accepted-domains}

By default, the system creates a domain for you. If you need to change the domain, use this command:

```powershell
New-AcceptedDomain -Name yantoso.net -DomainName yantoso.net
```

Edit the email address policy:

```powershell
Get-EmailAddressPolicy | Set-EmailAddressPolicy -EnabledPrimarySMTPAddressTemplate '@yantoso.net'
```

All new mailboxes will automatically get an alias with the `@yantoso.net` domain.

## Create a VM for Edge Transport servers {#create-edge-vm}

The Edge Transport servers will handle the primary user load, such as accepting emails from the internet, filtering out spam, and forwarding messages to internal Exchange mailbox servers.

### Create a VM for the `vm-edge-a` server {#create-edge-a}

Create a VM named `vm-edge-a`:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the folder dashboard in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
      * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create }}** in the window that opens.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then, the **Windows Server 2016 Datacenter** image from the list below. For more information on how to upload your own image for Microsoft products, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, set `50 {{ ui-key.yacloud.common.units.label_gigabyte }}` as your boot [disk](../../compute/concepts/disk.md) size.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and RAM size:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
  
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `exchange-subnet-a`.
      * Leave the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field set to `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` or select `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` and the public IP address from the list if you [reserved](../../vpc/operations/get-static-ip.md) one earlier.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vm-edge-a`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

- CLI {#cli}

  ```
  yc compute instance create \
    --name vm-edge-a \
    --hostname vm-edge-a \
    --memory 8 \
    --cores 4 \
    --zone {{ region-id }}-a \
    --network-interface subnet-name=exchange-subnet-a,nat-ip-version=ipv4 \
    --create-boot-disk size=50,image-folder-id=standard-images,image-family=windows-2016-gvlk \
    --metadata-from-file user-data=setpass
  ```

 {% endlist %}

### Create a VM for the vm-edge-b server {#create-edge-b}

Create a VM named `vm-edge-b`:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the folder dashboard in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
      * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create }}** in the window that opens.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then, the **Windows Server 2016 Datacenter** image from the list below. For more information on how to upload your own image for Microsoft products, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-b` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, set `50 {{ ui-key.yacloud.common.units.label_gigabyte }}` as your boot [disk](../../compute/concepts/disk.md) size.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and RAM size:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
  
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `exchange-subnet-b`.
      * Leave the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field set to `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` or select `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` and the public IP address from the list if you [reserved](../../vpc/operations/get-static-ip.md) one earlier.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vm-edge-b`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

- CLI {#cli}

  ```
  yc compute instance create \
    --name vm-edge-b \
    --hostname vm-edge-b \
    --memory 8 \
    --cores 4 \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=exchange-subnet-b,nat-ip-version=ipv4 \
    --create-boot-disk size=50,image-folder-id=standard-images,image-family=windows-2016-gvlk \
    --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Configure Edge Transport servers {#set-up-edge-transport}

### Configure the Edge Transport server in the {{ region-id }}-a zone {#edge-a}

1. Connect to `fsw-vm` through RDP.
1. Connect to `vm-edge-a` through RDP. Use `Administrator` as your username and enter your password. Launch PowerShell.
1. Create a temporary folder:

   ```
   mkdir C:\Windows\temp
   ```

1. Install the ADLDS roles on the server:

   ```powershell
   Install-WindowsFeature ADLDS
   ```

1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | `
       Set-DnsClientServerAddress -ServerAddresses "10.1.0.3,10.2.0.3"
   ```

1. Configure remote access to the distribution folder located on the `fsw-vm` server:

   ```powershell
   $Credential = Get-Credential # Username: yantoso\Administrator

   New-PSDrive -Name 'fsw-vm' -PSProvider:FileSystem -Root '\\fsw-vm.{{ region-id }}.internal\distrib' -Credential $Credential
   ```

   Enter `yantoso\Administrator` as your username and your password.

1. Install the dependencies:

   ```powershell
   & fsw-vm:\vcredist_x64_2012.exe /install /passive /norestart
   & fsw-vm:\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart
   ```

1. Copy the Microsoft Exchange distribution kit to the `vm-edge-a` server:

   ```powershell
   copy-item fsw-vm:\ExchangeServer2016-x64-cu13.iso c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Specify the primary DNS suffix:

   ```powershell
   $Suffix = '{{ region-id }}.internal'

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name Domain -Value $Suffix

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name 'NV Domain' -Value $Suffix
   ```

1. Restart the VM:

   ```powershell
   Restart-Computer -Force
   ```

   Reconnect to `vm-edge-a` through RDP and run PowerShell.

1. Mount the Exchange Server distribution kit:

   ```powershell
   Mount-DiskImage c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Install Edge Transport Server on the `vm-edge-a` server:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:EdgeTransport /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   ```

### Configure the Edge Transport server in the {{ region-id }}-b zone {#edge-b}

1. Connect to `fsw-vm` through RDP.
1. Connect to `vm-edge-b` through RDP. Use `Administrator` as your username and enter your password. Launch PowerShell.
1. Create a temporary folder:

   ```powershell
   mkdir C:\Windows\temp
   ```

1. Install the ADLDS roles on the server:

   ```powershell
   Install-WindowsFeature ADLDS
   ```

1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | `
       Set-DnsClientServerAddress -ServerAddresses "10.2.0.3,10.1.0.3"
   ```

1. Configure remote access to the distribution folder located on the `fsw-vm` server:

   ```powershell
   $Credential = Get-Credential # Username: yantoso\Administrator

   New-PSDrive -Name 'fsw-vm' -PSProvider:FileSystem -Root '\\fsw-vm.{{ region-id }}.internal\distrib' -Credential $Credential
   ```

   Enter `yantoso\Administrator` as your username and your password.

1. Install the dependencies:

   ```powershell
   & fsw-vm:\vcredist_x64_2012.exe /install /passive /norestart
   & fsw-vm:\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart
   ```

1. Copy the Microsoft Exchange distribution kit to the `vm-edge-b` server:

   ```powershell
   copy-item fsw-vm:\ExchangeServer2016-x64-cu13.iso c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Specify the primary DNS suffix:

   ```powershell
   $Suffix = '{{ region-id }}.internal'

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name Domain -Value $Suffix

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name 'NV Domain' -Value $Suffix
   ```

1. Restart the VM:

   ```powershell
   Restart-Computer -Force
   ```

   Reconnect to `vm-edge-b` through RDP and run PowerShell.

1. Mount the Exchange Server distribution kit:

   ```powershell
   Mount-DiskImage c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Install Edge Transport Server on the `vm-edge-b` server:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:EdgeTransport /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   ```

## Add the Edge Transport servers to Exchange {#add-edges-to-exchange}

Each Edge Transport server must subscribe to a site in its own availability zone.

### Set up a subscription on the `vm-edge-a` server {#subscribe-vm-edge-a}

1. Create the `subscribe` folder:

   ```powershell
   mkdir c:\subscribe
   ```

1. Run the Exchange Management Shell. Create a subscription file on the `vm-edge-a` server:

   ```powershell
   New-EdgeSubscription -FileName "C:\subscribe\$(hostname).xml"
   ```

1. Copy the `C:\subscribe\vm-edge-a.xml` file to the `vm-exchange-a` server, to the `C:\root\vm-edge-a.xml` folder.

1. Log in to the `vm-exchange-a` server and run the Exchange Management Shell.

1. Subscribe the `vm-edge-a` Edge Transport servers to the `{{ region-id }}-a` site:

   ```powershell
   New-EdgeSubscription -FileData ([byte[]]$(Get-Content -Path "C:\root\vm-edge-a.xml" -Encoding Byte -ReadCount 0)) -Site "{{ region-id }}-a"
   ```

1. Use this command to check the subscription:

   ```powershell
   Get-EdgeSubscription
   ```

   Result:

   ```powershell
   Name            Site                 Domain
   ----            ----                 ------
   vm-edge-a       yantoso.net/Confi... {{ region-id }}.internal
   ```

1. Check the sync status:

   ```powershell
   Test-EdgeSynchronization
   ```

   The `SyncStatus` parameter should change to `Normal`.


### Set up a subscription on the vm-edge-b server {#subscribe-vm-edge-b}

1. Create the `subscribe` folder:

   ```powershell
   mkdir c:\subscribe
   ```

1. Run the Exchange Management Shell. Create a subscription file on the `vm-edge-b` server:

   ```powershell
   New-EdgeSubscription -FileName "C:\subscribe\$(hostname).xml"
   ```

1. Copy the `C:\subscribe\vm-edge-b.xml` file to the `vm-exchange-b` server, to the `C:\root\vm-edge-b.xml` folder.

1. Log in to the `vm-exchange-b` server and run the Exchange Management Shell.

1. Subscribe the `vm-edge-b` Edge Transport servers to the `{{ region-id }}-b` site:

   ```powershell
   New-EdgeSubscription -FileData ([byte[]]$(Get-Content -Path "C:\root\vm-edge-b.xml" -Encoding Byte -ReadCount 0)) -Site "{{ region-id }}-b"
   ```

1. Make sure the subscription was created using this command:

   ```powershell
   Get-EdgeSubscription
   ```

   Result:

   ```powershell
   Name            Site                 Domain
   ----            ----                 ------
   vm-edge-a       yantoso.net/Confi... {{ region-id }}.internal
   vm-edge-b       yantoso.net/Confi... {{ region-id }}.internal
   ```

1. Check the sync status:

   ```powershell
   Test-EdgeSynchronization
   ```

   The `SyncStatus` parameter should change to `Normal`.

## How to delete the resources you created {#clear-out}

To stop paying for the deployed servers, delete all [VMs](../../compute/operations/vm-control/vm-delete.md) and the [load balancer](../../network-load-balancer/operations/load-balancer-delete.md):

* `fsw-vm`
* `ad-vm-a`
* `ad-vm-b`
* `vm-exchange-a`
* `vm-exchange-b`
* `vm-edge-a`
* `vm-edge-b`
* `exchange-lb` load balancer
