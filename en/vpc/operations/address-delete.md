# Deleting a static public IP address

{% note alert %}

Before deleting a [static IP](../concepts/address.md), you should release it by deleting the resource it is attached to.
You cannot restore an address after it is deleted.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to delete the static address.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Click ![image](../../_assets/options.svg) next to the IP you need and select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI delete address command:

      ```bash
      yc vpc address delete --help
      ```

   1. Get a list of addresses in the default folder:

      ```bash
      yc vpc address list
      ```

      Result:

      ```bash
      +----------------------+------+----------------+----------+-------+
      |          ID          | NAME |    ADDRESS     | RESERVED | USED  |
      +----------------------+------+----------------+----------+-------+
      | e9b6un9gkso6stdh6b3p |      | 178.154.253.52 | true     | false |
      +----------------------+------+----------------+----------+-------+
      ```

   1. Delete the address by specifying its ID:

      ```bash
      yc vpc address delete e9b6un9gkso6stdh6b3p
      ```

- API

   To delete a [static IP address](../concepts/address.md), use the [delete](../api-ref/Address/delete.md) REST API method for the [Address](../api-ref/Address/index.md) resource or the [AddressService/Delete](../api-ref/grpc/address_service.md#Delete) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a static public IP address created with {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the static public IP description.

      Sample description of a static public IP address in the {{ TF }} configuration:

      ```hcl
      ...
      resource "yandex_vpc_address" "addr" {
        name = "exampleAddress"
        external_ipv4_address {
          zone_id = "{{ region-id }}-a"
        }
      }
      ...
      ```

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc vpc address list
      ```

{% endlist %}
