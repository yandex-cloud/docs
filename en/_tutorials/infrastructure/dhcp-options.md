# DHCP settings for working with a corporate DNS server


If you want your VMs to resolve names in a private corporate DNS zone, use the [DHCP options](../../vpc/concepts/dhcp-options.md) in the [subnet configuration](../../vpc/operations/subnet-create.md). For example, you can specify a DNS suffix and DNS server for subnet nodes.

To run this scenario, make sure you have a corporate DNS server deployed that is available for the VMs in the cloud. You can also Deploy Active Directory to create an infrastructure with a DNS server:

* Cloud network named `ad-network` with subnets in different [availability zones](../../overview/concepts/geo-scope.md):
    * `ad-subnet-a` (10.1.0.0/16)
    * `ad-subnet-b` (10.2.0.0/16)
    * `ad-subnet-d` (10.3.0.0/16)
* Domain controllers and a bastion host:
    * `ad-vm-a` (10.1.0.3)
    * `ad-vm-b` (10.2.0.3)
    * `jump-server-vm` (10.3.0.x)

In this tutorial, you will add a new subnet, `10.128.0.0/24`, with the DNS suffix and DNS server specified, create a VM, and test the network.

To add a subnet with DHCP settings:

* [Get your cloud ready](#before-begin).
* [Create a subnet](#create-subnet).
* [Test the network](#check-config).

If you no longer need the resources you created, [delete](#clear-out) them.

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

To pass this scenario in full, deploy Active Directory. If you use your own DNS servers that are available for cloud VMs, specify your own DNS suffix and IP address values in the scenario.

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for continuously running virtual machines (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for VM disk storage (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using dynamic or static public IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for {{ yandex-cloud }} outbound internet traffic (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

## Create a subnet {#create-subnet}

To create a new subnet with DHCP settings, follow these steps:

{% list tabs group=instructions %}

- Management console {#console}

  To create a subnet:
  1. Open the **{{ vpc-name }}** section in the folder where you want to create a subnet.
  1. Click `ad-network`.
  1. Click **Add subnet**.
  1. Fill out the form:
      * Enter the subnet name: `test-subnet-1`. Select the availability zone: `{{ region-id }}-a`.
      * Enter the subnet CIDR: `10.128.0.0/24`. For more information about subnet IP address ranges, see [Cloud networks and subnets](../../vpc/concepts/network.md).
  1. Specify **DHCP settings**:
      * In the **Domain name** field, specify the DNS suffix: `yantoso.net`.
      * In the **Domain name servers** field, click **Add DNS server** and specify the DNS server address: `10.1.0.3`. Repeat the steps for the `10.2.0.3` address.
  1. Click **Create subnet**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  Run this command:

  ```
  yc vpc subnet create --name test-subnet-1 \
    --description "My test subnet" \
    --folder-id <folder_ID> \
    --network-name ad-network \
    --zone {{ region-id }}-a \
    --range 10.128.0.0/24 \
    --domain-name yantoso.net \
    --domain-name-server 10.1.0.3,10.2.0.3
  ```

  Where `<folder_ID>` is the ID of the folder to create resources in. If the folder is specified in the CLI profile, this parameter can be omitted.

  Result:

  ```
  id: e2ldy0b1prtj********
  folder_id: b1gbvco8fejm********
  created_at: "2021-07-12T13:28:54Z"
  name: test-subnet-1
  description: My test subnet
  network_id: enpl0t90hept********
  zone_id: {{ region-id }}-a
  v4_cidr_blocks:
  - 10.128.0.0/24
  dhcp_options:
    domain_name_servers:
    - 10.1.0.3
    - 10.2.0.3
    domain_name: yantoso.net
  ```

{% endlist %}

## Test the network {#check-config}

To check the configuration, create a VM and connect to it via RDP:

1. Create a VM:

    {% list tabs group=instructions %}
    
    - Management console {#console}

      1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) dashboard of the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
      1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the `{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}` tab and select the **Windows Server** image. For more information on how to upload your own image for Microsoft products, see [Importing a custom image](../../microsoft/byol.md#how-to-import).
      1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md) to create your VM in.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify your boot [disk](../../compute/concepts/disk.md) size: `50 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and RAM size:

          * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Cascade Lake`
          * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
          * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
          * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`
          * Make your VM [preemptible](../../compute/concepts/preemptible-vm.md), if required.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select `ad-network` and `test-subnet-1`.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vm-for-tests-in-subnet`.
      1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

      1. {% include [vm-reset-password-windows-operations](../../_includes/compute/reset-vm-password-windows-operations.md) %}

    - CLI {#cli}
    
      {% include [include](../../_includes/cli-install.md) %}
    
      To set a password for the VM, create the `metadata.yaml` file with the following contents:

      ```
      #ps1
      net user administrator '<password>'
      ```

      To create a VM, run the command:

      ```
      yc compute instance create \
        --name vm-for-tests-in-subnet \
        --metadata-from-file user-data=metadata.yaml \
        --zone {{ region-id }}-a \
        --cores 2 \
        --memory 4 \
        --network-interface subnet-name=test-subnet-1,nat-ip-version=ipv4 \
        --create-boot-disk image-id=<image_ID>
      ```

      Where `<image_ID>` is the ID of your Windows Server image used for creating the VM.

      {% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

      If the command is successful, save the IP address from the `one_to_one_nat` field. The address is used in the next step to create an RDP connection:

      ```
      ...
      status: RUNNING
      ...
      primary_v4_address:
        address: 10.128.0.26
      ...
      one_to_one_nat:
        address: 130.193.40.112
        ip_version: IPV4
      ...
      ```

    {% endlist %}

1. Wait a few minutes and [connect to the VM](../../compute/operations/vm-connect/rdp.md) over RDP.

1. Run PowerShell on the VM.

1. To view the Windows network configuration, run the command:

    ```
    ipconfig /all
    ```

    Result:

    ```
    Windows IP Configuration
    
      Host Name . . . . . . . . . . . . : epdpjtg********
      Primary Dns Suffix  . . . . . . . :
      Node Type . . . . . . . . . . . . : Hybrid
      IP Routing Enabled. . . . . . . . : No
      WINS Proxy Enabled. . . . . . . . : No
      DNS Suffix Search List. . . . . . : yantoso.net
    
    Ethernet adapter Ethernet 2:
    
      Connection-specific DNS Suffix  . : yantoso.net
      Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter #2
      Physical Address. . . . . . . . . : D0-0D-19-9F-60-C2
      DHCP Enabled. . . . . . . . . . . : Yes
      Autoconfiguration Enabled . . . . : Yes
      Link-local IPv6 Address . . . . . : fe80::1f0:5a1e:76ea:3ded%3(Preferred)
      IPv4 Address. . . . . . . . . . . : 10.128.0.11(Preferred)
      Subnet Mask . . . . . . . . . . . : 255.255.255.0
      Lease Obtained. . . . . . . . . . : Wednesday, July 14, 2021 11:00:09 AM
      Lease Expires . . . . . . . . . . : Saturday, August 20, 2157 5:33:50 PM
      Default Gateway . . . . . . . . . : 10.128.0.1
      DHCP Server . . . . . . . . . . . : 10.128.0.2
      DHCPv6 IAID . . . . . . . . . . . : 114298137
      DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-28-80-7B-90-D0-0D-19-9F-60-C2
      DNS Servers . . . . . . . . . . . : 10.1.0.3
                                          10.2.0.3
      NetBIOS over Tcpip. . . . . . . . : Enabled
    
    Tunnel adapter isatap.yantoso.net:
    
      Media State . . . . . . . . . . . : Media disconnected
      Connection-specific DNS Suffix  . : yantoso.net
      Description . . . . . . . . . . . : Microsoft ISATAP Adapter
      Physical Address. . . . . . . . . : 00-00-00-00-00-00-00-E0
      DHCP Enabled. . . . . . . . . . . : No
      Autoconfiguration Enabled . . . . : Yes
    ```

1. Check if there is a connection to the `yantoso.net` domain controller. 

    To do this, run the following command:

    ```
    ping ad-vm-a
    ```
    
    If connected, the output should look as follows:

    ```
    PS C:\Users\Administrator> ping ad-vm-a
    
    Pinging ad-vm-a.yantoso.net [10.1.0.3] with 32 bytes of data:
    Reply from 10.1.0.3: bytes=32 time=1ms TTL=127
    Reply from 10.1.0.3: bytes=32 time<1ms TTL=127
    Reply from 10.1.0.3: bytes=32 time<1ms TTL=127
    Reply from 10.1.0.3: bytes=32 time<1ms TTL=127
    
    Ping statistics for 10.1.0.3:
        Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
    Approximate round trip times in milli-seconds:
        Minimum = 0ms, Maximum = 1ms, Average = 0ms
    ```

## How to delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. Delete the `vm-for-tests-in-subnet` VM.

    {% list tabs group=instructions %}

    - Management console {#console}

      1. Select the folder that the VM belongs to. 
      1. On the folder dashboard, go to {{ compute-name }}.
      1. Select the VM → click ![image](../../_assets/console-icons/ellipsis.svg) → select **Delete**.
      1. Confirm the deletion.

    - CLI {#cli}
    
      {% include [include](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      To delete the VM, run:

      ```
      yc compute instance delete vm-for-tests-in-subnet
      ```

    {% endlist %}

1. Delete `test-subnet-1`.

    {% list tabs group=instructions %}

    - Management console {#console}
    
      1. Open the **{{ vpc-name }}** section in the folder you want to delete a subnet from.
      1. Click the name of the subnet's cloud network: `ad-network`.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the `test-subnet-1` row.
      1. In the menu that opens, click **Delete**.
      1. Confirm the deletion and click **Delete**.

    - CLI {#cli}

      {% include [include](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      To delete the subnet, run:

      ```
      yc vpc subnet delete --name test-subnet-1
      ```

    {% endlist %}

