# Moving a subnet to a different folder

You can move cloud resources between folders within a single [cloud](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs %}

- Management console

   To move a [subnet](../concepts/network.md) to another folder:

   1. In the [management console]({{ link-console-main }}), go to the folder with the subnet.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Click on the name of the subnet's cloud network.
   1. Click ![image](../../_assets/options.svg) in the row of the subnet to be moved and select **Move**.
   1. Select the destination folder from the drop-down list.
   1. Click **Move**.

   {% note info %}

   Subnets can also be [moved](network-move.md) as part of a cloud network.

   {% endnote %}

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a [subnet](../concepts/network.md) to another folder:

   1. View a description of the CLI move subnet command:

      ```bash
      yc vpc subnet move --help
      ```

   1. Get the name or ID of the subnet to move:

      ```bash
      yc vpc subnet list
      ```
      Result:
      ```text
      +----------------------+----------+----------------------+----------------+---------------+------------------+
      |          ID          |   NAME   |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
      +----------------------+----------+----------------------+----------------+---------------+------------------+
      | e9bcd5mq43cnrsfckikh | subnet-a | encb4ubvmief09h6qg5e |                | {{ region-id }}-a | [10.1.0.0/16]    |
      | e2llon52hhss119t4g2c | subnet-b | enc39op1vq9m8tjr3udp |                | {{ region-id }}-b | [192.168.1.0/24] |
      | b0cscj0f9uq59ig7o6u0 | subnet-c | enc772aa2rgqiqq67ehu |                | {{ region-id }}-c | [10.0.0.0/16]    |
      +----------------------+----------+----------------------+----------------+---------------+------------------+
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

   1. Move the subnet by specifying the name or ID of the subnet and destination folder:

      ```bash
      yc vpc subnet move <subnet_name_or_ID> \
        --destination-folder-name <name_of_destination_folder> \
        --destination-folder-id <ID_of_destination_folder>
      ```
      Use either the `--destination-folder-name` parameter or the `--destination-folder-id` parameter.

      If the subnet is not in the current folder (default folder), specify the source folder using the `--folder-name` or `--folder-id` option.

      Result:
      ```text
       id: e9bcd5mq43cnrsfckikh
       folder_id: b1chgf288nvg541tgu73
       created_at: "2022-10-08T15:03:39Z"
       name: subnet-a
       network_id: encb4ubvmief09h6qg5e
       zone_id: {{ region-id }}-a
       v4_cidr_blocks:
         - 10.1.0.0/16
       dhcp_options: {}
      ```
      For more information about the `yc vpc subnet move` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/move.md).

- API

   To move a [subnet](../concepts/network.md#subnet) to a different folder, use the [move](../api-ref/Subnet/move.md) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/Move](../api-ref/grpc/subnet_service.md#Move) gRPC API call.

{% endlist %}

## Examples {#examples}

### Subnet in the current folder {#from-default-folder}

Move a subnet from the current folder by specifying the subnet name and destination folder name:

{% list tabs %}

- CLI

   ```bash
   yc vpc subnet move subnet-a \
     --destination-folder-name my-folder-1
   ```

{% endlist %}

### Subnet in a different folder {#from-another-folder}

Move a subnet from a different folder. Specify the subnet ID and the source and destination folder IDs:

{% list tabs %}

- CLI

   ```bash
   yc vpc subnet move enc39op1vq9m8tjr3udp \
     --folder-id b1chgf288nvg541tgu73 \
     --destination-folder-id b1cs8ie21pk10aurd2c3
   ```

{% endlist %}

#### See also {#see-also}

* [{#T}](network-move.md)

