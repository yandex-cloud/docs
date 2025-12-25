# Configuring deletion protection

To prevent accidental deletion of a static public IP address, [enable deletion protection for it](#enable-deletion-protection).

You can [disable](#disable) this option when you no longer need it.

## Enabling deletion protection {#enable-deletion-protection}

{% list tabs %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder where you reserved the IP address.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. In the row with the IP address, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.vpc.addresses.button_action-enable-protection }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_enable-protection }}**.

- CLI {#cli}

    {% include [include](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. See the description of the CLI command for updating address attributes:

        ```bash
        yc vpc address update --help
        ```

    1. Get the list of addresses in the folder:

        ```bash
        yc vpc address list
        ```

        Result:

        ```text
        +----------------------+------+---------------+----------+------+
        |          ID          | NAME |    ADDRESS    | RESERVED | USED |
        +----------------------+------+---------------+----------+------+
        | e2l46k8conff******** |      | 84.201.177.41 | false    | true |
        +----------------------+------+---------------+----------+------+
        ```

    1. Enable deletion protection:

        ```bash
        yc vpc address update --deletion-protection <address_name_or_ID>
        ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Open the current configuration file describing the infrastructure.

    1. Add the `deletion_protection` parameter to the IP address description:


       ```hcl
       resource "yandex_vpc_address" "addr" {
         ...
         deletion_protection = true
         ...
       }
       ```

    1. Make sure the settings are correct.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Apply the changes.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  To enable IP address deletion protection, use the [update](../api-ref/Address/update.md) REST API method for the [Address](../api-ref/Address/index.md) resource or the [AddressService/Update](../api-ref/grpc/Address/update.md) gRPC API call and provide the following in the request:

  * ID of the address you want to disable protection for in the `addressId` parameter.

    {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * Name of the `deletionProtection` parameter in the `updateMask` parameter.
  * `true` in the `deletionProtection` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Disabling deletion protection {#disable}

{% list tabs %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder where you reserved the IP address.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. In the row with the IP address, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.vpc.addresses.button_action-disable-protection }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_disable-protection }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating address attributes:

      ```bash
      yc vpc address update --help
      ```

  1. Get the list of addresses in the folder:

      ```bash
      yc vpc address list
      ```

      Result:

      ```text
      +----------------------+------+---------------+----------+------+
      |          ID          | NAME |    ADDRESS    | RESERVED | USED |
      +----------------------+------+---------------+----------+------+
      | e2l46k8conff******** |      | 84.201.177.41 | false    | true |
      +----------------------+------+---------------+----------+------+
      ```

  1. Disable deletion protection:

      ```bash
      yc vpc address update --deletion-protection=false <address_name_or_ID>
      ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Open the current configuration file describing the infrastructure.

    1. In the IP address description, set `deletion_protection` to `false`.


       ```hcl
       resource "yandex_vpc_address" "addr" {
         ...
         deletion_protection = false
         ...
       }
       ```

    1. Make sure the settings are correct.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Apply the changes.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  To disable deletion protection for the IP address, use the [update](../api-ref/Address/update.md) REST API method for the [Address](../api-ref/Address/index.md) resource or the [AddressService/Update](../api-ref/grpc/Address/update.md) gRPC API call and provide the following in the request:

  * ID of the address you want to disable protection for in the `addressId` parameter.

    {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * Name of the `deletionProtection` parameter in the `updateMask` parameter.
  * `false` in the `deletionProtection` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
