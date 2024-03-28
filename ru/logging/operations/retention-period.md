---
title: "Изменение лог-группы"
description: "Следуя данной инструкции, вы сможете изменить лог-группу."
---

# Изменить лог-группу

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [лог-группа](../concepts/log-group.md).
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. В строке с лог-группой нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
    1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
    1. Измените параметры лог-группы.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Для обращения к лог-группе используйте ее имя или уникальный идентификатор. Чтобы узнать их, [получите](./list.md) список лог-групп в каталоге.

    Чтобы изменить параметры [лог-группы](../concepts/log-group.md), например срок хранения записей, выполните команду:

    ```
    yc logging group update --name=default --retention-period=24h
    ```

    Где:

    * `--name` — имя лог-группы, срок хранения записей в которой вы хотите изменить.
    * `--retention-period` — новый срок хранения записей в лог-группе.

        {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

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

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы изменить параметры [лог-группы](../concepts/log-group.md), созданной с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените нужный параметр в описании лог-группы, например срок хранения записей:

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

        {% include [retention-period](../../_includes/logging/retention-period-format.md) %}

     Более подробную информацию о параметрах ресурса `yandex_logging_group` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/logging_group).

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение лог-группы можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc logging group get <имя_лог-группы>
     ```

- API {#api}

  Чтобы изменить лог-группу, воспользуйтесь методом REST API [update](../api-ref/LogGroup/update.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Update](../api-ref/grpc/log_group_service.md#Update).

  
  **Пример запроса**

  {% include [api-example-introduction](../../_includes/logging/api-example-introduction.md) %}

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
  logging.{{ api-host }}:443 yandex.cloud.logging.v1.LogGroupService.Update < payload.json
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
