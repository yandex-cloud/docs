[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Logging](../index.md) > [Пошаговые инструкции](index.md) > Получение информации о лог-группе > Получить список лог-групп

# Получить список лог-групп

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите посмотреть список лог-групп.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Logging**.
    1. На панели слева выберите ![image](../../_assets/console-icons/tray.svg) **Группы**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить список лог-групп в каталоге, выполните команду:

    ```bash
    yc logging group list
    ```

    Результат:

    ```text
    +----------------------+---------+----------------------+--------+
    |          ID          |  NAME   |      FOLDER ID       | STATUS |
    +----------------------+---------+----------------------+--------+
    | af36gk8qv2********** | default | aoek6qrs8t********** | ACTIVE |
    +----------------------+---------+----------------------+--------+
    ```

- API {#api}

  Чтобы получить список лог-групп, воспользуйтесь методом REST API [list](../api-ref/LogGroup/list.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/List](../api-ref/grpc/LogGroup/list.md).

  **Пример запроса**

  Пример использования написан с помощью утилиты `grpcurl`. Чтобы воспользоваться им, [аутентифицируйтесь](../api-ref/authentication.md) в API и клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi).

  Выполните запрос:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer $(yc iam create-token)" \
    -d '{"folder_id": "<идентификатор_каталога>"}' \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
  logging.api.cloud.yandex.net:443 yandex.cloud.logging.v1.LogGroupService.List
  ```

  Результат:

  ```bash
  {
    "groups": [
      {
        "id": "e23u2vn449av********",
        "folderId": "b1g3f9i71bpm********",
        "cloudId": "b1gvlrnlei4l********",
        "createdAt": "2023-02-09T07:49:15.857Z",
        "name": "default",
        "description": "Auto-created default group",
        "status": "ACTIVE",
        "retentionPeriod": "259200s"
      }
    ]
  }
  ```

{% endlist %}