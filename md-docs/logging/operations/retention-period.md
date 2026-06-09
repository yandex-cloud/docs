# Изменить лог-группу

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [лог-группа](../concepts/log-group.md).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Logging**.
    1. В строке с лог-группой нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
    1. В открывшемся меню нажмите кнопку **Редактировать**.
    1. Измените параметры лог-группы.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Для обращения к лог-группе используйте ее имя или уникальный идентификатор. Чтобы узнать их, [получите](list.md) список лог-групп в каталоге.

    Чтобы изменить параметры [лог-группы](../concepts/log-group.md), например срок хранения записей, выполните команду:

    ```
    yc logging group update --name=default --retention-period=24h
    ```

    Где:

    * `--name` — имя лог-группы, срок хранения записей в которой вы хотите изменить.
    * `--retention-period` — новый срок хранения записей в лог-группе.

        Срок хранения записей можно указать только в часах, минутах или секундах. Например, `1h` или `1440m`.

    Результат:

    ```
    id: af3mu6hnd0**********
    folder_id: aoek6qrs8t**********
    cloud_id: aoegtvhtp8**********
    created_at: "2023-06-22T09:51:43.614Z"
    name: default
    status: ACTIVE
    retention_period: 86400s
    ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить параметры [лог-группы](../concepts/log-group.md), созданной с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените нужный параметр в описании лог-группы, например срок хранения записей:

     ```hcl
     ...
     resource "yandex_logging_group" "group1" {
       name             = "test-logging-group"
       folder_id        = "<идентификатор_каталога>"
       retention_period = "5h"
     }
     ...
     ```

     Где:

     * `name` — имя лог-группы. Необязательный параметр.
     * `folder_id` — идентификатор каталога. Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.
     * `retention_period` — новый срок хранения записей в лог-группе.

        Срок хранения записей можно указать только в часах, минутах или секундах. Например, `1h` или `1440m`.

     Более подробную информацию о параметрах ресурса `yandex_logging_group` в Terraform, см. в [документации провайдера](../../terraform/resources/logging_group.md).

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение лог-группы можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc logging group get <имя_лог-группы>
     ```

- API {#api}

  Чтобы изменить лог-группу, воспользуйтесь методом REST API [update](../api-ref/LogGroup/update.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Update](../api-ref/grpc/LogGroup/update.md).

  **Пример запроса**

  Пример использования написан с помощью утилиты `grpcurl`. Чтобы воспользоваться им, [аутентифицируйтесь](../api-ref/authentication.md) в API и клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi).

  В примере обновляется срок хранения записей.
  
  Создайте файл `payload.json`:

  ```json
  {
     "log_group_id": "<идентификатор_лог-группы>",
     "retention_period": "24h",
     "update_mask": {
        "paths": ["retention_period"]
     }
  }
  ```

  Выполните запрос:

  ```bash
  grpcurl -rpc-header "Authorization: Bearer $(yc iam create-token)" \
    -d @ \
    -import-path ~/cloudapi/ \
    -import-path ~/cloudapi/third_party/googleapis/ \
    -proto ~/cloudapi/yandex/cloud/logging/v1/log_group_service.proto \
  logging.api.cloud.yandex.net:443 yandex.cloud.logging.v1.LogGroupService.Update < payload.json
  ```

  Ответ:

  ```text
  {
    "id": "e23omac87b3a********",
    "description": "Update log group",
    "createdAt": "2023-03-25T05:39:24.058608338Z",
    "createdBy": "ajego134p5h1********",
    "modifiedAt": "2023-03-25T05:39:24.058608338Z",
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.logging.v1.UpdateLogGroupMetadata",
      "logGroupId": "e23ff0on5amv********"
    }
  }
  ```

{% endlist %}