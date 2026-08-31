---
title: How to specify a cloud network to host an API gateway
description: Follow this guide to specify a cloud network that will host your API gateway.
---

# Specifying a cloud network to host an API gateway

You can specify a [cloud network](../../vpc/concepts/network.md#network) to host an API gateway.

{% include [network](../../_includes/functions/network.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the API gateway.
    1. [Navigate]({{ link-console-main }}/link/api-gateway) to **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Select the API gateway.
    1. Click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
    1. In the **{{ ui-key.yacloud.vpc.label_network }}** field, specify a cloud network to host your API gateway.
    1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating an API gateway:

     ```bash
     {{ yc-serverless }} api-gateway update --help
     ```

  1. Get a list of API gateways in the default folder:

     ```bash
     {{ yc-serverless }} api-gateway list
     ```

  1. Specify a cloud network for the API gateway:

     ```bash
     {{ yc-serverless }} api-gateway update \
       --id <API_gateway_ID> \
       --network-name <cloud_network_name>
     ```

     Where:
     * `--id`: API gateway ID.
     * `--network-name`: Name of the cloud network. You can specify the `--network-id` parameter instead of the network name.

     To associate the API gateway with certain subnets, specify them in the `--subnet-id` or `--subnet-name` parameters instead of specifying a network.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add the `connectivity` section to the `yandex_api_gateway` resource description:

     ```hcl
     resource "yandex_api_gateway" "test-api-gateway" {
       name = "<API_gateway_name>"
       ...
       connectivity {
         network_id = "<cloud_network_ID>"
       }
     }
     ```

     Where `network_id` is the ID of the cloud network to host the API gateway.

     For more information about the properties of the `yandex_api_gateway` resource, see [this provider guide]({{ tf-provider-resources-link }}/api_gateway).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the result using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     {{ yc-serverless }} api-gateway get <API_gateway_ID>
     ```

- API {#api}

  To specify a cloud network to host an API gateway, use the [update](../apigateway/api-ref/ApiGateway/update.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md) gRPC API call.

  Set `updateMask` to `connectivity`, and `connectivity.networkId`, to the cloud network ID.

{% endlist %}

#### Useful links {#see-also}

[Networking in {{ api-gw-name }}](../concepts/networking.md)
