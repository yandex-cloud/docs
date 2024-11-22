# Moving a route table to a different folder

You can move cloud resources between folders within a single [cloud](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs group=instructions %}

- Management console {#console}

  To move a [route table](../concepts/routing.md) to another folder:

  1. In the [management console]({{ link-console-main }}), go to the folder containing the route table.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the table to move and select **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.
  1. Select the destination folder from the drop-down list.
  1. Click **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To move a [route table](../concepts/routing.md) to another folder:

  1. View the description of the CLI move route table command:

      ```bash
      yc vpc route-table move --help
      ```

  1. Get the name or ID of the route table to move:

      ```bash
      yc vpc route-table list
      ```
      Result:
      ```text
      +----------------------+---------+-------------+----------------------+
      |          ID          |  NAME   | DESCRIPTION |      NETWORK-ID      |
      +----------------------+---------+-------------+----------------------+
      | enp8c7ia88i8******** | table-1 |             | encb4ubvmief******** |
      +----------------------+---------+-------------+----------------------+
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

  1. Move the route table by specifying the name or ID of the table and destination folder:

     ```bash
     yc vpc route-table move <route_table_name_or_ID> \
       --destination-folder-name <destination_folder_name> \
       --destination-folder-id <destination_folder_ID>
     ```
     Use either `--destination-folder-name` or `--destination-folder-id`.

     If the route table is not in the current folder (default folder), specify the source folder using `--folder-name` or `--folder-id`.

     Result:
     ```text
     id: enp8c7ia88i8********
     folder_id: b1chgf288nvg********
     created_at: "2022-10-10T05:55:39Z"
     name: table-1
     network_id: encb4ubvmief********
     ```
     For more information about the `yc vpc route-table move` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/route-table/move.md).

- API {#api}

  To move a [route table](../concepts/routing.md) to a different folder, use the [move](../api-ref/RouteTable/move.md) REST API method for the [RouteTable](../api-ref/RouteTable/index.md) resource or the [RouteTableService/Move](../api-ref/grpc/RouteTable/move.md) gRPC API call, and provide the following in the request:

  * ID of the route table you need to move in the `routeTableId` parameter.

    To get the route table ID, use the [list](../api-ref/RouteTable/list) REST API method for the [RouteTable](../api-ref/RouteTable/index.md) resource or the [RouteTableService/List](../api-ref/grpc/RouteTable/list.md) gRPC API call and provide the current folder ID in the `folderId` request parameter.

  * ID of the folder the route table will be moved to in the `destinationFolderId` parameter.

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

## Examples {#examples}

### Route table in the current folder {#from-default-folder}

Move a route table from the current folder by specifying the table name and destination folder name:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc route-table move table-1 \
    --destination-folder-name my-folder-1
  ```

{% endlist %}


#### See also {#see-also}

* [{#T}](network-move.md)
* [{#T}](subnet-move.md)

