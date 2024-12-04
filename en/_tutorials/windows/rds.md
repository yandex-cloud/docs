# Deploying Microsoft Remote Desktop Services


{% include [ms-disclaimer](../../_includes/ms-disclaimer.md) %}



This scenario describes how to deploy Microsoft Windows Server Datacenter with pre-installed Remote Desktop Services in {{ yandex-cloud }}. The Microsoft Windows Server with Remote Desktop Services instance consists of a single server with Remote Desktop Services and Active Directory installed. Images are available with preset quotas for 5, 10, 25, 50, and 100 users. Select the version with the necessary quota. All examples are given for a server with a quota for five users.

{% note warning %}

To increase the quota, re-create the VM.

{% endnote %}

To deploy the Remote Desktop Services infrastructure:

1. [Prepare your cloud](#before-you-begin).
1. [Create a cloud network and subnets](#create-network).
1. [Create a script to manage a local administrator account](#admin-script).
1. [Create a VM for Remote Desktop Services](#add-vm).
1. [Install and configure Active Directory domain controllers](#install-ad).
1. [Set up the firewall rules](#firewall).
1. [Set up the license server in the domain](#license-server).
1. [Set up the Remote Desktop Session Host role](#rdsh).
1. [Create users](#create-users).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [ms-additional-data-note](../_tutorials_includes/ms-additional-data-note.md) %}


### Required paid resources {#paid-resources}

The cost of installing Microsoft Windows Server with Remote Desktop Services includes:

* Fee for continuously running virtual machines (see [{{ compute-full-name }}](../../compute/pricing.md) pricing).
* Fee for using dynamic or static public IP addresses (see [{{ vpc-full-name }}](../../vpc/pricing.md) pricing).
* Fee for outbound traffic from {{ yandex-cloud }} to the internet (see [{{ compute-full-name }}](../../compute/pricing.md) pricing).


## Create a cloud network and subnets {#create-network}

Create a cloud network named `my-network` with subnets in all availability zones where your VMs will be located.

1. Create a cloud network:

   {% list tabs group=instructions %}

   - Management console {#console}

     To create a [cloud network](../../vpc/concepts/network.md):
     1. Open the **{{ vpc-name }}** section of the folder where you want to create a cloud network.
     1. Click **Create network**.
     1. Enter the network name: `my-network`.
     1. Click **Create network**.

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}
  
     {% include [default-catalogue](../../_includes/default-catalogue.md) %} 

     To create a cloud network, run the command:

     ```
     yc vpc network create --name my-network
     ```

   - API {#api}

     Use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.

   {% endlist %}

2. Create a subnet in `my-network`:

   {% list tabs group=instructions %}

     - Management console {#console}

       To create a subnet:
       1. Open the **{{ vpc-name }}** section in the folder to create a subnet in.
       1. Click the name of the cloud network.
       1. Click **Add subnet**.
       1. Fill out the form: enter `my-subnet-d` as the subnet name and select the `{{ region-id }}-d` availability zone from the drop-down list.
       1. Enter the subnet CIDR: IP address and subnet mask: `10.1.0.0/16`. For more information about subnet IP address ranges, see [Cloud networks and subnets](../../vpc/concepts/network.md).
       1. Click **Create subnet**.

     - CLI {#cli}

       To create a subnet, run the following command:

       ```
       yc vpc subnet create \
         --name my-subnet-d \
         --zone {{ region-id }}-d \
         --network-name my-network \
         --range 10.1.0.0/16
       ```
     
     - API {#api}

       Use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

   {% endlist %}


## Create a script to manage a local administrator account {#admin-script}

Create a file named `setpass` with a script that will set a password for the local administrator account when you create VMs via the CLI:

{% list tabs group=programming_language %}

- PowerShell {#powershell}

    ```
    #ps1
    Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<your_password>" -AsPlainText -Force)
    ```
{% endlist %}

The password must meet the [complexity requirements]({{ ms.docs }}/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочные-материалы).

You can read more about the best practices for securing Active Directory on the [MS official website]({{ ms.docs }}/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

## Create a VM for Windows Server with Remote Desktop Services {#add-vm}

Create a virtual machine for Windows Server with Remote Desktop Services. This VM will have internet access.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, specify `RDS` and select the appropriate [RDS](/marketplace?tab=software&search=windows+rds) image: 
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, enter `50 {{ ui-key.yacloud.common.units.label_gigabyte }}` as your boot [disk](../../compute/concepts/disk.md) size.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and the amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `4`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, specify:

      * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: Network named `my-network` and subnet named `my-subnet-d`.
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `my-rds-vm`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

- CLI {#cli}

  ```
   yc compute instance create \
     --name my-rds-vm \
     --hostname my-rds-vm \
     --memory 8 \
     --cores 4 \
     --zone {{ region-id }}-d \
     --network-interface subnet-name=my-subnet-d,ipv4-address=10.1.0.3,nat-ip-version=ipv4 \
     --create-boot-disk image-folder-id=standard-images,image-family=windows-2022-dc-gvlk-rds-5 \
     --metadata-from-file user-data=setpass
  ```

- API {#api}

  Use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}

## Install and configure Active Directory domain controllers {#install-ad}

1. Restart `my-rds-vm`:

   {% list tabs group=instructions %}
   
   - Management console {#console}
   
     1. On the folder page in the [management console]({{ link-console-main }}), select **{{ compute-name }}**.
     1. Select the `my-rds-vm` VM.
     1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **Restart**.
   
   - CLI {#cli}
   
     ```
     yc compute instance restart my-rds-vm
     ```
   
   - API {#api}
   
     Use the [restart](../../compute/api-ref/Instance/restart.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Restart](../../compute/api-ref/grpc/Instance/restart.md) gRPC API call.
   
   {% endlist %}

1. Connect to `my-rds-vm` through [RDP](../../compute/operations/vm-connect/rdp.md). Use `Administrator` for username, and your password.
1. Assign Active Directory roles:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
        Restart-Computer -Force
        ```
      
    {% endlist %}

1. Create an Active Directory forest:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
        ```
      
    {% endlist %}

   Windows will restart automatically. Reconnect to `my-rds-vm`. Use `yantoso\Administrator` for username, and your password. Relaunch PowerShell.

## Set up the firewall rules {#firewall}

1. Add firewall rules that protect Active Directory from external network requests:
    
    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

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

1. Add the Network Service system user to the Terminal Server License Servers group in the Active Directory security group:
    
    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        net localgroup "Terminal Server License Servers" /Add 'Network Service'
        ```
      
    {% endlist %}
   
1. Set the licensing type.
    
    {% note info %}
    
    You can only use `User CAL` licenses.
    
    {% endnote %}

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        New-ItemProperty `
        -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' `
        -Name 'LicensingMode' `
        -Value 4 `
        -PropertyType 'DWord'
        ```
      
    {% endlist %}
    
1. Specify the RDS licensing service:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        New-ItemProperty `
        -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' `
        -Name 'LicenseServers' `
        -Value 'localhost' `
        -PropertyType 'String'
        ```
      
    {% endlist %}

1. (Optional) Limit the number of permitted concurrent server sessions:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}
        
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

{% list tabs group=programming_language %}

- PowerShell {#powershell}

    ```powershell
    Install-WindowsFeature RDS-RD-Server -IncludeManagementTools
    Restart-Computer -Force
    ```

{% endlist %}


## Add the server to the AD security group and register it as SCP {#ad-sg-scp}

Add the server to the Terminal Server License Servers group in the Active Directory security group and register it as the license service connection point (SCP) for users:

{% list tabs group=operating_system %}

- Windows Server {#windows}

  1. Click **Start**.
  1. In the search field, enter `Remote Desktop Licensing Manager`.
  1. Right-click the server in the list and select **Review Configuration...**.
  1. Next to the first warning on the `Terminal Server License Servers` group, click **Add to Group** and then click **Continue**.
  1. Next to the second warning, the one on the service connection point, click **Register as SCP**.
  1. Click **OK**.
  1. Restart the VM.

{% endlist %}


## Create users {#create-users}

1. Create test users:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}
    
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

1. Issue the `Remote Desktop Users` permissions to users:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        Add-ADGroupMember -Members 'ru1' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru2' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru3' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru4' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru5' -Identity 'Remote Desktop Users'
        ```

    {% endlist %}

1. Set up RDP access permissions for the `Remote Desktop Users` group:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}
    
        ```powershell
        & secedit /export /cfg sec_conf_export.ini  /areas user_rights
        $secConfig = Get-Content sec_conf_export.ini
        $SID = 'S-1-5-32-555'
        $secConfig = $secConfig -replace '^SeRemoteInteractiveLogonRight .+', "`$0,*$SID"
        $secConfig | Set-Content sec_conf_import.ini
        & secedit /configure /db secedit.sdb /cfg sec_conf_import.ini /areas user_rights
        Remove-Item sec_conf_import.ini
        Remove-Item sec_conf_export.ini
        ```
      
    {% endlist %}

## How to delete the resources you created {#clear-out}

If you no longer need the created resources, delete the [VM instances](../../compute/operations/vm-control/vm-delete.md) and [networks](../../vpc/operations/network-delete.md).