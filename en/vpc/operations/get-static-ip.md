# Reserving a static public IP address

You can reserve a static public IP address to use later for accessing cloud resources.

{% note info %}

Make sure to check out our [pricing policy](../pricing.md#prices-public-ip) for inactive static public IPs.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the page of the folder where you want to reserve an IP address.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Click **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
   1. In the window that opens:
      * In the **{{ ui-key.yacloud.vpc.addresses.popup-create_field_zone }}** field, select the availability zone where you want to reserve the address.
      * (Optional) Under **{{ ui-key.yacloud.vpc.addresses.popup-create_field_advanced }}**, enable **{{ ui-key.yacloud.vpc.addresses.popup-create_field_ddos-protection-provider }}** and **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}**.
   1. Click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI reserve address command:

      ```bash
      yc vpc address create --help
      ```

   1. Reserve the address by specifying the availability zone:

      ```bash
      yc vpc address create --external-ipv4 zone={{ region-id }}-a
      ```

      Result:

      ```bash
      id: e9b6un9gkso6stdh6b3p
      folder_id: b1g7gvsi89m34pipa3ke
      created_at: "2021-01-19T17:52:42Z"
      external_ipv4_address:
        address: 178.154.253.52
        zone_id: {{ region-id }}-a
        requirements: {}
      reserved: true
      ```

      The static public IP address is reserved.

- API

   To reserve a static IP address, use the [create](../api-ref/Address/create.md) REST API method for the [Address](../api-ref/Address/index.md) resource or the [AddressService/Create](../api-ref/grpc/address_service.md#Create) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `name`: Static public IP address name. Use this name format:

         {% include [name-format](../../_includes/name-format.md) %}

      * `external_ipv4_address`: IPv4 address description:
         * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).

      Example of the configuration file structure:

      ```hcl
      resource "yandex_vpc_address" "addr" {
        name = "<static public IP address name>"
        external_ipv4_address {
          zone_id = "<availability zone>"
        }
      }
      ```

      For more information about the `yandex_vpc_address` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_address).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can verify that the resources are there and their configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

         ```
         yc vpc address list
         ```

{% endlist %}
