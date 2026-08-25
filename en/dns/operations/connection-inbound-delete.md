---
title: How to delete an inbound DNS connection in {{ dns-full-name }}
description: Follow this guide to delete an inbound DNS connection.
---

# Deleting an inbound DNS connection

To delete an [inbound DNS connection](../concepts/dns-connection.md#dns-inbound):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder containing the DNS connection.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. In the left-hand panel, select ![nodes-down](../../_assets/console-icons/nodes-down.svg) **{{ ui-key.yacloud.dns.label_inbound-endpoints }}**.
  1. In the row with the DNS connection, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting an inbound DNS connection:

      ```bash
      yc dns inbound-endpoint delete --help
      ```   
  1. {% include [list-inbound-endpoints-cli](../../_includes/dns/list-inbound-endpoints-cli.md) %}
  1. Delete the inbound DNS connection by specifying its name or ID:

      ```bash
      yc dns inbound-endpoint delete <DNS_connection_name_or_ID>
      ```

      For more information about the `yc dns inbound-endpoint delete` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/delete.md).

      {% note info %}

      If the inbound DNS connection you are deleting has deletion protection enabled, disable it before deleting. For more information, see [{#T}](./connection-inbound-update.md).

      {% endnote %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. To delete an inbound DNS connection created using {{ TF }}, open the {{ TF }} configuration file and delete the DNS connection description fragment.

      {% cut "Here is a sample description for an inbound DNS connection in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_dns_inbound_endpoint" "dns_connection" {
        name        = "my-inbound-endpoint"
        description = "DNS Inbound Endpoint"

        network_id  = yandex_vpc_network.my_net.id
        address_id  = yandex_vpc_address.dns_address.id

        deletion_protection = false
      }
      ...
      ```

      {% endcut %}

  1. Apply your changes to delete the inbound DNS connection:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will delete the inbound DNS connection. You can check the resource deletion using the [management console]({{ link-console-main }}) or this [CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/list.md) command:

      ```bash
      yc dns inbound-endpoint list
      ```

- API {#api}

  To delete an inbound DNS connection, use the [delete](../api-ref/DnsInboundEndpoint/delete.md) REST API method for the [DnsInboundEndpoint](../api-ref/DnsInboundEndpoint/index.md) resource or the [DnsInboundEndpointService/Delete](../api-ref/grpc/DnsInboundEndpoint/delete.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../concepts/dns-connection.md)
* [{#T}](../tutorials/dns-integration.md)