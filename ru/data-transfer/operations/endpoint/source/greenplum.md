---
title: "Как настроить эндпоинт-источник {{ GP }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ GP }} в {{ data-transfer-full-name }}."
---

# Настройка эндпоинта-источника {{ GP }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mgp-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).



## Кластер {{ mgp-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mgp.viewer }}`](../../../../managed-greenplum/security/index.md#mgp-viewer) или примитивная [роль `viewer`](../../../../iam/concepts/access-control/roles.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mgp-full-name }}](../../../../managed-greenplum/).

{% list tabs %}

- Консоль управления

    {% include [Managed Greenplum](../../../../_includes/data-transfer/necessary-settings/ui/managed-greenplum.md) %}

{% endlist %}



## Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием сетевых адресов и портов.

{% list tabs %}

- Консоль управления

    {% include [On premise Greenplum UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-greenplum.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.include_tables.title }}** — будут передаваться данные только из таблиц этого списка.

      Если таблица партиционирована, в этом поле можно указать как всю таблицу, так и отдельные ее партиции.

      Также убедитесь, что для включаемых в список таблиц [выданы необходимые привилегии](../../../../data-transfer/operations/prepare.md#source-gp) пользователю, от имени которого будет осуществляться трансфер.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.exclude_tables.title }}** — данные таблиц из этого списка передаваться не будут.

      Если таблица партиционирована, то для исключения таблицы из этого списка необходимо перечислить все ее партиции.

      Списки включают имя [схемы]({{gp.docs.vmware}}/6/greenplum-database/admin_guide-ddl-ddl-schema.html) (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

      * `<имя схемы>.<имя таблицы>` — полное имя таблицы;
      * `<имя схемы>.*` — все таблицы в указанной схеме;
      * `<имя таблицы>` — таблица в схеме по умолчанию.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.strong_consistency.title }}** — при включении {{ data-transfer-name }} выполнит дополнительные действия с источником для обеспечения [консистентности снапшота](#snapshot-consistency).

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.service_schema.title }}** — схема, которая будет использоваться для размещения служебных объектов трансфера.

{% endlist %}

## Особенности работы с источником Greenplum {#advanced}

{{ data-transfer-name }} поддерживает только {{ GP }} версии 6. {{ GP }} версий 4 и 5 не поддерживается.

Сервис выполняет операции с кластером {{ GP }} в транзакциях с [уровнем изоляции]({{ gp.docs.pivotal }}/6-19/ref_guide/sql_commands/SET_TRANSACTION.html) `READ COMMITTED`.

{{ data-transfer-name }} поддерживает работу с включенным [параллельным копированием](../../../concepts/sharded.md) для источника {{ GP }}.

Во время работы с включенным параллельным копированием {{ data-transfer-name }} удерживает открытую транзакцию на хосте-мастере {{ GP }}. При прерывании этой транзакции трансфер завершится с ошибкой.

При отключенном параллельном копировании трансфер переносит данные объектов {{ GP }} `TABLE`, `VIEW`, `FOREIGN TABLE`, и `EXTERNAL TABLE`. Данные из этих объектов трактуются как данные из обыкновенных таблиц и обрабатываются приемником соответственно. При включенном параллельном копировании трансфер переносит только таблицы (объекты `TABLE`), причем таблицы с [политикой распределения]({{ gp.docs.pivotal }}/6-19/admin_guide/distribution.html) `DISTRIBUTED REPLICATED` не переносятся.

### Консистентность снапшота {#snapshot-consistency}

При запуске трансфера с отключенным параллельным копированием (по умолчанию) сервис выполняет копирование, взаимодействуя только с [хостом-мастером](../../../../managed-greenplum/concepts/index.md) кластера {{ GP }}. Доступ к копируемым таблицам осуществляется в [режиме блокировки]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-sql_commands-LOCK.html) `ACCESS SHARE`. Консистентность снапшота обеспечивается средствами {{ GP }}.

При запуске трансфера с включенным параллельным копированием сервис выполняет копирование, взаимодействуя как с хостом-мастером, так и в режиме прямого доступа (utility mode) с [хостами-сегментами](../../../../managed-greenplum/concepts/index.md) кластера {{ GP }}. Доступ к копируемым таблицам осуществляется с блокировкой таблицы в режиме `ACCESS SHARE` или `SHARE`, зависящем от настройки "Обеспечивать строгую консистентность снапшота".

Трансферу с включенным параллельным копированием для обеспечения консистентности снапшота требуется обеспечить неизменность данных в переносимых таблицах. При блокировке в режиме `ACCESS SHARE` (по умолчанию) неизменность данных не обеспечивается сервисом и должна быть обеспечена извне. При блокировке в режиме `SHARE` неизменность данных в исходных таблицах обеспечивается механизмами {{ GP }}.

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
