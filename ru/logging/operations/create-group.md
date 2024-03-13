---
title: "Инструкция о том, как создать лог-группу в {{ cloud-logging-name }}"
description: "Из статьи вы узнаете, как создать лог-группу в {{ cloud-logging-name }}."
---

# Создать лог-группу

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [лог-группу](../concepts/log-group.md).
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.
    1. (Опционально) Введите имя и описание лог-группы. Формат имени:

        {% include [name-format](../../_includes/name-format.md) %}

    1. Укажите срок хранения записей в лог-группе.
    1. (опционально) Выберите [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) или создайте новый.
    1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

        {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

    
    * `--data-stream` — идентификатор [потока данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }}. Необязательный параметр. В указанный поток автоматически будут перенаправляться записи, которые добавили в лог-группу. Идентификатор потока состоит из зоны доступности, идентификатора каталога, идентификатора базы данных {{ ydb-full-name }} и имени потока.

        >Например, укажите идентификатор потока `/{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream`, если:
        >* `aws_stream` — имя потока;
        >* `{{ region-id }}` — зона доступности;
        >* `aoeu1kuk2dht********` — идентификатор каталога;
        >* `cc8029jgtuab********` — идентификатор базы данных {{ ydb-full-name }}.


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
    data_stream: /{{ region-id }}/aoeu1kuk2dht********/cc8029jgtuab********/aws_stream
    ```


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `name` — имя [лог-группы](../concepts/log-group.md). Необязательный параметр. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.

     * `retention_period` — срок хранения записей в лог-группе. Необязательный параметр.

         {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

     Пример структуры конфигурационного файла:

     
     ```hcl
     provider "yandex" {
       token     = "<OAuth-токен>"
       cloud_id  = "<идентификатор_облака>"
       folder_id = "<идентификатор_каталога>"
       zone      = "{{ region-id }}-a"
     }

     resource "yandex_logging_group" "group1" {
       name             = "<имя_лог-группы>"
       folder_id        = "<идентификатор_каталога>"
       retention_period = "5h"
     }
     ```



     Более подробную информацию о параметрах ресурса `yandex_logging_group` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/logging_group).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```
        yc logging group list
        ```

- API {#api}

  Чтобы создать [лог-группу](../concepts/log-group.md), воспользуйтесь методом REST API [create](../api-ref/LogGroup/create.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Create](../api-ref/grpc/log_group_service.md#Create).

  **Пример запроса**

  {% include [api-example-introduction](../../_includes/logging/api-example-introduction.md) %}

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