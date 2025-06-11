---
title: How to delete a resource record in {{ dns-full-name }}
description: In this tutorail, you will learn how to delete a resource record.
---

# Deleting a resource record

To delete a [resource record](../concepts/resource-record.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the DNS zone with the record you want to delete.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Select the zone from the list.
  1. Find the record you want to delete and click ![image](../../_assets/console-icons/ellipsis.svg) in its row.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting a record:

      ```
      yc dns zone delete-records --help
      ```
  1. Get a list of all zone records:

      ```
      yc dns zone list-records --name <zone_name>
      ```
  1. Delete the record:

     ```
     yc dns zone delete-records --name <zone_name> \
     --record "<domain_name> <TTL> <record_type> <value>"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a DNS resource record created with {{ TF }}, do the following:

  1. Open the {{ TF }} configuration file and delete the fragment describing the DNS record.
     
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


  1. In the command line, navigate to the directory with the {{ TF }} configuration file.

  1. Check the configuration using this command:
     ```
     terraform validate
     ```
     
     If the configuration is correct, you will get this message:
     
     ```
     Success! The configuration is valid.
     ```

  1. Run this command:
     ```
     terraform plan
     ```
  
     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains errors, {{ TF }} will show them.

  1. Apply the changes:
     ```
     terraform apply
     ```
     
  1. Type `yes` and press **Enter** to confirm changes.

     You can check the updates in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```
     yc dns zone list-records <zone_name>
     ```

- API {#api}

  To delete a resource record, use the [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../api-ref/grpc/DnsZone/updateRecordSets.md) gRPC API call.

{% endlist %}