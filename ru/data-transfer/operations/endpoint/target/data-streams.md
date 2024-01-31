---
title: "Как настроить эндпоинт-приемник {{ yds-full-name }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ yds-full-name }} в {{ data-transfer-full-name }}."
---
# Передача данных в эндпоинт-приемник {{ yds-full-name }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в очередь {{ yds-full-name }} и реализовывать различные сценарии обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. [Выполняйте необходимые действия по работе с базой](../../../../_includes/data-transfer/endpoints/sources/pg-work-with-db.md) и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ yds-full-name }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/cdc.md) %}
    * [Захват изменений {{ MY }} и поставка в {{ DS }}](../../../tutorials/mmy-to-yds.md);
    * [Захват изменений {{ PG }} и поставка в {{ DS }}](../../../tutorials/mpg-to-yds.md);
    * [Захват изменений {{ ydb-short-name }} и поставка в {{ DS }}](../../../tutorials/ydb-to-yds.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
  
    * [Поставка данных из {{ KF }} в {{ DS }}](../../../tutorials/mkf-to-yds.md).

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ KF }}](../source/kafka.md);
* [Aibyte](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ objstorage-full-name }}](../source/object-storage.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Настройка эндпоинта-приемника {{ yds-full-name }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* [Настройки подключения](#general-settings) к потоку данных в {{ yds-full-name }} и [настройки сериализации](#serializer). Это обязательные параметры.
* [Расширенные настройки](#additional-settings).

### Основные настройки {#general-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Data Streams UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-data-streams-target.md) %}

{% endlist %}

### Расширенные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSTargetAdvancedSettings.save_tx_order.title }}** — не разбивать поток событий на независимые очереди по таблицам.

{% endlist %}

### {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }} {#serializer}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [serializer](../../../../_includes/data-transfer/serializer.md) %}

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Прерывание трансфера с ошибкой](#overloaded)
* [Редиректы {{ sf-short-name }}](#redirects)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [overloaded](../../../../_includes/data-transfer/troubles/overloaded.md) %}

{% include [redirects](../../../../_includes/data-transfer/troubles/data-streams/data-streams-redirects.md) %}