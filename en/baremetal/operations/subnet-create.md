---
title: How to create a private subnet in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to create a private subnet and connect your {{ baremetal-full-name }} servers to it.
---

# Creating a private subnet

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [private subnet](../concepts/private-network.md#private-subnet).
  1. [Navigate]({{ link-console-main }}/link/baremetal) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks_uU4LH }}**.
  1. At the top right, click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_zone-id }}** field, select the [availability zone](../../overview/concepts/geo-scope.md) where your server will be located.
  1. In the **{{ ui-key.yacloud.baremetal.field_hardware-pool-id }}** field, select the [pool](../concepts/servers.md#server-pools) containing available servers for leasing.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, specify your subnet name. The naming requirements are as follows:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Optionally, you can add a subnet **{{ ui-key.yacloud.baremetal.field_description }}**.
  1. Optionally, you can add labels.
  1. Optionally, configure routing to allow communication with servers from other [pools](../concepts/servers.md#server-pools):

     1. Enable **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
     1. In the **{{ ui-key.yacloud.baremetal.field_network-id }}** field, select an existing [VRF](../concepts/private-network.md#vrf-segment) or create a new one.
     1. In the **{{ ui-key.yacloud.baremetal.field_CIDR_rwYMi }}** field, specify the subnet [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
     1. In the **{{ ui-key.yacloud.baremetal.field_gateway_t7LLk }}** field, specify the gateway IP address for routing traffic from this subnet to other VRF-connected subnets.
     
         {% include [default-gateaway](../../_includes/baremetal/instruction-steps/default-gateaway.md) %}

     1. Optionally, enable **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** to allow network interfaces on the private subnet to obtain IP addresses automatically.
     1. If you have enabled **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}**, specify an IP address range for assigning addresses to server network interfaces.
     
         {% include [default-dhcp](../../_includes/baremetal/instruction-steps/default-dhcp.md) %}

     1. Optionally, if DHCP is enabled, configure the [DNS servers and domain name](../concepts/dns.md) to provide to servers within the subnet:

         {% include [configure-dns](../../_includes/baremetal/instruction-steps/configure-dns.md) %}

         To use an incoming DNS connection, first [configure network connectivity](../tutorials/bm-vrf-and-vpc-interconnect.md) between the VRF and the {{ vpc-name }} cloud network, then [create a DNS connection](../../dns/operations/connection-inbound-create.md) in that network. Selecting a DNS server does not create routes or check its availability.

  1. Click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To configure DNS, use CLI version `1.37.0` or higher.

  1. View the description of the command for creating a [private subnet](../concepts/private-network.md#private-subnet):

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
       --vrf-options-spec '{
         vrf-id=<VRF_ID>,
         cidr=<CIDR>,
         gateway-ip=<gateway_IP_address>,
         dhcp-options={
           start-ip=<IP_address_range_start>,
           end-ip=<IP_address_range_end>,
           dns-options={
             servers=[
               {server={dns-inbound-endpoint-id=<DNS_connection_ID>}}
             ],
             domain-name=example.internal
           }
         }
       }'
     ```

     Where:
     * `--hardware-pool-id`: [Pool](../concepts/servers.md#server-pools) to lease a server from. This is a required setting.
     * `--name`: Subnet name. The naming requirements are as follows:
       
       {% include [name-format](../../_includes/name-format.md) %}
       
     * `--description`: Subnet description. This is an optional setting.
     * `--labels`: Subnet labels. This is an optional setting.
     * `--vrf-options-spec`: Routing settings for communication with servers from other pools. This is an optional setting. Possible settings:
       * `vrf-id`: ID of the [virtual network segment (VRF)](../concepts/private-network.md#vrf-segment).
       * `cidr`: Subnet [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
       * `gateway-ip`: Gateway IP address for routing traffic from this subnet to other VRF-connected subnets. This is an optional setting.
     
         {% include [default-gateaway](../../_includes/baremetal/instruction-steps/default-gateaway.md) %}

       * `dhcp-options`: DHCP settings. If the section is not provided, DHCP in the subnet is disabled. In `start-ip` and `end-ip`, specify the start and end of your IP address range for assigning addresses to server network interfaces.
     
         {% include [default-dhcp](../../_includes/baremetal/instruction-steps/default-dhcp.md) %}

         Under `dns-options`, you can customize [DNS settings](../concepts/dns.md):

         * `servers`: List of DNS servers. For each `server` item, specify either `dns-inbound-endpoint-id`, i.e., the incoming DNS connection ID, or `ip-address`, i.e., the IPv4 address of a custom DNS server, e.g., `{server={ip-address=192.168.10.2}}`. You can specify up to three items, comma-separated. For an inbound DNS connection, [configure network connectivity](./configure-dns.md#before-you-begin) first. You can get the connection ID by running this command: `yc dns inbound-endpoint list`.
         * `domain-name`: Search domain. This is an optional parameter. Replace `example.internal` with a custom domain, or delete the parameter if you do not need a search domain.

         If you do not need DNS settings, delete the `dns-options` section.

- API {#api}

  To create a private subnet, use the [create](../api-ref/PrivateSubnet/create.md) REST API method for the [PrivateSubnet](../api-ref/PrivateSubnet/index.md) resource or the [PrivateSubnetService/Create](../api-ref/grpc/PrivateSubnet/create.md) gRPC API call.

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
    --vrf-options-spec '{
      vrf-id=ly5j5qluq32z********,
      cidr=10.0.0.0/8,
      gateway-ip=10.0.0.1,
      dhcp-options={start-ip=10.0.1.2,end-ip=10.0.1.10}
    }'
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

- API {#api}

  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM_token>" \
    -d '{
      "folderId": "b1g07hj5r6i4********",
      "hardwarePoolId": "ru-central1-m3",
      "name": "demo-private-subnet",
      "description": "My first private subnet",
      "labels": {
        "env": "test"
      },
      "vrfOptionsSpec": {
        "vrfId": "ly5uyq2gbxu2********",
        "cidr": "10.0.*.*/8",
        "dhcpOptions": {
          "startIp": "10.0.*.*",
          "endIp": "10.0.*.*"
        },
        "gatewayIp": "10.0.*.*"
      }
    }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/privateSubnets"
  ```

  Where:

  * `<IAM_token>`: IAM token used for authentication.
  * `folderId`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
  * `hardwarePoolId`: ID of the [pool](../concepts/servers.md#server-pools) to lease a server from.
  * `name`: Subnet name. The naming requirements are as follows:
    
    {% include [name-format](../../_includes/name-format.md) %}
    
  * `description`: Subnet description. This is an optional parameter.
  * `labels`: Subnet labels. This is an optional parameter.
  * `vrfId`: ID of the [virtual network segment (VRF)](../concepts/private-network.md#vrf-segment).
  * `cidr`: Subnet [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
  * `gatewayIp`: Gateway IP address. This is an optional parameter.
  * `startIp`, `endIp`: Address range for DHCP. This is an optional parameter.

  Result:

  ```bash
  {
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.CreatePrivateSubnetMetadata",
      "privateSubnetId": "ly52xefxa2hi********"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.PrivateSubnet",
      "vrfOptions": {
        "dhcpOptions":
        {
          "startIp": "10.0.*.*",
          "endIp": "10.0.*.*"
        },
        "vrfId": "ly5licxve4z3********",
        "cidr": "10.0.*.*/8",
        "gatewayIp": "10.0.*.*"
      },
      "labels": {
        "env": "test"
      },
      "id": "ly52xefxa2hi********",
      "cloudId": "b1gia87mbaom********",
      "folderId": "b1g07hj5r6i4********",
      "name": "demo-private-subnet",
      "description": "My first private subnet",
      "status": "READY",
      "zoneId": "ru-central1-m",
      "hardwarePoolId": "ru-central1-m3",
      "createdAt": "2025-12-14T14:42:58.372557Z"
    },
    "id": "ly5hcnsbx3l4********",
    "description": "Private subnet create",
    "createdAt": "2025-12-14T14:42:58.375290Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-14T14:42:58.375290Z"
  }
  ```

  Follow the status of the operation by the `done` field.

{% endlist %}
