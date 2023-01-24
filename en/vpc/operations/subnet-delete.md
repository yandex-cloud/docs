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
      ```

      Result:

      ```
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

- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   To delete a subnet created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the subnet description.

      {% cut "Example subnet description in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_vpc_subnet" "lab-subnet-a" {
        name           = "subnet-1"
        description    = "My first subnet"
        v4_cidr_blocks = ["10.2.0.0/16"]
        zone           = "{{ region-id }}-a"
        network_id     = "${yandex_vpc_network.lab-net.id}"
      }
      ...
      ```

      {% endcut %}

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc vpc subnet list
      ```

{% endlist %}

## Examples {#examples}

### Deleting a subnet from a particular folder {#from-folder}

{% list tabs %}

- CLI

   Delete a subnet from another folder:

   ```
   yc vpc subnet delete test-subnet-2 --folder-id b1gnbfd11bq5g5vnjgr4
   ```

   Where `--folder-id` is the ID of the folder.

   ```
   yc vpc subnet delete test-subnet-2 --folder-name test-folder
   ```

   Where `--folder-name` is the name of the folder.

   You can pass the ID and name as positional arguments, or you can use the `--id` and `--name` flags:

   ```
   yc vpc subnet delete --id enpavfmgapumnl7cqin8
   ```

   ```
   yc vpc subnet delete --name test-network-1
   ```

{% endlist %}
