---
editable: false
---

# Правила тарификации для {{ cdn-full-name }}

При расчете стоимости использования {{ cdn-full-name }} учитывается только объем исходящего трафика с CDN-серверов, в том числе запрошенного с пользовательских ресурсов сервисов {{ yandex-cloud }}: например, с [виртуальных машин](../compute/concepts/vm.md) {{ compute-full-name}}. Входящий трафик, поступающий на CDN-серверы от сервисов и ресурсов {{ yandex-cloud }} и из интернета, не тарифицируется.


## Цены {#prices}

{% if region == "ru" %}

{% include notitle [rub.md](../_pricing/cdn/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt.md](../_pricing/cdn/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd.md](../_pricing/cdn/usd.md) %}

{% endif %}
