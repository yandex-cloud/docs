---
title: "Как настроить канареечный релиз для API-шлюза"
description: "Следуя данной инструкции, вы сможете настроить канареечный релиз для API-шлюза."
---

# Настроить канареечный релиз

Настройка канареечного релиза возможна только для [спецификаций OpenAPI](https://ru.wikipedia.org/wiki/OpenAPI_(спецификация)) с переменными (см. раздел [Параметризация спецификации](../concepts/extensions/parametrization.md)).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [API-шлюз](../concepts/index.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.serverless-functions.gateways.list.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.gateways.form.label_section-variables }}** включите [канареечный релиз](../concepts/extensions/canary.md).
  1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.label_canary-share }}** укажите процент запросов, который будет обрабатываться канареечным релизом.
  1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.label_canary-variables }}** перечислите переменные и их значения, которые будут применяться в канареечном релизе.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы настроить [канареечный релиз](../concepts/extensions/canary.md):
  1. При необходимости внесите изменения в файл спецификации OpenAPI или подготовьте новый файл.
  1. Посмотрите описание команды CLI для изменения [API-шлюза](../concepts/index.md):

     ```bash
     {{ yc-serverless }} api-gateway update --help
     ```

  1. Укажите в команде идентификатор или имя API-шлюза, а также параметры канареечного релиза:

     ```bash
     {{ yc-serverless }} api-gateway update \
       --id <идентификатор_шлюза> \
       --canary-weight <процент_запросов> \
       --canary-variables=<список_переменных>
     ```

     Где:
     * `--canary-weight` — процент запросов, которые будут обработаны канареечным релизом.
     * `--canary-variables` — переменные для канареечного релиза в формате `ключ=значение`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы настроить [канареечный релиз](../concepts/extensions/canary.md):
  1. Откройте файл конфигурации {{ TF }} и добавьте в него блок `canary`:

     ```hcl
     resource "yandex_api_gateway" "<имя_API-шлюза>" {
     ...
     canary {
       weight    = <процент_запросов>
       variables = {
         <список_переменных>
       }
     }
     ```

     Где:
     * `weight` — процент запросов, которые будут обработаны канареечным релизом.
     * `variables` — переменные для канареечного релиза в формате `ключ=значение`.

     Более подробную информацию о параметрах ресурса `yandex_api_gateway` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/api_gateway).
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

  Проверить, что [API-шлюз](../concepts/index.md) изменился, можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```bash
  yc serverless api-gateway get <имя API-шлюза>
  ```

- API {#api}

  Чтобы настроить [канареечный релиз](../concepts/extensions/canary.md), воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/apigateway_service.md#Update).

{% endlist %}

## См. также

* [Что такое канареечный релиз](../concepts/extensions/canary.md).
* [Канареечный релиз функции {{ sf-name }}](../tutorials/canary-release.md).