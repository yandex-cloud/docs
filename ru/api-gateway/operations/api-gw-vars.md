---
title: Настроить переменные для спецификации API-шлюза
description: Следуя данной инструкции, вы сможете настроить переменные для спецификации API-шлюза.
---

# Настроить переменные

Сервис {{ api-gw-name }} поддерживает использование [переменных в спецификации OpenAPI](../concepts/extensions/parametrization.md).

{% cut "Пример файла спецификации с переменной" %}

```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0

x-yc-apigateway:
  variables:
    environment:
      default: "prod"
      enum:
        - "prod"
        - "testing"
        - "dev"
      description: "API Gateway installation."

paths:
  /env/info:
    get:
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': It is ${var.environment} environment!
        http_code: 200
        http_headers:
          Content-Type: text/plain
```

{% endcut %}

По умолчанию переменные принимают значения, которые указаны в поле `default` в [спецификации OpenAPI](https://ru.wikipedia.org/wiki/OpenAPI_(спецификация)). Вы можете переопределить их, передав другие значения при настройке [API-шлюза](../concepts/index.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором необходимо изменить API-шлюз.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.serverless-functions.gateways.list.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.gateways.form.label_section-variables }}** перечислите все объявленные в спецификации переменные и их значения.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы настроить переменные:
  1. При необходимости внесите изменения в файл спецификации OpenAPI или подготовьте новый файл.
  1. Посмотрите описание команды CLI для изменения API-шлюза:

     ```bash
     {{ yc-serverless }} api-gateway update --help
     ```

  1. Укажите в команде идентификатор или имя API-шлюза, а также список всех объявленных в спецификации переменных в формате `ключ=значение`:

     ```bash
     {{ yc-serverless }} api-gateway update \
       --id <идентификатор_шлюза> \
       --variables <список_переменных>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы передать значения переменных, объявленных в спецификации API-шлюза:
  1. Откройте файл конфигурации {{ TF }} и добавьте в него блок `variables`:

     ```hcl
     resource "yandex_api_gateway" "<имя_API-шлюза>" {
       ...
       variables = {
         <список_переменных>
       }
       ...
     }
     ```

     Список переменных задается в формате `ключ = значение`, например:

     ```hcl
     resource "yandex_api_gateway" "<имя_API-шлюза>" {
       ...
       variables = {
         environment = "testing"
       }
       ...
     }
     ```

  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```bash
     terraform plan
     ```

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить, что API-шлюз изменился, можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc serverless api-gateway get <имя_API-шлюза>
     ```

- API {#api}

  Чтобы настроить переменные для спецификации API-шлюза, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/apigateway_service.md#Update).

{% endlist %}

## См. также

* [Как работает параметризация спецификации](../concepts/extensions/parametrization.md).
* [Как изменить спецификацию API-шлюза](../operations/api-gw-update.md).