# Converting a static public IP address to dynamic

You can convert a static public IP address set for a cloud resource to dynamic. If a dynamic IP address is used by a VM, it will disappear when the VM is stopped and change when it is started again.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing the address.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the IP address and select **{{ ui-key.yacloud.vpc.addresses.button_action-dynamic }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_dynamic }}**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's update address attribute command:

      ```bash
      yc vpc address update --help
      ```

   1. Get a list of addresses in the default folder:

      ```bash
      yc vpc address list
      ```

      Result:

      ```text
      +----------------------+------+---------------+----------+------+
      |          ID          | NAME |    ADDRESS    | RESERVED | USED |
      +----------------------+------+---------------+----------+------+
      | e2l46k8conff******** |      | 84.201.177.41 | true     | true |
      +----------------------+------+---------------+----------+------+
      ```

      The `true` value of the `RESERVED` parameter for the IP address with the `e2l46k8conff********` ID shows that this IP is static.

   1. Convert it to dynamic by using the `--reserved=false` key and the address ID:

      ```bash
      yc vpc address update --reserved=false e2l46k8conff********
      ```

      Result:

      ```text
      id: e2l46k8conff********
      folder_id: b1g7gvsi89m3********
      created_at: "2021-01-14T09:36:46Z"
      external_ipv4_address:
        address: 84.201.177.41
        zone_id: {{ region-id }}-a
        requirements: {}
      used: true
      ```

      The IP address is now dynamic.

- API {#api}

  To change the type of a public IP address from static to dynamic, use the [update](../api-ref/Address/update.md) REST API method for the [Address](../api-ref/Address/index.md) resource or the [AddressService/Update](../api-ref/grpc/address_service.md#Update) gRPC API call, and provide the following in the request:

  * ID of the IP address you want to convert to dynamic in the `addressId` parameter.

    {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * `false` in the `reserved` parameter.
  * Name of the `reserved` parameter in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
