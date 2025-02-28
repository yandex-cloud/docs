---
title: Как изменить коннектор
description: Следуя данной инструкции, вы сможете изменить коннектор.
---

# Изменить коннектор

Вы можете изменить имя, описание и метки [коннектора](../../../concepts/eventrouter/connector.md), а также включить или выключить защиту от удаления. Тип и параметры источника данных коннектора изменить нельзя.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите изменить коннектор.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**.
  1. В строке с нужным коннектором нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Измените дополнительные параметры коннектора.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров коннектора:

      ```bash
      yc serverless eventrouter connector update --help
      ```

  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}
  1. Укажите в команде параметры, которые необходимо изменить, например имя коннектора:

      ```bash
      yc serverless eventrouter connector update \
        --name <имя_коннектора> \
        --new-name <новое_имя_коннектора>
      ```

      Результат:

      ```text
      id: f66g4h59ih2g********
      bus_id: f66qn4p7uk6p********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-20T15:30:05.248052Z"
      name: renamed-ydb
      description: consumer-one
      labels:
        owner: admin
        version: beta
      source:
        data_stream:
          database: /{{ region-id }}/b1gia87mbaom********/etntd0p5tauu********
          stream_name: my-ydb-flow
          consumer: consumer-one
          service_account_id: ajelprpohp7r********
      deletion_protection: true
      status: STOPPED
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../../_includes/terraform-install.md) %}

  Чтобы изменить коннектор:

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием ресурса `yandex_serverless_eventrouter_connector`.

      Пример описания коннектора в конфигурационном файле {{ TF }}:

      ```hcl
      resource "yandex_serverless_eventrouter_connector" "example_connector" {
        bus_id              = "<идентификатор_шины>"
        name                = "<имя_коннектора>"
        description         = "<описание_коннектора>"
        deletion_protection = <true|false>

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }
        ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_connector` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_connector).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/):

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  Чтобы изменить коннектор, воспользуйтесь методом REST API [Update](../../../../serverless-integrations/eventrouter/api-ref/Connector/update.md) для ресурса [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [Connector/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/update.md).

{% endlist %}