# Deploying Remote Desktop Gateway

Remote Desktop Gateway (RDGW) is a Windows Server service for accessing resources that have no internet access via a secure HTTPS communication channel.

In this use case, users from the `Administrators` group are granted access to a test VM using a self-signed certificate.

## Before you start {#before-you-begin}

Before deploying servers, you need to sign up for {{ yandex-cloud }} and create a billing account:

{% include [prepare-register-billing](../../_includes/tutorials/includes/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page](https://console.cloud.yandex.com/cloud).

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

The cost of installing RDGW includes:

* A fee for continuously running VMs (see [pricing for {{ compute-full-name }}](../../compute/pricing.md)).
* A fee for using dynamic or static public IP addresses (see [pricing for {{ vpc-full-name }}](../../vpc/pricing.md)).
* The cost of outgoing traffic from {{ yandex-cloud }} to the internet (see [pricing for {{ compute-full-name }}](../../compute/pricing.md)).

## Create a cloud network and subnets {#create-network}

Create a cloud network named `rdgw-network` with a subnet in the availability zone where your VMs will be located.

1. Create a [cloud network](../../vpc/concepts/network.md).

   {% list tabs %}

    - Management console

        1. Open the **Virtual Private Cloud** section in the folder where you want to create the cloud network.
        1. Click **Create network**.
        1. Enter the network name: `rdgw-network`.
        1. Click **Create network**.

    - CLI

      ```
      yc vpc network create --name rdgw-network
      ```

      Command execution result:

      ```
      id: qqppl6fduhct76qkjh6s
      folder_id: big67u7m5flplkc6vvpc
      created_at: "2021-06-09T10:49:07Z"
      name: rdgw-network
      default_security_group_id: enpa139ji55jti00u5sg
      ```

   {% endlist %}

1. Create a subnet in the network `rdgw-network`.

   {% list tabs %}

    - Management console

        1. Open **Virtual Private Cloud** in the folder where you want to create the subnet.
        1. Click on the name of the cloud network.
        1. Click **Add subnet**.
        1. Fill out the form: enter `rdgw-subnet` as a subnet name and select the desired availability zone from the drop-down list (for example, `ru-central1-a`).
        1. Enter the subnet CIDR, which is its IP address and mask: `10.1.0.0/16`. For more information about subnet IP ranges, see [Cloud networks and subnets](../../vpc/concepts/network.md).
        1. Click **Create subnet**.

    - CLI

      ```
      yc vpc subnet create `
        --name rdgw-subnet `
        --zone ru-central1-a `
        --network-name rdgw-network `
        --range 10.1.0.0/16
      ```

      Command execution result:

      ```
      id: e9b95m6al33r62n5vkab
      folder_id: big67u7m5flplkc6vvpc
      created_at: "2021-06-09T10:49:21Z"
      name: rdgw-subnet
      network_id: qqppl6fduhct76qkjh6s
      zone_id: ru-central1-a
      v4_cidr_blocks:
      - 10.1.0.0/16
      ```

   {% endlist %}

## Create a security group {#sg}

Create and set up a [security group](../../vpc/concepts/security-groups.md).

{% list tabs %}

- Management console

   1. Open the **Virtual Private Cloud** section in the folder to create a security group in.
   1. Open the **Security groups** tab.
   1. Click **Create group**.
   1. Enter the security group name: `my-rdgw-sg`.
   1. In the **Network** field, select the network to assign the security group to: `rdgw-network`.
   1. Under **Rules**, create the following traffic management rules according to the instructions below the table:

        | Traffic</br>direction | Description | Port</br>range | Protocol | Source</br>type | Source/Purpose |
        | --- | --- | --- | --- | --- | --- |
        | Incoming | ICMP | — | ICMP | CIDR | 0.0.0.0/0 |
        | Incoming | self-security | Any | Any | Security group | Current |
        | Incoming | TCP | 3389 | TCP | CIDR | 0.0.0.0/0 |
        | Incoming | RDGW | 443 | TCP | CIDR | 0.0.0.0/0 |
        | Outgoing | default | Any | Any | CIDR | 0.0.0.0/0 |
        1. Select the **Outgoing traffic** or **Incoming traffic** tab.
        1. Click **Add rule**.
        1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
        1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
        1. In the **Purpose** or **Source** field, select the purpose of the rule:
           * **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
           * **Security group**: The rule will apply to the VMs from the current group or the selected security group.
        1. Click **Save**. Repeat the steps to create all rules from the table.
   1. Click **Save**.

- CLI

   ```
   yc vpc security-group create --name=my-rdgw-sg `
     --network-name rdgw-network `
     --rule direction=ingress,protocol=icmp,v4-cidrs=[0.0.0.0/0],description=icmp `
     --rule direction=ingress,port=any,protocol=any,predefined=self_security_group,description=self `
     --rule direction=ingress,port=3389,protocol=tcp,v4-cidrs=[0.0.0.0/0],description=rdp `
     --rule direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0],description=rdgw `
     --rule direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0],description=default 
   ```

   Command execution result:

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

{% endlist %}

## Create a VM for the gateway {#create-gw}

Create a VM with a static address:

{% list tabs %}

- Management console

     1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.
     1. In the **Name** field, enter a name for the VM: `my-rds-gw`.
     1. Select the [availability zone](../../overview/concepts/geo-scope.md) `ru-central1-a`.
     1. Under **Image/boot disk selection**, select the **2019 Datacenter** image.
     1. Under **Disks**, enter 60 GB for the size of the boot disk.
     1. Under **Computing resources**:
         * Choose a [platform](../../compute/concepts/vm-platforms.md): Intel Ice Lake.
         * Specify the number of vCPUs and amount of RAM:
             * **vCPU**: 2
             * **Guaranteed vCPU share**: 100%
             * **RAM**: 4 GB
     1. Under **Network settings**, click **Add network** and select `rdgw-network`. Select `rdgw-subnet`. Under **Public address**, select **Automatically**. Select the `my-rdgw-sg` security group.
     1. Under **Access**, specify the data required to access the VM: enter your password in the **Password** field.
     1. Click **Create VM**.

- CLI

    1. In the PowerShell terminal, create a script named `setpass` to set up a password for the `Administrator` account using the `user-data` field in the [VM's metadata](../../compute/concepts/vm-metadata.md). The `cloudbase-init` utility executes it on the first run.

       {% note info %}

       The first line of the script must only contain `#ps1`, otherwise the `cloudbase-init` utility won't execute the script.

       {% endnote %}

        ```powershell
        #ps1
        Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<your password>" -AsPlainText -Force) 
        ```

    1. Create a VM and specify the created script as the metadata source. As the `security-group-ids` parameter, enter the ID of the `my-rdgw-group` security group:

       ```
       yc compute instance create `
            --name my-rds-gw `
            --hostname my-rds-gw `
            --memory 4 `
            --cores 2 `
            --zone ru-central1-a `
            --network-interface subnet-name=rdgw-subnet,ipv4-address=10.1.0.3,nat-ip-version=ipv4,security-group-ids=<id_my-rdgw-group> `
            --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-dc-gvlk `
            --metadata-from-file user-data=setpass
       ```

      Command execution result:

      ```
      done (25s)
      id: frmogfp7mm1kg87c25f3
      folder_id: big67u7m5flplkc6vvpc
      created_at: "2021-06-09T10:51:58Z"
      name: my-rds-gw
      zone_id: ru-central1-a
      platform_id: standard-v2
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
           fqdn: my-rds-gw.ru-central1.internal
           scheduling_policy: {}
           network_settings:
           type: STANDARD
           placement_policy: {}
      ```

{% endlist %}

## Configure the RDGW role {#role}

1. [Connect](../../compute/operations/vm-connect/rdp.md) to the created VM via RDP.
1. Install the required roles and [management snap-ins](https://docs.microsoft.com/en-us/troubleshoot/windows-server/system-management-components/what-is-microsoft-management-console#more-information):

    ```powershell
    Install-WindowsFeature RDS-Gateway -IncludeManagementTools
    ```

   Command execution result:

   ```
   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    No             Success        {Network Policy and Access Services, Remot...
   ```

1. Import the RDS module:

    ```powershell
    Import-Module -Name RemoteDesktopServices
    ```

1. Create a client access policy to allow all `Administrators` local group accounts to connect to the RDGW. You can do this using a [Windows PowerShell drive](https://docs.microsoft.com/en-us/powershell/scripting/samples/managing-windows-powershell-drives?view=powershell-7.1) that is created automatically when importing the role:

   ```powershell
   New-Item -Path 'RDS:\GatewayServer\CAP' -Name 'Default-CAP' -UserGroups Administrators@Builtin -AuthMethod '1'
   ```

   Command execution result:

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

   Command execution result:

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

1. Export the created certificate to later upload it to the `Trusted Roots Certificate Authorities` certificate store on the computer connecting to the VM. This is necessary for the client to trust the self-signed RDGW certificate:

    ```powershell
    $Certificate | Export-Certificate -FilePath "C:\REGW.cer"
    ```

   Command execution result:

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

   Command execution result:

   ```
       Directory: C:\
   
   Mode                LastWriteTime         Length Name
   ----                -------------         ------ ----
   -a----         6/9/2021  11:51 AM            796 REGW.cer
   ```

The gateway VM with the RDGW role configured allows `BUILTIN\Administrators` local group accounts to connect to VMs that do not have direct internet access.

## Test the RDGW {#test-rdgw}

1. Create a VM with no internet access and connect to it during the test.

    {% list tabs %}

    - Management console

        1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.
        1. In the **Name** field, enter the VM name: `test-vm`.
        1. Select the [availability zone](../../overview/concepts/geo-scope.md) `ru-central1-a`.
        1. Under **Image/boot disk selection**, select the **2019 Datacenter** image.
        1. Under **Disks**, enter 60 GB for the size of the boot disk.
        1. Under **Computing resources**:
            * Choose a [platform](../../compute/concepts/vm-platforms.md): Intel Ice Lake.
            * Specify the number of vCPUs and amount of RAM:
                * **vCPU**: 2
                * **Guaranteed vCPU share**: 100%
                * **RAM**: 4 GB
        1. Under **Network settings**, click **Add network** and select `rdgw-network`. Select `rdgw-subnet`. Under **Public address**, select **No address**.
        1. Under **Access**, specify the data required to access the VM: enter your password in the **Password** field.
        1. Click **Create VM**.

    - CLI

      Create a VM:

      ```
      yc compute instance create `
        --name test-vm `
        --hostname test-vm `
        --memory 4 `
        --cores 2 `
        --zone ru-central1-a `
        --network-interface subnet-name=rdgw-subnet,ipv4-address=10.1.0.4 `
        --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-dc-gvlk `
        --metadata-from-file user-data=setpass
      ```

      Command execution result:

      ```
      done (19s)
      id: fhm5pflreh2jellq97r0
      folder_id: big67u7m5flplkc6vvpc
      created_at: "2021-06-09T11:53:03Z"
      name: test-vm
      zone_id: ru-central1-a
      platform_id: standard-v2
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
        fqdn: test-vm.ru-central1.internal
        scheduling_policy: {}
        network_settings:
        type: STANDARD
        placement_policy: {}
      ```

    {% endlist %}

1. Import the created certificate to the `Trusted Roots Certificate Authorities` directory on the computer that you'll use to connect to the test VM.

   To connect to the gateway using the VM name, specify the name and external IP address of the created RDGW in the `C:\Windows\system32\drivers\hosts` file. For example:

    ```powershell
    87.250.250.242 my-rds-gw
    ```

1. Run the [`mstsc` utility](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/mstsc) that creates remote desktop connections. In the settings on the **Advanced** tab, specify the `my-rds-gw` VM name as the gateway, the `test-vm` name as the destination node, and `Administrator` as the username.

## Delete the created resources {#clear-out}

If you no longer need the created resources, delete the [VMs](../../compute/operations/vm-control/vm-delete.md) and [networks](../../vpc/operations/network-delete.md).
