# Moving a route table to a different folder

You can move cloud resources between folders within a single [cloud](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs %}

- Management console

   To move a [route table](../concepts/static-routes.md) to another folder:

   1. In the [management console]({{ link-console-main }}), go to the folder where the route table is located.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/route-tables.svg) **Route tables**.
   1. Click ![image](../../_assets/options.svg) in the row of the table to be moved and select **Move**.
   1. Select the destination folder from the drop-down list.
   1. Click **Move**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a [route table](../concepts/static-routes.md) to another folder:

   1. View a description of the CLI move route table command:

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
      | enp8c7ia88i8lm60ah1s | table-1 |             | encb4ubvmief09h6qg5e |
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
      | b1cs8ie21pk10aurd2c3 | default                |        | ACTIVE |
      | b1chgf288nvg541tgu73 | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh690at5bm7 | my-folder-2            |        | ACTIVE |
      +----------------------+------------------------+--------+--------+
      ```

   1. Move the route table by specifying the name or ID of the table and destination folder:

      ```bash
      yc vpc route-table move <route_table_name_or_ID> \
        --destination-folder-name <name_of_destination_folder> \
        --destination-folder-id <ID_of_destination_folder>
      ```
      Use either the `--destination-folder-name` parameter or the `--destination-folder-id` parameter.

      If the route table is not in the current folder (default folder), specify the source folder using the `--folder-name` or `--folder-id` option.

      Result:
      ```text
      id: enp8c7ia88i8lm60ah1s
      folder_id: b1chgf288nvg541tgu73
      created_at: "2022-10-10T05:55:39Z"
      name: table-1
      network_id: encb4ubvmief09h6qg5e
      ```
      For more information about the `yc vpc route-table move` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/route-table/move.md).

{% endlist %}


## Examples {#examples}

### Route table in the current folder {#from-default-folder}

Move a route table from the current folder by specifying the table name and destination folder name:

{% list tabs %}

- CLI

   ```bash
   yc vpc route-table move table-1 \
     --destination-folder-name my-folder-1
   ```

{% endlist %}


#### See also {#see-also}

* [{#T}](network-move.md)
* [{#T}](subnet-move.md)
