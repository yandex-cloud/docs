# Updating a resource record

You can update the value of a [resource record](../concepts/resource-record.md). To update a record:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder to modify the DNS zone record in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
   1. Select the zone from the list.
   1. Click ![image](../../_assets/options.svg) next to the record you need and select **{{ ui-key.yacloud.common.edit }}**.
   1. Change the record TTL or value.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update a DNS zone:

   1. View a description of the CLI update record command:

      ```
      yc dns zone replace-records --help
      ```

   1. Change the record value:

      ```
      yc dns zone replace-records --name <zone name> \
      --record "<record domain name> 600 <record type> <new record value>"
      ```

- {{ TF }}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify that the DNS record has been updated in the [management console]({{ link-console-main }}) or using the [CLI](../../cli/quickstart.md) command below:

      ```
      yc dns zone list-records <DNS zone name>
      ```

- API

   To update a resource record, use the [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../api-ref/grpc/dns_zone_service.md#UpdateRecordSets) gRPC API call.

{% endlist %}

The value of resource [TXT records](../concepts/resource-record.md#txt) cannot contain more than 255 characters per line and 1024 characters total. If the new value contains more characters, split it into multiple values.
