---
title: Как настроить эндпоинт-источник YTsaurus в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника YTsaurus в {{ data-transfer-full-name }}.
---

# Передача данных из эндпоинта-источника {{ ytsaurus-name }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из таблиц {{ ytsaurus-name }} в управляемые базы данных и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой данных и [контролируйте трансфер](../../monitoring.md).

## Сценарии передачи данных из {{ ytsaurus-name }} {#scenarios}

Вы можете реализовывать сценарии загрузки данных из таблиц в управляемые базы данных {{ yandex-cloud }} для дальнейшего хранения в облаке, обработки и загрузки в витрины данных для визуализации.

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка эндпоинта-источника {{ myt-name }} {#endpoint-settings}


При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки доступа к [кластеру {{ myt-name }}](#cluster):


{% list tabs group=instructions %}

- Консоль управления {#console}

    
    {% include [UI settings](../../../../_includes/data-transfer/fields/yt/ui/main-settings.md) %}


    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yt.console.form.yt.YTSource.paths.title }}** — пути к таблицам с данными. Для добавления нового пути нажмите кнопку **+ {{ ui-key.yc-data-transfer.data-transfer.console.form.yt.console.form.yt.YTTarget.path.title }}** и введите значение.

{% endlist %}


## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ PG }}](../target/postgresql.md);
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

