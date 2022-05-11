# Updating a resource record

You can update the value of a [resource record](../concepts/resource-record.md). To update a record:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing the DNS zone to update a record in.
   1. Select **{{ dns-name }}**.
   1. Select the zone from the list.
   1. Click ![image](../../_assets/options.svg) in the row next to the record to update.
   1. In the menu that opens, click **Edit**.
   1. Change the record's TTL or value.
   1. Click **Save**.

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

- Terraform

   For more information about Terraform, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To update a DNS record created using Terraform:

   1. Open the Terraform configuration file and edit the fragment with the DNS record description.

      {% cut "Example DNS record description in the Terraform configuration" %}

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

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, Terraform points them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press Enter.

      You can verify that the DNS record has been updated in the [management console]({{ link-console-main }}) or using the [CLI](../../cli/quickstart.md) command below:

      ```
      yc dns zone list-records <DNS zone name>
      ```

{% endlist %}
