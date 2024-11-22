# Deleting a route table

If you no longer need a route table, you can [delete](#delete-route-table) it. Before deleting a table, [disassociate it](#unlink-route-table) from all subnets it is associated with.

## Disassociating a route table from a subnet {#unlink-route-table}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you need to disassociate a route table.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Go to the cloud network the route table belongs to.

     {% note info %}

     If you do not know which network the route table belongs to, in the right-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**. This will open a list of route tables. Find the network you need in the **Network** column next to the route table name. To view the cloud network, click its name.

     {% endnote %}

  1. In the list of subnets, find the subnet associated with the route table.
  1. Disassociate the route table from the subnet using any of these methods:
     * In the line with subnet information, click ![image](../../_assets/console-icons/xmark.svg) next to the route table name.
     * In the line with subnet information, click ![image](../../_assets/console-icons/ellipsis.svg) and select **Edit**. In the window that opens, click ![image](../../_assets/console-icons/xmark.svg) in the row with the route table name and save the changes.
     * Open the subnet information and click ![image](../../_assets/console-icons/xmark.svg) next to the route table name.
     * Open the subnet information and click **Edit** in the top right corner. In the window that opens, click ![image](../../_assets/console-icons/xmark.svg) in the row with the route table name and save the changes.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To disassociate a route table from a subnet:

  1. View the description of the CLI command for updating subnet parameters:

      ```bash
      yc vpc subnet update --help
      ```

  1. Get the name or ID of the subnet the route table is associated with:

      ```bash
      yc vpc subnet list
      ```
      Result:
      ```text
      +----------------------+----------------------------+----------------------+----------------------+---------------+-----------------+
      |          ID          |            NAME            |      NETWORK ID      |    ROUTE TABLE ID    |     ZONE      |      RANGE      |
      +----------------------+----------------------------+----------------------+----------------------+---------------+-----------------+
      | e9b4vdgv0v1n******** | default-ru-central1-a      | enptgj64mv2r******** |                      | ru-central1-a | [10.128.0.0/24] |
      | e2lp11c4o77d******** | default-ru-central1-b      | enptgj64mv2r******** | enpcaaqahk3c******** | ru-central1-b | [10.129.0.0/24] |
      +----------------------+----------------------------+----------------------+----------------------+---------------+-----------------+

      ```
  1. Disassociate the route table from the subnet:
      ```bash
      yc vpc subnet update <subnet_name_or_ID> --disassociate-route-table
      ```
      Use either the `--id` or `--name` parameter.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  To disassociate a route table from a subnet in the infrastructure created in {{ TF }}:

  1. Open the {{ TF }} configuration file and find the fragment with the description of the subnet associated with the route table:

     {% cut "Example subnet description in the {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_vpc_subnet" "subnet" {
       folder_id      = "<user_folder_ID>"
       name           = "<subnet_name>"
       v4_cidr_blocks = ["10.20.30.0/24"]
       zone           = "<availability_zone>"
       network_id     = "<subnet_ID>"
       route_table_id = "<route_table_ID>"
     }
     ...
     ```

     {% endcut %}

  1. Delete the route table description string from this fragment:

     ```hcl
     route_table_id = "<route_table_ID>"
     ```

  1. In the command line, go to the directory with the {{ TF }} configuration file.

  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc vpc subnet get <subnet_name_or_ID>
     ```
     Use either the `--id` or `--name` parameter.

- API {#api}

  To disassociate a route table from a subnet, use the [update](../api-ref/Subnet/update.md) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/Update](../api-ref/grpc/Subnet/update.md) gRPC API call and provide an empty string in the following request parameters:
    * `routeTableId`: For REST API
    * `route_table_id`: For gRPC API

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a route table {#delete-route-table}

{% note warning %}

Before deleting a table, [disassociate it](#unlink-route-table) from all subnets it is associated with.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To delete a route table:
  1. In the [management console]({{ link-console-main }}), go to the folder where you need to delete a route table.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the line with the table name and select **Delete**.
  1. In the window that opens, click **Delete**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a route table:

  1. View the description of the CLI command for deleting a route table:

      ```bash
      yc vpc route-table delete --help
      ```

  1. Get the name or ID of the route table to delete:

      ```bash
      yc vpc route-table list
      ```
      Result:
      ```text
      +----------------------+---------+-------------+----------------------+
      |          ID          |  NAME   | DESCRIPTION |      NETWORK-ID      |
      +----------------------+---------+-------------+----------------------+
      | enpd3s8svtkd******** | table-1 |             | enptgj64mv2r******** |
      +----------------------+---------+-------------+----------------------+
      ```
  1. Delete the route table:
      ```bash
      yc vpc route-table delete <route_table_name_or_ID>
      ```
      Use either the `--id` or `--name` parameter.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  To delete a route table created using {{ TF }}:

  1. Open the {{ TF }} configuration file and remove the route table description fragment.

      {% cut "Example of a table description in the {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_vpc_route_table" "route_table" {
       folder_id  = "<user_folder_ID>"
       name       = "<route_table_name>"
       network_id = "<network_ID>"
       static_route {
         destination_prefix = "10.2.0.0/16"
         next_hop_address   = "172.16.10.10"
       }
     }
     ...
     ```

     {% endcut %}

  1. In the command line, go to the directory with the {{ TF }} configuration file.

  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc vpc subnet list
     ```

- API {#api}

  To delete a route table, use the [delete](../api-ref/RouteTable/delete.md) REST API method for the [RouteTable](../api-ref/RouteTable/index.md) resource or the [RouteTableService/Delete](../api-ref/grpc/RouteTable/delete.md) gRPC API call and provide the ID of the route table you want to delete in the following request parameters:
    * `routeTableID`: For REST API
    * `route_table_id`: For gRPC API

  To get the route table ID, use the [list](../api-ref/RouteTable/list.md) REST API method for the [RouteTable](../api-ref/RouteTable/index.md) resource or the [RouteTableService/List](../api-ref/grpc/RouteTable/list.md) gRPC API call and provide the folder ID in the following request parameters:
    * `folderID`: For REST API
    * `folder_id`: For gRPC API

{% endlist %}
