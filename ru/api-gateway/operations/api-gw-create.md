# Создание API-шлюза

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором необходимо создать API-шлюз.
    1. В списке сервисов выберите **{{ api-gw-name }}**.
    1. Нажмите кнопку **Создать API-шлюз**.
    1. В поле **Имя** введите `numbers`.
    1. (Опционально) В поле **Описание** введите описание.
    1. В блок **Спецификация** добавьте спецификацию:
    
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
    1. Нажмите кнопку **Создать**.
    
- CLI

    Чтобы создать API-шлюз: 
    1. Сохраните следующую спецификацию в файл `hello-world.yaml`:
        
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
    1. Выполните команду:

        ```bash
        yc serverless api-gateway create --name hello-world --spec=hello-world.yaml --description "hello world"
        ```

        Где:
       
        - `name` — имя API-шлюза.
        - `spec` — файл со спецификацией.
        - `description` — описание API-шлюза.

        Результат:

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

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-create](../../_includes/api-gateway/terraform-create.md) %}

- {{ yandex-cloud }} Toolkit

  Создать API-шлюз можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

- API

  Чтобы создать API-шлюз, воспользуйтесь методом REST API [create](../apigateway/api-ref/ApiGateway/create.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Create](../apigateway/api-ref/grpc/apigateway_service.md#Create).

{% endlist %}
