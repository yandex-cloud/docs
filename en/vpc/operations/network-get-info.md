---
title: How to get information about a cloud network in {{ vpc-full-name }}
description: Follow this guide to get information about a cloud network.
---

# Getting information about a cloud network

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your [cloud network](../concepts/network.md#network).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.vpc.switch_list }}**.
  1. Select the cloud network you need.
  1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the selected network.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to get information about the [cloud network](../concepts/network.md#network):

      ```bash
      yc vpc network get --help
      ```

  1. Get information about a network by specifying its name or ID:

      ```bash
      yc vpc network get <network_name>
      ```

      Result:

      ```text
      id: ne7w0rkfj75j********
      folder_id: f01derqpemb4********
      created_at: "2023-10-25T14:59:46Z"
      name: my-network
      description: Auto-created network
      default_security_group_id: 5ecur17yj09k********
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get information about a [cloud network](../concepts/network.md#network) using {{ TF }}:
  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

     ```hcl
     data "yandex_vpc_network" "admin" {
       network_id = "<network_ID>"
     }

     output "network" {
       value = data.yandex_vpc_network.admin.created_at
     }
     ```

     Where:
     * `data "yandex_vpc_network"`: Description of the cloud network as a data source:
       * `network_id`: Cloud network ID.
     * `output "network"`: Output variable that contains information about the network creation timestamp:
       * `value`: Returned value.

     You can replace `created_at` with any other parameter to get the information you need. For more information about the `yandex_vpc_network` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/datasource_vpc_network).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

     ```bash
     terraform output
     ```

     Result:

     ```text
     network = "2024-04-05T06:42:00Z"
     ```

- API {#api}

  To get detailed information about a [cloud network](../concepts/network.md#network), use the [get](../api-ref/Network/get.md) REST API method for the [Network](../api-ref/Network/index.md) resource or the [NetworkService/Get](../api-ref/grpc/network_service.md#Get) gRPC API call and provide the ID of the cloud network you need in the `networkId` request parameter.

  {% include [get-network-id](../../_includes/vpc/get-network-id.md) %}

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}


{% endlist %}

#### See also {#see-also}

* [{#T}](subnet-get-info.md)