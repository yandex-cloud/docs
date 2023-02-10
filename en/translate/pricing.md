---
editable: false
---
# Pricing for {{ translate-name }}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ translate-short-name }} {#rules}

### Translation and language detection {#rules-translate-detect}

The cost for using Yandex Translate is calculated based on the total number of characters that were sent in requests for text translation and language detection during a calendar month (the Reporting Period).

{% include [pricing-symbol-count](../_includes/pricing-symbol-count.md) %}

## Prices {#prices}

### Text translation and language detection {#prices-translate-detect}

{% if region == "ru"%}

{% include [rub.md](../_pricing/translate/rub.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/translate/kzt.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/translate/usd.md) %}

{% endif %}
