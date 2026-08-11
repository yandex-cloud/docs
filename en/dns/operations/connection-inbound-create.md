---
title: How to create an inbound DNS connection in {{ dns-full-name }}
description: Follow this guide to create an inbound DNS connection.
---

# Creating an inbound DNS connection

{% include [inb-endpoint-1-per-netw-notice](../../_includes/dns/inb-endpoint-1-per-netw-notice.md) %}

To create an [inbound DNS connection](../concepts/dns-connection.md#dns-inbound):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to create an inbound DNS connection.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. In the left-hand panel, select ![nodes-down](../../_assets/console-icons/nodes-down.svg) **{{ ui-key.yacloud.dns.label_inbound-endpoints }}** and click **{{ ui-key.yacloud.dns.DnsInboundEndpointsListScreen.create_button }}**. In the window that opens:

      1. In the **{{ ui-key.yacloud.common.name }}** field, specify a [name](*name) for the new DNS connection.
      1. Optionally, provide any description in the **{{ ui-key.yacloud.common.description }}** field.
      1. Optionally, set [labels](../../resource-manager/concepts/labels.md) for the new resource in the **{{ ui-key.yacloud.component.label-set.label_labels }}** field.
      1. Optionally, enable **{{ ui-key.yacloud.common.deletion-protection }}** to protect the new DNS connection from accidental deletion.
      1. Under **{{ ui-key.yacloud.dns.DnsInboundEndpointForm.network_settings_title }}**, in the **{{ ui-key.yacloud.vpc.label_network }}** field, select the {{ vpc-full-name }} [cloud network](../../vpc/concepts/network.md#network) in which to create the inbound DNS connection.
      1. In the **{{ ui-key.yacloud.entity.ipAddress }}** field, select a reserved [private](../../vpc/concepts/address.md#internal-addresses) IP address for the inbound DNS connection.

          The IP address can belong to any of the subnets in the cloud network selected in the previous step.

          If you have no reserved private IP address or want to reserve a new one, click **{{ ui-key.yacloud.component.internal-v4-address-field.button_internal-address-reserve }}** and in the window that opens:

          1. In the **{{ ui-key.yacloud.common.name }}** field, enter a [name](*name) for the IP address.
          1. In the **{{ ui-key.yacloud.common.label_subnet }}** field, select a [subnet](../../vpc/concepts/network.md#subnet) to reserve the address in.
          1. In the **{{ ui-key.yacloud.vpc.addresses.popup-create_field_internal-v4-address }}** field, specify the IP address to reserve.

              This IP address must belong to the IP address range of the subnet you selected. You cannot specify IP addresses already used by {{ yandex-cloud }} resources.
          1. Optionally, enable **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}** to protect the address from accidental deletion.
          1. Click **{{ ui-key.yacloud.common.create }}** to reserve the address.
      1. Click **{{ ui-key.yacloud.common.create }}** to create an inbound DNS connection.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the CLI command description for creating an inbound DNS connection:

      ```bash
      yc dns inbound-endpoint create --help
      ```   
  1. Reserve an IP address for the inbound DNS connection in the required subnet:

      ```bash
      yc vpc address create \
        --name <name_of_address_to_reserve> \
        --description '<address_description>' \
        --internal-ipv4 subnet=<subnet_ID>,address=<IP_address>
      ```

      Where:

      * `--name`: [Name](*name) of the [private](../../vpc/concepts/address.md#internal-addresses) IP address to reserve.
      * `--description`: Description of the IP address to reserve. This is an optional setting.
      * `--internal-ipv4`: Attribute block for reserving a private IP address:

          * `subnet`: ID of the [subnet](../../vpc/concepts/network.md#subnet) the IP address will be reserved in.
          * `address`: IPv4 address to reserve. This IP address must belong to the IP address range of the subnet you selected. You cannot specify IP addresses already used by {{ yandex-cloud }} resources.

      Result:

      ```text
      id: fl8not0e596n********
      folder_id: b1gt6g8ht345********
      created_at: "2026-07-05T13:21:12Z"
      name: my-address
      description: inbound endpoint address
      internal_ipv4_address:
        address: 192.168.3.3
        subnet_id: fl8dmq91iruu********
      reserved: true
      type: INTERNAL
      ip_version: IPV4
      ```

      Save the ID (`id` field value) of the reserved address to create a DNS connection later.

      For more information about the `yc vpc address create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/address/create.md).
  1. Create an inbound DNS connection:

      ```bash
      yc dns inbound-endpoint create \
        --name <incoming_connection_name> \
        --description '<connection_description>' \
        --labels <key>=<value>[,<key>=<value>] \
        --network-id <network_ID> \
        --address-id <address_ID> \
        --deletion-protection
      ```

      Where:

      * `--name`: [Name](*name) of the new DNS connection.
      * `--description`: Connection description. This is an optional setting.
      * `--labels`: List of [labels](../../resource-manager/concepts/labels.md). This is an optional setting. You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.
      * `--network-id`: ID of the {{ vpc-full-name }} [network](../../vpc/concepts/network.md#network) the inbound DNS connection will be created in.
      * `--address-id`: Previously saved ID of the reserved IP address that will be used for the inbound DNS connection.
      * `--deletion-protection`: Enables protection of the new inbound DNS connection from accidental deletion. This is an optional setting.

      Result:

      ```text
      id: dns80efu32ve********
      folder_id: b1gt6g8ht345********
      created_at: "2026-07-05T13:32:36.880Z"
      name: my-inbound-endpoint
      network_id: enpcfncr6uld********
      address: 192.168.3.3
      address_id: fl8not0e596n********
      status: AVAILABLE
      ```

      For more information about the `yc dns inbound-endpoint create` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/create.md).

  1. Optionally, after you create an inbound DNS connection, test FQDN resolution through that connection. To do it, run the `dig` command by specifying the IP address of the inbound DNS connection and the FQDN of the resource in {{ yandex-cloud }}.
  
      Here is an example:

      ```bash
      dig @192.168.3.3 my-sample-vm.{{ region-id }}.internal
      ```

      Result:

      ```text
      ; <<>> DiG 9.18.39-0ubuntu0.24.04.5-Ubuntu <<>> @192.168.3.3 my-sample-vm.{{ region-id }}.internal
      ; (1 server found)
      ;; global options: +cmd
      ;; Got answer:
      ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 26971
      ;; flags: qr aa rd ra; MBZ: 0x4; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

      ;; OPT PSEUDOSECTION:
      ; EDNS: version: 0, flags:; udp: 1232
      ; COOKIE: 5628ffd26cc7ebc0 (echoed)
      ;; QUESTION SECTION:
      ;my-sample-vm.{{ region-id }}.internal. IN A

      ;; ANSWER SECTION:
      my-sample-vm.{{ region-id }}.internal. 600 IN A 192.168.2.22

      ;; Query time: 2 msec
      ;; SERVER: 192.168.3.3#53(192.168.3.3) (UDP)
      ;; WHEN: Sun Jul 05 13:39:52 UTC 2026
      ;; MSG SIZE  rcvd: 153
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, specify the properties of the resources you want to create:

      ```hcl
      resource "yandex_vpc_network" "my_net" {}

      resource "yandex_vpc_subnet" "subnet1" {
        network_id     = yandex_vpc_network.my_net.id
        v4_cidr_blocks = ["192.168.3.0/24"]
      }

      resource "yandex_vpc_address" "dns_address" {
        name        = "my-address"
        description = "inbound endpoint address"

        internal_ipv4_address {
          subnet_id = yandex_vpc_subnet.subnet1.id
          address   = "192.168.3.3"
        }
        deletion_protection = false
      }

      resource "yandex_dns_inbound_endpoint" "dns_connection" {
        name        = "my-inbound-endpoint"
        description = "DNS Inbound Endpoint"

        network_id  = yandex_vpc_network.my_net.id
        address_id  = yandex_vpc_address.dns_address.id

        deletion_protection = false
      }
      ```

      Where:

      * `name`: [Name](*name) of the new DNS connection.
      * `description`: Connection description. This is an optional setting.
      * `network_id`: ID of the {{ vpc-name }} [network](../../vpc/concepts/network.md#network) the inbound DNS connection will be created in.
      * `address_id`: ID of the [reserved](../../vpc/operations/private-ip-reserve.md) [private](../../vpc/concepts/address.md#internal-addresses) IP address that will be used for the inbound DNS connection.
      * `deletion_protection`: Enables protection of the new inbound DNS connection from accidental deletion. This is an optional setting.

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/get.md) command:

      ```bash
      yc dns inbound-endpoint get <DNS_connection_name>
      ```

- API {#api}

  To reserve a static IP address, use the [create](../../vpc/api-ref/Address/create.md) REST API method for the [Address](../../vpc/api-ref/Address/index.md) resource or the [AddressService/Create](../../vpc/api-ref/grpc/Address/create.md) gRPC API call.

  To create an inbound DNS connection, use the [create](../api-ref/DnsInboundEndpoint/create.md) REST API method for the [DnsInboundEndpoint](../api-ref/DnsInboundEndpoint/index.md) resource or the [DnsInboundEndpointService/Create](../api-ref/grpc/DnsInboundEndpoint/create.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../concepts/dns-connection.md)
* [{#T}](../tutorials/dns-integration.md)

[*name]: {% include [name-format](../../_includes/_popups/name-format-general.md) %}