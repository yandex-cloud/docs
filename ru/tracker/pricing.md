---
title: Правила тарификации для {{ tracker-full-name }}
description: 'Стоимость использования {{ tracker-name }} зависит от общего числа пользователей, у которых есть полный доступ к сервису. Небольшим командам платить за {{ tracker-name }} не придется: вы можете бесплатно подключить к {{ tracker-name }} до 5 сотрудников.'
---

# Правила тарификации для Yandex Tracker

По умолчанию все сотрудники организации могут бесплатно работать с {{ tracker-full-name }} в режиме [<q>Только чтение</q>](access.md#readonly). Чтобы использовать все возможности {{ tracker-name }}, разрешите сотрудникам [полный доступ](access.md).

Стоимость использования {{ tracker-name }} зависит от общего числа пользователей, у которых есть [полный доступ к сервису](access.md). Ежемесячный платеж [списывается с платежного аккаунта](pay-the-bill.md#charge), привязанного к {{ tracker-name }}.

Ответы на распространенные вопросы об оплате услуг вы найдете в разделе [{#T}](payment.md).

## Тарифы {#sec_price}

{% note tip %}

Небольшим командам платить за {{ tracker-name }} не придется: вы можете бесплатно подключить к {{ tracker-name }} до 5 сотрудников.

{% endnote %}

{% if region == "ru"%}

{% include [rub.md](../_pricing/tracker/rub.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/tracker/kzt.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/tracker/usd.md) %}

{% endif %}

{% note info %}

Если вы хотите подключить к {{ tracker-name }} больше 500 пользователей, [напишите нам]({{ link-500-users }}), чтобы обсудить индивидуальные условия сотрудничества.

{% endnote %}

Чтобы проверить информацию о вашем платежном аккаунте или посмотреть историю платежей, на верхней панели {{ tracker-name }} нажмите ![](../_assets/tracker/tracker-burger.png) → **Биллинг**.

## Расчет стоимости {#sec_calculate}

Правила расчета ежемесячных платежей за использование {{ tracker-name }}:

* Плата за месяц рассчитывается исходя из максимального количества пользователей, которые одновременно имели доступ к {{ tracker-name }} в течение месяца.

    {% note tip %}

    Если нужно добавить в {{ tracker-name }} новых пользователей и одновременно отозвать доступ у тех, кто больше не работает с {{ tracker-name }}, мы рекомендуем сначала отозвать доступ, а затем добавить новых пользователей. В этом случае количество пользователей с одновременным доступом к {{ tracker-name }} будет меньше.

    {% endnote %}

{% if audience == "draft" %} - Если вы случайно дали доступ к {{ tracker-name }} пользователю или команде, которые не будут работать с {{ tracker-name }}, вы можете отозвать доступ в течение 30 минут. Тогда эти пользователи не будут учитываться при расчете платы за месяц.
{% endif %}
* Для крупных организаций ежемесячная плата рассчитывается по ступенчатой системе.

> Например, в январе действовали тарифы:
>
> * для первых 100 пользователей — {% if region == "ru"%}{{ sku|RUB|b2b.tracker.license.v1|pricingRate.6|int|string }}{% endif %}{% if region == "kz"%}{{ sku|KZT|b2b.tracker.license.v1|pricingRate.6|int|string }}{% endif %}{% if region == "int"%}{{ sku|USD|b2b.tracker.license.v1|pricingRate.6|string }}{% endif %} за пользователя в месяц;
>
> * для следующих 150 пользователей — {% if region == "ru"%}{{ sku|RUB|b2b.tracker.license.v1|pricingRate.100|int|string }}{% endif %}{% if region == "kz"%}{{ sku|KZT|b2b.tracker.license.v1|pricingRate.100|int|string }}{% endif %}{% if region == "int"%}{{ sku|USD|b2b.tracker.license.v1|pricingRate.100|string }}{% endif %} за пользователя в месяц;
>
> * для всех пользователей свыше 250 — {% if region == "ru"%}{{ sku|RUB|b2b.tracker.license.v1|pricingRate.250|int|string }}{% endif %}{% if region == "kz"%}{{ sku|KZT|b2b.tracker.license.v1|pricingRate.250|int|string }}{% endif %}{% if region == "int"%}{{ sku|USD|b2b.tracker.license.v1|pricingRate.250|string }}{% endif %} за пользователя в месяц.
>
> Количество сотрудников, имеющих полный доступ к {{ tracker-name }}, в январе изменялось так:
> 
> * 14 дней было 245 сотрудников.
>
> * 7 дней — 270 сотрудников.
>
> * остальные 10 дней — 260 сотрудников.
> 
> Максимальное количество пользователей, которые одновременно имели доступ к {{ tracker-name }} в течение месяца, равно 270.
> 
> Сумма оплаты за 270 пользователей будет рассчитана по формуле:
>
> {% if region == "ru" %}
> 
> ```
> 100 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.6|int|string }} + 150 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.100|int|string }} + 20 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.250|int|string }}
> ```
> 
> {% endif %}
> 
> {% if region == "kz" %}
> 
> ```
> 100 × {{ sku|KZT|b2b.tracker.license.v1|pricingRate.6|int|string }} + 150 × {{ sku|KZT|b2b.tracker.license.v1|pricingRate.100|int|string }} + 20 × {{ sku|KZT|b2b.tracker.license.v1|pricingRate.250|int|string }}
> ```
> 
> {% endif %}
> 
> {% if region == "int" %}
> 
> ```
> 100 × {{ sku|USD|b2b.tracker.license.v1|pricingRate.6|string }} + 150 × {{ sku|USD|b2b.tracker.license.v1|pricingRate.100|string }} + 20 × {{ sku|USD|b2b.tracker.license.v1|pricingRate.250|string }}
> ```
> 
> {% endif %}