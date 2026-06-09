# Получить информацию о триггере в {{ serverless-containers-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Выберите триггер, о котором хотите получить подробную информацию.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Получите подробную информацию о триггере:

    ```bash
    yc serverless trigger get <имя_триггера>
    ```

    Результат:

    ```text
    id: a1sfe084v4h2********
    folder_id: b1g88tflrih2********
    created_at: "2022-12-04T08:45:31.131391Z"
    name: mail-trigger
    description: My trigger for mail.
    rule:
      mail:
        email: a1smdtklemh2********-xivn****@serverless.yandexcloud.net
        invoke_container:
          container_id: bba5jb38o8h2********
          service_account_id: aje03adgd2h2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ngh2********:dlq
            service-account-id: aje3lebfemh2********
    status: ACTIVE
    ```

- API {#api}

  Чтобы получить информацию о триггере, воспользуйтесь методом REST API [get](../triggers/api-ref/Trigger/get.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Get](../triggers/api-ref/grpc/Trigger/get.md).

{% endlist %}