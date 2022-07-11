# Deploying Active Directory

The scenario provides an example of how to deploy Active Directory in {{ yandex-cloud }}.

To deploy the Active Directory infrastructure:

1. [Before you start](#before-you-begin)
{% if product == "yandex-cloud" %}1. [Required paid resources](#paid-resources){% endif %}
1. [Create a cloud network and subnets](#create-network).
1. [Create a script to manage a local administrator account](#admin-script).
1. [Create a VM for Active Directory](#ad-vm).
1. [Create a VM for a bastion host](#jump-server-vm)
1. [Install and configure Active Directory](#install-ad).
1. [Configure the second domain controller](#install-ad-2).
1. [Test Active Directory](#test-ad)
1. [Delete the created resources](#clear-out)

## Before you start {#before-you-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}
{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of an Active Directory installation includes:

* A fee for continuously running VMs (see [pricing{{ compute-full-name }}](../compute/pricing.md)).
* A fee for using dynamic or static public IP addresses (see [pricing{{ vpc-full-name }}](../vpc/pricing.md)).
* The cost of outgoing traffic from {{ yandex-cloud }} to the internet (see [{{ compute-full-name }} pricing](../compute/pricing.md)).

{% endif %}

## Create a cloud network and subnets {#create-network}

Create a cloud network named `ad-network` with subnets in all the availability zones where your VMs will be located.

1. Create a cloud network:

   {% list tabs %}

   - Management console

     To create a [cloud network](../vpc/concepts/network.md):
     1. Open the **Virtual Private Cloud** section in the folder where you want to create the cloud network.
     1. Click **Create network**.
     1. Enter the network name `ad-network`.
     1. Click **Create network**.

   - CLI

     To create a cloud network, run the command:

     ```
     $ yc vpc network create --name ad-network
     ```

   {% endlist %}

1. Create three `ad-network` subnets:

   {% list tabs %}

     - Management console

       To create a subnet:
       1. Open the **Virtual Private Cloud** section in the folder where you want to create the subnet.
       1. Click on the name of the cloud network.
       1. Click **Add subnet**.
       1. Fill out the form: set the subnet name to `ad-subnet-a` and select the `{{ region-id }}-a` availability zone from the drop-down list.
       1. Enter the subnet CIDR, which is its IP address and mask: `10.1.0.0/16`. For more information about subnet IP ranges, see [Cloud networks and subnets](../vpc/concepts/network.md).
       1. Click **Create subnet**.

       Repeat these steps for two more subnets, `ad-subnet-b` and `ad-subnet-c`, in the `{{ region-id }}-b` and `{{ region-id }}-c` availability zones with the `10.2.0.0/16` and `10.3.0.0/16` CIDR, respectively.

     - CLI

       To create subnets, run the following commands:

       ```
       yc vpc subnet create \
         --name ad-subnet-a \
         --zone {{ region-id }}-a \
         --network-name ad-network \
         --range 10.1.0.0/16
       
       yc vpc subnet create \
         --name ad-subnet-b \
         --zone {{ region-id }}-b \
         --network-name ad-network \
         --range 10.2.0.0/16
       
       yc vpc subnet create \
         --name ad-subnet-c \
         --zone {{ region-id }}-c \
         --network-name ad-network \
         --range 10.3.0.0/16
       ```

   {% endlist %}

## Create a script to manage a local administrator account {#admin-script}

Create a file named `setpass` with a script that sets a password for the local administrator account when creating VMs via the CLI:

```
#ps1
Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<your password>" -AsPlainText -Force)
```

The password must meet the [complexity requirements]({{ ms.docs }}/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочные-материалы).

Read more about the best practices for securing Active Directory on the [official website]({{ ms.docs }}/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

## Create a VM for Active Directory {#ad-vm}

Create two VMs for Active Directory domain controllers. These VMs don't have internet access.

{% list tabs %}

- Management console

  1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

  1. In the **Name** field, enter the VM name `ad-vm-a`.

  1. Select the [availability zone](../overview/concepts/geo-scope.md) `{{ region-id }}-a`.

  1. Under **Images from {{ marketplace-name }}**, click **Select**. In the window that opens, select the **2016 Datacenter** image.

  1. Under **Disks**, enter 35 GB for the size of the boot disk.

  1. Under **Computing resources**:
      - Choose a [platform](../compute/concepts/vm-platforms.md): Intel Ice Lake.
      - Specify the number of vCPUs and amount of RAM:
         * **vCPU**: 4.
         * **Guaranteed vCPU share**: 100%.
         * **RAM**: 8 GB.

  1. Under **Network settings**, click **Add network** and select `exchange-network`. Select `exchange-subnet-a`. Under **Public address**, select **No address**.

  1. Under **Access**, specify the data required to access the VM:
      - In the **Password** field, enter your password.

  1. Click **Create VM**.

  Repeat this operation for the VM `ad-vm-b` in the `{{ region-id }}-a` availability zone and connect it to the subnet `exchange-subnet-b`.

- CLI

  ```
  $ yc compute instance create \
      --name ad-vm-a \
      --hostname ad-vm-a \
      --memory 8 \
      --cores 4 \
      --zone {{ region-id }}-a \
      --network-interface subnet-name=exchange-subnet-a,ipv4-address=10.1.0.3 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  
  $ yc compute instance create \
      --name ad-vm-b \
      --hostname ad-vm-b \
      --memory 8 \
      --cores 4 \
      --zone {{ region-id }}-b \
      --network-interface subnet-name=exchange-subnet-b,ipv4-address=10.2.0.3 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Create a VM for a bastion host {#jump-server-vm}

A file server with internet access is used to configure VMs with Active Directory.

{% list tabs %}

- Management console

  1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.
  1. In the **Name** field, enter the VM name `jump-server-vm`.
  1. Select the [availability zone](../overview/concepts/geo-scope.md) `{{ region-id }}-c`
  1. Under **Images from {{ marketplace-name }}**, click **Select**. In the window that opens, select the **2016 Datacenter** image.
  1. Under **Disks**, enter 35 GB for the size of the boot disk.
  1. Under **Computing resources**:
      - Choose a [platform](../compute/concepts/vm-platforms.md): Intel Ice Lake.
      - Specify the number of vCPUs and amount of RAM:
         * **vCPU**: 2.
         * **Guaranteed vCPU share**: 100%.
         * **RAM**: 4 GB.

  1. Under **Network settings**, click **Add network** and select `exchange-network`. Select `exchange-subnet-c`. Under **Public address**, select **No address**.
  1. Under **Access**, specify the data required to access the VM:
      - In the **Password** field, enter your password.
  1. Click **Create VM**.

- CLI

  ```
  $ yc compute instance create \
      --name jump-server-vm \
      --hostname jump-server-vm \
      --memory 4 \
      --cores 2 \
      --zone {{ region-id }}-c \
      --network-interface subnet-name=exchange-subnet-c,nat-ip-version=ipv4 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Install and configure Active Directory {#install-ad}

VMs with Active Directory don't have internet access, so they should be configured from the `jump-server-vm` VM using RDP.

1. Connect to `jump-server-vm` using RDP. Enter `Administrator` as the username and then your password.

1. Start the RDP client and connect to `ad-vm-a`.

1. Run the PowerShell and set a static address:

   ```powershell
   netsh interface ip set address "Ethernet 2" static 10.1.0.3 255.255.255.0 10.1.0.1
   ```

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

1. Create an Active Directory forest:

   ```powershell
   Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
   ```

   Windows restarts automatically. Relaunch PowerShell.

1. Rename the default site to `{{ region-id }}-a`:

   ```powershell
   Get-ADReplicationSite 'Default-First-Site-Name' | Rename-ADObject -NewName '{{ region-id }}-a'
   ```

1. Create two more sites for the other availability zones:

   ```powershell
   New-ADReplicationSite '{{ region-id }}-b'
   New-ADReplicationSite '{{ region-id }}-c'
   ```

1. Create subnets and link them to the sites:

   ```powershell
   New-ADReplicationSubnet -Name '10.1.0.0/16' -Site '{{ region-id }}-a'
   New-ADReplicationSubnet -Name '10.2.0.0/16' -Site '{{ region-id }}-b'
   New-ADReplicationSubnet -Name '10.3.0.0/16' -Site '{{ region-id }}-c'
   ```

1. Rename the site link and configure replication:

   ```powershell
   Get-ADReplicationSiteLink 'DEFAULTIPSITELINK' | `
       Set-ADReplicationSiteLink -SitesIncluded @{Add='{{ region-id }}-b'} -ReplicationFrequencyInMinutes 15 -PassThru | `
       Set-ADObject -Replace @{options = $($_.options -bor 1)} -PassThru | `
       Rename-ADObject -NewName '{{ region-id }}'
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

1. Connect to `jump-server-vm` using RDP.
1. Connect to `ad-vm-b` using RDP. Specify `Administrator` as the username and enter your password.
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

   Windows restarts automatically. Relaunch PowerShell.

1. Set the DNS redirect server:

   ```powershell
   Set-DnsServerForwarder '10.2.0.2'
   ```

## Test Active Directory {#test-ad}

1. Connect to `jump-server-vm` using RDP.

1. Connect to `ad-vm-b` using RDP. Specify `Administrator` as the username and enter your password. Launch PowerShell.

1. Create a test user:

   ```powershell
   New-ADUser testUser
   ```

1. Make sure the user is present on both servers:

   ```
   Get-ADUser testUser -Server yadc-b
   Get-ADUser testUser -Server yadc-a
   ```

## Delete the created resources {#clear-out}

To stop paying for deployed servers, delete all the [VMs you created](../compute/operations/vm-control/vm-delete.md).

