---
editable: false
---

# Pricing for {{ cloud-logging-name }}

## What goes into the cost of using {{ cloud-logging-name }} {#rules}

In {{ cloud-logging-name }} , you're billed for the amount of recorded data and storage time.

## Pricing {#prices}

{% note info %}

Prices are valid from November 1, 2022.

{% endnote %}

### Data recording {#data-ingested}

{% if region == "ru" %}

{% include [rub-data-ingested.md](../_pricing/logging/rub-data-ingested.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-data-ingested.md](../_pricing/logging/kzt-data-ingested.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-data-ingested.md](../_pricing/logging/usd-data-ingested.md) %}

{% endif %}

### Data storage {#storage}

{% if region == "ru" %}

{% include [rub-storage.md](../_pricing/logging/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage.md](../_pricing/logging/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-storage.md](../_pricing/logging/usd-storage.md) %}

{% endif %}
