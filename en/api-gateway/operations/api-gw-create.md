# Creating API gateways

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.
   1. In the list of services, select **{{ api-gw-name }}**.
   1. Click **Create API gateway**.
   1. In the **Name** field, enter `numbers`.
   1. (optional) In the **Description** field, enter a description.
   1. In the **Specification** section, add a specification:

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
   1. Click **Create**.

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
   1. Run the following command:

      ```bash
      yc serverless api-gateway create --name hello-world --spec=hello-world.yaml --description "hello world"
      ```

      Where:

      - `name`: API gateway name.
      - `spec`: Specification file.
      - `description`: API gateway description.

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

- API

   You can create an API gateway using the [create](../apigateway/api-ref/ApiGateway/create.md) API method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-create](../../_includes/api-gateway/terraform-create.md) %}

- {{ yandex-cloud }} Toolkit

   You can create an API gateway using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) by [JetBrains](https://www.jetbrains.com/).

{% endlist %}
