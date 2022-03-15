# Параметры эндпоинта-приемника {{ PG }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mpg-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

## Кластер {{ mpg-name }} {#managed-service}

Подключение к БД с указанием идентификатора кластера в {{ yandex-cloud }}. Доступно только для кластеров, развернутых в сервисе [{{ mpg-full-name }}](../../../../managed-postgresql/).

{% list tabs %}

- Консоль управления

    {% include [Managed Postgresql](../../../../_includes/data-transfer/necessary-settings/ui/managed-postgresql.md) %}

- CLI

    * Тип эндпоинта — `postgres-target`.

    {% include [Managed PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-postgresql.md) %}

- API

    {% include [Managed PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-postgresql.md) %}

{% endlist %}

## Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием ее сетевого адреса и порта.

{% list tabs %}

- Консоль управления

    {% include [On premise Postgresql](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-postgresql.md) %}

- CLI

    * Тип эндпоинта — `postgres-target`.

    {% include [On premise PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-postgresql.md) %}

- API

    {% include [On premise PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-postgresql.md) %}

{% endlist %}

## Дополнительные настройки {#additional-settings}

{% list tabs %}

- Консоль управления

    * {% include [Field Cleanup Policy Disabled/Drop/Truncate](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop-truncate.md) %}

    * **Сохранение границ транзакций** — включите, чтобы сервис записывал данные в базу-приемник только после полного чтения данных транзакции из базы-источника.

        {% note warning %}

        Эта функциональность находится на стадии [Preview](../../../../overview/concepts/launch-stages.md).

        {% endnote %}

{% endlist %}
