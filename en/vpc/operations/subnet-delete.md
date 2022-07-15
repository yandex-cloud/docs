# Deleting a subnet

{% note alert %}

Before deleting a subnet, disable all resources connected to it.
You cannot restore a subnet after it is deleted.

{% endnote %}

{% list tabs %}

- Management console

   To delete a [subnet](../concepts/network.md#subnet):
   1. In the [management console]({{ link-console-main }}), go to the folder where you need to delete a subnet.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Click on the name of the subnet's cloud network.
   1. Click ![image](../../_assets/options.svg) in the line of the subnet to delete.
   1. In the menu that opens, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command for deleting a subnet:

      ```
      yc vpc subnet delete --help
      ```
   1. Get a list of all subnets in the default folder:

      ```
      yc vpc subnet list
      +----------------------+-----------------------+------------------------+
      |          ID          |         NAME          | ... |       RANGE      |
      +----------------------+-----------------------+------------------------+
      ...
      | e2l0psbfoloefpjb1rau | test-subnet-1         | ... | [192.168.0.0/24] |
      ...
      +----------------------+-----------------------+-----+------------------+
      ```
   1. Select the `ID` or `NAME` of the subnet.
   1. Delete the subnet from the default folder:

      ```
      yc vpc subnet delete test-subnet-1
      ```
{% endlist %}

## Examples {#examples}

### Deleting a subnet from a particular folder {#from-folder}

{% list tabs %}
- CLI

   To delete a subnet from a different folder, use the `--folder-id` or `--folder-name` flag.

   ```
   yc vpc subnet delete test-subnet-2 --folder-id b1gnbfd11bq5g5vnjgr4
   ```
   ```
   yc vpc subnet delete test-subnet-2 --folder-name test-folder
   ```

   You can pass the ID and name as positional arguments, or you can use the `--id` and -`-name` flags:

   ```
   yc vpc subnet delete --id enpavfmgapumnl7cqin8
   ```
   ```
   yc vpc subnet delete --name test-network-1
   ```
{% endlist %}
