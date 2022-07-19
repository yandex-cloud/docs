# Reserving a static public IP address

You can reserve a static public IP address to use later for accessing cloud resources.

{% note info %}

Pay attention to the [pricing policy](../pricing.md#prices-public-ip) for inactive static public IPs.

{% endnote %}

{% list tabs %}

- Management console

   To reserve a static public IP address:
   1. In the [management console]({{ link-console-main }}), go to the page of the folder where you want to reserve an IP address.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **IP addresses**.
   1. Click **Reserve address**.
   1. In the window that opens, select the availability zone where you want to reserve the address.
   1. Click **Reserve address**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To reserve a static public IP address:

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

{% endlist %}
