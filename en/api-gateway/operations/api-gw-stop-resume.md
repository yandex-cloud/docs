---
title: Stopping and starting an API gateway
description: Follow this guide to stop or start an API gateway.
---

# Stopping and starting an API gateway

Once you have created an [API gateway](../concepts/index.md), you can stop it and start it again.


# Stopping an API gateway {#stop}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to stop an API gateway.
  1. [Navigate]({{ link-console-main }}/link/api-gateway) to **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. In the API gateway row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![square](../../_assets/console-icons/square.svg) **{{ ui-key.yacloud.common.stop }}**.

     The API gateway will switch to `Stopped`.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for stopping an API gateway:

     ```bash
     {{ yc-serverless }} api-gateway stop --help
     ```

  1. Stop your API gateway:

     ```bash
     {{ yc-serverless }} api-gateway stop <API_gateway_name_or_ID>
     ```

     Result:

     ```text
     id: d5daqt0ofc4t********
     folder_id: b1g681qpemb4********
     created_at: "2026-08-20T12:56:16.354Z"
     name: my-gateway
     status: STOPPED
     domain: d5daqt0ofc4t********.********.apigw.yandexcloud.net
     connectivity: {}
     log_options:
       disabled: true
       folder_id: b1g681qpemb4********
     execution_timeout: 300s
     ```

- API {#api}

  To stop an API gateway, use the [stop](../apigateway/api-ref/ApiGateway/stop.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Stop](../apigateway/api-ref/grpc/ApiGateway/stop.md) gRPC API call.

{% endlist %}


# Starting an API gateway {#resume}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to start an API gateway.
  1. [Navigate]({{ link-console-main }}/link/api-gateway) to **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. In the API gateway row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![play](../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.common.start }}**.

     The API gateway will switch to `Active`.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for starting an API gateway:

     ```bash
     {{ yc-serverless }} api-gateway resume --help
     ```

  1. Start your API gateway:

     ```bash
     {{ yc-serverless }} api-gateway resume <API_gateway_name_or_ID>
     ```

     Result:

     ```text
     id: d5daqt0ofc4t********
     folder_id: b1g681qpemb4********
     created_at: "2026-08-20T12:56:16.354Z"
     name: my-gateway
     status: ACTIVE
     domain: d5daqt0ofc4t********.********.apigw.yandexcloud.net
     connectivity: {}
     log_options:
       disabled: true
       folder_id: b1g681qpemb4********
     execution_timeout: 300s
      ```

- API {#api}

  To start an API gateway, use the [resume](../apigateway/api-ref/ApiGateway/resume.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Resume](../apigateway/api-ref/grpc/ApiGateway/resume.md) gRPC API call.

{% endlist %}
