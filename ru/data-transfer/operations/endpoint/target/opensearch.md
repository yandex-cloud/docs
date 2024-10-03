---
title: "Инструкция по настройке эндпоинта-приемника {{ OS }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ OS }} в {{ data-transfer-full-name }}."
---
# Передача данных в эндпоинт-приемник {{ OS }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в базу {{ OS }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных {{ OS }}](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ OS }} {#scenarios}

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    * [Поставка данных из {{ DS }} в {{ OS }}](../../../tutorials/trails-to-os.md);
   * [Поставка данных из {{ KF }} в {{ OS }}](../../../tutorials/mkf-to-mos.md).

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
    * [Миграция кластера {{ OS }}](../../../tutorials/os-to-mos.md);
    * [Миграция со сменой хранилища: из {{ ES }} в {{ OS }}](../../../tutorials/mes-to-mos.md);
    * [Миграция со сменой хранилища: из {{ PG }} в {{ OS }}](../../../tutorials/postgresql-to-opensearch.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} см. в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ DS }}](../source/data-streams.md);
* [{{ KF }}](../source/kafka.md);
* [{{ ES }}](../source/elasticsearch.md);
* [{{ OS }}](../source/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

{% note info %}

Ограничение для типа данных: если из источника передается запись с типом `ip` (IP-адрес), то в приемнике эта запись будет сохранена с типом `text`.

{% endnote %}

## Подготовка базы данных приемника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/opensearch-prepare.md) %}

## Настройка эндпоинта-приемника {{ OS }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mos-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).


### Кластер {{ mos-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mos.viewer }}`](../../../../managed-opensearch/security/index.md#mos-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Managed OpenSearch](../../../../_includes/data-transfer/necessary-settings/ui/managed-opensearch.md) %}

{% endlist %}


### Пользовательская инсталляция {#on-premise}

Подключение к узлам с явным указанием сетевых адресов и портов.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise OpenSearch UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-opensearch.md) %}

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchTarget.cleanup_policy.title }}** — выберите способ очистки данных в приемнике перед переносом:

        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` — выберите эту опцию, если будет производиться только репликация без копирования данных.

        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

            Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchTarget.sanitize_doc_keys.title }}** — выберите эту опцию, чтобы для полей на приемнике выполнялась автозамена ключей, невалидных для {{ OS }}.

        {% include [sanitize-rules](../../../../_includes/data-transfer/necessary-settings/ui/es-os-sanitize-rules.md) %}

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Прерывание трансфера с ошибкой](#ambiguous-resolution-es)
* [Дублирование документов на приемнике](#duplication)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [ambiguous-object-resolution-os](../../../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-os.md) %}

{% include [duplication](../../../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}


