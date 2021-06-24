---
editable: false
---

# Правила тарификации для Yandex CDN

При расчете стоимости использования {{ cdn-full-name }} учитывается только объем исходящего трафика из CDN в интернет. Передача данных между сервисами {{ yandex-cloud }} и входящий трафик из интернета не тарифицируются.


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
