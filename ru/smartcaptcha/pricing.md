---
editable: false
---

# Правила тарификации для {{ captcha-full-name }}


## Из чего складывается стоимость использования {{ captcha-full-name }} {#rules}

Тарифицируются [запросы к API {{ captcha-name }}](./quickstart.md#check-answer) по адресу `https://captcha-api.yandex.ru/validate`.


## Цены {#prices}

{% if region == "ru" %}

{% include notitle [rub.md](../_pricing/smartcaptcha/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt.md](../_pricing/smartcaptcha/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd.md](../_pricing/smartcaptcha/usd.md) %}

{% endif %}
