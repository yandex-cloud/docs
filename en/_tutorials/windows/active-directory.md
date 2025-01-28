# Deploying Active Directory


{% include [ms-disclaimer](../../_includes/ms-disclaimer.md) %}



The tutorial provides an example of how to deploy Active Directory in {{ yandex-cloud }}.

To deploy the Active Directory infrastructure:
1. [Prepare your cloud](#before-you-begin).
1. [Create a cloud network and subnets](#create-network).
1. [Create a script to manage a local administrator account](#admin-script).
1. [Create a virtual machine for Active Directory](#ad-vm).
1. [Create a VM for a bastion host](#jump-server-vm).
1. [Install and configure Active Directory](#install-ad).
1. [Configure the second domain controller](#install-ad-2).
1. [Test Active Directory](#test-ad).

If you no longer need the infrastructure, [delete all the resources it uses](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [ms-additional-data-note](../_tutorials_includes/ms-additional-data-note.md) %}


### Required paid resources {#paid-resources}

The Active Directory installation cost includes:
* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using dynamic or static [public IP addresses](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for outbound traffic from {{ yandex-cloud }} to the internet (see [{{ compute-name }} pricing](../../compute/pricing.md)).


## Create a cloud network and subnets {#create-network}

Create a [cloud network](../../vpc/concepts/network.md#network) named `ad-network` with [subnets](../../vpc/concepts/network.md#subnet) in all [availability zones](../../overview/concepts/geo-scope.md) where your VMs will be located.
1. Create a cloud network:

   {% list tabs group=instructions %}

   - Management console {#console}

     To create a cloud network:
     1. Open the **{{ vpc-name }}** section of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a cloud network.
     1. Click **Create network**.
     1. Enter the network name: `ad-network`.
     1. Click **Create network**.

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     To create a cloud network, run this command:

     ```bash
     yc vpc network create --name ad-network
     ```

   {% endlist %}

1. Create three subnets in `ad-network`:

   {% list tabs group=instructions %}

   - Management console {#console}

       To create a subnet:
       1. Open the **{{ vpc-name }}** section in the folder where you need to create a subnet.
       1. Click the name of the cloud network.
       1. Click **Add subnet**.
       1. Fill out the form: enter `ad-subnet-a` as the subnet name and select the `{{ region-id }}-a` availability zone from the drop-down list.
       1. Enter the subnet CIDR: IP address and `10.1.0.0/16` as subnet mask.
       1. Click **Create subnet**.

       Repeat these steps for two more subnets:
       * Name: `ad-subnet-b`: Availability zone: `{{ region-id }}-b`. CIDR: `10.2.0.0/16`.
       * Name: `ad-subnet-d`. Availability zone: `{{ region-id }}-d`. CIDR: `10.3.0.0/16`.

   - CLI {#cli}

       To create subnets, run the following commands:

       ```bash
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
         --name ad-subnet-d \
         --zone {{ region-id }}-d \
         --network-name ad-network \
         --range 10.3.0.0/16
       ```

   {% endlist %}

## Create a script to manage a local administrator account {#admin-script}

When creating a VM via the CLI, you need to set a password for a local administrator account.

To do this, in the root folder of the command line, create a file named `setpass` without an extension. Copy the script to the file and set your password:

```powershell
#ps1
Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<your password>" -AsPlainText -Force)
```

The password must meet the [complexity requirements]({{ ms.docs }}/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#reference).

You can read more about the best practices for securing Active Directory on the [MS official website]({{ ms.docs }}/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

## Create a VM for Active Directory {#ad-vm}

Create two VMs for Active Directory domain controllers. These VMs will not have internet access.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
      * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create-new }}** in the window that opens.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then select the **Windows Server 2022 Datacenter** image from the list below. For more information on how to upload your own image for Microsoft products, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-a` availability zone.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify the boot [disk](../../compute/concepts/disk.md) size: `50 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, specify:

      * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `ad-subnet-a`.
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
      * Expand the **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** section; in the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}`.
      * In the input field that appears, enter `10.1.0.3`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `ad-vm-a`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

  Repeat the steps for the `ad-vm-b` VM in the `{{ region-id }}-b` availability zone, connect it to the `ad-subnet-b` subnet, and manually specify the internal IP address: `10.2.0.3`.

- CLI {#cli}

  ```bash
  yc compute instance create \
    --name ad-vm-a \
    --hostname ad-vm-a \
    --memory 8 \
    --cores 4 \
    --zone {{ region-id }}-a \
    --network-interface subnet-name=ad-subnet-a,ipv4-address=10.1.0.3 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2022-dc-gvlk \
    --metadata-from-file user-data=setpass

  yc compute instance create \
    --name ad-vm-b \
    --hostname ad-vm-b \
    --memory 8 \
    --cores 4 \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=ad-subnet-b,ipv4-address=10.2.0.3 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2022-dc-gvlk \
    --metadata-from-file user-data=setpass
  ```

  {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

{% endlist %}

## Create a VM for a bastion host {#jump-server-vm}

A file server with internet access is used to configure VMs with Active Directory.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
      * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create-new }}** in the window that opens.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then select the **Windows Server 2022 Datacenter** image from the list below. For more information on how to upload your own image for Microsoft products, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
  
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-d` availability zone.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify the boot disk size: `50 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required platform, number of vCPUs, and amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
  
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `ad-subnet-d`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, leave `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `jump-server-vm`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

- CLI {#cli}

  ```bash
  yc compute instance create \
    --name jump-server-vm \
    --hostname jump-server-vm \
    --memory 4 \
    --cores 2 \
    --zone {{ region-id }}-d \
    --network-interface subnet-name=ad-subnet-d,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2022-dc-gvlk \
    --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Install and configure Active Directory {#install-ad}

Active Directory VMs do not have internet access. To configure them, use `jump-server-vm` through [RDP](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol).
1. [Connect](../../compute/operations/vm-connect/rdp.md) to `jump-server-vm` through RDP. Use `Administrator` as your username and your password.
1. Run RDP and connect to `ad-vm-a` using its local IP address, the `Administrator` username and your password.
1. Run PowerShell and set a static IP address:

   ```powershell
   netsh interface ip set address "eth0" static 10.1.0.3 255.255.255.0 10.1.0.1
   ```

1. Assign Active Directory roles:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
   ```

   Result:

   ```text
   Success  Restart Needed  Exit Code  Feature Result
   -------  --------------  ---------  --------------
   True     No              Success    {Active Directory Domain Services, Group P...
   ```

1. Create an Active Directory forest:

   ```powershell
   Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
   ```

   Next, enter the password and confirm it.

   Windows will restart automatically. Reconnect to `ad-vm-a` and launch PowerShell.
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

1. Connect to `jump-server-vm` through RDP.
1. Using RDP, connect to `ad-vm-b` using its local IP address, the `Administrator` username, and your password.
1. Assign Active Directory roles:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
   ```

   Result:

   ```text
   Success  Restart Needed  Exit Code       Feature Result
   -------  --------------  ---------       --------------
   True     No              NoChangeNeeded  {}
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

   Next, enter the password and confirm it.

   Windows will restart automatically. Reconnect to `ad-vm-b` and launch PowerShell.
1. Set the DNS server forwarder:

   ```powershell
   Set-DnsServerForwarder '10.2.0.2'
   ```

## Test Active Directory {#test-ad}

1. Connect to `jump-server-vm` through RDP.
1. Using RDP, connect to `ad-vm-b` using its local IP address, the `Administrator` username, and your password. Launch PowerShell.
1. Create a test user:

   ```powershell
   New-ADUser testUser
   ```

1. Make sure the user is present on both servers:

   ```powershell
   Get-ADUser testUser -Server 10.1.0.3
   Get-ADUser testUser -Server 10.2.0.3
   ```

   The results of both commands must be the same:

   ```text
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

## How to delete the resources you created {#clear-out}

To stop paying for the deployed servers, delete all [VMs](../../compute/operations/vm-control/vm-delete.md) you created.
