# Deleting a DNS zone

To delete a [DNS zone](../concepts/dns-zone.md):

{% list tabs %}

- Management console

  1. Open the **{{ dns-name }}** section in the folder to delete a DNS zone from.
  1. Click ![image](../../_assets/options.svg) in the row of the zone you want to delete.
  1. In the menu that opens, click **Delete**.
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

- Terraform

  Read more about Terraform in the [documentation](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To delete a DNS zone created using Terraform:

  1. Open the Terraform configuration file and delete the fragment with the DNS zone description.

     {% cut "Example of DNS record definition in Terraform configuration" %}

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

  1. In the command line, go to the directory with the Terraform configuration file.

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

     You can check if the DNS zone has been deleted in the [management console]({{ link-console-main }}) or using the [CLI](../../cli/quickstart.md) command:

     ```
     yc dns zone list
     ```

{% endlist %}

