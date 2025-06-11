---
title: How to update a resource record in {{ dns-full-name }}
description: In this tutorial, you will learn how to update a resource record.
---

# Updating a resource record

To update a [resource record](../concepts/resource-record.md), do the following:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your DNS zone.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Select the zone from the list.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the resource record you want to update and select **{{ ui-key.yacloud.common.edit }}**.
  1. Change the record TTL or value.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update a DNS zone:

  1. See the description of the CLI command for updating a resource record:

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

  To update a DNS record created with {{ TF }}:

  1. Open the {{ TF }} configuration file and edit the fragment describing your DNS record.

     {% cut "{{ TF }} DNS record description example" %}

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

     You can verify DNS record changes in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc dns zone list-records <zone_name>
     ```

- API {#api}

  To update a DNS resource record, use the [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../api-ref/grpc/DnsZone/updateRecordSets.md) gRPC API call.

{% endlist %}

A [TXT record](../concepts/resource-record.md#txt) value must be split into 255-character segments (strings) and cannot exceed 1024 characters total.

{% note info %}

You cannot modify [service resource records](../concepts/resource-record.md#service-records).

{% endnote %}