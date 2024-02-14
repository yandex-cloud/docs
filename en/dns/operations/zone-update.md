# Updating a DNS zone

You can modify a [DNS zone](../concepts/dns-zone.md) after it is created by renaming it or adding a description.

To update a DNS zone:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update a DNS zone.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row of the zone to update.
   1. In the menu that opens, click **{{ ui-key.yacloud.common.edit }}**.
   1. Edit the zone settings.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update a DNS zone:

   1. View a description of the CLI update zone command:

      ```
      yc dns zone update --help
      ```

   1. Change the visibility of the zone in the networks:

      ```
      yc dns zone update <zone_name_or_ID> --network-ids=<network_IDs_for_the_zone>,
      ```

      Where `--network-ids` refers to the IDs of the networks for the zone.

      Result:

      ```
      id: aet29qhara5j********
      folder_id: aoerb349v3h4********
      created_at: "2021-02-21T09:21:03.935Z"
      name: new-zone-name
      zone: staging.
      private_visibility:
        network_ids:
        - c645mh47vsc********
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

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

        zone = "test.example-public2.com."
      }
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


   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can make sure the DNS zone has been updated in the [management console]({{ link-console-main }}) or via the [CLI](../../cli/quickstart.md) command below:

      ```
      yc dns zone get <zone_name>
      ```

- API {#api}

   To update a DNS zone, use the [update](../api-ref/DnsZone/update.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/Update](../api-ref/grpc/dns_zone_service.md#Update) gRPC API call.

{% endlist %}
