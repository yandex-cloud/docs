# Updating a DNS zone

You can modify a [DNS zone](../concepts/dns-zone.md) after it is created by renaming it or adding a description.

To update a DNS zone:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to update a DNS zone.
   1. Select **{{ dns-name }}**.
   1. Click ![image](../../_assets/options.svg) in the row next to the zone to update.
   1. In the menu that opens, click **Edit**.
   1. Edit the zone settings.
   1. Click **Save**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update a DNS zone:

   1. View a description of the CLI's update zone command:

      ```
      yc dns zone update --help
      ```

   1. Change the visibility of the zone in the networks:

      ```
      yc dns zone update <zone name or ID> \
      --private-visibility network-ids=c645mh47vscba1d64tbs,
      ```

      Result:

      ```
      id: aet29qhara5jeg45tbjg
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2021-02-21T09:21:03.935Z"
      name: <new zone name>
      zone: staging.
      private_visibility:
        network_ids:
        - c645mh47vscba1d64tbs
      ```

- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To update a DNS zone created using {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the fragment with the DNS zone description.

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


   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can make sure the DNS zone has been updated in the [management console]({{ link-console-main }}) or via the [CLI](../../cli/quickstart.md) command below:

      ```
      yc dns zone get <DNS zone name>
      ```

{% endlist %}
