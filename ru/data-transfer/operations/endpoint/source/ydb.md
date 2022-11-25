# Настройка эндпоинта-источника YDB

{% if audience == "external" %}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Базу данных {{ ydb-full-name }} и [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) для доступа к ней.
* Список путей для переноса (таблицы, директории).

## Настройки {#settings}

{% list tabs %}

- Консоль управления

    {% include [YDB UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-database.md) %}

    * **Список путей для переноса** — добавьте пути к таблицам или директориям {{ ydb-name }}, которые необходимо перенести. Если ни одного пути не указано, будут перенесены все таблицы.

{% endlist %}

{% endif %}
