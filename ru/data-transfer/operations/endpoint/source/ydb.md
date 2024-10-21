---
title: Как настроить эндпоинт-источник {{ ydb-full-name }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ ydb-full-name }} в {{ data-transfer-full-name }}.
---

# Передача данных из эндпоинта-источника {{ ydb-name }}


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из базы {{ ydb-name }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ ydb-name }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из {{ ydb-name }} {#scenarios}

1. {% include [cdc](../../../../_includes/data-transfer/scenario-captions/cdc.md) %}
    
    * [Захват изменений из {{ PG }} и поставка в {{ DS }}](../../../tutorials/ydb-to-yds.md);
    * [Захват изменений из {{ PG }} и поставка в {{ KF }}](../../../tutorials/cdc-ydb.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Загрузка данных из {{ ydb-short-name }} в витрину {{ CH }}](../../../tutorials/ydb-to-clickhouse.md).

1. {% include [storage](../../../../_includes/data-transfer/scenario-captions/storage.md) %}

    * [Загрузка данных из {{ ydb-short-name }} в {{ objstorage-name }}](../../../../_tutorials/dataplatform/datatransfer/ydb-to-object-storage.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/ydb-prepare.md) %}

## Настройка эндпоинта-источника {{ ydb-name }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:
* Настройки подключения к базе данных {{ ydb-full-name }}. Эти параметры обязательные.
* Список путей для переноса (таблицы, директории).


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `ydb.viewer`](../../../../ydb/security/index.md#ydb-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/database-name.md) %}

  
  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/service-account.md) %}

  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/security-groups.md) %}


  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}** — добавьте пути к таблицам или директориям {{ ydb-name }}, которые необходимо перенести.

      Имена таблиц и директорий должны соответствовать правилам именования идентификаторов в {{ ydb-short-name }}. Экранирование двойных кавычек не требуется. В пути в качестве разделителя используется символ `/`. Подробнее читайте в [документации {{ ydb-short-name }}]({{ ydb.docs }}/concepts/connect#database).

      Добавление новых путей при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных таблиц. Чтобы добавить таблицу с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [параметрах трансфера](../../transfer.md#update).

      Для трансферов типа {{ dt-type-copy }} можно не указывать пути, в таком случае будут перенесены все таблицы.

      Для трансферов типа {{ dt-type-repl }} или {{ dt-type-copy-repl }} обязательно указывать пути, в том числе и при репликации всех таблиц.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.changefeed_custom_name.title }}** — Укажите здесь название потока изменений, если он уже создан. В противном случае оставьте это поле пустым.

{% endlist %}


## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ CH }}](../target/clickhouse.md);
* [{{ objstorage-full-name }}](../target/object-storage.md);
* [{{ KF }}](../target/kafka.md);
* [{{ DS }}](../target/data-streams.md);
* [{{ ydb-full-name }}](../target/yandex-database.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Известные проблемы, связанные с использованием эндпоинта {{ ydb-name }}:

{% include [overloaded](../../../../_includes/data-transfer/troubles/overloaded.md) %}

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).
