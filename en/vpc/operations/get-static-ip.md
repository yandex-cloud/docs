# Reserving a static public IP address


You can reserve a static public IP address to use later for accessing cloud resources.

{% note info %}

Make sure to check out our [pricing policy](../pricing.md#prices-public-ip) for inactive static public IPs.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the page of the folder where you want to reserve an IP address.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Click **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
   1. In the window that opens:
       * In the **{{ ui-key.yacloud.vpc.addresses.popup-create_field_zone }}** field, select the availability zone where you want to reserve the address.
       * (Optional) Under **{{ ui-key.yacloud.vpc.addresses.popup-create_field_advanced }}**, enable **{{ ui-key.yacloud.common.field_ddos-protection-provider }}** and **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}**.
   1. Click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

- CLI {#cli}

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

      ```text
      id: e9b6un9gkso6********
      folder_id: b1g7gvsi89m3********
      created_at: "2021-01-19T17:52:42Z"
      external_ipv4_address:
        address: 178.154.253.52
        zone_id: {{ region-id }}-a
        requirements: {}
      reserved: true
      ```

      The static public IP address is reserved.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the parameters of the resources you want to create:

     * `name`: Static public IP address name. The name format is as follows:

          {% include [name-format](../../_includes/name-format.md) %}

     * `deletion_protection`: Static public IP deletion protection. You cannot delete an IP address with this option enabled. The default value is `false`.
     * `external_ipv4_address`: IPv4 address description:
        * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_vpc_address" "addr" {
       name = "<IP_address_name>"
       deletion_protection = "<deletion_protection>"
       external_ipv4_address {
         zone_id = "<availability_zone>"
       }
     }
     ```

     For more information about the `yandex_vpc_address` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_address).

  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc vpc address list
     ```

- API {#api}

  To reserve a static IP address, use the [create](../api-ref/Address/create.md) REST API method for the [Address](../api-ref/Address/index.md) resource or the [AddressService/Create](../api-ref/grpc/Address/create.md) gRPC API call, and provide the following in the request:

    * ID of the folder the static IP address will reside in, in the `folderId` parameter.
    * Name of the static public IP address, in the `name` parameter. The name format is as follows:

      {% include [name-format](../../_includes/name-format.md) %}

    * ID of the [availability zone](../../overview/concepts/geo-scope.md) the address will reside in, in the `externalIpv4AddressSpec.zoneId` parameter.

{% endlist %}
