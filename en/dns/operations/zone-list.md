---
title: "How to get a list of DNS zones"
---

# Getting a list of DNS zones

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to view a list of [DNS zones](../concepts/dns-zone.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. The **{{ ui-key.yacloud.dns.label_zones-list }}** page will show the list of DNS zones.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to get a list of [DNS zones](../concepts/dns-zone.md):

     ```bash
      yc dns zone list --help
      ```

  1. To get a list of DNS zones, run this command:

      ```bash
      yc dns zone list
      ```

      Result:

      ```text
      +----------------------+------------+---------+------------------------------+-------------+
      |          ID          |    NAME    |  ZONE   |          VISIBILITY          | DESCRIPTION |
      +----------------------+------------+---------+------------------------------+-------------+
      | dns5djfi2h68******** | test-zone. | staging | PRIVATE enpncp31fh3n******** |             |
      +----------------------+------------+---------+------------------------------+-------------+
      ```

- API {#api}

  To get a list of [DNS zones](../concepts/dns-zone.md), use the [list](../api-ref/DnsZone/list.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/List](../api-ref/grpc/dns_zone_service.md#List) gRPC API call.

{% endlist %}