---
title: How to get information about a NAT gateway in {{ vpc-full-name }}
description: Follow this guide to get information about a NAT gateway.
---

# Getting information about a NAT gateway

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your [NAT gateway](../concepts/gateways.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/arrows-opposite-to-dots.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}**.
  1. Select the NAT gateway you need.
  1. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the NAT gateway.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../cli/) command to get information about a [NAT gateway](../concepts/gateways.md):

     ```bash
     yc vpc gateway get --help
     ```

  1. Get information about your NAT gateway by specifying its name or ID:

     ```bash
     yc vpc gateway get <NAT_gateway_name_or_ID>
     ```

     Result:

     ```text
     id: enpkq1v2e7p0********
     folder_id: b1go79qlt1tp********
     created_at: "2024-04-23T16:34:53Z"
     name: test-gateway
     shared_egress_gateway: {}
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get information about a [NAT gateway](../concepts/gateways.md) using {{ TF }}:
  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

     ```hcl
     data "yandex_vpc_gateway" "default" {
       gateway_id = "<NAT_gateway_ID>"
     }

     output "gateway" {
       value = data.yandex_vpc_gateway.default.created_at
     }
     ```

     Where:
     * `data "yandex_vpc_gateway"`: Description of the NAT gateway as a data source:
       * `gateway_id`: NAT gateway ID.
     * `output "gateway"`: Output variable containing information about the NAT gateway creation time:
       * `value`: Returned value.

     You can replace `created_at` with any other parameter to get the information you need. For more information about the `yandex_vpc_gateway` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/vpc_gateway).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources and display the output variable values in the terminal. To check the results, run this command:

     ```bash
     terraform output
     ```

     Result:

     ```text
     gateway = "2024-04-23T16:34:53Z"
     ```

- API {#api}

  To get detailed information about a [NAT gateway](../concepts/gateways.md), use the [get](../api-ref/Gateway/get.md) REST API method for the [Gateway](../api-ref/Gateway/index.md) resource or the [GatewayService/Get](../api-ref/grpc/Gateway/get.md) gRPC API call and provide the NAT gateway ID in the `gatewayId` request parameter.

   {% include [get-nat-gateway](../../_includes/vpc/get-nat-gateway.md) %}

   {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}