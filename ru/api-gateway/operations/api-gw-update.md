# Изменение API-шлюза

{% list tabs %}

- Консоль управления

    Чтобы обновить спецификацию API-шлюза:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором необходимо изменить API-шлюз.
    1. В списке сервисов выберите **{{ api-gw-name }}**.
    1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/options.svg) и выберите **Редактировать**.
    1. Отредактируйте имя, описание или спецификацию API-шлюза.
    1. Нажмите кнопку **Сохранить**.
    
- CLI

    Чтобы изменить спецификацию API-шлюза:
    1. Внесите необходимые изменения в файл со спецификацией `hello-world.yaml`.
    1. Выполните команду: 

        ```
        yc serverless api-gateway update --id d5dug9gkmu187iojcrtr --spec=hello_world.yaml
        ```

        Где:
    
        - `id` — идентификатор API-шлюза.
        - `spec` — файл с обновленной спецификацией.

        Результат:

        ```
        done (6s)
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

  Изменить имя, описание или спецификацию API-шлюза можно с помощью метода API [update](../apigateway/api-ref/ApiGateway/update.md).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить имя, описание или спецификацию API-шлюза:

  1. Откройте файл конфигурации {{ TF }} и измените параметры `name`, `description` или `spec` соответственно.

     Пример структуры конфигурационного файла:

     ```hcl
     ...
     resource "yandex_api_gateway" "test-api-gateway" {
       name        = "some_name"
       description = "any description"
       labels      = {
         label       = "label"
         empty-label = ""
       }
       spec = <<-EOT
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
                   'text/plain': "Hello again, {user}!\n"
       EOT
     }
     ...
     ```

     Более подробную информацию о параметрах ресурса `yandex_api_gateway` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/api_gateway).

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение API-шлюза можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc serverless api-gateway get <имя API-шлюза>
     ```

- Yandex.Cloud Toolkit

  Изменить имя, описание или спецификацию API-шлюза можно с помощью [плагина Yandex.Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
