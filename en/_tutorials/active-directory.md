# Deploying Active Directory

The scenario provides an example of how to deploy Active Directory in {{ yandex-cloud }}.

To deploy the Active Directory infrastructure:

1. [Before you start](#before-you-begin)
{% if product == "yandex-cloud" %}1. [Required paid resources](#paid-resources){% endif %}
1. [Create a cloud network and subnets](#create-network).
1. [Create a script to manage a local administrator account](#admin-script).
1. [Create a VM for Active Directory](#ad-vm).
1. [Create a VM for a bastion host](#jump-server-vm).
1. [Install and configure Active Directory](#install-ad).
1. [Configure the second domain controller](#install-ad-2).
1. [Test Active Directory](#test-ad).

If you no longer need the infrastructure, [delete all the resources it uses](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}
{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of an Active Directory installation includes:

* A fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../compute/pricing.md)).
* A fee for using dynamic or static public IP addresses (see [{{ vpc-full-name }} pricing](../vpc/pricing.md)).
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

      {% include [cli-install](../_includes/cli-install.md) %}

      {% include [default-catalogue](../_includes/default-catalogue.md) %}

      To create a cloud network, run the command:

      ```powershell
      yc vpc network create --name ad-network
      ```

   {% endlist %}

1. Create three `ad-network` subnets:

   {% list tabs %}

   - Management console

      To create a subnet:
      1. Open the **Virtual Private Cloud** section in the folder where you want to create the subnet.
      1. Click on the name of the cloud network.
      1. Click **Add subnet**.
      1. Fill out the form: set the subnet name to `ad-subnet-a` and select the `ru-central1-a` availability zone from the drop-down list.
      1. Enter the subnet CIDR, which is its IP address and mask: `10.1.0.0/16`. For more information about subnet IP address ranges, see [Cloud networks and subnets](../vpc/concepts/network.md).
      1. Click **Create subnet**.

      Repeat the steps for two more subnets:

      * Name: `ad-subnet-b`. Availability zone: `ru-central1-b`. CIDR: `10.2.0.0/16`.
      * Name: `ad-subnet-c`. Availability zone: `ru-central1-c`. CIDR: `10.3.0.0/16`.

   - CLI

      To create subnets, run the following commands:

      ```powershell
      yc vpc subnet create \
        --name ad-subnet-a \
        --zone ru-central1-a \
        --network-name ad-network \
        --range 10.1.0.0/16

      yc vpc subnet create \
        --name ad-subnet-b \
        --zone ru-central1-b \
        --network-name ad-network \
        --range 10.2.0.0/16

      yc vpc subnet create \
        --name ad-subnet-c \
        --zone ru-central1-c \
        --network-name ad-network \
        --range 10.3.0.0/16
      ```

   {% endlist %}

## Create a script to manage a local administrator account {#admin-script}

When creating a virtual machine via the CLI, you need to set a password for a local administrator account.

To do this, in the root folder of the command line, create a file named `setpass` without an extension. Copy the script to the file and set your password:

```powershell
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
   1. Select the [availability zone](../overview/concepts/geo-scope.md): `ru-central1-a`.
   1. Under **Image/boot disk selection** → **{{ marketplace-name }}** click **Show more**. In the window that opens, select the **Windows Server 2019 Datacenter** image and click **Use**.
   1. Under **Disks**, enter 50 GB for the size of the boot disk:
   1. Under **Computing resources**:

      * Select the [platform](../compute/concepts/vm-platforms.md): **Intel Ice Lake**.
      * Specify the number of vCPUs and amount of RAM:
         * **vCPU** — 4.
         * **Guaranteed vCPU share**: 100%
         * **RAM**: 8 GB.

   1. Under **Network settings**:

      * Select the `ad-subnet-a` subnet.
      * **Public address**: **No address**.
      * **Internal address**: Select **Manual** and specify `10.1.0.3`.

   1. Under **Access**, in the **Password** field, enter your password.
   1. Click **Create VM**.

   Repeat this operation for the VM `ad-vm-b` in the `ru-central1-b` availability zone, connect it to the `ad-subnet-b` subnet, and manually specify the internal address `10.2.0.3`.

- CLI

   ```powershell
   yc compute instance create \
     --name ad-vm-a \
     --hostname ad-vm-a \
     --memory 8 \
     --cores 4 \
     --zone ru-central1-a \
     --network-interface subnet-name=ad-subnet-a,ipv4-address=10.1.0.3 \
     --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-dc-gvlk \
     --metadata-from-file user-data=setpass

   yc compute instance create \
     --name ad-vm-b \
     --hostname ad-vm-b \
     --memory 8 \
     --cores 4 \
     --zone ru-central1-b \
     --network-interface subnet-name=ad-subnet-b,ipv4-address=10.2.0.3 \
     --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-dc-gvlk \
     --metadata-from-file user-data=setpass
   ```

{% endlist %}

## Create a VM for a bastion host {#jump-server-vm}

A file server with internet access is used to configure VMs with Active Directory.

{% list tabs %}

- Management console

   1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.
   1. In the **Name** field, enter the VM name `jump-server-vm`.
   1. Select the `ru-central1-c` [availability zone](../overview/concepts/geo-scope.md)
   1. Under **Image/boot disk selection** → **{{ marketplace-name }}** click **Show more**. In the window that opens, select the **Windows Server 2019 Datacenter** image and click **Use**.
   1. Under **Disks**, enter 50 GB for the size of the boot disk:
   1. Under **Computing resources**:

      * Select the [platform](../compute/concepts/vm-platforms.md): Intel Ice Lake.
      * Specify the number of vCPUs and amount of RAM:
         * **vCPU** — 2.
         * **Guaranteed vCPU share**: 100%
         * **RAM**: 4 GB.

   1. Under **Network settings**, select the `ad-subnet-c` subnet. Under **Public address**, select **Automatically**.
   1. Under **Access**, in the **Password** field, enter your password.
   1. Click **Create VM**.

- CLI

   ```powershell
   yc compute instance create \
     --name jump-server-vm \
     --hostname jump-server-vm \
     --memory 4 \
     --cores 2 \
     --zone ru-central1-c \
     --network-interface subnet-name=ad-subnet-c,nat-ip-version=ipv4 \
     --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-dc-gvlk \
     --metadata-from-file user-data=setpass
   ```

{% endlist %}

## Install and configure Active Directory {#install-ad}

VMs with Active Directory don't have internet access, so they should be configured from the `jump-server-vm` VM using [RDP]{% if lang == "ru"%}(https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Remote_Desktop_Protocol){% endif %}.

1. [Connect](../compute/operations/vm-connect/rdp.md) to `jump-server-vm` using RDP. Enter `Administrator` as the username and then your password.
1. Launch RDP and connect to `ad-vm-a`, using its local IP address, `Administrator` username and your password.
1. Run PowerShell and set a static address:

   ```powershell
   netsh interface ip set address "eth0" static 10.1.0.3 255.255.255.0 10.1.0.1
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

   Then enter the password and confirm it.

   Windows restarts automatically. Reconnect to `ad-vm-a` and launch PowerShell.

1. Rename the default site `ru-central1-a`:

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

1. Connect to `jump-server-vm` using RDP.
1. Using RDP, connect to `ad-vm-b`, using its local IP address, the `Administrator` username and your password.
1. Assign Active Directory roles:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
   ```

   Result:

   ```powershell
   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    No             NoChangeNeeded {}
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

   Then enter the password and confirm it.

   Windows restarts automatically. Reconnect to `ad-vm-a` and launch PowerShell.

1. Set the DNS redirect server:

   ```powershell
   Set-DnsServerForwarder '10.2.0.2'
   ```

## Test Active Directory {#test-ad}

1. Connect to `jump-server-vm` using RDP.
1. Using RDP, connect to `ad-vm-b`, using its local IP address, the `Administrator` username and your password. Launch PowerShell.
1. Create a test user:

   ```powershell
   New-ADUser testUser
   ```
1. Make sure the user is present on both servers:

   ```powershell
   Get-ADUser testUser -Server 10.1.0.3
   Get-ADUser testUser -Server 10.2.0.3
   ```

   Result:

   ```powershell
   DistinguishedName : CN=testUser,CN=Users,DC=yantoso,DC=net
   Enabled           : False
   GivenName         :
   Name              : testUser
   ObjectClass       : user
   ObjectGUID        : 7202f41a-(...)-2d168ecd5271
   SamAccountName    : testUser
   SID               : S-1-5-21-(...)-1105
   Surname           :
   UserPrincipalName :

   DistinguishedName : CN=testUser,CN=Users,DC=yantoso,DC=net
   Enabled           : False
   GivenName         :
   Name              : testUser
   ObjectClass       : user
   ObjectGUID        : 7202f41a-(...)-2d168ecd5271
   SamAccountName    : testUser
   SID               : S-1-5-21-(...)-1105
   Surname           :
   UserPrincipalName :
   ```

## How to delete created resources {#clear-out}

To stop paying for deployed servers, delete all the [VMs](../compute/operations/vm-control/vm-delete.md).
