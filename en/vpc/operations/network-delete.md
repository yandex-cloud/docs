# Deleting a cloud network

{% note alert %}

Before you delete a network, you need to [delete](subnet-delete.md) all its subnets.

You cannot restore a network after it is deleted.

{% endnote %}

{% list tabs %}

- Management console

   To delete a [cloud network](../concepts/network.md#network):
   1. In the [management console]({{ link-console-main }}), go to the folder where you need to delete a cloud network.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Click ![image](../../_assets/options.svg) in the line of the network to delete.
   1. In the menu that opens, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete cloud network command:

      ```
      yc vpc network delete --help
      ```

   1. Get a list of all networks in the default folder:

      ```
      yc vpc network list
      ```
      Result:
      ```
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpiuvhhd4t80k4n80i8 | test-network-1 |
      | enplom7a98s1t0lhass8 | default        |
      +----------------------+----------------+
      ```

   1. Select the `ID` or `NAME` of the network you need.
   1. Delete the network:

      ```
      yc vpc network delete test-network-1
      ```
{% endlist %}
