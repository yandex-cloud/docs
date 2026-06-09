# Получить информацию о триггере в {{ api-gw-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Выберите триггер, о котором хотите получить подробную информацию.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Получите подробную информацию о триггере:

    ```bash
    yc serverless trigger get <имя_триггера>
    ```

    Результат:

    ```text
    id: a1sltg0kn8bt********
    folder_id: b1gc1t4cb638********
    created_at: "2024-07-17T08:54:17.022Z"
    name: timer-trigger
    rule:
      timer:
        cron_expression: '* * ? * * *'
        gateway_websocket_broadcast:
          gateway_id: d5d1ud9bli1e********
          path: /
          service_account_id: aje07l4q4vmo********
    status: ACTIVE
    ```

- API {#api}

  Чтобы получить информацию о триггере, воспользуйтесь методом REST API [get](../../triggers/api-ref/Trigger/get.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Get](../../triggers/api-ref/grpc/Trigger/get.md).

{% endlist %}