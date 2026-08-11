---
title: How to update an inbound DNS connection in {{ dns-full-name }}
description: Follow this guide to update an inbound DNS connection.
---

# Updating an inbound DNS connection

To update an [inbound DNS connection](../concepts/dns-connection.md#dns-inbound):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the DNS connection folder.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. In the left-hand panel, select ![nodes-down](../../_assets/console-icons/nodes-down.svg) **{{ ui-key.yacloud.dns.label_inbound-endpoints }}**.
  1. In the row with the DNS connection, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. In the window that opens:

      1. Optionally, change the DNS connection [name](*name) in the **{{ ui-key.yacloud.common.name }}** field.
      1. Optionally, provide any description in the **{{ ui-key.yacloud.common.description }}** field.
      1. Optionally, set [labels](../../resource-manager/concepts/labels.md) for the DNS connection in the **{{ ui-key.yacloud.component.label-set.label_labels }}** field.
      1. Optionally, enable or disable the **{{ ui-key.yacloud.common.deletion-protection }}** setting based on whether you need to enable or disable protection of the connection from accidental deletion.
      1. Click **{{ ui-key.yacloud.common.save }}** to save your changes.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating an inbound DNS connection:

      ```bash
      yc dns inbound-endpoint update --help
      ```
  1. {% include [list-inbound-endpoints-cli](../../_includes/dns/list-inbound-endpoints-cli.md) %}
  1. Update the inbound DNS connection by specifying its name or ID:

      ```bash
      yc dns inbound-endpoint update <DNS_connection_name_or_ID> \
        --new-name <new_connection_name> \
        --description '<connection_description>' \
        --labels <key>=<value>[,<key>=<value>] \
        --deletion-protection
      ```

      Where:

      * `--new-name`: New [name](*name) for the inbound DNS connection. This is an optional setting.
      * `--description`: Connection description. This is an optional setting.
      * `--labels`: List of [labels](../../resource-manager/concepts/labels.md). This is an optional setting. You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.
      * `--deletion-protection`: Enables protection of the inbound DNS connection from accidental deletion. This is an optional setting.

          If you want to disable deletion protection, provide `--deletion-protection=false` in the command

      Result:

      ```text
      id: dns0uullmbcn********
      folder_id: b1gt6g8ht345********
      created_at: "2026-07-05T15:40:39.595Z"
      name: my-inbound-endpoint
      network_id: enpcfncr6uld********
      address: 192.168.3.3
      address_id: fl8not0e596n********
      status: AVAILABLE
      deletion_protection: true
      ```

      For more information about the `yc dns inbound-endpoint update` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Specify the inbound DNS connection properties in the configuration file:

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

      * `name`: DNS connection [name](*name).
      * `description`: Connection description. This is an optional setting.
      * `network_id`: ID of the {{ vpc-name }} [network](../../vpc/concepts/network.md#network) where the inbound DNS connection was created.
      * `address_id`: ID of the [reserved](../../vpc/operations/private-ip-reserve.md) [private](../../vpc/concepts/address.md#internal-addresses) IP address that will be used for the inbound DNS connection.
      * `deletion_protection`: Enables protection of the inbound DNS connection from accidental deletion. This is an optional setting.

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/get.md) command:

      ```bash
      yc dns inbound-endpoint get <DNS_connection_name>
      ```

- API {#api}

  To update an inbound DNS connection, use the [update](../api-ref/DnsInboundEndpoint/update.md) REST API method for the [DnsInboundEndpoint](../api-ref/DnsInboundEndpoint/index.md) resource or the [DnsInboundEndpointService/Update](../api-ref/grpc/DnsInboundEndpoint/update.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../concepts/dns-connection.md)
* [{#T}](../tutorials/dns-integration.md)

[*name]: {% include [name-format](../../_includes/_popups/name-format-general.md) %}