---
editable: false
---

# Pricing for {{ captcha-full-name }}

The service is at the [Preview](../overview/concepts/launch-stages.md) stage, {{ captcha-full-name }} can be used free of charge.

The service will be charged when it enters the [General Availability](../overview/concepts/launch-stages.md) stage.


## What will go into the cost of using {{ captcha-full-name }} {#rules}

You are charged for [{{ captcha-name }} API requests](./quickstart.md#check-answer) at `https://captcha-api.yandex.ru/validate`.


## Pricing {#prices}

{% if region == "ru" %}

{% include notitle [rub.md](../_pricing/smartcaptcha/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt.md](../_pricing/smartcaptcha/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd.md](../_pricing/smartcaptcha/usd.md) %}

{% endif %}
