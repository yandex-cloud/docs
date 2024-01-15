---
title: "Инструкция по настройке эндпоинта-приемника {{ ES }} в {{ data-transfer-full-name }}"
description: "Из статьи вы узнаете, как задать настройки при создании или изменении эндпоинта-приемника {{ ES }} в {{ data-transfer-full-name }}."
---
# Передача данных в эндпоинт-приемник {{ ES }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в базу {{ ES }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных {{ ES }}](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ ES }} {#scenarios}

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    * [Поставка данных из {{ KF }} в {{ ES }}](../../../tutorials/mkf-to-mes.md)    

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ KF }}](../source/kafka.md);
* [{{ DS }}](../source/data-streams.md);
* [{{ PG }}](../source/postgresql.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} см. в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Подготовка базы данных приемника {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/elasticsearch-prepare.md) %}

## Настройка эндпоинта-приемника {{ ES }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mes-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).


### Кластер {{ mes-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mes.viewer }}`](../../../../managed-elasticsearch/security/index.md#mes-viewer) или примитивная [роль `viewer`](../../../../iam/concepts/access-control/roles.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение с указанием идентификатора кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [Managed Elasticsearch](../../../../_includes/data-transfer/necessary-settings/ui/managed-elasticsearch.md) %}

{% endlist %}


### Пользовательская инсталляция {#on-premise}

Подключение к узлам с явным указанием сетевых адресов и портов.

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [On premise Elasticsearch UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-elasticsearch.md) %}

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchTarget.cleanup_policy.title }}** — выберите способ очистки данных в приемнике перед переносом:

        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` — выберите эту опцию, если будет производиться только репликация без копирования данных.

        * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

            Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchTarget.sanitize_doc_keys.title }}** — выберите эту опцию, чтобы для полей на приемнике выполнялась автозамена ключей, невалидных для {{ ES }}.

        {% include [sanitize-rules](../../../../_includes/data-transfer/necessary-settings/ui/es-os-sanitize-rules.md) %}

{% endlist %}


После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Прерывание трансфера с ошибкой](#ambiguous-resolution-es)
* [Дублирование документов на приемнике](#duplication)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

{% include [ambiguous-object-resolution-es](../../../../_includes/data-transfer/troubles/elastic-opensearch/ambiguous-object-resolution-es.md) %}

{% include [duplication](../../../../_includes/data-transfer/troubles/elastic-opensearch/duplication.md) %}