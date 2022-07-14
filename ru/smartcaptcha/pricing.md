---
editable: false
---

# Правила тарификации для {{ captcha-full-name }}

Сервис находится на стадии [Preview](../overview/concepts/launch-stages.md), использование сервиса {{ captcha-full-name }} не тарифицируется.

Указанные цены вступят в силу, когда сервис перейдет на стадию [Общедоступная версия (General Availability)](../overview/concepts/launch-stages.md).


## Из чего будет складываться стоимость использования {{ captcha-full-name }} {#rules}

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
