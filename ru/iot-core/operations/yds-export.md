---
title: "Экспорт сообщений в {{ yds-name }}"
description: "Следуя данной инструкции, вы сможете экспортировать сообщения в {{ yds-name }}."
---

# Экспорт сообщений в {{ yds-name }}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится реестр.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. Выберите в списке нужный реестр.
  1. Перейдите на вкладку **{{ ui-key.yacloud.iot.label_yds-exports }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.iot.button_add-yds-export }}**.
  1. Заполните поля:

     * **{{ ui-key.yacloud.common.name }}** — имя экспорта.
     * **{{ ui-key.yacloud.iot.label_mqtt-topic-filter }}** — укажите топик, из которого будут экспортироваться сообщения, или фильтр с использованием [символов подстановки](../concepts/topic/usage.md#wildcards). Если поле пустое, экспортируются сообщения из всех топиков реестра и всех топиков устройств внутри реестра.
     * **{{ ui-key.yacloud.data-streams.label_data-stream }}** — укажите [поток данных](../../data-streams/concepts/glossary.md#stream-concepts), в который будут отправляться сообщения из MQTT-топиков, или [создайте новый](../../data-streams/operations/manage-streams.md#create-data-stream). Если вы создали новый поток, нажмите кнопку **Обновить** для обновления списка потоков.
     * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — укажите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с ролью `yds-writer`.

  1. Нажмите кнопку **Добавить**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы создать экспорт:

  1. Получите список реестров в каталоге:

     ```bash
     yc iot registry list
     ```

     Результат:

     ```text
     +----------------------+-------------------+
     |          ID          |       NAME        |
     +----------------------+-------------------+
     | arenou2oj4********** | my-registry       |
     +----------------------+-------------------+
     ```

  1. Создайте экспорт:

     ```bash
     yc iot registry yds-export add \
       --registry-name <название_реестра> \
       --name <название_экспорта> \
       --database <путь_базы_данных> \
       --stream <название_потока> \
       --mqtt-topic-filter <топик> \
       --stream-service-account-name <название_сервисного_аккаунта>
     ```

     Где:

     * `--registry-name` — имя реестра.
     * `--name` — имя экспорта.
     * `--database` — [размещение базы данных](https://ydb.tech/ru/docs/concepts/connect#database), в которой хранятся данные потока: вторая часть значения поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть после вхождения `/?database=`). Например, `/ru-central1/r1gra875baommfd5leds/g5n22e7ejf**********`.
     * `--stream` — имя [потока данных](../../data-streams/concepts/glossary.md#stream-concepts), в который будут отправляться сообщения из MQTT-топиков.
     * `--mqtt-topic-filter` — топик, из которого будут экспортироваться сообщения, или фильтр с использованием [символов подстановки](../concepts/topic/usage.md#wildcards). Если параметр не указан, экспортируются сообщения из всех топиков реестра и всех топиков устройств внутри реестра.
     * `--stream-service-account-name` — имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с ролью `yds-writer`.

     Результат:

     ```text
     id: are520n46t**********
     name: export-from-topic
     registry_id: areqqa5ntm**********
     database: /ru-central1/b1gia87mbaomkfvsleds/etnu4r0v1c**********
     stream: topic-message-stream
     service_account_id: ajeu9klp40**********
     created_at: "2023-09-18T09:52:28.840124837Z"
     ```

- API

  Чтобы добавить экспорт в {{ yds-name }} для реестра, воспользуйтесь вызовом gRPC API [RegistryService/AddDataStreamExport](../api-ref/grpc/registry_service.md#AddDataStreamExport).

{% endlist %}

## См. также {#see-also}

* [{#T}](../concepts/topic/usage.md#yds-export)
