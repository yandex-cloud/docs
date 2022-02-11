# Updating a DNS zone

After creating a [DNS zone](../concepts/dns-zone.md), you can update it: rename the zone, add a description, or select other networks for it.

To update a DNS zone:

{% list tabs %}

- Management console

  1. Open the **{{ dns-name }}** section in the folder where you want to update a DNS zone.
  1. Click ![image](../../_assets/options.svg) in the row of the zone you want to update.
  1. In the menu that opens, click **Edit**.
  1. Update the zone parameters, for example, change its visibility settings or add it to other networks.
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

     Command output:

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

- Terraform

  Read more about Terraform in the [documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  To update a DNS zone created using Terraform:

  1. Open the Terraform configuration file and edit the fragment with the DNS zone description.

     {% cut "Example of DNS zone definition in Terraform configuration" %}

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

     The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, Terraform points them out.

  1. Confirm the changes: type `yes` into the terminal and press Enter.

     You can check the DNS zone parameter changes in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

     ```
     yc dns zone get <DNS zone name>
     ```

{% endlist %}

