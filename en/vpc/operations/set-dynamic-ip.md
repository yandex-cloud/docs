# Making a static public IP address dynamic

You can make a static public IP address dynamic. If a dynamic IP address is used by a VM, then the address resets each time the VM stops. When the VM starts up, it may be allocated a different address.

{% list tabs %}

* Management console

   To change a public IP address from static to dynamic:
   1. Go to the folder with the static IP and select **Virtual Private Cloud**.
   1. Select **IP addresses**.
   1. Click ![image](../../_assets/options.svg) in the row of the address that you want to make dynamic.
   1. In the menu that opens, select **Make dynamic**.
   1. In the window that opens, click **Edit**.

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

      Execution result:

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

      Execution result:

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

