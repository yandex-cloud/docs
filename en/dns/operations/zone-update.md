# Updating a DNS zone

You can rename or add a descriptoin to an existing [DNS zone](../concepts/dns-zone.md).

To update a DNS zone:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the DNS zone you want to update.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Find the zone you want to update and click ![image](../../_assets/console-icons/ellipsis.svg) in its row.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.edit }}**.
  1. Edit zone settings as needed.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update a DNS zone:

  1. See the description of the CLI command for updating a DNS zone:

     ```
     yc dns zone update --help
     ```

  1. Configure DNS zone visibility settings for specific networks:

     ```
     yc dns zone update <zone_name_or_ID> --network-ids=<zone_network_IDs>,
     ```

     Where `--network-ids` is a list of network IDs authorized to access this DNS zone.

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

  To update a DNS zone created with {{ TF }}:

  1. Open the {{ TF }} configuration file and edit the fragment describing the DNS zone.

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

     
  1. Type `yes` and press **Enter** to confirm changes.

     You can check whether the DNS zone has been successfully updated in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```
     yc dns zone get <zone_name>
     ```

- API {#api}

  To update a DNS zone, use the [update](../api-ref/DnsZone/update.md) REST API method for the [DnsZone](../api-ref/DnsZone/index.md) resource or the [DnsZoneService/Update](../api-ref/grpc/DnsZone/update.md) gRPC API call.

{% endlist %}
