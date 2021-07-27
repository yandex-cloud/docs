---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Making a dynamic public IP address static

You can make a dynamic public IP address static. Static public IP addresses are reserved and remain attached to respective resources when VMs and load balancers are stopped.

{% note info %}

Pay attention to the [pricing policy](../pricing.md#prices-public-ip) for inactive static public IPs.

{% endnote %}

{% list tabs %}

* Management console

   To change a public IP address from dynamic to static:
   1. Go to the page of the folder with cloud resources that have dynamic public IP addresses and select **Virtual Private Cloud**.
   1. Select **IP addresses**.
   1. Click ![image](../../_assets/options.svg) in the row of the address that you want to make static.
   1. In the menu that opens, select **Make static**.
   1. In the window that opens, click **Edit**.

* CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change a public IP address from dynamic to static:

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
      | e2l46k8conff8n6ru1jl |      | 84.201.177.41 | false    | true |
      +----------------------+------+---------------+----------+------+
      ```

      The `false` value of the RESERVED parameter of the IP address with the ID `e2l46k8conff8n6ru1jl` shows that this address is dynamic.

   1. Make the address static by using the `--reserved=true` key and address ID:

      ```bash
      yc vpc address update --reserved=true e2l46k8conff8n6ru1jl
      ```

      Execution result:

      ```bash
      id: e2l46k8conff8n6ru1jl
      folder_id: b1g7gvsi89m34pipa3ke
      created_at: "2021-01-14T09:36:46Z"
      external_ipv4_address:
        address: 84.201.177.41
        zone_id: ru-central1-b
        requirements: {}
      reserved: true
      used: true
      ```

      The `reserved` parameter value changed to `true` and the IP address is now static.

{% endlist %}

