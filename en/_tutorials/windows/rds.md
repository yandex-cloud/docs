# Deploying Microsoft Remote Desktop Services

This scenario describes how to deploy Microsoft Windows Server 2019 Datacenter with pre-installed Remote Desktop Services in {{ yandex-cloud }}. The Microsoft Windows Server with Remote Desktop Services instance consists of a single server where Remote Desktop Services and Active Directory will be installed. Images are available with quotas for 5/10/25/50/100/250/500 users. Select the version with the necessary quota. All examples are given for a server with a quota for 5 users.

{% note warning %}

To increase the quota, re-create the VM.

{% endnote %}

To deploy the Remote Desktop Services infrastructure:

1. [Before you start](#before-you-begin).
1. [Create a cloud network and subnets](#create-network).
1. [Create a script to manage a local administrator account](#admin-script).
1. [Create a VM for Remote Desktop Services](#add-vm).
1. [Install and configure Active Directory domain controllers](#install-ad).
1. [Set up the firewall rules](#firewall).
1. [Set up the license server in the domain](#license-server).
1. [Set up the Remote Desktop Session Host role](#rdsh).
1. [Create users](#create-users).

If you no longer need these resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [ms-additional-data-note](../includes/ms-additional-data-note.md) %}


### Required paid resources {#paid-resources}

The cost of installing Microsoft Windows Server with Remote Desktop Services includes:

* A fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using dynamic or static public IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* The cost of outgoing traffic from {{ yandex-cloud }} to the internet (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).


## Create a cloud network and subnets {#create-network}

Create a cloud network named `my-network` with subnets in all the availability zones where your VMs will be located.

1. Create a cloud network:

   {% list tabs %}

   - Management console

      To create a [cloud network](../../vpc/concepts/network.md):
      1. Open the **Virtual Private Cloud** section in the folder where you want to create the cloud network.
      1. Click **Create network**.
      1. Enter a network name: `my-network`.
      1. Click **Create network**.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      To create a cloud network, run the command:

      ```
      yc vpc network create --name my-network
      ```

   {% endlist %}

2. Create `my-network` subnet:

   {% list tabs %}

   - Management console

      To create a subnet:
      1. Open the **Virtual Private Cloud** section in the folder where you want to create the subnet.
      1. Click on the name of the cloud network.
      1. Click **Add subnet**.
      1. Fill out the form: enter `my-subnet-a` as the subnet name and select the `{{ region-id }}-a` availability zone from the drop-down list.
      1. Enter the subnet CIDR, which is its IP address and mask: `10.1.0.0/16`. For more information about subnet IP address ranges, see [Cloud networks and subnets](../../vpc/concepts/network.md).
      1. Click **Create subnet**.

   - CLI

      To create subnet, run the following command:

      ```
      yc vpc subnet create \
        --name my-subnet-a \
        --zone {{ region-id }}-a \
        --network-name my-network \
        --range 10.1.0.0/16
      ```

   {% endlist %}


## Create a script to manage a local administrator account {#admin-script}

Create a file named `setpass` with a script that will set a password for the local administrator account when creating VMs via the CLI:

{% list tabs %}

- PowerShell

   ```
   #ps1
   Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<your password>" -AsPlainText -Force)
   ```
{% endlist %}

The password must meet the [complexity requirements]({{ ms.docs }}/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочные-материалы).

Read more about the best practices for securing Active Directory on the [official website]({{ ms.docs }}/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

## Create a VM for Windows Server with Remote Desktop Services {#add-vm}

Create a virtual machine for Windows Server with Remote Desktop Services. This VM will have internet access.

{% list tabs %}

- Management console

   1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.
   1. In the **Name** field, enter a name for the VM: `my-rds-vm`.
   1. Select the [availability zone](../../overview/concepts/geo-scope.md): `{{ region-id }}-a`.
   1. Under **{{ marketplace-name }}**, click **Show more**. In the window that opens, select the [Windows RDS](/marketplace?tab=software&search=windows+rds) image.
   1. Under **Disks**, enter 50 GB for the size of the boot disk:
   1. Under **Computing resources**:
      - Select the [platform](../../compute/concepts/vm-platforms.md): Intel Ice Lake.
      - Specify the number of vCPUs and amount of RAM:
         * **vCPU** — 4.
         * **Guaranteed vCPU share**: 100%
         * **RAM**: 8 GB.

   1. Under **Network settings**, click **Add network** and select `my-network`. Select the `my-subnet-a` subnet. Under **Public address**, select **Automatically**.
   1. Under **Access**, specify the data required to access the VM:
      - In the **Password** field, enter your password.
   1. Click **Create VM**.

- CLI

   ```
    yc compute instance create \
       --name my-rds-vm \
       --hostname my-rds-vm \
       --memory 8 \
       --cores 4 \
       --zone {{ region-id }}-a \
       --network-interface subnet-name=my-subnet-a,ipv4-address=10.1.0.3,nat-ip-version=ipv4 \
       --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-dc-gvlk-rds-5 \
       --metadata-from-file user-data=setpass
   ```

{% endlist %}

## Install and configure Active Directory domain controllers {#install-ad}

1. Connect to `my-rds-vm` [using RDP](../../compute/operations/vm-connect/rdp.md). Enter `Administrator` as the username and then your password.
1. Assign Active Directory roles:

   {% list tabs %}

   - PowerShell

      ```powershell
      Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
      Restart-Computer -Force
      ```

   {% endlist %}

1. Create an Active Directory forest:

   {% list tabs %}

   - PowerShell

      ```powershell
      Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
      ```

   {% endlist %}

   Windows restarts automatically. Reconnect to `my-rds-vm`. Enter `yantoso\Administrator` as the username and then your password. Relaunch PowerShell.

## Set up the firewall rules {#firewall}

1. Add firewall rules that protect Active Directory from external network requests:

   {% list tabs %}

   - PowerShell

      ```powershell
      Set-NetFirewallRule `
        -DisplayName 'Active Directory Domain Controller - LDAP (UDP-In)' `
        -RemoteAddress:Intranet

      Set-NetFirewallRule `
        -DisplayName 'Active Directory Domain Controller - LDAP (TCP-In)' `
        -RemoteAddress:Intranet

      Set-NetFirewallRule `
        -DisplayName 'Active Directory Domain Controller - Secure LDAP (TCP-In)' `
        -RemoteAddress:Intranet
      ```

   {% endlist %}

## Set up the license server in the domain {#license-server}

1. Authorize the license server in the domain.

   The role is on the domain controller, so add `Network Service` to the `BUILTIN` group:

   {% list tabs %}

   - PowerShell

      ```powershell
      net localgroup "Terminal Server License Servers" /Add 'Network Service'
      ```

   {% endlist %}

1. Set the licensing type.

   {% note info %}

   You can only use `User CAL` licenses.

   {% endnote %}

   {% list tabs %}

   - PowerShell

      ```powershell
      New-ItemProperty `
      -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' `
      -Name 'LicensingMode' `
      -Value 4 `
      -PropertyType 'DWord'
      ```

   {% endlist %}

1. Specify the RDS licensing service:

   {% list tabs %}

   - PowerShell

      ```powershell
      New-ItemProperty `
      -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' `
      -Name 'LicenseServers' `
      -Value 'localhost' `
      -PropertyType 'String'
      ```

   {% endlist %}

1. (Optional) Limit the number of permitted concurrent server sessions:

   {% list tabs %}

   - PowerShell

      ```powershell
      New-ItemProperty `
      -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' `
      -Name 'MaxInstanceCount' `
      -Value 5 `
      -PropertyType 'DWord'
      ```

   {% endlist %}

## Set up the Remote Desktop Session Host role {#rdsh}

Install the Remote Desktop Session Host role on the server:

{% list tabs %}

- PowerShell

   ```powershell
   Install-WindowsFeature RDS-RD-Server -IncludeManagementTools
   Restart-Computer -Force
   ```

{% endlist %}

## Create users {#create-users}

1. Create test users:

   {% list tabs %}

   - PowerShell

      ```powershell
      New-ADUser `
        -Name ru1 `
        -PasswordNeverExpires $true `
        -Enabled $true `
        -AccountPassword ("P@ssw0rd!1" | ConvertTo-SecureString -AsPlainText -Force )
      New-ADUser `
        -Name ru2 `
        -PasswordNeverExpires $true `
        -Enabled $true `
        -AccountPassword ("P@ssw0rd!1" | ConvertTo-SecureString -AsPlainText -Force )
      New-ADUser `
        -Name ru3 `
        -PasswordNeverExpires $true `
        -Enabled $true `
        -AccountPassword ("P@ssw0rd!1" | ConvertTo-SecureString -AsPlainText -Force )
      New-ADUser `
        -Name ru4 `
        -PasswordNeverExpires $true `
        -Enabled $true `
        -AccountPassword ("P@ssw0rd!1" | ConvertTo-SecureString -AsPlainText -Force )
      New-ADUser `
        -Name ru5 `
        -PasswordNeverExpires $true `
        -Enabled $true `
        -AccountPassword ("P@ssw0rd!1" | ConvertTo-SecureString -AsPlainText -Force )
      ```

   {% endlist %}

1. Grant `Remote Desktop Users` rights to the users:

   {% list tabs %}

   - PowerShell

      ```powershell
      Add-ADGroupMember -Members 'ru1' -Identity 'Remote Desktop Users'
      Add-ADGroupMember -Members 'ru2' -Identity 'Remote Desktop Users'
      Add-ADGroupMember -Members 'ru3' -Identity 'Remote Desktop Users'
      Add-ADGroupMember -Members 'ru4' -Identity 'Remote Desktop Users'
      Add-ADGroupMember -Members 'ru5' -Identity 'Remote Desktop Users'
      ```

   {% endlist %}

1. Set up RDP access rights for the `Remote Desktop Users` group:

   {% list tabs %}

   - PowerShell

      ```powershell
      & secedit /export /cfg sec_conf_export.ini /areas user_rights
      $secConfig = Get-Content sec_conf_export.ini
      $SID = 'S-1-5-32-555'
      $secConfig = $secConfig -replace '^SeRemoteInteractiveLogonRight .+', "`$0,*$SID"
      $secConfig | Set-Content sec_conf_import.ini
      & secedit /configure /db secedit.sdb /cfg sec_conf_import.ini /areas user_rights
      Remove-Item sec_conf_import.ini
      Remove-Item sec_conf_export.ini
      ```

   {% endlist %}

## How to delete created resources {#clear-out}

If you no longer need the created resources, delete the [VM instances](../../compute/operations/vm-control/vm-delete.md) and [networks](../../vpc/operations/network-delete.md).