---
title: Deleting a reserved internal IP address
description: Follow this guide to release a reserved internal IP address.
---

# Deleting an internal IP address

Before deleting a reserved IP address, you should release it by deleting the resource it is assigned to.

If deletion protection is on for the address, [disable](./deletion-protection.md#disable) it before deleting.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing the address.
   1. [Navigate]({{ link-console-main }}/link/vpc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Select the subnet containing the reserved address.
   1. Navigate to the **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}** tab.
   1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) in the row with the IP address to delete and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the deletion.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command for deleting an address:

      ```bash
      yc vpc address delete --help
      ```

   1. Get a list of addresses in the default folder:

      ```bash
      yc vpc address list
      ```

      Result:

      ```text
      +----------------------+---------------------+----------------+----------+-------+
      |          ID          |        NAME         |    ADDRESS     | RESERVED | USED  |
      +----------------------+---------------------+----------------+----------+-------+
      | e9b6un9gkso6******** | my-internal-address | 192.168.0.10   | true     | false |
      +----------------------+---------------------+----------------+----------+-------+
      ```

   1. Delete the address by specifying its ID or name:

      ```bash
      yc vpc address delete <address_ID_or_name>
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete an internal IP address created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment with the internal IP address description.

     Example of an internal IP address description in a {{ TF }} configuration:

     ```hcl
     ...
     resource "yandex_vpc_address" "internal_addr" {
       name = "<address_name>"
       folder_id = "<folder_ID>"
       internal_ipv4_address {
         subnet_id = "<subnet_ID>"
       }
     }
     ...
     ```

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  1. You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc vpc address list
     ```

- API {#api}

  To delete an internal IP address, use the [delete](../api-ref/Address/delete.md) REST API method for the [Address](../api-ref/Address/index.md) resource or the [AddressService/Delete](../api-ref/grpc/Address/delete.md) gRPC API call, and provide in the request the ID of the IP address you are deleting in `addressId` for REST API, or `address_id` for gRPC API.

  {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

