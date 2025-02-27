# Deploying Remote Desktop Gateway


{% include [ms-disclaimer](../../_includes/ms-disclaimer.md) %}



Remote Desktop Gateway (RDGW) is a Windows Server role which allows you to access internal network resources over HTTPS. 

In this scenario, users from the `Administrators` group will access a test VM with a self-signed certificate.

To deploy the Remote Desktop Gateway infrastructure:

1. [Get your cloud ready](#before-you-begin).
1. [Create a cloud network and subnets](#create-network).
1. [Create a security group](#sg).
1. [Create a gateway VM](#create-gw).
1. [Configure the RDGW role](#role).
1. [Test the RDGW](#test-rdgw).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [ms-additional-data-note](../_tutorials_includes/ms-additional-data-note.md) %}


### Required paid resources {#paid-resources}

The cost of RDGW infrastructure includes:

* Fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for dynamic or static public IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for {{ yandex-cloud }} outbound internet traffic (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).


## Create a cloud network and subnets {#create-network}

Create the `rdgw-network` cloud network with a subnet in the availability zone where your VMs will reside.

1. Create a [cloud network](../../vpc/concepts/network.md).

   {% list tabs group=instructions %}

   - Management console {#console}
    
        1. Navigate to the folder where you want to create your cloud network and select **{{ vpc-short-name }}**.
        1. Click **Create network**.
        1. Specify the network name: `rdgw-network`.
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
    
        1. Select **{{ vpc-short-name }}** in the folder where you created the network.
        1. Click the name of your cloud network.
        1. Click **Add subnet**.
        1. Specify `rdgw-subnet` as the subnet name and select the availability zone from the drop-down list (e.g., `{{ region-id }}-d`).
        1. Specify the subnet CIDR IP address range: `10.1.0.0/16`. For more information about IP address ranges, see [Cloud networks and subnets](../../vpc/concepts/network.md).
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
      id: e9b95m6al33r********
      folder_id: big67u7m5flp********
      created_at: "2021-06-09T10:49:21Z"
      name: rdgw-subnet
      network_id: qqppl6fduhct********
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
   1. Specify the security group name: `my-rdgw-sg`.
   1. In the **Network** field, select the security group network: `rdgw-network`.
   1. Under **Rules**, create the following network traffic rules using the instructions below the table:
      
        | Traffic</br>direction | Description | Port</br>range | Protocol | Source</br>type | Source/Destination | 
        |---|---|---|---|---|---|
        | Inbound | icmp | — | ICMP | CIDR | 0.0.0.0/0 |
        | Inbound | self-security | Any | Any | Security group | Current |
        | Inbound | tcp | 3389 | TCP | CIDR | 0.0.0.0/0 |
        | Inbound | rdgw | 443 | TCP | CIDR | 0.0.0.0/0 |
        | Outbound | default | Any | Any | CIDR | 0.0.0.0/0 |
        
        1. Select the **Outgoing traffic** or **Incoming traffic** tab.
        1. Click **Add rule**.
        1. In the **Port range** field of the window that opens, specify a port or range of ports open for inbound or outbound traffic.
        1. In the **Protocol** field, specify the protocol or leave **Any** to allow traffic over any protocol.
        1. In the **Source** or **Destination** field, select the scope of the rule:
           * **CIDR**: Rule will apply to a range of IP addresses. In the **CIDR blocks** field, specify CIDR IP address ranges of source or destination subnets, respectively. To add multiple CIDRs, click **Add CIDR**.
           * **Security group**: Rule will apply to the current or the selected security group VMs.
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
   id: enp136p8s2ae********
   folder_id: big67u7m5flp********
   created_at: "2021-06-09T10:50:29Z"
   name: my-rdgw-sg
   network_id: qqppl6fduhct********
   status: ACTIVE
   rules:
   - id: env98jerk9b3********
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

## Create a gateway VM {#create-gw}

Create a VM and give it a public IP address:

{% list tabs group=instructions %}

- Management console {#console}

     1. On the folder dashboard in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

         * Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
         * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create-new }}** in the window that opens.
         * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then select the **Windows Server 2022 Datacenter** image from the list below. For more information on how to upload a Microsoft disk image, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
         * Optionally, in the **{{ ui-key.yacloud.compute.field_additional }}** field, enable **{{ ui-key.yacloud.compute.field_disk-autodelete }}** to automatically delete this disk when deleting the VM.
         * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
     1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify your boot [disk](../../compute/concepts/disk.md) size: `60 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

         * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
         * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
         * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
         * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, specify:

         * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `rdgw-subnet`
         * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`
         * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**: `my-rdgw-sg`
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `my-rds-gw`.
     1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

     {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

- CLI {#cli}
     
    1. In PowerShell, create the `setpass` script setting up the `Administrator` password using the [VM metadata](../../compute/concepts/vm-metadata.md) `user-data` field. The `cloudbase-init` tool will execute the script on the first run.

       {% note info %}
    
       The first line of the script must be `#ps1`; otherwise, the `cloudbase-init` tool will fail.
    
       {% endnote %}
    
        ```powershell
        #ps1
        Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<your password>" -AsPlainText -Force) 
        ```
   
    1. Create a VM specifying the created script as the metadata source. Specify the `my-rdgw-group` ID as the `security-group-ids` value:

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
      id: frmogfp7mm1k********
      folder_id: big67u7m5flp********
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
      device_name: fhmplfvr7g6p********
      auto_delete: true
      disk_id: fhmplfvr7g6p********
      network_interfaces:
      - index: "0"
        mac_address: d0:0d:18:83:c8:7b
        subnet_id: e9b95m6al33r********
        primary_v4_address:
        address: 10.1.0.3
        one_to_one_nat:
        address: 178.154.231.126
        ip_version: IPV4
        security_group_ids:
         - enp136p8s2a********
           fqdn: my-rds-gw.{{ region-id }}.internal
           scheduling_policy: {}
           network_settings:
           type: STANDARD
           placement_policy: {}
      ```

       {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

{% endlist %}

## Configure the RDGW role {#role}

1. [Connect](../../compute/operations/vm-connect/rdp.md) to the created VM via RDP.
1. Install the required role and [management tools]({{ ms.docs }}/troubleshoot/windows-server/system-management-components/what-is-microsoft-management-console#more-information):
   
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
   
   
1. Create a client access policy allowing members of the `Administrators` group to connect to the RDGW. You can do this using a [Windows PowerShell drive]({{ ms.docs }}/powershell/scripting/samples/managing-windows-powershell-drives?view=powershell-7.1) that is automatically installed with the role:

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

1. Create a resource access policy allowing members of the `Administrators` groups to connect to internal resources through the RDGW. 

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
   
1. Create your RDGW server certificate that will be used for traffic encryption:

   ```powershell
   $Certificate = New-SelfSignedCertificate -CertStoreLocation 'Cert:\LocalMachine\My' -DnsName $ENV:COMPUTERNAME
   ```
   
1. Export the created certificate so the gateway clients can upload it to their `Trusted Roots Certificate Authorities` certificate stores. This is required to trust your self-signed certificate:

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

1. Configure RDGW to use your certificate and restart the RDG service to apply the settings:

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

The RDGW VM allows members of the `BUILTIN\Administrators` group to connect to internal network VMs.

## Test the RDGW {#test-rdgw}

1. Create an internal network VM to which you will connect during the test. 

    {% list tabs group=instructions %}

    - Management console {#console}

        1. On the folder dashboard in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

            * Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
            * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create-new }}** in the window that opens.
            * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then select the **Windows Server 2022 Datacenter** image from the list below. For more information on how to upload a Microsoft disk image, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
            * Optionally, in the **{{ ui-key.yacloud.compute.field_additional }}** field, enable **{{ ui-key.yacloud.compute.field_disk-autodelete }}** to automatically delete this disk when deleting the VM.
            * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
        1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify your boot disk size: `60 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

            * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
            * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
            * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
            * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, specify:

            * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: `rdgw-subnet`
            * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`
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
      id: fhm5pflreh2j********
      folder_id: big67u7m5flp********
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
      device_name: fhmmf65nlbt1********
      auto_delete: true
      disk_id: fhmmf65nlbt1********
      network_interfaces:
      - index: "0"
        mac_address: d0:0d:5d:ef:bb:74
        subnet_id: e9b95m6al33r********
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

1. Import your RDGW certificate file to the `Trusted Roots Certificate Authorities` directory of the computer you will connect to the test VM.
    
   To connect to the gateway by the VM name, specify its name and external IP address in the `C:\Windows\system32\drivers\etc\hosts` file. Here is an example:
   
    ```powershell
    87.250.250.242 my-rds-gw
    ```
   
1. Run the [`mstsc`]({{ ms.docs }}/windows-server/administration/windows-commands/mstsc) remote desktop client. On the **Advanced** tab of the connection settings, specify the gateway: `my-rds-gw`, destination node: `test-vm`, and username: `Administrator`. 

## How to delete the resources you created {#clear-out}

If you no longer need the resources you created, i.e., [VMs](../../compute/operations/vm-control/vm-delete.md) and [networks](../../vpc/operations/network-delete.md), delete them.
