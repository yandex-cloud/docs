---
title: "How to delete a cloud network"
description: "Follow this guide to delete a cloud network."
---

# Deleting a cloud network

{% note alert %}

Before deleting a network, you need to delete all its child resources.
You cannot restore a network after it is deleted.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   To delete a [cloud network](../concepts/network.md#network):
   1. In the [management console]({{ link-console-main }}), go to the folder where you need to delete a cloud network.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. Click ![image](../../_assets/options.svg) next to the network you need and select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete cloud network command:

      ```
      yc vpc network delete --help
      ```

   1. Get a list of all networks in the default folder:

      ```
      yc vpc network list
      ```

      Result:
      ```
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpiuvhhd4t8******** | test-network-1 |
      | enplom7a98s1******** | default        |
      +----------------------+----------------+
      ```

   1. Select the `ID` or `NAME` of the network you need.
   1. Delete the network:

      ```
      yc vpc network delete test-network-1
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   To delete a cloud network created with {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the cloud network description.

      {% cut "Example cloud network description in a {{ TF }} configuration" %}

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

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc vpc network list
      ```

- API {#api}

   To delete a [cloud network](../concepts/network.md), use the [delete](../api-ref/Network/delete.md) REST API method for the [Network](../api-ref/Network/index.md) resource or the [NetworkService/Delete](../api-ref/grpc/network_service.md#Delete) gRPC API call, and provide the ID of the cloud network to be deleted, in the `networkId` request parameter.

   {% include [get-network-id](../../_includes/vpc/get-network-id.md) %}

   {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}
