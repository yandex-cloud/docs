---
title: "Creating API gateways"
description: "Follow this guide to create an API gateway."
---

# Creating API gateways

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_name }}** field, enter `numbers`.
   1. (Optional) In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_description }}** field, enter a description.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** section, add a specification:

      ```yaml
      openapi: "3.0.0"
      info:
        version: 1.0.0
        title: Test API
      paths:
        /hello:
          get:
            summary: Say hello
            operationId: hello
            parameters:
              - name: user
                in: query
                description: User name to appear in greetings
                required: false
                schema:
                  type: string
                  default: 'world'
            responses:
              '200':
                description: Greeting
                content:
                  'text/plain':
                     schema:
                       type: "string"
            x-yc-apigateway-integration:
              type: dummy
              http_code: 200
              http_headers:
                'Content-Type': "text/plain"
              content:
                'text/plain': "Hello, {user}!\n"
      ```
   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.

- CLI

   To create an API gateway:
   1. Save the following specification to a file named `hello-world.yaml`:

      ```yaml
      openapi: "3.0.0"
      info:
        version: 1.0.0
        title: Test API
      paths:
        /hello:
          get:
            summary: Say hello
            operationId: hello
            parameters:
              - name: user
                in: query
                description: User name to appear in greetings
                required: false
                schema:
                  type: string
                  default: 'world'
            responses:
              '200':
                description: Greeting
                content:
                  'text/plain':
                     schema:
                       type: "string"
            x-yc-apigateway-integration:
              type: dummy
              http_code: 200
              http_headers:
                'Content-Type': "text/plain"
              content:
                'text/plain': "Hello, {user}!\n"
      ```
   1. Run this command:

      ```bash
      yc serverless api-gateway create --name hello-world --spec=hello-world.yaml --description "hello world"
      ```

      Where:

      * `name`: API gateway name
      * `spec`: Specification file
      * `description`: API gateway description

      Result:

      ```text
      done (29s)
      id: d5dug9gkmu187iojcrtr
      folder_id: b1g55tflru0ek7omtfu0
      created_at: "2020-06-17T09:20:22.929Z"
      name: hello-world
      description: hello world
      status: ACTIVE
      domain: d5dug9gkmu187iojcpvp.apigw.yandexcloud.net
      log_group_id: ckghq1hm19q7ek5sjnh5
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   {% include [terraform-create](../../_includes/api-gateway/terraform-create.md) %}


- {{ yandex-cloud }} Toolkit

   You can create an API gateway using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).


- API

   To create an API gateway, use the [create](../apigateway/api-ref/ApiGateway/create.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Create](../apigateway/api-ref/grpc/apigateway_service.md#Create) gRPC API call.

{% endlist %}
