---
title: How to delete a cloud network
description: Follow this guide to delete a cloud network.
---

# Deleting a cloud network

{% note alert %}

Before deleting a network, you need to delete all its child resources.
You cannot restore a network after it is deleted.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To delete a [cloud network](../concepts/network.md#network):

  1. In the [management console]({{ link-console-main }}), select the folder where you need to delete a cloud network.
  1. [Navigate]({{ link-console-main }}/link/vpc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row of the network you need and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for deleting [cloud networks](../concepts/network.md#network):

     ```bash
     yc vpc network delete --help
     ```

  1. Get a list of all networks in the default folder:

     ```bash
     yc vpc network list
     ```

     Result:

     ```text
     +----------------------+----------------+
     |          ID          |      NAME      |
     +----------------------+----------------+
     | enpiuvhhd4t8******** | test-network-1 |
     | enplom7a98s1******** | default        |
     +----------------------+----------------+
     ```

  1. Select the network `ID` or `NAME`.
  1. Delete the network:

     ```bash
     yc vpc network delete test-network-1
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  To delete a [cloud network](../concepts/network.md#network) created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment with the cloud network description.

     {% cut "Example of a cloud network description in the {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_vpc_network" "default" {
       name        = "network-1"
       description = "My first network"
       labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }
     ...
     ```

     {% endcut %}

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

  ```bash
  yc vpc network list
  ```

- API {#api}

  To delete a [cloud network](../concepts/network.md), use the [delete](../api-ref/Network/delete.md) REST API method for the [Network](../api-ref/Network/index.md) resource or the [NetworkService/Delete](../api-ref/grpc/Network/delete.md) gRPC API call, and provide the ID of the cloud network to delete in the `networkId` request parameter.

  {% include [get-network-id](../../_includes/vpc/get-network-id.md) %}

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}
