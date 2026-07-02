[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Logging](../index.md) > [Пошаговые инструкции](index.md) > Управление лог-группой > Создать лог-группу

# Создать лог-группу

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать [лог-группу](../concepts/log-group.md).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Logging**.
    1. Нажмите кнопку **Создать группу**.
    1. (Опционально) Введите имя и описание лог-группы. Формат имени:

        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.

    1. Укажите срок хранения записей в лог-группе.

    1. (Опционально) Выберите [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) или создайте новый, чтобы перенаправлять в него записи, которые добавили в лог-группу.


    1. Нажмите кнопку **Создать группу**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать [лог-группу](../concepts/log-group.md), выполните команду:

    ```
    yc logging group create \
      --name=group \
      --retention-period=1h \
      --data-stream=<идентификатор_потока>
    ```

    Где:
    * `--name` — имя лог-группы.
    * `--retention-period` — срок хранения записей в лог-группе. Необязательный параметр.

        Срок хранения записей можно указать только в часах, минутах или секундах. Например, `1h` или `1440m`.

    * `--data-stream` — идентификатор [потока данных](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams. Необязательный параметр. В указанный поток автоматически будут перенаправляться записи, которые добавили в лог-группу. Идентификатор потока состоит из зоны доступности, идентификатора каталога, идентификатора базы данных Yandex Managed Service for YDB и имени потока.

        >Например, укажите идентификатор потока `/ru-central1/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream`, если:
        >* `aws_stream` — имя потока;
        >* `ru-central1` — зона доступности;
        >* `aoeu1kuk2dht********` — идентификатор каталога;
        >* `cc8029jgtuab********` — идентификатор базы данных Yandex Managed Service for YDB.


    Результат:

    ```
    done (1s)
    id: af3flf29t8**********
    folder_id: aoek6qrs8t**********
    cloud_id: aoegtvhtp8**********
    created_at: "2023-06-24T09:56:38.970Z"
    name: group
    status: ACTIVE
    retention_period: 3600s
    data_stream: /ru-central1/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream
    ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `name` — имя [лог-группы](../concepts/log-group.md). Необязательный параметр. Формат имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.

     * `retention_period` — срок хранения записей в лог-группе. Необязательный параметр.

         Срок хранения записей можно указать только в часах, минутах или секундах. Например, `1h` или `1440m`.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_logging_group" "group1" {
       name             = "<имя_лог-группы>"
       folder_id        = "<идентификатор_каталога>"
       retention_period = "5h"
     }
     ```

     Подробнее о параметрах ресурса `yandex_logging_group` в [документации провайдера Terraform](../../terraform/resources/logging_group.md).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

        ```
        yc logging group list
        ```

- API {#api}

  Чтобы создать [лог-группу](../concepts/log-group.md), воспользуйтесь методом REST API [create](../api-ref/LogGroup/create.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Create](../api-ref/grpc/LogGroup/create.md).

  **Пример запроса**

  Пример использования написан с помощью утилиты `grpcurl`. Чтобы воспользоваться им, [аутентифицируйтесь](../api-ref/authentication.md) в API и клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi).

  Создайте файл `payload.json`:

  ```json
  {
     "folder_id": "<идентификатор_каталога>",
     "name": "new-group",
     "description": "Описание лог-группы, созданной с помощью grpcurl",
     "labels": {
       "compute": "instance-logging"
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
  logging.api.cloud.yandex.net:443 yandex.cloud.logging.v1.LogGroupService.Create < payload.json
  ```

  Ответ:

  ```text
  {
    "id": "e23nitus5cg9********",
    "description": "Create log group",
    "createdAt": "2023-11-23T14:54:23.077532292Z",
    "createdBy": "ajeugsk5ubk6********",
    "modifiedAt": "2023-11-23T14:54:23.077532292Z",
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.logging.v1.CreateLogGroupMetadata",
      "logGroupId": "e23pjn86385t********"
    }
  }
  ```

{% endlist %}