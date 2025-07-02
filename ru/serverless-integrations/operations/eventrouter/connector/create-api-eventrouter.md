---
title: Как создать коннектор для API {{ er-name }}
description: Следуя данной инструкции, вы сможете создать коннектор для API {{ er-name }}.
---

# Создать коннектор для API {{ er-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [коннектор](../../../concepts/eventrouter/connector.md).

  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.

  1. На панели слева выберите ![object-align-center-vertical](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.

  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).

  1. В меню слева выберите ![broadcast-signal](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**.

  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-event-router.button_create-connector }}**.

  1. В поле **{{ ui-key.yacloud.serverless-event-router.label_connector-source }}** выберите `{{ ui-key.yc-eventrouter.dynamic-forms.event_service_name }}`.

  1. {% include [connector-create-additional-params](../../../../_includes/serverless-integrations/connector-create-additional-params.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания [коннектора](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector create event-service --help
      ```

  1. Создайте коннектор для API {{ er-name }}:

      ```bash
      yc serverless eventrouter connector create event-service \
        --bus-id <идентификатор_шины> \
        --name <имя_коннектора> \
        --description <описание_коннектора> \
        --labels <список_меток> \
        --deletion-protection
      ```

      Где:

      * `--bus-id` — идентификатор [шины](../../../concepts/eventrouter/bus.md) {{ er-name }}.
      * `--name` — имя коннектора. Требования к имени:

          {% include [name-format-2](../../../../_includes/name-format-2.md) %}

      * `--description` — описание коннектора. Необязательный параметр.
      * `--labels` — список меток. Необязательный параметр.

          Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.
      * `--deletion-protection` — защита от удаления коннектора. По умолчанию защита выключена. Пока опция включена, удалить коннектор невозможно. Чтобы отключить защиту от удаления, укажите параметр `--no-deletion-protection`. Необязательный параметр.

      Результат:

      ```text
      id: f667savopsoe********
      bus_id: f66klk4lvvjf********
      folder_id: b1gt6g8ht345********
      cloud_id: b1gia87mbaom********
      created_at: "2025-06-18T16:44:03.849030Z"
      name: my-sample-connector
      description: my description
      labels:
        no: label
      source:
        event_service_source: {}
      deletion_protection: true
      status: RUNNING
      ```

- API {#api}

  Чтобы создать коннектор для API {{ er-name }}, воспользуйтесь методом REST API [Create](../../../../serverless-integrations/eventrouter/api-ref/Connector/create.md) для ресурса [connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/Create](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/create.md).

{% endlist %}

{% include [connector-created-running](../../../../_includes/serverless-integrations/connector-created-running.md) %}