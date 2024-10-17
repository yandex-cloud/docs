# Moving a subnet to a different folder

You can move [subnets](../concepts/network.md) between folders within a single [cloud](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder with the subnet.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the subnet you need and select **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.
   1. In the window that opens, select the destination folder.
   1. Click **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.

   {% note info %}

   Subnets can also be [moved](network-move.md) as part of a cloud network.

   {% endnote %}

- CLI {#cli}

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
      | e9bcd5mq43cn******** | subnet-a | encb4ubvmief******** |                | {{ region-id }}-a | [10.1.0.0/16]    |
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
      | b1cs8ie21pk1******** | default                |        | ACTIVE |
      | b1chgf288nvg******** | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh6******** | my-folder-2            |        | ACTIVE |
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
       id: e9bcd5mq43cn********
       folder_id: b1chgf288nvg********
       created_at: "2022-10-08T15:03:39Z"
       name: subnet-a
       network_id: encb4ubvmief********
       zone_id: {{ region-id }}-a
       v4_cidr_blocks:
         - 10.1.0.0/16
       dhcp_options: {}
      ```
      For more information about the `yc vpc subnet move` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/move.md).

- API {#api}

   To move a [subnet](../concepts/network.md#subnet) to a different folder, use the [move](../api-ref/Subnet/move.md) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/Move](../api-ref/grpc/Subnet/move.md) gRPC API call, and provide the following in the request:

   * ID of the subnet to be moved, in the `subnetId` parameter.

      {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

   * ID of the folder you want to move the subnet to, in the `destinationFolderId` parameter.

      {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

## Examples {#examples}

### Subnet in the current folder {#from-default-folder}

Move a subnet from the current folder by specifying the subnet name and destination folder name:

{% list tabs group=instructions %}

- CLI {#cli}

   ```bash
   yc vpc subnet move subnet-a \
     --destination-folder-name my-folder-1
   ```

{% endlist %}

### Subnet in a different folder {#from-another-folder}

Move a subnet from a different folder. Specify the subnet ID and the source and destination folder IDs:

{% list tabs group=instructions %}

- CLI {#cli}

   ```bash
   yc vpc subnet move enc39op1vq9m******** \
     --folder-id b1chgf288nvg******** \
     --destination-folder-id b1cs8ie21pk1********
   ```

{% endlist %}

#### See also {#see-also}

* [{#T}](network-move.md)

