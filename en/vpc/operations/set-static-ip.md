# Converting a dynamic public IP address to static

You can convert a dynamic public IP address to static. Static public IP addresses are reserved and remain attached to respective resources when VMs and network load balancers are stopped.

{% note info %}

Make sure to check out our [pricing policy](../pricing.md#prices-public-ip) for inactive static public IPs.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing the appropriate address.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Click ![image](../../_assets/options.svg) next to the IP you need and select **{{ ui-key.yacloud.vpc.addresses.button_action-static }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_static }}**.

- CLI

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

      ```bash
      +----------------------+------+---------------+----------+------+
      |          ID          | NAME |    ADDRESS    | RESERVED | USED |
      +----------------------+------+---------------+----------+------+
      | e2l46k8conff******** |      | 84.201.177.41 | false    | true |
      +----------------------+------+---------------+----------+------+
      ```

      The `false` value of the RESERVED parameter of the IP address with the `e2l46k8conff********` ID shows that this address is dynamic.

   1. Make the address static by using the `--reserved=true` key and address ID:

      ```bash
      yc vpc address update --reserved=true e2l46k8conff********
      ```

      Result:

      ```bash
      id: e2l46k8conff********
      folder_id: b1g7gvsi89m3********
      created_at: "2021-01-14T09:36:46Z"
      external_ipv4_address:
        address: 84.201.177.41
        zone_id: {{ region-id }}-a
        requirements: {}
      reserved: true
      used: true
      ```

      The `reserved` parameter value changed to `true` and the IP address is now static.

- API

   To change the type of a public IP address from dynamic to static, use the [update](../api-ref/Address/update.md) REST API method for the [Address](../api-ref/Address/index.md) resource or the [AddressService/Update](../api-ref/grpc/address_service.md#Update) gRPC API call, and provide the following in the request:

   * ID of the address to be changed to static, in the `addressId` parameter.

      {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

      {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

   * `true` value, in the `reserved` parameter.
   * Name of the `reserved` parameter, in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
