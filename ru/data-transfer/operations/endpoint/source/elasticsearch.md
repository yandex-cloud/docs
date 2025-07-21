---
title: Инструкция по настройке эндпоинта-источника {{ ES }} в {{ data-transfer-full-name }}
description: Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-источника {{ ES }} в {{ data-transfer-full-name }}.
---

# Передача данных из эндпоинта-источника {{ ES }}


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные поиска и аналитики из базы {{ ES }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ ES }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из {{ ES }} {#scenarios}

{% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

* [Миграция со сменой типа хранилища из {{ ES }} в {{ OS }}](../../../tutorials/mes-to-mos.md)

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% include [elastic-version](../../../../_includes/data-transfer/elastic-version-note.md) %}

{% include [prepare elasticsearch db](../../../../_includes/data-transfer/endpoints/sources/elasticsearch-prepare.md) %}

## Настройка эндпоинта-источника {{ ES }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).


### Пользовательская инсталляция {#on-premise}

Подключение к узлам с явным указанием сетевых адресов и портов.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise Elasticsearch UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-elasticsearch.md) %}

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchSource.dump_index_with_mapping.title }}** — выберите эту опцию, чтобы перенести типы данных с источника на приемник до начала трансфера. Если опция отключена, а схема индекса на приемнике не задана, то типы данных на приемнике будут определяться автоматически в процессе трансфера.

    {% include [dump-index-warning](../../../../_includes/data-transfer/necessary-settings/ui/dump-index-warning.md) %}

{% endlist %}


## Настройка приемника данных {#supported-targets}

Настройте эндпоинт-приемник:

* [{{ OS }}](../target/opensearch.md);
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md);
* [{{ objstorage-full-name }}](../target/object-storage.md);
* [{{ KF }}](../target/kafka.md);
* [{{ DS }}](../target/data-streams.md);

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Прерывание трансфера с ошибкой](#ambiguous-resolution-es)
* [Дублирование документов на приемнике](#duplication)
* [Версия {{ ES }} не поддерживается](#elastic-version)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [ambiguous-object-resolution-es](../../../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-es.md) %}

{% include [duplication](../../../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}

{% include [elastic-version](../../../../_includes/data-transfer/troubles/elastic-opensearch/elastic-version.md) %}