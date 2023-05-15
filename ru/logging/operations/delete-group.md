---
title: "Инструкция о том, как удалить лог-группу в {{ cloud-logging-name }}"
description: "Из статьи вы узнаете, как удалить лог-группу в {{ cloud-logging-name }}."
---

# Удаление группы

{% note info %}

Имя [лог-группы по умолчанию](../concepts/log-group.md) — `default`. Вы можете удалить ее, но она автоматически создастся заново, если сервис или приложение запишет логи, указав в качестве назначения идентификатор каталога.

{% endnote %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите удалить [лог-группу](../concepts/log-group.md).
    1. Выберите сервис **{{ cloud-logging-name }}**.
    1. В строке с лог-группой нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Для обращения к лог-группе используйте ее имя или уникальный идентификатор. Чтобы узнать их, [получите](./list.md) список лог-групп в каталоге.

    Чтобы удалить лог-группу, выполните команду:

    ```
    yc logging group delete --name=group
    ```

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
    ```

- {{ TF }}

  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить лог-группу, созданную с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием лог-группы.
     
     {% cut "Пример описания лог-группы в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_logging_group" "group1" {
       name      = "test-logging-group"
       folder_id = "${data.yandex_resourcemanager_folder.test_folder.id}"
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

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

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc logging group list
     ```

- API

  Чтобы удалить пользовательскую лог-группу, воспользуйтесь методом REST API [delete](../api-ref/LogGroup/delete.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Delete](../api-ref/grpc/log_group_service.md#Delete).

{% endlist %}
