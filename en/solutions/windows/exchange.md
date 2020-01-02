# Deploying Microsoft Exchange

This scenario describes how to deploy Microsoft Exchange servers in Yandex.Cloud. The following Microsoft Exchange servers will be installed in `ru-central1-a` and `ru-central1-b` availability zones: two mail servers, two Active Directory servers, and two Edge Transport servers. A network load balancer is used to distribute load across servers. A separate VM with internet access in the `ru-central1-c` availability zone will manage all the servers.

1. Prepare for deployment:
   1. [Before you start](#before-begin)
   1. [Create a cloud network and subnets](#create-network)
   1. [Create a script to manage a local administrator account](#admin-script)
1. Install and configure Active Directory on a VM:
   1. [Create a VM for Active Directory](#ad-vm)
   1. [Create a VM for File Share Witness](#ad-fsw-vm)
   1. [Install and configure Active Directory](#install-ad)
   1. [Configure the second domain controller](#install-ad-2)
1. Install and configure Microsoft Exchange:
   1. [Install Microsoft Exchange](#install-exchange)
   1. [Create Microsoft Exchange servers](#create-ms-exchange-servers)
   1. [Create a Database Availability Group](#create-dag)
   1. [Create disks for VM databases](#create-db-disks)
   1. [Configure the Database Availability Group](#dag-configuration)
   1. [Configure Client Access](#configure-access)
1. [Configure the network load balancer](#set-up-load-balancer)
1. [Configure Accepted Domains and Email Address Policy](#set-up-AC-domains)
1. [Create and configure a VM for Edge Transport servers](#create-edge-vm)
   1. [Configure Edge Transport servers](#set-up-edge-transport)
   1. [Configure the Edge Transport server in the ru-central1-a zone](#edge-a)
   1. [Configure the Edge Transport server in the ru-central1-b zone](#edge-b)
   1. [Add Edge Transport servers to Exchange](#add-edges-to-exchange)
   1. [Set up a subscription on the vm-edge-a server](#subscribe-vm-edge-a)
   1. [Set up a subscription on the vm-edge-b server](#subscribe-vm-edge-b)
1. [Delete created cloud resources if you no longer need them](#clear-out)

## Before you start {#before-begin}

Before deploying servers, you need to sign up for Yandex.Cloud and create a billing account:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page](https://console.cloud.yandex.com/cloud).

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

The cost of a Microsoft Exchange installation includes:

* A fee for continuously running VMs (see [pricing {{ compute-full-name }}](../../compute/pricing.md)).
* A fee for load balancing (see [pricing {{ load-balancer-full-name }}](../../load-balancer/pricing.md)).
* A fee for using dynamic or static public IP addresses (see [pricing {{ vpc-full-name }}](../../vpc/pricing.md)).
* The cost of outgoing traffic from Yandex.Cloud to the internet (see [pricing {{ compute-full-name }}](../../compute/pricing.md)).

## Create a cloud network and subnets {#create-network}

Create a cloud network named `exchange-network` with subnets in all the availability zones where your VMs will be located.

1. Create a cloud network:

   {% list tabs %}

   - Management console

     To create a [cloud network](../../vpc/concepts/network.md):
     1. Open the **Virtual Private Cloud** section in the folder where you want to create the cloud network.
     1. Click **Create network.**
     1. Enter the network name: `exchange-network`.
     1. Click **Create network**.

   - CLI

     To create a cloud network, run the command:

     ```
     $ yc vpc network create --name exchange-network
     ```

   {% endlist %}

1. Create three `exchange-network` subnets:

   {% list tabs %}

     - Management console

       To create a subnet:
       1. Open the **Virtual Private Cloud** section in the folder where you want to create the subnet.
       1. Click on the name of the cloud network.
       1. Click **Add subnet**.
       1. Fill out the form: set the subnet name to `exchange-subnet-a` and select the `ru-central1-a` availability zone from the drop-down list.
       1. Enter the subnet CIDR, which is its IP address and mask: `10.1.0.0/16`. For more information about subnet IP ranges, see [Cloud networks and subnets](../../vpc/concepts/network.md).
       1. Click **Create subnet**.

       Repeat these steps for two more subnets, `exchange-subnet-b` and `exchange-subnet-c`, in the `ru-central1-b` and `ru-central1-c` availability zones with the `10.2.0.0/16` and `10.3.0.0/16` CIDR, respectively.

     - CLI

       To create subnets, run the following commands:

       ```
       yc vpc subnet create \
         --name exchange-subnet-a \
         --zone ru-central1-a \
         --network-name exchange-network \
         --range 10.1.0.0/16

       yc vpc subnet create \
         --name exchange-subnet-b \
         --zone ru-central1-b \
         --network-name exchange-network \
         --range 10.2.0.0/16

       yc vpc subnet create \
         --name exchange-subnet-c \
         --zone ru-central1-c \
         --network-name exchange-network \
         --range 10.3.0.0/16
       ```

   {% endlist %}

## Create a script to manage a local administrator account {#admin-script}

Create a file named `setpass` with a script that sets a password for the local administrator account when creating VMs via the CLI:

```
#ps1
Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<your password>" -AsPlainText -Force)
```

Your password must meet [complexity requirements](https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#reference).

Read more about Active Directory security practices on the [developer's website](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

## Create a VM for Active Directory {#ad-vm}

Create two virtual machines for Active Directory. These VMs don't have internet access.

{% list tabs %}

- Management console

  1. On the folder page in the [management console](https://console.cloud.yandex.com), click **Create resource** and select **Virtual machine**.

  1. In the **Name** field, enter the VM name `ad-vm-a`.

  1. Select [availability zone](../../overview/concepts/geo-scope.md) `ru-central1-a`.

  1. Under **Public images**, click **Select**. In the window that opens, select the **2016 Datacenter** image.

  1. Under **Disks**, enter 35 GB for the size of the boot disk.

  1. Under **Computing resources**:
      - Choose the [platform](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
      - Specify the number of vCPUs and amount of RAM:
         * **vCPU**: 4.
         * **Guaranteed vCPU share**: 100%.
         * **RAM**: 8 GB.

  1. Under **Network settings**, click **Add network** and select `exchange-network`. Select `exchange-subnet-a`. Under **Public address**, select **No address**.

  1. In the **Access** section, specify the data required to access the VM:
      - In the **Password** field, enter your password.

  1. Click **Create VM**.

  Repeat this operation for the VM `ad-vm-b` in the `ru-central1-a` availability zone and connect it to the subnet `exchange-subnet-b`

- CLI

  ```
  $ yc compute instance create \
      --name ad-vm-a \
      --hostname ad-vm-a \
      --memory 8 \
      --cores 4 \
      --zone ru-central1-a \
      --network-interface subnet-name=exchange-subnet-a,ipv4-address=10.1.0.3 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass

  $ yc compute instance create \
      --name ad-vm-b \
      --hostname ad-vm-b \
      --memory 8 \
      --cores 4 \
      --zone ru-central1-b \
      --network-interface subnet-name=exchange-subnet-b,ipv4-address=10.2.0.3 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Create a VM for File Share Witness {#ad-fsw-vm}

A file server with internet access is used to configure VMs with Active Directory.

{% list tabs %}

- Management console

  1. On the folder page in the [management console](https://console.cloud.yandex.com), click **Create resource** and select **Virtual machine**.

  1. In the **Name** field, enter the VM name: `fsw-vm`.

  1. Select [availability zone](../../overview/concepts/geo-scope.md) `ru-central1-c`.

  1. Under **Public images**, click **Select**. In the window that opens, select the **2016 Datacenter** image.

  1. Under **Disks**, enter 35 GB for the size of the boot disk.

  1. Under **Computing resources**:
      - Choose the [platform](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
      - Specify the number of vCPUs and amount of RAM:
         * **vCPU**: 2.
         * **Guaranteed vCPU share**: 100%.
         * **RAM**: 4 GB.

  1. Under **Network settings**, click **Add network** and select `exchange-network`. Select `exchange-subnet-c`. Under **Public address**, select **No address**.

  1. In the **Access** section, specify the data required to access the VM:
      - In the **Password** field, enter your password.

  1. Click **Create VM**.

- CLI

  ```
  $ yc compute instance create \
      --name fsw-vm \
      --hostname fsw-vm \
      --memory 4 \
      --cores 2 \
      --zone ru-central1-c \
      --network-interface subnet-name=exchange-subnet-c,nat-ip-version=ipv4 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Install and configure Active Directory {#install-ad}

VMs with Active Directory don't have internet access, so they should be configured from the `fsw-vm` VM using RDP.

1. Connect to `fsw-vm` [using RDP](../../compute/operations/vm-connect/rdp.md). Enter `Administrator` as the username and your password.

1. On `fsw-vm`, start the RDP client and connect to `ad-vm-a`. Enter `Administrator` as the username and your password.

1. On the `ad-vm-a` VM, launch PowerShell and set a static address:

   ```powershell
   netsh interface ip set address "Ethernet 2" static 10.1.0.3 255.255.255.0 10.1.0.1
   ```

1. Create a temporary folder:

   ```powershell
   mkdir C:\Windows\temp
   ```

1. Assign Active Directory roles:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    No             Success        {Active Directory Domain Services, Group P...
   ```

1. Create an Active Directory forest:

   ```powershell
   Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
   ```

   Windows restarts automatically. Reconnect to `ad-vm-a`. Enter `yantoso\Administrator` as the username and your password. Relaunch PowerShell.

1. Rename the default site to `ru-central1-a`:

   ```powershell
   Get-ADReplicationSite 'Default-First-Site-Name' | Rename-ADObject -NewName 'ru-central1-a'
   ```

1. Create two more sites for the other availability zones:

   ```powershell
   New-ADReplicationSite 'ru-central1-b'
   New-ADReplicationSite 'ru-central1-c'
   ```

1. Create subnets and link them to the sites:

   ```powershell
   New-ADReplicationSubnet -Name '10.1.0.0/16' -Site 'ru-central1-a'
   New-ADReplicationSubnet -Name '10.2.0.0/16' -Site 'ru-central1-b'
   New-ADReplicationSubnet -Name '10.3.0.0/16' -Site 'ru-central1-c'
   ```

1. Rename the site link and configure replication:

   ```powershell
   Get-ADReplicationSiteLink 'DEFAULTIPSITELINK' | `
       Set-ADReplicationSiteLink -SitesIncluded @{Add='ru-central1-b'} -ReplicationFrequencyInMinutes 15 -PassThru | `
       Set-ADObject -Replace @{options = $($_.options -bor 1)} -PassThru | `
       Rename-ADObject -NewName 'ru-central1'
   ```

1. Set the DNS redirect server:

   ```powershell
   Set-DnsServerForwarder '10.1.0.2'
   ```

1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.2.0.3,127.0.0.1"
   ```

## Configure the second domain controller {#install-ad-2}

1. Connect to `fsw-vm` [using RDP](../../compute/operations/vm-connect/rdp.md). Enter `Administrator` as the username and your password.

1. On `fsw-vm`, start the RDP client and connect to `ad-vm-b`. Enter `Administrator` as the username and your password.

1. Create a temporary folder:

   ```
   mkdir C:\Windows\temp
   ```

1. Assign Active Directory roles:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

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
   netsh interface ip set address "Ethernet 2" static 10.2.0.3 255.255.255.0 10.2.0.1
   ```

1. Add the controller to the domain:

   ```powershell
   Install-ADDSDomainController `
       -Credential (Get-Credential "yantoso\Administrator") `
       -DomainName 'yantoso.net' `
       -Force:$true
   ```

   Windows restarts automatically. Reconnect to `ad-vm-b`. Enter `yantoso\Administrator` as the username and your password. Relaunch PowerShell.

1. Set the DNS redirect server:

   ```powershell
   Set-DnsServerForwarder '10.2.0.2'
   ```

## Install Microsoft Exchange {#install-exchange}

1. Connect to `fsw-vm` using RDP and launch PowerShell.

1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3,10.2.0.3"
   ```

1. Add the server to the domain:

   ```powershell
   $Credentials = Get-Credential # yantoso\Administrator
   Add-Computer -DomainName yantoso.net -DomainCredential $Credentials -Force -Restart
   ```

   Windows restarts automatically. Reconnect to `fsw-vm`. Enter `yantoso\Administrator` as the username and your password. Relaunch PowerShell.

1. Create a folder named `distrib`:

   ```powershell
   mkdir c:\distrib
   ```

1. Download the [Exchange Server distribution](https://docs.microsoft.com/en-us/exchange/new-features/updates?view=exchserver-2016) and necessary dependencies:
   1. [.NET Framework 4.7.1](https://go.microsoft.com/fwlink/p/?linkid=863265).
   1. [Visual C++ Redistributable Package for Visual Studio 2012](https://go.microsoft.com/fwlink/?linkid=327788). Rename the downloaded file to `vcredist_x64_2012.exe`.
   1. [Visual C++ Redistributable Package for Visual Studio 2013](https://go.microsoft.com/fwlink/?linkid=2002913). Rename the downloaded file to `vcredist_x64_2013.exe`.
   1. [Microsoft Unified Communications Managed API 4.0, Core Runtime 64-bit](https://go.microsoft.com/fwlink/p/?linkId=258269).

   Put the distributions in the directory `C:\distrib`.

1. Grant shared access from the domain to the directory containing the distributions:

   ```powershell
   New-SmbShare -ReadAccess 'yantoso\domain users' -Path 'c:\distrib' -Name 'distrib'
   ```

## Create Microsoft Exchange servers {#create-ms-exchange-servers}

### Create the first Exchange server {#create-exchange-vm-a}

1. Create a VM named `vm-exchange-a`:

   {% list tabs %}

   - Management console

     1. On the folder page in the [management console](https://console.cloud.yandex.com), click **Create resource** and select **Virtual machine**.

     1. In the **Name** field, enter the VM name `vm-exchange-a`.

     1. Select [availability zone](../../overview/concepts/geo-scope.md) `ru-central1-a`.

     1. Under **Public images**, click **Select**. In the window that opens, select the **2016 Datacenter** image.

     1. Under **Disks**, enter 100 GB for the size of the boot disk.

     1. Add another 250 GB SSD named `db`.

     1. Under **Computing resources**:
         - Choose the [platform](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
         - Specify the number of vCPUs and amount of RAM:
            * **vCPU**: 8.
            * **Guaranteed vCPU share**: 100%.
            * **RAM**: 32 GB.

     1. Under **Network settings**, click **Add network** and select `exchange-network`. Select `exchange-subnet-a`. Under **Public address**, select **No address**.

     1. In the **Access** section, specify the data required to access the VM:
         - In the **Password** field, enter your password.

     1. Click **Create VM**.

   - CLI

     ```
     yc compute instance create \
       --name vm-exchange-a \
       --hostname vm-exchange-a \
       --memory 32 \
       --cores 8 \
       --zone ru-central1-a \
       --network-interface subnet-name=exchange-subnet-a \
       --create-boot-disk size=100,image-folder-id=standard-images,image-family=windows-2016-gvlk \
       --create-disk type=network-ssd,size=250,auto-delete=false \
       --metadata-from-file user-data=setpass
     ```

   {% list tabs %}

1. Connect to `fsw-vm` using RDP.

1. On `fsw-vm`, start the RDP client and use it to connect to `vm-exchange-a`. Enter `Administrator` as the username and your password. Launch PowerShell.

1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3"
   ```

1. Add `vm-exchange-a` to the domain:

   ```powershell
   $Credentials = Get-Credential # yantoso\Administrator
   Add-Computer -DomainName yantoso.net -DomainCredential $Credentials -Force -Restart
   ```

   After restarting, log in to the VM as `yantoso\Administrator` with your password. Relaunch PowerShell.

1. Install the downloaded dependencies in the following order:
   1. `& \\fsw-vm\distrib\vcredist_x64_2012.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\vcredist_x64_2013.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\UcmaRuntimeSetup.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart`

1. Restart the VM: `Restart-Computer -Force`.

   After restarting, log in to the VM as `yantoso\Administrator` with your password. Relaunch PowerShell.

1. Install Exchange Mailbox Server on `vm-exchange-a`. Mount the distribution image from the shared directory with distributions:

   ```powershell
   Mount-DiskImage \\fsw-vm\distrib\ExchangeServer2016-x64-cu13.iso
   ```

1. Launch the Exchange Mailbox Server installer:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:Mailbox /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   Restart-Computer -Force
   ```

   When the installation is complete, the VM restarts automatically.

### Create the second Exchange server {#create-exchange-vm-b}

1. Create a VM named `vm-exchange-b`:

   {% list tabs %}

   - Management console

     1. On the folder page in the [management console](https://console.cloud.yandex.com), click **Create resource** and select **Virtual machine**.

     1. In the **Name** field, enter the VM name `vm-exchange-b`.

     1. Select [availability zone](../../overview/concepts/geo-scope.md) `ru-central1-b`.

     1. Under **Public images**, click **Select**. In the window that opens, select the **2016 Datacenter** image.

     1. Under **Disks**, enter 100 GB for the size of the boot disk.

     1. Add another 250 GB SSD named `db`.

     1. Under **Computing resources**:
         - Choose the [platform](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
         - Specify the number of vCPUs and amount of RAM:
            * **vCPU**: 8.
            * **Guaranteed vCPU share**: 100%.
            * **RAM**: 32 GB.

     1. Under **Network settings**, click **Add network** and select `exchange-network`. Select `exchange-subnet-b`. Under **Public address**, select **No address**.

     1. In the **Access** section, specify the data required to access the VM:
         - In the **Password** field, enter your password.

     1. Click **Create VM**.

   - CLI

     ```
     yc compute instance create \
       --name vm-exchange-b \
       --hostname vm-exchange-b \
       --memory 32 \
       --cores 8 \
       --zone ru-central1-b \
       --network-interface subnet-name=exchange-subnet-b \
       --create-boot-disk size=100,image-folder-id=standard-images,image-family=windows-2016-gvlk \
       --create-disk type=network-ssd,size=250,auto-delete=false \
       --metadata-from-file user-data=setpass
     ```

   {% endlist %}

1. Connect to `fsw-vm` using RDP.

1. On the `fsw-vm` VM, start the RDP client and use it to connect to `vm-exchange-b`. Enter `Administrator` as the username and your password. Launch PowerShell.

1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3"
   ```

1. Add `vm-exchange-a` to the domain:

   ```powershell
   $Credentials = Get-Credential # yantoso\Administrator
   Add-Computer -DomainName yantoso.net -DomainCredential $Credentials -Force -Restart
   ```

   After restarting, log in to the VM as `yantoso\Administrator` with your password. Relaunch PowerShell.

1. Install the downloaded dependencies in the following order:
   1. `& \\fsw-vm\distrib\vcredist_x64_2012.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\vcredist_x64_2013.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\UcmaRuntimeSetup.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart`

1. Restart the VM: `Restart-Computer -Force`.

   After restarting, log in to the VM as `yantoso\Administrator` with your password. Relaunch PowerShell.

1. Install Exchange Mailbox Server on `vm-exchange-b`. Mount the distribution image from the shared directory with distributions:

   ```powershell
   Mount-DiskImage \\fsw-vm\distrib\ExchangeServer2016-x64-cu13.iso
   ```

1. Launch the Exchange Mailbox Server installer:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:Mailbox /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   Restart-Computer -Force
   ```

   When the installation is complete, the VM restarts automatically.

## Create a Database Availability Group {#create-dag}

A Database Availability Group ensures fault tolerance for mail servers via DB replication and automatic DB failover in the event of a crash.

1. Connect to `fsw-vm` using RDP.

1. Grant the `yantoso\Exchange Trusted Subsystem` group administrator privileges to the `fsw-vm` VM:

   ```powershell
   Add-LocalGroupMember -Group 'Administrators' -Member 'yantoso\Exchange Trusted Subsystem'
   ```

### Create disks for VM databases {#create-db-disks}

1. On `fsw-vm`, start the RDP client and use it to connect to `vm-exchange-a`. Enter `yantoso\Administrator` as the username and your password.

1. Create an additional disk and format it:

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

Repeat these commands for the `vm-exchange-b` VM.

### Configure the Database Availability Group {#dag-configuration}

1. On `fsw-vm`, start the RDP client and use it to connect to `vm-exchange-a`. Enter `yantoso\Administrator` as the username and your password.

1. Run the Exchange Management Shell.

1. Create a Database Availability Group:

   ```powershell
   New-DatabaseAvailabilityGroup `
       -Name ycdag `
       -WitnessServer fsw-vm `
       -DatabaseAvailabilityGroupIpAddresses 255.255.255.255
   ```

1. Add the `vm-exchange-a` and `vm-exchange-b` servers to the Database Availability Group (DAG):

   ```powershell
   Add-DatabaseAvailabilityGroupServer -Identity yadag -MailboxServer vm-exchange-a
   Add-DatabaseAvailabilityGroupServer -Identity yadag -MailboxServer vm-exchange-b
   ```

1. Check the status of the servers. Both should be in the Operational Servers column:

   ```powershell
   Get-DatabaseAvailabilityGroup -Status

   Name             Member Servers                                      Operational Servers
   ----             --------------                                      -------------------
   ycdag            {VM-EXCHANGE-A, VM-EXCHANGE-B}                    {VM-EXCHANGE-A, VM-EXCHANGE-B}
   ```

1. Create a mail server database:

   ```powershell
   New-MailboxDatabase -Name yamdb -EdbFilePath 'Z:\MDB\yamdb\yamdb.edb' -LogFolderPath 'Z:\MDB\yamdb\log' -Server vm-exchange-a
   ```

1. Mount the database:

   ```powershell
   Mount-Database yamdb
   ```

1. Create a copy of the database on the second server:

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

## Configure the network load balancer {#set-up-load-balancer}

It distributes the load across Exchange servers in different availability zones.

{% list tabs %}

- Management console

  To create a [network load balancer](../../load-balancer/concepts/index.md):
  1. Open the **Load Balancer** section in the folder where you want to create a load balancer.
  1. Click **Create load balancer**.
  1. Enter a name for the network load balancer: `exchange-lb`.
  1. Under **Listeners**, select an automatic public address and click **Add listener**.
  1. Enter a name for the listener: `yassl`
  1. Set the listener port to `443` and click **Add**.
  1. Turn on **Target groups**.
  1. Enter a name for the target group: `exchange-tg`.
  1. Select the `vm-exchange-a` and `vm-exchange-b` VMs.
  1. Under **Health check**, enter a name for the health check: `exchange-hc`.
  1. Select the **TCP** check.
  1. Set the port to `443`.
  1. Keep the other parameters as default.
  1. Click **Create load balancer**.

- UI

  1. Create a network load balancer:

     ```
     $ yc lb nlb create --name exchange-lb
     ```

  1. Create a target group:

     ```
     $ yc lb tg create --name exchange-tg
     ```

  1. Get information about the mail servers:

     ```
     $ yc compute instance get vm-exchange-a
     $ yc compute instance get vm-exchange-b
     ```

     Copy the VM subnet IP addresses and IDs.

  1. Add the servers to the target group:

     ```
     $ yc lb tg update --name exchange-tg \
         --target address=10.2.0.4,subnet-id=e2lkh054nic9h3nckbrs \
         --target address=10.1.0.24,subnet-id=e9bkdrnv156ctcp14p5q
     ```

  1. Add the listener to the network load balancer:

     ```
     $ yc lb nlb add-listener --name exchange-lb --listener name=yassl,port=443,target-port=443,external-ip-version=ipv4
     ```

  1. Get information about the target groups:

     ```
     $ yc lb tg list
     ```

     Copy the target group ID.

  1. Connect the target group to the network load balancer using the target group ID:

     ```
     $ yc lb nlb attach-target-group \
         --name exchange-lb \
         --target-group target-group-id=b7ruh2aqg7pr6ahus4an,healthcheck-name=exchange-hc,healthcheck-tcp-port=443
     ```

{% endlist %}

## Configure Accepted Domains and Email Address Policy {#set-up-accepted-domains}

A domain is created by default. If you need to change the domain, use the command:

```powershell
New-AcceptedDomain -Name yantoso.net -DomainName yantoso.net
```

Edit the Email Address Policy:

```powershell
Get-EmailAddressPolicy | Set-EmailAddressPolicy -EnabledPrimarySMTPAddressTemplate '@yantoso.net'
```

An alias with the `@yantoso.net` domain is automatically added to all the new mailboxes.

## Create a VM for Edge Transport servers {#create-edge-vm}

Edge Transport servers handle the main user load: accept emails from the internet, filter out spam, and forward messages to the internal Exchange mail servers.

### Create a VM for the vm-edge-a server {#create-edge-a}

Create a VM named `vm-edge-a`:

{% list tabs %}

- Management console

  1. On the folder page in the [management console](https://console.cloud.yandex.com), click **Create resource** and select **Virtual machine**.

  1. In the **Name** field, enter the VM name: `vm-edge-a`.

  1. Select [availability zone](../../overview/concepts/geo-scope.md) `ru-central1-a`.

  1. Under **Public images**, click **Select**. In the window that opens, select the **2016 Datacenter** image.

  1. Under **Disks**, enter 50 GB for the size of the boot disk:

  1. Under **Computing resources**:
      - Choose the [platform](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
      - Specify the number of vCPUs and amount of RAM:
         * **vCPU**: 4.
         * **Guaranteed vCPU share**: 100%.
         * **RAM**: 8 GB.

  1. Under **Network settings**, click **Add network** and select `exchange-network`. Select `exchange-subnet-a`. Under **Public address**, select **Automatically** or choose an address from the list of reserved ones.

  1. In the **Access** section, specify the data required to access the VM:
      - In the **Password** field, enter your password.

  1. Click **Create VM**.

- CLI

  ```
  $ yc compute instance create \
      --name vm-edge-a \
      --hostname vm-edge-a \
      --memory 8 \
      --cores 4 \
      --zone ru-central1-a \
      --network-interface subnet-name=exchange-subnet-a,nat-ip-version=ipv4 \
      --create-boot-disk size=50,image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  ```

{% endlist %}

### Create a VM for the vm-edge-b server {#create-edge-b}

Create a VM named `vm-edge-b`:

{% list tabs %}

- Management console

  1. On the folder page in the [management console](https://console.cloud.yandex.com), click **Create resource** and select **Virtual machine**.

  1. In the **Name** field, enter the VM name: `vm-edge-b`.

  1. Select [availability zone](../../overview/concepts/geo-scope.md) `ru-central1-b`.

  1. Under **Public images**, click **Select**. In the window that opens, select the **2016 Datacenter** image.

  1. Under **Disks**, enter 50 GB for the size of the boot disk:

  1. Under **Computing resources**:
      - Choose the [platform](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
      - Specify the number of vCPUs and amount of RAM:
         * **vCPU**: 4.
         * **Guaranteed vCPU share**: 100%.
         * **RAM**: 8 GB.

  1. Under **Network settings**, click **Add network** and select `exchange-network`. Select `exchange-subnet-b`. Under **Public address**, select **Automatically** or choose an address from the list of reserved ones.

  1. In the **Access** section, specify the data required to access the VM:
      - In the **Password** field, enter your password.

  1. Click **Create VM**.

- CLI

  ```
  $ yc compute instance create \
      --name vm-edge-b \
      --hostname vm-edge-b \
      --memory 8 \
      --cores 4 \
      --zone ru-central1-b \
      --network-interface subnet-name=yasn-b,nat-ip-version=ipv4 \
      --create-boot-disk size=50,image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Configure Edge Transport servers {#set-up-edge-transport}

### Configure the Edge Transport server in the ru-central1-a zone {#edge-a}

1. Connect to `fsw-vm` using RDP.

1. Connect to `vm-edge-a` using RDP. Enter `Administrator` as the username and your password. Launch PowerShell.

1. Create a temporary folder:

   ```
   mkdir C:\Windows\temp
   ```

1. Install AD LDS roles on the server:

   ```powershell
   Install-WindowsFeature ADLDS
   ```

1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | `
       Set-DnsClientServerAddress -ServerAddresses "10.1.0.3,10.2.0.3"
   ```

1. Configure remote access to the directory with distributions on `fsw-vm`:

   ```powershell
   $Credential = Get-Credential # Username: yantoso\Administrator

   New-PSDrive -Name 'fsw-vm' -PSProvider:FileSystem -Root '\\fsw-vm.ru-central1.internal\distrib' -Credential $Credential
   ```

   Enter `yantoso\Administrator` as the username and your password.

1. Install the dependencies:

   ```powershell
   & fsw-vm:\vcredist_x64_2012.exe /install /passive /norestart
   & fsw-vm:\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart
   ```

1. Copy the Microsoft Exchange distribution to the `vm-edge-a` server:

   ```powershell
   copy-item fsw-vm:\ExchangeServer2016-x64-cu13.iso c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Specify the primary DNS suffix:

   ```powershell
   $Suffix = 'ru-central1.internal'

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name Domain -Value $Suffix

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name 'NV Domain' -Value $Suffix
   ```

1. Restart the VM:

   ```powershell
   Restart-Computer -Force
   ```

   Reconnect to `vm-edge-a` using RDP and launch PowerShell.

1. Mount the Exchange Server distribution:

   ```powershell
   Mount-DiskImage c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Install Edge Transport Server on the `vm-edge-a` server:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:EdgeTransport /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   ```

### Configure the Edge Transport server in the ru-central1-b zone {#edge-b}

1. Connect to `fsw-vm` using RDP.

1. Connect to `vm-edge-b` using RDP. Enter `Administrator` as the username and your password. Launch PowerShell.

1. Create a temporary folder:

   ```powershell
   mkdir C:\Windows\temp
   ```

1. Install AD LDS roles on the server:

   ```powershell
   Install-WindowsFeature ADLDS
   ```

1. Configure the DNS client:

   ```powershell
   Get-NetAdapter | `
       Set-DnsClientServerAddress -ServerAddresses "10.2.0.3,10.1.0.3"
   ```

1. Configure remote access to the directory with distributions on `fsw-vm`:

   ```powershell
   $Credential = Get-Credential # Username: yantoso\Administrator

   New-PSDrive -Name 'fsw-vm' -PSProvider:FileSystem -Root '\\fsw-vm.ru-central1.internal\distrib' -Credential $Credential
   ```

   Enter `yantoso\Administrator` as the username and your password.

1. Install the dependencies:

   ```powershell
   & fsw-vm:\vcredist_x64_2012.exe /install /passive /norestart
   & fsw-vm:\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart
   ```

1. Copy the Microsoft Exchange distribution to `vm-edge-b`:

   ```powershell
   copy-item fsw-vm:\ExchangeServer2016-x64-cu13.iso c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Specify the primary DNS suffix:

   ```powershell
   $Suffix = 'ru-central1.internal'

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name Domain -Value $Suffix

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name 'NV Domain' -Value $Suffix
   ```

1. Restart the VM:

   ```powershell
   Restart-Computer -Force
   ```

   Reconnect to `vm-edge-b` using RDP and launch PowerShell.

1. Mount the Exchange Server distribution:

   ```powershell
   Mount-DiskImage c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Install Edge Transport Server on `vm-edge-b`:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:EdgeTransport /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   ```

## Add Edge Transport servers to Exchange {#add-edges-to-exchange}

Each Edge Transport server must subscribe to a website in its own availability zone.

### Set up a subscription on vm-edge-a {#subscribe-vm-edge-a}

1. Create a folder named `subscribe`:

   ```powershell
   mkdir c:\subscribe
   ```

1. Run the Exchange Management Shell. Create a subscription file on `vm-edge-a`:

   ```powershell
   New-EdgeSubscription -FileName "C:\subscribe\$(hostname).xml"
   ```

1. Copy `C:\subscribe\vm-edge-a.xml` to the `C:\root\vm-edge-a.xml` directory of the `vm-exchange-a` server.

1. Log in to `vm-exchange-a` and run the Exchange Management Shell.

1. Subscribe the `vm-edge-a` Edge Transport server to the `ru-central1-a` website:

   ```powershell
   New-EdgeSubscription -FileData ([byte[]]$(Get-Content -Path "C:\root\vm-edge-a.xml" -Encoding Byte -ReadCount 0)) -Site "ru-central1-a"
   ```

1. Make sure that the subscription is created using the command:

   ```powershell
   Get-EdgeSubscription

   Name            Site                 Domain
   ----            ----                 ------
   vm-edge-a       yantoso.net/Confi... ru-central1.internal
   ```

1. Check the sync status:

   ```powershell
   Test-EdgeSynchronization
   ```

   The `SyncStatus` value must be `Normal`.

### Set up a subscription on the vm-edge-b server {#subscribe-vm-edge-b}

1. Create a folder named `subscribe`:

   ```powershell
   mkdir c:\subscribe
   ```

1. Run the Exchange Management Shell. Create a subscription file on the `vm-edge-b` server:

   ```powershell
   New-EdgeSubscription -FileName "C:\subscribe\$(hostname).xml"
   ```

1. Copy `C:\subscribe\vm-edge-b.xml` to the `C:\root\vm-edge-b.xml` directory of the `vm-exchange-b` server.

1. Log in to the `vm-exchange-b` server and run the Exchange Management Shell.

1. Subscribe the `vm-edge-b` Edge Transport server to the `ru-central1-b` website:

   ```powershell
   New-EdgeSubscription -FileData ([byte[]]$(Get-Content -Path "C:\root\vm-edge-b.xml" -Encoding Byte -ReadCount 0)) -Site "ru-central1-b"
   ```

1. Make sure that the subscription is created using the command:

   ```powershell
   Get-EdgeSubscription

   Name            Site                 Domain
   ----            ----                 ------
   vm-edge-a       yantoso.net/Confi... ru-central1.internal
   vm-edge-b       yantoso.net/Confi... ru-central1.internal
   ```

1. Check the sync status:

   ```powershell
   Test-EdgeSynchronization
   ```

   The `SyncStatus` value must be `Normal`.

## Delete the created resources {#clear-out}

To stop paying for deployed servers, delete all the [VMs](../../compute/operations/vm-control/vm-delete.md) and [load balancer](../../load-balancer/operations/load-balancer-delete.md) you created:

* `fsw-vm`
* `ad-vm-a`
* `ad-vm-b`
* `vm-exchange-a`
* `vm-exchange-b`
* `vm-edge-a`
* `vm-edge-b`
* load balancer `exchange-lb`

