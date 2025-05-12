---
title: Как настроить эндпоинт-источник {{ GP }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ GP }} в {{ data-transfer-full-name }}.
---

# Передача данных из эндпоинта-источника {{ GP }}


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из базы {{ GP }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ GP }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из {{ GP }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

    * [Миграция кластера {{ GP }}](../../../tutorials/managed-greenplum.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Загрузка данных из {{ GP }} в витрину {{ CH }}](../../../tutorials/greenplum-to-clickhouse.md);
    * [Загрузка данных из {{ GP }}  в витрину {{ PG }}](../../../tutorials/greenplum-to-postgresql.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных {{ GP }} {#prepare}

{% include [prepare greenplum db](../../../../_includes/data-transfer/endpoints/sources/greenplum-prepare.md) %}

## Настройка эндпоинта-источника {{ GP }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mgp-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).


### Кластер {{ mgp-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mgp.viewer }}`](../../../../managed-greenplum/security/index.md#mgp-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Managed Greenplum](../../../../_includes/data-transfer/necessary-settings/ui/managed-greenplum.md) %}

{% endlist %}


### Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием сетевых адресов и портов.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise Greenplum UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-greenplum.md) %}

{% endlist %}

### Фильтр таблиц {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.include_tables.title }}** — будут передаваться данные только из таблиц этого списка.

      Если таблица партиционирована, в этом поле можно указать как всю таблицу, так и отдельные ее партиции.

      Также убедитесь, что для включаемых в список таблиц [выданы необходимые привилегии](../../../../data-transfer/operations/prepare.md#source-gp) пользователю, от имени которого будет осуществляться трансфер.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.exclude_tables.title }}** — данные таблиц из этого списка передаваться не будут.

      Если таблица партиционирована, то для исключения таблицы из этого списка необходимо перечислить все ее партиции.

      Списки включают имя [схемы]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-ddl-ddl-schema.html) (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

      * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
      * `<имя_схемы>.*` — все таблицы в указанной схеме;
      * `<имя_таблицы>` — таблица в схеме по умолчанию.

      Имена включенных и исключенных таблиц должны соответствовать правилам именования идентификаторов в {{ GP }}. Двойные кавычки внутри имени таблицы не поддерживаются. Внешние кавычки используются только как разделители и будут удалены при обработке путей.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.strong_consistency.title }}** — при включении {{ data-transfer-name }} выполнит дополнительные действия с источником для обеспечения [консистентности снапшота](#snapshot-consistency).

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.service_schema.title }}** — схема, которая будет использоваться для размещения служебных объектов трансфера.

    Имя схемы должно соответствовать правилам именования идентификаторов в {{ GP }}. Двойные кавычки в имени схемы не поддерживаются.

{% endlist %}

### Особенности работы с источником Greenplum {#advanced}

{{ data-transfer-name }} поддерживает только {{ GP }} версии 6. {{ GP }} версий 4 и 5 не поддерживается.

Сервис выполняет операции с кластером {{ GP }} в транзакциях с [уровнем изоляции]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-SET_TRANSACTION.html) `READ COMMITTED`.

{{ data-transfer-name }} поддерживает работу с включенным [параллельным копированием](../../../concepts/sharded.md) для источника {{ GP }}.

Во время работы с включенным параллельным копированием {{ data-transfer-name }} удерживает открытую транзакцию на хосте-мастере {{ GP }}. При прерывании этой транзакции трансфер завершится с ошибкой.

При отключенном параллельном копировании трансфер переносит данные объектов {{ GP }} `TABLE`, `VIEW`, `FOREIGN TABLE`, и `EXTERNAL TABLE`. Данные из этих объектов трактуются как данные из обыкновенных таблиц и обрабатываются приемником соответственно. При включенном параллельном копировании трансфер переносит только таблицы (объекты `TABLE`), причем таблицы с [политикой распределения]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-CREATE_TABLE.html) `DISTRIBUTED REPLICATED` не переносятся.

### Консистентность снапшота {#snapshot-consistency}

При запуске трансфера с отключенным параллельным копированием (по умолчанию) сервис выполняет копирование, взаимодействуя только с [хостом-мастером](../../../../managed-greenplum/concepts/index.md) кластера {{ GP }}. Доступ к копируемым таблицам осуществляется в [режиме блокировки]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-LOCK.html) `ACCESS SHARE`. Консистентность снапшота обеспечивается средствами {{ GP }}.

При запуске трансфера с включенным параллельным копированием сервис выполняет копирование, взаимодействуя как с хостом-мастером, так и в режиме прямого доступа (utility mode) с [хостами-сегментами](../../../../managed-greenplum/concepts/index.md) кластера {{ GP }}. Доступ к копируемым таблицам осуществляется с блокировкой таблицы в режиме `ACCESS SHARE` или `SHARE`, зависящем от настройки "Обеспечивать строгую консистентность снапшота".

Трансферу с включенным параллельным копированием для обеспечения консистентности снапшота требуется обеспечить неизменность данных в переносимых таблицах. При блокировке в режиме `ACCESS SHARE` (по умолчанию) неизменность данных не обеспечивается сервисом и должна быть обеспечена извне. При блокировке в режиме `SHARE` неизменность данных в исходных таблицах обеспечивается механизмами {{ GP }}.

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}


## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ PG }}](../target/postgresql.md);
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).
