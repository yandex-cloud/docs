---
title: How to delete a dedicated public subnet in {{ baremetal-full-name }}
description: Follow this guide to delete a dedicated public subnet in {{ baremetal-full-name }}.
---

# Deleting a dedicated public subnet

A [dedicated public subnet](../concepts/public-network.md#public-subnet) becomes billable the moment it is created. The minimum rent period is one month, so you cannot delete a public subnet during the first month after the order date.

{% note warning %}

Deleting a dedicated public subnet is irreversible. Following the deletion, the subnet's IP addresses will return to the {{ baremetal-full-name }} shared address pool and can be reassigned to other users.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the public subnet belongs to.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets_v16CV }}**.
  1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the subnet and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the command for deleting a [dedicated public subnet](../concepts/public-network.md#public-subnet):

     ```bash
     yc baremetal public-subnet delete --help
     ```

  1. Get a list of dedicated public subnets in the default folder:

     ```bash
     yc baremetal public-subnet list
     ```

  1. Delete the subnet:

     ```bash
     yc baremetal public-subnet delete <subnet_ID_or_name>
     ```

     Where `<subnet_ID_or_name>` is the ID or name of the dedicated public subnet to delete.

- API {#api}

  To delete a dedicated public subnet, use the [delete](../api-ref/PublicSubnet/delete.md) REST API method for the [PublicSubnet](../api-ref/PublicSubnet/index.md) resource or the [PublicSubnetService/Delete](../api-ref/grpc/PublicSubnet/delete.md) gRPC API call.

  Run this command:

  ```bash
  curl -X DELETE \
    -H "Authorization: Bearer <IAM_token>" \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/publicSubnets/<subnet_ID>"
  ```

  Where:

  * `<IAM_token>`: IAM token used for authentication.
  * `<subnet_ID>`: ID of the dedicated public subnet to delete. To find out the ID, follow [this guide](reserve-public-subnet.md).

  Result:

  ```json
  {
    "id": "ly5hcnsbx3l4********",
    "description": "Public subnet delete",
    "createdAt": "2025-12-14T14:42:58.375290Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-14T14:42:58.375290Z",
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.DeletePublicSubnetMetadata",
      "publicSubnetId": "ly52xefxa2hi********"
    },
    "response": {
      "@type": "type.googleapis.com/google.protobuf.Empty"
    }
  }
  ```

  Follow the status of the operation by the `done` field.

{% endlist %}
