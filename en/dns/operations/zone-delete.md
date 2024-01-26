---
title: "How to delete a public zone in {{ dns-full-name }}"
description: "Follow this guide to delete a public DNS zone."
---

# Deleting a DNS zone

To delete a [DNS zone](../concepts/dns-zone.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to delete a DNS zone from.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
   1. Click ![image](../../_assets/options.svg) in the row of the zone to delete.
   1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

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
      yc dns zone delete <zone_name_or_ID>
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

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

        zone = "test.example-public2.com."
      }
      ```

      {% endcut %}

   1. In the command line, go to the directory with the {{ TF }} configuration file.

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

      You can check the DNS zone deletion using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```
      yc dns zone list
      ```

- API {#api}

   To delete a DNS zone, use the [delete](../api-ref/DnsZone/delete.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/Delete](../api-ref/grpc/dns_zone_service.md#Delete) gRPC API call.

{% endlist %}
