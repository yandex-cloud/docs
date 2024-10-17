---
title: Инструкция о том, как создать приемник логов в {{ cloud-logging-name }}
description: Из статьи вы узнаете, как создать приемник логов в {{ cloud-logging-name }}.
---

# Создать приемник логов

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать приемник логов.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Перейдите на вкладку **{{ ui-key.yacloud.logging.label_sinks }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-sink }}**.
    1. (Опционально) Введите имя и описание приемника логов. Формат имени:

        {% include [name-format](../../_includes/name-format.md) %}

    1. (Опционально) Добавьте метки.
    1. В поле **{{ ui-key.yacloud.logging.label_destination }}** выберите `{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}`.
    1. Выберите бакет, в который будут сохраняться логи.
    1. (Опционально) Укажите [папку](../../storage/concepts/object.md#folder).
    1. Выберите сервисный аккаунт, у которого есть права на загрузку объектов в бакет.
    1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-sink }}**.

- CLI {#cli}

    Чтобы создать приемник логов, выполните команду:
    ```
    yc logging sink create \
      --name <имя_приемника> \
      --service-account-id <идентификатор_сервисного_аккаунта> \
      --s3 bucket=<имя_бакета>
    ```

    Где:
    * `--name` — имя приемника логов. Необязательный параметр.
    * `--service-account-id` — идентификатор сервисного аккаунта, у которого есть права на загрузку объектов в бакет.
    * `bucket` — имя бакета, в который будут выгружаться логи.

    Результат:
    ```
    id: e23s5s2jsr78********
    folder_id: b1gc1t4cb638********
    cloud_id: b1gvlrnlei4l********
    created_at: "2023-09-24T19:05:33.367058291Z"
    name: test
    service_account_id: aje07l4q4vmo********
    s3:
      bucket: bucket-name
    ```

- API {#api}

    Чтобы создать приемник логов, воспользуйтесь методом REST API [create](../api-ref/Sink/create.md) для ресурса [Sink](../api-ref/Sink/index.md) или вызовом gRPC API [SinkService/Create](../api-ref/grpc/Sink/create.md).

{% endlist %}
