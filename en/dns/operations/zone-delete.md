---
title: How to delete a public zone in {{ dns-full-name }}
description: In this tutorial, you will learn how to delete a public DNS zone.
---

# Deleting a DNS zone

To delete a [DNS zone](../concepts/dns-zone.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your DNS zone.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Find the zone you want to delete and click ![image](../../_assets/console-icons/ellipsis.svg) in its row.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting a DNS zone:

      ```
      yc dns zone delete --help
      ```
  1. Get a list of all DNS zones in the default folder:

      ```
      yc dns zone list
      ```
  1. Select the zone `ID` or `NAME`.
  1. Delete the selected zone from the default folder:

      ```
      yc dns zone delete <zone_name_or_ID>
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a DNS zone created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment describing your DNS zone.

     {% cut "{{ TF }} DNS zone description example" %}

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

     You can check whether the DNS zone was successfully deleted in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```
     yc dns zone list
     ```

- API {#api}

  To delete a DNS zone, use the [delete](../api-ref/DnsZone/delete.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/Delete](../api-ref/grpc/DnsZone/delete.md) gRPC API call.

{% endlist %}
