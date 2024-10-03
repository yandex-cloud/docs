---
title: How to update a resource record in {{ dns-full-name }}
description: Follow this guide to update a resource record.
---

# Updating a resource record

You can update the value of a [resource record](../concepts/resource-record.md). To update a record:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder to modify the DNS zone record in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Select the zone from the list.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the record you need and select **{{ ui-key.yacloud.common.edit }}**.
  1. Change the record TTL or value.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update a DNS zone:

  1. View a description of the CLI update record command:

     ```bash
     yc dns zone replace-records --help
     ```

  1. Change the record value:

     ```bash
     yc dns zone replace-records --name <zone_name> \
     --record "<domain_name> 600 <record_type> <new_value>"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To update a DNS record created using {{ TF }}:

  1. Open the {{ TF }} configuration file and edit the fragment with the DNS record description.

     {% cut "Example DNS record description in the {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_dns_recordset" "rs1" {
       zone_id = yandex_dns_zone.zone1.id
       name    = "srv.example.com."
       type    = "A"
       ttl     = 200
       data    = ["10.1.0.1"]
     }
     ...
     ```

     {% endcut %}

  1. Check the configuration using this command:

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the DNS record update in the [management console]({{ link-console-main }}) or using the [CLI](../../cli/quickstart.md) command below:

     ```bash
     yc dns zone list-records <zone_name>
     ```

- API {#api}

  To update a resource record, use the [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../api-ref/grpc/dns_zone_service.md#UpdateRecordSets) gRPC API call.

{% endlist %}

The value of resource [TXT records](../concepts/resource-record.md#txt) cannot contain more than 255 characters per line and 1024 characters total. If the new value contains more characters, split it into multiple values.

{% note info %}

You cannot modify a [service resource record](../concepts/resource-record.md#service-records).

{% endnote %}