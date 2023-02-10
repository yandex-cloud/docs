# Deleting a DNS zone

To delete a [DNS zone](../concepts/dns-zone.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to delete a DNS zone.
   1. Select **{{ dns-name }}**.
   1. Click ![image](../../_assets/options.svg) in the row next to the zone to delete it.
   1. In the resulting menu, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI delete zone command:

      ```
      yc dns zone delete --help
      ```
   1. Get a list of all DNS zones in the default folder:

      ```
      yc dns zone list
      ```
   1. Select the `ID` or `NAME` of the zone.
   1. Delete the zone from the default folder:

      ```
      yc dns zone delete <zone name or ID>
      ```

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a DNS zone created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the DNS zone description.

      {% cut "Example DNS zone description in the {{ TF }} configuration" %}

      ```hcl
      resource "yandex_vpc_network" "foo" {}

      resource "yandex_dns_zone" "zone1" {
        name        = "my-public-zone"
        description = "Test public zone"

        labels = {
          label1 = "test-public"
        }

        zone    = "test.example-public2.com."
      }
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

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can make sure the DNS zone has been deleted in the [management console]({{ link-console-main }}) or via the [CLI](../../cli/quickstart.md) command below:

      ```
      yc dns zone list
      ```

{% endlist %}
