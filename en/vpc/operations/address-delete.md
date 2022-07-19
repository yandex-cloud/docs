# Deleting a static public IP address

{% note alert %}

Before deleting an address, you should release it by deleting the resource it's attached to.
You cannot restore an address after it is deleted.

{% endnote %}

{% list tabs %}

- Management console

   To delete a [static address](../concepts/address.md):
   1. In the [management console]({{ link-console-main }}), go to the folder where you need to delete the static address.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **IP addresses**.
   1. Click ![image](../../_assets/options.svg) in the line of the address to delete.
   1. In the menu that opens, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a static IP address:

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

{% endlist %}
