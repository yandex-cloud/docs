# Moving a NAT gateway to a different folder

{% note info %}

{% include [Preview](../../_includes/vpc/preview.md) %}

{% endnote %}

You can move cloud resources between folders within a single [cloud](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs %}

- Management console

   To move a [NAT gateway](../concepts/gateways.md) to a different folder:

   1. In the [management console]({{ link-console-main }}), go to the folder where the NAT gateway is located.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/gateways.svg) **Gateways**.
   1. Click ![image](../../_assets/options.svg) in the row of the NAT gateway to be moved and select **Move**.
   1. Select the destination folder from the drop-down list.
   1. Click **Move**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a [NAT gateway](../concepts/gateways.md) to a different folder:

   1. View a description of the CLI move NAT gateway command:

      ```bash
      yc vpc gateway move --help
      ```

   1. Get the name or ID of the NAT gateway to move:

      ```bash
      yc vpc gateway list
      ```
      Result:
      ```text
      +----------------------+----------+-------------+
      |          ID          |   NAME   | DESCRIPTION |
      +----------------------+----------+-------------+
      | enckq19qqsr54b727dct | router-1 |             |
      +----------------------+----------+-------------+
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

   1. Move the NAT gateway by specifying the name or ID of the NAT gateway and destination folder:

      ```bash
      yc vpc gateway move <gateway_name_or_ID> \
        --destination-folder-name <name_of_destination_folder> \
        --destination-folder-id <ID_of_destination_folder>
      ```
      Use either the `--destination-folder-name` parameter or the `--destination-folder-id` parameter.

      If the gateway is not in the current folder (default folder), specify the source folder using the `--folder-name` or `--folder-id` option.

      Result:
      ```text
      id: enckq19qqsr54b727dct
      folder_id: b1chgf288nvg541tgu73
      created_at: "2022-10-06T10:14:04Z"
      name: router-1
      shared_egress_gateway: {}
      ```
      For more information about the `yc vpc gateway move` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/gateway/move.md).

{% endlist %}

## Examples {#examples}

### NAT gateway in a different folder {#from-another-folder}

Move a NAT gateway from a different folder. Specify the NAT gateway ID and the source and destination folder IDs:

{% list tabs %}

- CLI

   ```bash
   yc vpc gateway move enckq19qqsr54b727dct \
     --folder-id b1chgf288nvg541tgu73 \
     --destination-folder-id b1cs8ie21pk10aurd2c3
   ```

{% endlist %}

#### See also {#see-also}

* [{#T}](network-move.md)
* [{#T}](subnet-move.md)
