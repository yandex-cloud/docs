# Moving a cloud network to a different folder

You can move cloud resources between folders within a single [cloud](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs %}

- Management console

   To move a [cloud network](../concepts/network.md) to a different folder:

   1. In the [management console]({{ link-console-main }}), go to the folder where the cloud network is located.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Click ![image](../../_assets/options.svg) in the row of the network to be moved and select **Move**.
   1. Select the destination folder from the drop-down list.
   1. Click **Move**.

   {% note info %}

   The cloud network's subnets are also moved to the other folder.

   {% endnote %}

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a [cloud network](../concepts/network.md) to a different folder:

   1. View a description of the CLI move cloud network command:

      ```bash
      yc vpc network move --help
      ```

   1. Get the name or ID of the cloud network to move:

      ```bash
      yc vpc network list
      ```
      Result:
      ```text
      +----------------------+-----------+
      |          ID          |   NAME    |
      +----------------------+-----------+
      | encb4ubvmief09h6qg5e | default   |
      | enc39op1vq9m8tjr3udp | network-1 |
      | enc772aa2rgqiqq67ehu | network-2 |
      +----------------------+-----------+
      ```

   1. Get a list of available folders:

      ```bash
      yc resource-manager folder list
      ```

      Result:
      ```text
      +----------------------+------------------------+--------+--------+
      |          ID          |          NAME          | LABELS | STATUS |
      +----------------------+------------------------+--------+--------+
      | b1cs8ie21pk10aurd2c3 | default                |        | ACTIVE |
      | b1chgf288nvg541tgu73 | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh690at5bm7 | my-folder-2            |        | ACTIVE |
      +----------------------+------------------------+--------+--------+
      ```

   1. Move the network by specifying the name or ID of the network and destination folder:

      ```bash
      yc vpc network move <network_name_or_ID> \
        --destination-folder-name <name_of_destination_folder> \
        --destination-folder-id <ID_of_destination_folder>
      ```
      Use either the `--destination-folder-name` parameter or the `--destination-folder-id` parameter.

      If the network is not in the current folder (default folder), specify the source folder using the `--folder-name` or `--folder-id` option.

      Result:
      ```text
      id: enc39op1vq9m8tjr3udp
       folder_id: b1chgf288nvg541tgu73
       created_at: "2022-10-06T14:54:48Z"
       name: network-1
       default_security_group_id: enc2ta63h3q2jsri70ll
      ```
      For more information about the `yc vpc network move` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/network/move.md).

- API

   To move a [cloud network](../concepts/network.md) to a different folder, use the [move](../api-ref/Network/move.md) REST API method for the [Network](../api-ref/Network/index.md) resource or the [NetworkService/Move](../api-ref/grpc/network_service.md#Move) gRPC API call.

{% endlist %}

## Examples {#examples}

### Cloud network in the current folder {#from-default-folder}

Move a cloud network from the current folder by specifying the network name and destination folder name:

{% list tabs %}

- CLI

   ```bash
   yc vpc network move network-1 \
     --destination-folder-name my-folder-1
   ```

{% endlist %}

### Cloud network in a different folder {#from-another-folder}

Move a cloud network from a different folder. Specify the network ID and the source and destination folder IDs:

{% list tabs %}

- CLI

   ```bash
   yc vpc network move enc39op1vq9m8tjr3udp \
     --folder-id b1chgf288nvg541tgu73 \
     --destination-folder-id b1cs8ie21pk10aurd2c3
   ```

{% endlist %}
