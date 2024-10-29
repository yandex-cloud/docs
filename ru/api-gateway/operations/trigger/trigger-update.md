# Изменить триггер в {{ api-gw-full-name }}

Вы можете изменить все параметры, кроме типа триггера и запускаемого ресурса.

{% note info %}

Изменения применятся в течение пяти минут.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
  1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Выберите триггер, параметры которого хотите изменить.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры триггера и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_update-trigger }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% include [trigger-list-note](../../../_includes/serverless-containers/trigger-list-note.md) %}

  1. Посмотрите описание команды CLI для обновления параметров триггера:

      ```bash
      yc serverless trigger update <тип_триггера> --help
      ```

  1. Измените параметры триггера, например переименуйте его:

      ```bash
      yc serverless trigger update <тип_триггера> <имя_триггера> \ 
        --new-name <новое_имя_триггера> 
      ```

      Результат:

      ```text
      id: a1s5msktijh2********
      folder_id: b1gmit33hgh2********
      created_at: "2022-10-24T15:19:15.353909857Z"
      name: my-trigger
      rule:
        object_storage:
          event_type:
          - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT
          bucket_id: s3-for-trigger
          prefix: dev
          suffix: 12.jpg
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
      status: ACTIVE
      ```

- API {#api}

  Чтобы изменить параметры триггера, воспользуйтесь методом REST API [update](../../triggers/api-ref/Trigger/update.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Update](../../triggers/api-ref/grpc/Trigger/update.md).

{% endlist %}
