---
title: How to move a NAT gateway to a different folder
description: Use this guide to move a NAT gateway to a different folder.
---

# Moving a NAT gateway to a different folder

{% note info %}

{% include [Preview](../../_includes/vpc/preview.md) %}

{% endnote %}

You can move cloud resources between folders within a single [cloud](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs group=instructions %}

- Management console {#console}

  To move a [NAT gateway](../concepts/gateways.md) to a different folder:

  1. In the [management console]({{ link-console-main }}), go to the folder where the NAT gateway is located.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/arrows-opposite-to-dots.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row of the NAT gateway to move and select **{{ ui-key.yacloud.common.move }}**.
  1. Select the destination folder from the drop-down list.
  1. Click **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.

- CLI {#cli}

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
      | enckq19qqsr5******** | router-1 |             |
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
      | b1cs8ie21pk1******** | default                |        | ACTIVE |
      | b1chgf288nvg******** | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh6******** | my-folder-2            |        | ACTIVE |
      +----------------------+------------------------+--------+--------+
      ```

  1. Move the NAT gateway by specifying the name or ID of the NAT gateway and destination folder:

     ```bash
     yc vpc gateway move <gateway_name_or_ID> \
       --destination-folder-name <destination_folder_name> \
       --destination-folder-id <destination_folder_ID>
     ```
     Use either `--destination-folder-name` or `--destination-folder-id`.

     If the gateway is not in the current folder (default folder), specify the source folder using the `--folder-name` or `--folder-id` option.

     Result:
     ```text
     id: enckq19qqsr5********
     folder_id: b1chgf288nvg********
     created_at: "2022-10-06T10:14:04Z"
     name: router-1
     shared_egress_gateway: {}
     ```
     For more information about the `yc vpc address move` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/gateway/move.md).

- API {#api}

  To move a [NAT gateway](../concepts/gateways.md) to a different folder, use the [move](../api-ref/Gateway/move.md) REST API method for the [Gateway](../api-ref/Gateway/index.md) resource or the [GatewayService/Move](../api-ref/grpc/Gateway/move.md) gRPC API call, and provide the following in the request:

  * ID of the NAT gateway to move, in the `gatewayId` parameter.

    {% include [get-nat-gateway](../../_includes/vpc/get-nat-gateway.md) %}

  * ID of the folder you want to move the NAT gateway to, in the `destinationFolderId` parameter.

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

## Examples {#examples}

### NAT gateway in a different folder {#from-another-folder}

Move a NAT gateway from a different folder. Specify the NAT gateway ID and the source and destination folder IDs:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc gateway move enckq19qqsr5******** \
    --folder-id b1chgf288nvg******** \
    --destination-folder-id b1cs8ie21pk1********
  ```

{% endlist %}

#### See also {#see-also}

* [{#T}](network-move.md)
* [{#T}](subnet-move.md)

