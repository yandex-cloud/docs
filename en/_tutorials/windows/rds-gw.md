# Deploying Remote Desktop Gateway


{% include [ms-disclaimer](../../_includes/ms-disclaimer.md) %}



Remote Desktop Gateway (RDGW) is a Windows Server service for accessing resources that have no internet access via a secure HTTPS communication channel. 

In this scenario, users from the `Administrators` group will get access to a test VM using a self-signed certificate.

To deploy the Remote Desktop Gateway infrastructure:

1. [Prepare your cloud](#before-you-begin).
1. [Create a cloud network and subnets](#create-network).
1. [Create a security group](#sg).
1. [Create a VM for the gateway](#create-gw).
1. [Configure the RDGW role](#role).
1. [Test the RDGW](#test-rdgw).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [ms-additional-data-note](../_tutorials_includes/ms-additional-data-note.md) %}


### Required paid resources {#paid-resources}

The cost of installing RDGW includes:

* Fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using dynamic or static public IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for outbound traffic from {{ yandex-cloud }} to the internet (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).


## Create a cloud network and subnets {#create-network}

Create a cloud network named `rdgw-network` with a subnet in the availability zone your VMs will be located in.

1. Create a [cloud network](../../vpc/concepts/network.md).

   {% list tabs group=instructions %}

   - Management console {#console}
    
        1. Select **{{ vpc-short-name }}** in the folder where you want to create a cloud network.
        1. Click **Create network**.
        1. Enter the network name: `rdgw-network`.
        1. Click **Create network**.
   
    - CLI {#cli}
      
      ```
      yc vpc network create --name rdgw-network
      ```

      Where `rdgw-network` is the network name.

      Result:
      
      ```
      id: qqppl6fduhct76qkjh6s
      folder_id: big67u7m5flplkc6vvpc
      created_at: "2021-06-09T10:49:07Z"
      name: rdgw-network
      default_security_group_id: enpa139ji55jti00u5sg
      ```

    - API {#api}

      Use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.

   {% endlist %}

1. Create a subnet in `rdgw-network`.

   {% list tabs group=instructions %}
   
    - Management console {#console}
    
        1. Select **{{ vpc-short-name }}** in the folder to create a subnet in.
        1. Click the name of the cloud network.
        1. Click **Add subnet**.
        1. Fill out the form: enter `rdgw-subnet` for subnet name and select the desired availability zone from the drop-down list (e.g., `{{ region-id }}-d`).
        1. Enter the subnet CIDR: IP address and subnet mask: `10.1.0.0/16`. For more information about subnet IP address ranges, see [Cloud networks and subnets](../../vpc/concepts/network.md).
        1. Click **Create subnet**.
   
    - CLI {#cli}
   
      ```
      yc vpc subnet create `
        --name rdgw-subnet `
        --zone {{ region-id }}-d `
        --network-name rdgw-network `
        --range 10.1.0.0/16
      ```

      Where `rdgw-subnet` is the subnet name.
      
      Result:
      
      ```
      id: e9b95m6al33r62n5vkab
      folder_id: big67u7m5flplkc6vvpc
      created_at: "2021-06-09T10:49:21Z"
      name: rdgw-subnet
      network_id: qqppl6fduhct76qkjh6s
      zone_id: {{ region-id }}-d
      v4_cidr_blocks:
      - 10.1.0.0/16
      ```

    - API {#api}

       Use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

   {% endlist %}

## Create a security group {#sg}

Create and configure a [security group](../../vpc/concepts/security-groups.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. Select **{{ vpc-short-name }}** in the folder where you want to create a security group.
   1. Open the **Security groups** tab.
   1. Click **Create group**.
   1. Enter a name for the security group: `my-rdgw-sg`.
   1. In the **Network** field, select the network to assign the security group to: `rdgw-network`.
   1. Under **Rules**, create the following traffic management rules according to the instructions below the table:
      
        | Traffic</br>direction | Description | Port</br>range | Protocol | Source</br>type | Source/Purpose |
        |---|---|---|---|---|---|
        | Incoming | icmp | — | ICMP | CIDR | 0.0.0.0/0 |
        | Incoming | self-security | Any | Any | Security group | Current |
        | Incoming | tcp | 3389 | TCP | CIDR | 0.0.0.0/0 |
        | Incoming | rdgw | 443 | TCP | CIDR | 0.0.0.0/0 |
        | Outgoing | default | Any | Any | CIDR | 0.0.0.0/0 |
        
        1. Select the **Outgoing traffic** or **Incoming traffic** tab.
        1. Click **Add rule**.
        1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
        1. In the **Protocol** field, specify the appropriate protocol or leave **Any** to allow traffic transmission over any protocol.
        1. In the **Purpose** or **Source** field, select the purpose of the rule:
           * **CIDR**: Rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
           * **Security group**: Rule will apply to the VMs from the current group or the selected security group.
        1. Click **Save**. Repeat the steps to create all the rules from the table.
     
   1. Click **Save**.
   
- CLI {#cli}

   ```
   yc vpc security-group create --name=my-rdgw-sg `
     --network-name rdgw-network `
     --rule direction=ingress,protocol=icmp,v4-cidrs=[0.0.0.0/0],description=icmp `
     --rule direction=ingress,port=any,protocol=any,predefined=self_security_group,description=self `
     --rule direction=ingress,port=3389,protocol=tcp,v4-cidrs=[0.0.0.0/0],description=rdp `
     --rule direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0],description=rdgw `
     --rule direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0],description=default 
   ```
  
   Result:

   ```
   id: enp136p8s2ael7ob6klg
   folder_id: big67u7m5flplkc6vvpc
   created_at: "2021-06-09T10:50:29Z"
   name: my-rdgw-sg
   network_id: qqppl6fduhct76qkjh6s
   status: ACTIVE
   rules:
   - id: env98jerk9b3tcp68k61
     description: icmp
     direction: INGRESS
     protocol_name: ICMP
     protocol_number: "1"
     cidr_blocks:
     v4_cidr_blocks:
      - 0.0.0.0/0
  ```

- API {#api}

  Use the [create](../../vpc/api-ref/SecurityGroup/create.md) REST API method for the [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Create](../../vpc/api-ref/grpc/SecurityGroup/create.md) gRPC API call.

{% endlist %}

## Create a VM for the gateway {#create-gw}

Create a VM with a public address:

{% list tabs group=instructions %}

- Management console {#console}

     1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

         * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
         * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create-new }}** in the window that opens.
         * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then select the **Windows Server 2022 Datacenter** image from the list below. For more information on how to upload your own image for Microsoft products, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
         * (Optional) In the **{{ ui-key.yacloud.compute.field_additional }}** field, enable **{{ ui-key.yacloud.compute.field_disk-autodelete }}** if you need to automatically delete this disk when deleting the VM.
         * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
     1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, enter `60 {{ ui-key.yacloud.common.units.label_gigabyte }}` as your boot [disk](../../compute/concepts/disk.md) size.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and the amount of RAM:

         * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
         * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`.
         * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
         * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, specify:

         * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: Network named `rdgw-network` and subnet named `rdgw-subnet`.
         * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
         * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**: `my-rdgw-sg`.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `my-rds-gw`.
     1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

     {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

- CLI {#cli}
     
    1. In the PowerShell terminal, create a script named `setpass` to set up a password for the `Administrator` account using the `user-data` field in the [VM's metadata](../../compute/concepts/vm-metadata.md). The `cloudbase-init` utility will execute the script on the first run.

       {% note info %}
    
       The first line of the script must only contain `#ps1`, otherwise the `cloudbase-init` utility will not execute the script.
    
       {% endnote %}
    
        ```powershell
        #ps1
        Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<your password>" -AsPlainText -Force)
        ```
   
    1. Create a VM and specify the created script as the metadata source. In the `security-group-ids` parameter, insert the ID of the `my-rdgw-group` security group:

       ```
       yc compute instance create `
         --name my-rds-gw `
         --hostname my-rds-gw `
         --memory 4 `
         --cores 2 `
         --platform standard-v3 `
         --zone {{ region-id }}-d `
         --network-interface subnet-name=rdgw-subnet,ipv4-address=10.1.0.3,nat-ip-version=ipv4,security-group-ids=<id_my-rdgw-group> `
         --create-boot-disk image-folder-id=standard-images,image-family=windows-2022-dc-gvlk `
         --metadata-from-file user-data=setpass
       ```
   
      Result:
   
      ```
      done (25s)
      id: frmogfp7mm1kg87c25f3
      folder_id: big67u7m5flplkc6vvpc
      created_at: "2021-06-09T10:51:58Z"
      name: my-rds-gw
      zone_id: {{ region-id }}-d
      platform_id: standard-v3
      resources:
      memory: "4294967296"
      cores: "2"
      core_fraction: "100"
      status: RUNNING
      boot_disk:
      mode: READ_WRITE
      device_name: fhmplfvr7g6pfv63fsr7
      auto_delete: true
      disk_id: fhmplfvr7g6pfv63fsr7
      network_interfaces:
      - index: "0"
        mac_address: d0:0d:18:83:c8:7b
        subnet_id: e9b95m6al33r62n5vkab
        primary_v4_address:
        address: 10.1.0.3
        one_to_one_nat:
        address: 178.154.231.126
        ip_version: IPV4
        security_group_ids:
         - enp136p8s2ael7ob6klg
           fqdn: my-rds-gw.{{ region-id }}.internal
           scheduling_policy: {}
           network_settings:
           type: STANDARD
           placement_policy: {}
      ```

{% endlist %}

## Configure the RDGW role {#role}

1. [Connect](../../compute/operations/vm-connect/rdp.md) to the created VM via RDP.
1. Set the required roles and [management snap-ins]({{ ms.docs }}/troubleshoot/windows-server/system-management-components/what-is-microsoft-management-console#more-information):
   
    ```powershell
    Install-WindowsFeature RDS-Gateway -IncludeManagementTools
    ```
   
   Result:
   
   ``` 
   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    No             Success        {Network Policy and Access Services, Remot...
   ```
   
1. Import the RDS module:
   
   ```powershell
   Import-Module -Name RemoteDesktopServices
   ```
   
   
1. Create a client access policy to allow all `Administrators` local group accounts to connect to the RDGW. You can do this using a [Windows PowerShell drive]({{ ms.docs }}/powershell/scripting/samples/managing-windows-powershell-drives?view=powershell-7.1) that will be created automatically when importing the role:

   ```powershell
   New-Item -Path 'RDS:\GatewayServer\CAP' -Name 'Default-CAP' -UserGroups Administrators@Builtin -AuthMethod '1'
   ```

   Result:

   ``` 
       Directory: RDS:\GatewayServer\CAP
   
   Name                   Type      CurrentValue         GP   PermissibleValues PermissibleOperations
   ----                   ----      ------------         --   ----------------- ---------------------
   Default-CAP                                           -                      Get-Item, Get-ChildItem, Remove-Item,...
   ```

1. Create a resource access policy to allow all `Administrators` local group accounts to connect to any internal resource through the created RDGW. 

   ```powershell
   New-Item -Path 'RDS:\GatewayServer\RAP' -Name 'Default-RAP' -UserGroups Administrators@Builtin -ComputerGroupType '2'
   ```

   Result:

   ``` 
       Directory: RDS:\GatewayServer\RAP
   
   Name                   Type      CurrentValue         GP   PermissibleValues PermissibleOperations
   ----                   ----      ------------         --   ----------------- ---------------------
   Default-RAP                                           -                      Get-Item, Get-ChildItem, Remove-Item,...
   ```
   
1. Create a certificate with the name of the server to be used for connecting to the gateway and encrypting traffic:

   ```powershell
   $Certificate = New-SelfSignedCertificate -CertStoreLocation 'Cert:\LocalMachine\My' -DnsName $ENV:COMPUTERNAME
   ```
   
1. Export the created certificate so you can later upload it to the `Trusted Roots Certificate Authorities` certificate store on the computer connecting to the VM. This is necessary for the client to trust the self-signed RDGW certificate:

   ```powershell
   $Certificate | Export-Certificate -FilePath "C:\REGW.cer"
   ```
   
   Result:

   ``` 
       Directory: RDS:\GatewayServer\RAP
   
   Name                   Type      CurrentValue         GP   PermissibleValues PermissibleOperations
   ----                   ----      ------------         --   ----------------- ---------------------
   Default-RAP                                           -                      Get-Item, Get-ChildItem, Remove-Item,...
   ```

1. Specify which certificate the RDGW should use. Restart the Remote Desktop Gateway service to apply the settings:

   ```powershell
   Set-Item -Path 'RDS:\GatewayServer\SSLCertificate\Thumbprint' -Value $Certificate.Thumbprint
   Get-Service TSGateway | Restart-Service
   ```

   Result:

   ``` 
       Directory: C:\
   
   Mode                LastWriteTime         Length Name
   ----                -------------         ------ ----
   -a----         6/9/2021  11:51 AM            796 REGW.cer
   ```

The gateway VM with a RDGW role configured allows `BUILTIN\Administrators` local group accounts to connect to VMs that have no direct internet access.

## Test the RDGW {#test-rdgw}

1. Create a VM with no internet access and connect to it during the test.

    {% list tabs group=instructions %}

    - Management console {#console}

        1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

            * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
            * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create-new }}** in the window that opens.
            * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then select the **Windows Server 2022 Datacenter** image from the list below. For more information on how to upload your own image for Microsoft products, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
            * (Optional) In the **{{ ui-key.yacloud.compute.field_additional }}** field, enable **{{ ui-key.yacloud.compute.field_disk-autodelete }}** if you need to automatically delete this disk when deleting the VM.
            * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
        1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, enter `60 {{ ui-key.yacloud.common.units.label_gigabyte }}` as your boot disk size.
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and the amount of RAM:

            * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
            * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`.
            * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
            * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, specify:

            * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: Network named `rdgw-network` and subnet named `rdgw-subnet`.
            * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `test-vm`.
        1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

        {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

    - CLI {#cli}
        
      Create a VM:
    
      ```
      yc compute instance create `
        --name test-vm `
        --hostname test-vm `
        --memory 4 `
        --cores 2 `
        --platform standard-v3 `
        --zone {{ region-id }}-d `
        --network-interface subnet-name=rdgw-subnet,ipv4-address=10.1.0.4 `
        --create-boot-disk image-folder-id=standard-images,image-family=windows-2022-dc-gvlk `
        --metadata-from-file user-data=setpass
      ```

      Result:
   
      ``` 
      done (19s)
      id: fhm5pflreh2jellq97r0
      folder_id: big67u7m5flplkc6vvpc
      created_at: "2021-06-09T11:53:03Z"
      name: test-vm
      zone_id: {{ region-id }}-d
      platform_id: standard-v3
      resources:
      memory: "4294967296"
      cores: "2"
      core_fraction: "100"
      status: RUNNING
      boot_disk:
      mode: READ_WRITE
      device_name: fhmmf65nlbt131b3e36l
      auto_delete: true
      disk_id: fhmmf65nlbt131b3e36l
      network_interfaces:
      - index: "0"
        mac_address: d0:0d:5d:ef:bb:74
        subnet_id: e9b95m6al33r62n5vkab
        primary_v4_address:
        address: 10.1.0.4
        fqdn: test-vm.{{ region-id }}.internal
        scheduling_policy: {}
        network_settings:
        type: STANDARD
        placement_policy: {}
      ```

    - API {#api}

      Use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

    {% endlist %}

1. Import the created certificate to the `Trusted Roots Certificate Authorities` directory on the computer that you will use to connect to the test VM.
    
   To connect to the gateway using the VM name, specify the name and external IP address of the created RDGW in the `C:\Windows\system32\drivers\etc\hosts` file. For example:
   
    ```powershell
    87.250.250.242 my-rds-gw
    ```
   
1. Run the [`mstsc` utility]({{ ms.docs }}/windows-server/administration/windows-commands/mstsc) that creates remote desktop connections. In the settings on the **Advanced** tab, specify the `my-rds-gw` VM name as the gateway, the `test-vm` name as the destination node, and `Administrator` as the username.

## How to delete the resources you created {#clear-out}

If you no longer need the created resources, delete the [VM instances](../../compute/operations/vm-control/vm-delete.md) and [networks](../../vpc/operations/network-delete.md).
