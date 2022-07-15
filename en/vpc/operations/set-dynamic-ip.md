# Making a static public IP address dynamic

A static public IP address set for a cloud resource can be made dynamic. If a dynamic IP address is used by a VM, it disappears when it's stopped and changes the next time it's started.

{% list tabs %}

* Management console

   To change a public IP address from static to dynamic:
   1. In the [management console]({{ link-console-main }}), select the folder containing the appropriate address.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **IP addresses**.
   1. Click ![image](../../_assets/options.svg) in the row of the address that you want to make dynamic.
   1. In the menu that opens, select **Make dynamic**.
   1. In the window that opens, click **Change**.

* CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change a public IP address from static to dynamic:

   1. See the description of the CLI's update address attribute command:

      ```bash
      yc vpc address update --help
      ```

   1. Get a list of addresses in the default folder:

      ```bash
      yc vpc address list
      ```

      Output:

      ```bash
      +----------------------+------+---------------+----------+------+
      |          ID          | NAME |    ADDRESS    | RESERVED | USED |
      +----------------------+------+---------------+----------+------+
      | e2l46k8conff8n6ru1jl |      | 84.201.177.41 | true     | true |
      +----------------------+------+---------------+----------+------+
      ```

      The `true` value of the RESERVED parameter of the IP address with the ID `e2l46k8conff8n6ru1jl` shows that this address is static.

   1. Make the address dynamic using the `--reserved=false` key and the address ID:

      ```bash
      yc vpc address update --reserved=false e2l46k8conff8n6ru1jl
      ```

      Output:

      ```bash
      id: e2l46k8conff8n6ru1jl
      folder_id: b1g7gvsi89m34pipa3ke
      created_at: "2021-01-14T09:36:46Z"
      external_ipv4_address:
        address: 84.201.177.41
        zone_id: {{ region-id }}-a
        requirements: {}
      used: true
      ```

      The IP address is now dynamic.

{% endlist %}
