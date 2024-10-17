---
title: How to delete a subnet
description: Follow this guide to delete a subnet.
---

# Deleting a subnet

{% note alert %}

Before deleting a [subnet](../concepts/network.md#subnet), disable all resources connected to it.
You cannot restore a subnet after it is deleted.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to delete a subnet.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the subnet you need and select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

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
      | e2l0psbfoloe******** | test-subnet-1         | ... | [192.168.0.0/24] |
      ...
      +----------------------+-----------------------+-----+------------------+
      ```

   1. Select the `ID` or `NAME` of the subnet.
   1. Delete the subnet from the default folder:

      ```
      yc vpc subnet delete test-subnet-1
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

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

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc vpc subnet list
      ```

- API {#api}

   To delete a [subnet](../concepts/network.md#subnet), use the [delete](../api-ref/Subnet/delete.md) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/Delete](../api-ref/grpc/Subnet/delete.md) gRPC API call and provide the ID of the subnet to be deleted in the `subnetId` request parameter.

   {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

   {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

## Examples {#examples}

### Deleting a subnet from a particular folder {#from-folder}

{% list tabs group=instructions %}

- CLI {#cli}

   Delete a subnet from another folder:

   ```
   yc vpc subnet delete test-subnet-2 --folder-id b1gnbfd11bq5********
   ```

   Where `--folder-id` is the ID of the folder.

   ```
   yc vpc subnet delete test-subnet-2 --folder-name test-folder
   ```

   Where `--folder-name` is the name of the folder.

   You can provide the ID and name not only as positional arguments but also using the `--id` and `--name` flags:

   ```
   yc vpc subnet delete --id enpavfmgapum********
   ```

   ```
   yc vpc subnet delete --name test-network-1
   ```

{% endlist %}
