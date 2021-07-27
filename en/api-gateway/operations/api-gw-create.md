---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating API gateways

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.

    1. In the list of services, select **{{ api-gw-name }}**.

    1. Click **Create API gateway**.

    1. In the **Name** field, enter `numbers`.

    1. (optional) In the **Description** field, enter a description.

    1. In the **Specification** section, add a specification:

        ```
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

        ```
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

    1. Run the command with the following parameters:
        - `name`: API gateway name.
        - `spec`: Specification file.
        - `description`: API gateway description.

        ```
        yc serverless api-gateway create --name hello-world --spec=hello-world.yaml --description "hello world"
        
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

{% endlist %}

