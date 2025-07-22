---
title: How to create a private subnet in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to create a private subnet and connect your {{ baremetal-full-name }} servers to it.
---

# Creating a private subnet

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [private subnet](../concepts/network.md#private-subnet).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}**.
  1. At the top right, click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_server-zone }}** field, select the [availability zone](../../overview/concepts/geo-scope.md) where your server will be located.
  1. In the **{{ ui-key.yacloud.baremetal.field_server-pool }}** field, select the [pool](../concepts/servers.md#server-pools) containing available servers for leasing.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, specify your subnet name. The naming requirements are as follows:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Optionally, you can add a subnet **{{ ui-key.yacloud.baremetal.field_description }}**.
  1. Optionally, you can add labels.
  1. Optionally, configure routing to allow communication with servers from other [pools](../concepts/servers.md#server-pools):

     1. Enable **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
     1. In the **{{ ui-key.yacloud.baremetal.field_network-id }}** field, select an existing [VRF](../concepts/network.md#vrf-segment) or create a new one.
     1. In the **{{ ui-key.yacloud.baremetal.field_CIDR }}** field, specify the subnet [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
     1. In the **{{ ui-key.yacloud.baremetal.field_gateway }}** field, specify the gateway IP address for routing traffic from this subnet to other VRF-connected subnets.
     
         {% include [default-gateaway](../../_includes/baremetal/instruction-steps/default-gateaway.md) %}

     1. Optionally, enable **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** to allow network interfaces on the private subnet to obtain IP addresses automatically.
     1. If you have enabled **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}**, specify an IP address range for assigning addresses to server network interfaces.
     
         {% include [default-dhcp](../../_includes/baremetal/instruction-steps/default-dhcp.md) %}

  1. Click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the command for creating a [private subnet](../concepts/network.md#private-subnet):

     ```bash
     yc baremetal private-subnet create --help
     ```
  
  1. Create a subnet:
     
     ```bash
     yc baremetal private-subnet create \
       --hardware-pool-id <pool> \
       --name <private_subnet_name> \
       --description "<private_subnet_description>" \
       --labels <key>=<value> \
       --vrf-options "vrf-id=<VRF_ID>,vrf-name=<VRF_name>,cidr=<CIDR>,gateway-ip=<gateway_ID_address>,dhcp=[start-ip=<IP_address_range_start>,end-ip=<IP_address_range_end>]"
     ```

     Where:
     * `--hardware-pool-id`: [Pool](../concepts/servers.md#server-pools) to lease a server from.
     * `--name`: Subnet name. The naming requirements are as follows:
       
       {% include [name-format](../../_includes/name-format.md) %}
       
     * `--description`: Subnet description. This is an optional parameter.
     * `--labels`: Subnet labels. This is an optional parameter.
     * `--vrf-options`: Routing settings for communication with servers from other pools. This is an optional parameter. Possible settings:
       * `vrf-id`: ID of the [virtual network segment (VRF)](../concepts/network.md#vrf-segment).
       * `vrf-name`: VRF name.
       * `cidr`: Subnet [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
       * `gateway-ip`: Gateway IP address for routing traffic from this subnet to other VRF-connected subnets. This is an optional parameter.
     
         {% include [default-gateaway](../../_includes/baremetal/instruction-steps/default-gateaway.md) %}

       * `dhcp`: IP address range for assigning addresses using DHCP to server network interfaces. This is an optional parameter.
     
         {% include [default-dhcp](../../_includes/baremetal/instruction-steps/default-dhcp.md) %}

{% endlist %}

## Example {#examples}

Create a private subnet with a VRF, CIDR, default gateway, and IP address range:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal private-subnet create \
    --hardware-pool-id ru-central1-m3 \
    --name demo-private-subnet \
    --description "My first private subnet" \
    --labels env=test \
    --hardware-pool-id ru-central1-m3 \
    --vrf-options "vrf-id=ly5j5qluq32z********,cidr=10.0.0.0/8,gateway-ip=10.0.0.1,dhcp=[start-ip=10.0.1.2,end-ip=10.0.1.10]"
  ```

  Result:  
  
  ```text
  id: ly5p3zynykcg********
  cloud_id: b1gia87mbaom********
  folder_id: b1gcqo0asnc1********
  name: demo-private-subnet
  description: My first private subnet
  status: READY
  zone_id: ru-central1-m
  hardware_pool_id: ru-central1-m3
  vrf_options:
    vrf_id: ly5j5qluq32z********
    cidr: 10.0.0.0/8
    dhcp_options:
      start_ip: 10.0.1.2
      end_ip: 10.0.1.10
    gateway_ip: 10.0.0.1
  created_at: "2025-06-26T13:28:29.348159Z"
  labels:
    env: test
  ```

{% endlist %}