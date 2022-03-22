---
editable: false
---

# Правила тарификации для {{ cdn-full-name }}

При расчете стоимости использования {{ cdn-name }} учитываются:
* Объем исходящего трафика с CDN-серверов, в том числе запрошенного с пользовательских ресурсов сервисов {{ yandex-cloud }}, например с [виртуальных машин](../compute/concepts/vm.md) {{ compute-full-name}}. Входящий трафик, поступающий на CDN-серверы от сервисов и ресурсов {{ yandex-cloud }} и из интернета, не тарифицируется.
* Платные функции, включенные для ресурсов: [экранирование источников](concepts/origins-shielding.md) и [выгрузка логов](concepts/logs.md).

  {% note info %}

  Использование платных функций начнет тарифицироваться 1 октября 2021 года.

  {% endnote %}

## Цены {#prices}

{% if region != "int" %}

{% include [disclaimer-new-prices](../_pricing/disclaimer-new-prices.md) %}

{% endif %}

### Исходящий трафик {#traffic}

{% if region == "ru" %}

{% include notitle [rub.md](../_pricing/cdn/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt.md](../_pricing/cdn/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd.md](../_pricing/cdn/usd.md) %}

{% endif %}

### Платные функции {#paid-features}

Тарификация помесячная. Если функция подключена или отключена в любой день месяца, в последний день будет списана полная цена функции в месяц.

{% if region == "ru" %}

{% include notitle [rub-paid-features.md](../_pricing/cdn/rub-paid-features.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-paid-features.md](../_pricing/cdn/kzt-paid-features.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-paid-features.md](../_pricing/cdn/usd-paid-features.md) %}

{% endif %}