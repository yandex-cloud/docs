# Получить информацию о триггере в Cloud Functions

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится триггер.
  1. Перейдите в сервис **Cloud Functions**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **Триггеры**.
  1. Выберите триггер, о котором хотите получить подробную информацию.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор триггера, [получите](trigger-list.md) список триггеров в каталоге.

    Получите подробную информацию о триггере:

    ```bash
    yc serverless trigger get <имя_триггера>
    ```

    Результат:

    ```text
    id: a1s9q2li6t**********
    folder_id: b1g9hv2loa**********
    created_at: "2023-08-01T12:36:14.321Z"
    name: my-trigger
    description: Trigger for uploaded objects
    rule:
      object_storage:
        event_type:
          - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
        bucket_id: **********
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: d4e5muirrt**********
          function_tag: $latest
          service_account_id: ajek0fou8e**********
    status: ACTIVE
    ```

- API {#api}

  Чтобы получить подробную информацию о триггере, воспользуйтесь методом REST API [get](../../triggers/api-ref/Trigger/get.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Get](../../triggers/api-ref/grpc/Trigger/get.md).

{% endlist %}