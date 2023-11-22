---
title: "Изменить API-шлюз"
description: "Следуя данной инструкции, вы сможете изменить API-шлюз."
---

# Изменить API-шлюз

После создания API-шлюза вы можете изменить любые его параметры и спецификацию OpenAPI.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором необходимо изменить API-шлюз.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.serverless-functions.gateways.list.button_action-edit }}**.
    1. Отредактируйте параметры API-шлюза или спецификацию OpenAPI при необходимости.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить API-шлюз:

    1. При необходимости внесите изменения в файл спецификации OpenAPI или подготовьте новый файл.
    1. Посмотрите описание команды CLI для изменения API-шлюза:

        ```bash
        {{ yc-serverless }} api-gateway update --help
        ```

    1. Укажите в команде изменения идентификатор или имя API-шлюза, а также параметры, которые необходимо изменить (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-serverless }} api-gateway update \
          --id <идентификатор_шлюза> \
          --new-name <новое_имя_шлюза>
          --spec=<путь_к_новому_файлу_спецификации> \
        ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

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

     Более подробную информацию о параметрах ресурса `yandex_api_gateway` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/api_gateway).

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


- {{ yandex-cloud }} Toolkit

  Изменить имя, описание или спецификацию API-шлюза можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).


- API

  Чтобы изменить имя, описание или спецификацию API-шлюза, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/apigateway_service.md#Update).

{% endlist %}
