# Deleting a resource record

To delete a [resource record](../concepts/resource-record.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing the DNS zone to delete a record from.
   1. Select **{{ dns-name }}**.
   1. Select the zone from the list.
   1. Click ![image](../../_assets/options.svg) in the row next to the record to delete.
   1. In the resulting menu, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI delete record command:

      ```
      yc dns zone delete-records --help
      ```
   1. Get a list of all records in the zone:

      ```
      yc dns zone list-records --name <DNS zone name>
      ```
   1. Delete a record:

      ```
      yc dns zone delete-records --name <DNS name zone> \
      --record "<domain name> <TTL> <record type> <value>"
      ```

- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a record created using {{ TF }} from the DNS zone:

   1. Open the {{ TF }} configuration file and delete the fragment with the DNS record description.

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


   1. In the command line, go to the directory with the {{ TF }} configuration file.

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc dns zone list-records <DNS zone name>
      ```

{% endlist %}
