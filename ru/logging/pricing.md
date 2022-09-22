---
editable: false
---

# Правила тарификации для {{ cloud-logging-name }}

## Из чего складывается стоимость использования {{ cloud-logging-name }} {#rules}

В рамках сервиса {{ cloud-logging-name }} тарифицируются объем записываемых данных и время их хранения.

## Цены {#prices}

{% note info %}

Цены действуют с 1 ноября 2022 года.

{% endnote %}

### Запись данных {#data-ingested}

{% if region == "ru" %}

{% include [rub-data-ingested.md](../_pricing/logging/rub-data-ingested.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-data-ingested.md](../_pricing/logging/kzt-data-ingested.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-data-ingested.md](../_pricing/logging/usd-data-ingested.md) %}

{% endif %}

### Хранение данных {#storage}

{% if region == "ru" %}

{% include [rub-storage.md](../_pricing/logging/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage.md](../_pricing/logging/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-storage.md](../_pricing/logging/usd-storage.md) %}

{% endif %}
