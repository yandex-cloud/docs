---
title: How to get a list of DNS zones
---

# Getting a list of DNS zones

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder contaning [DNS zones](../concepts/dns-zone.md) you want to view.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. You will see the list of DNS zones on the **{{ ui-key.yacloud.dns.label_zones-list }}** page.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting a list of [DNS zones](../concepts/dns-zone.md):

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

  To get a list of [DNS zones](../concepts/dns-zone.md), use the [list](../api-ref/DnsZone/list.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/List](../api-ref/grpc/DnsZone/list.md) gRPC API call.

{% endlist %}