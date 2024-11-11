---
title: Как настроить эндпоинт-источник {{ yds-full-name }} в {{ data-transfer-full-name }}
description: Следуя данной инструкции, вы сможете настроить эндпоинт-источник {{ yds-full-name }} в {{ data-transfer-full-name }}.
---

# Передача данных из эндпоинта-источника {{ yds-full-name }}


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из очереди {{ yds-name }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ yds-name }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из {{ yds-name }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

   Отдельной задачей миграции является зеркалирование данных между очередями {{ yds-name }}.

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}

    * [{{ DS }} в {{ CH }}](../../../tutorials/yds-to-clickhouse.md);
    * [{{ DS }} в {{ objstorage-name }}](../../../tutorials/yds-to-objstorage.md);
    * [{{ DS }} в {{ OS }}](../../../tutorials/trails-to-os.md);
    * [{{ DS }} в {{ ydb-name }}](../../../tutorials/yds-to-ydb.md);
    * [{{ DS }} в {{ mkf-name }}](../../../tutorials/yds-to-kafka.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% include [prepare yds db](../../../../_includes/data-transfer/endpoints/sources/yds-prepare.md) %}

## Настройка эндпоинта-источника {{ yds-name }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения](#managed-service) к потоку данных в [{{ yds-full-name }}](#managed-service). Это обязательные параметры.
* [Расширенные настройки](#additional-settings).

### Основные настройки {#managed-service}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Data Streams UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-data-streams-source.md) %}

{% endlist %}

### Расширенные настройки {#additional-settings}


{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}


{% list tabs group=instructions %}

- Консоль управления {#console}


    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.transformer.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.cloud_function.title }}** — выберите одну из функций, созданных в сервисе {{ sf-name }}.


            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}** — выберите или [создайте](../../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого будет запускаться функция обработки.


        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.number_of_retries.title }}** — укажите количество попыток вызова функции обработки.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_size.title }}** — укажите размер буфера (в байтах), при заполнении которого данные будут переданы функции обработки.

            Максимальный размер буфера — 3,5 МБ. Подробнее об ограничениях, действующих при работе с функциями в сервисе {{ sf-name }}, читайте в [соответствующем разделе](../../../../functions/concepts/limits.md).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** — укажите длительность интервала (в секундах), по истечении которого данные из потока должны быть переданы функции обработки.

            {% note info %}

            Если буфер заполнится или истечет интервал отправки, данные будут переданы функции обработки.

            {% endnote %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** — укажите допустимое время ожидания ответа от функции обработки (в секундах).

        {% note warning %}

        Значения в полях **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** указываются с постфиксом `s`, например, `10s`.

        {% endnote %}


    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**:

       * {% include [conversion-rules](../../../../_includes/data-transfer/fields/yds/ui/conversion-rules.md) %}    

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.supported_codecs.title }}** — укажите требуемый формат сжатия данных: `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.gzip.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.zstd.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.raw.title }}`

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.allow_ttl_rewind.title }}** — выберите опцию, чтобы продолжить работу трансфера при превышении TTL топика, потеряв часть данных. Если опция не выбрана, трансфер остановится с ошибкой, определив потерю данных.

{% endlist %}


## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ PG }}](../target/postgresql.md);
* [{{ MY }}](../target/mysql.md);
* [{{ MG }}](../target/mongodb.md)
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md);
* [{{ objstorage-full-name }}](../target/object-storage.md);
* [{{ KF }}](../target/kafka.md);
* [{{ DS }}](../target/data-streams.md);
* [{{ ES }}](../target/elasticsearch.md);
* [{{ OS }}](../target/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Прерывание трансфера с ошибкой](#overloaded)
* [Редиректы {{ sf-short-name }}](#redirects)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [overloaded](../../../../_includes/data-transfer/troubles/overloaded.md) %}

{% include [redirects](../../../../_includes/data-transfer/troubles/data-streams/data-streams-redirects.md) %}

