---
title: How to get information about a subnet in {{ vpc-full-name }}
---

# Getting information about a subnet

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [subnet](../concepts/network.md#subnet).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.network.overview.section_subnetworks }}**.
  1. Select the subnet you need.
  1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the subnet.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to get information about a [subnet](../concepts/network.md#subnet):

      ```bash
      yc vpc subnet get --help
      ```

  1. Get information about a subnet by specifying its name or ID:

      ```bash
      yc vpc subnet get <subnet_name>
      ```

      Result:

      ```text
      id: 5ubne7r188b7********
      folder_id: f01derqpemb4********
      created_at: "2023-10-25T14:59:49Z"
      name: my-network-{{ region-id }}-a
      description: Auto-created default subnet for zone {{ region-id }}-a in my-network
      network_id: ne7w0rkfj75j********
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
        - 10.130.0.0/24
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get information about a [subnet](../concepts/network.md#subnet) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

     ```hcl
     data "yandex_vpc_subnet" "my_subnet" {
       subnet_id = "<subnet_ID>"
     }

     output "subnet" {
       value = data.yandex_vpc_subnet.my_subnet.zone
     }
     ```

     Where:
     * `data "yandex_vpc_subnet"`: Description of the subnet as a data source:
       * `subnet_id`: Subnet ID.
     * `output "subnet"`: Output variable that contains the name of the subnet's availability zone:
       * `value`: Returned value.

     You can replace `zone` with any other parameter to get the information you need. For more information about the `yandex_vpc_subnet` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/vpc_subnet).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources and display the output variable values in the terminal. To check the results, run this command:

     ```bash
     terraform output
     ```

     Result:

     ```text
     subnet = "ru-central1-a"
     ```

- API {#api}

  To get detailed information about a [subnet](../concepts/network.md#subnet), use the [get](../api-ref/Subnet/get) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/Get](../api-ref/grpc/Subnet/get.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](network-get-info.md)
