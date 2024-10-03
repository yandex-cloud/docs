---
title: Правила тарификации для {{ tracker-full-name }}
description: 'Стоимость использования {{ tracker-name }} зависит от общего числа пользователей, у которых есть полный доступ к сервису. Небольшим командам платить за {{ tracker-name }} не придется: вы можете бесплатно подключить к {{ tracker-name }} до 5 сотрудников.'
---

# Правила тарификации для {{ tracker-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% note tip %}

Небольшим командам платить за {{ tracker-name }} не придется: вы можете бесплатно подключить к {{ tracker-name }} до 5 сотрудников.

{% endnote %}

По умолчанию все сотрудники организации могут бесплатно работать с {{ tracker-full-name }} в режиме [«Только чтение»](access.md#readonly). Чтобы использовать все возможности {{ tracker-name }}, разрешите сотрудникам [полный доступ](access.md).

Стоимость использования {{ tracker-name }} зависит от общего числа пользователей, у которых есть [полный доступ к сервису](access.md). Ежемесячный платеж [списывается с платежного аккаунта](pay-the-bill.md#charge), привязанного к {{ tracker-name }}.

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

Ответы на распространенные вопросы об оплате услуг вы найдете в разделе [{#T}](payment.md).

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  Для крупных организаций (от 100 пользователей) стоимость {{ tracker-name }} [рассчитывается по ступенчатому тарифу](#sec_calculate). Для первых 100 пользователей полный доступ к Tracker стоит {{ sku|RUB|b2b.tracker.license.v1|pricingRate.6|string }} за пользователя в месяц. Если к Tracker уже подключены 100 сотрудников организации, для следующих 150 пользователей цена будет ниже —  {{ sku|RUB|b2b.tracker.license.v1|pricingRate.100|string }} за пользователя в месяц. Если подключены более 250 сотрудников, цена за каждого нового пользователя — {{ sku|RUB|b2b.tracker.license.v1|pricingRate.250|string }} в месяц.

  {% include notitle [rub.md](../_pricing/tracker/rub.md) %}

- Цены в тенге {#prices-kzt}

  Для крупных организаций стоимость {{ tracker-name }} [рассчитывается по ступенчатому тарифу](#sec_calculate). Для первых 100 пользователей полный доступ к Tracker стоит {{ sku|KZT|b2b.tracker.license.v1|pricingRate.6|string }} за пользователя в месяц. Если к Tracker уже подключены 100 сотрудников организации, для следующих 150 пользователей цена будет ниже — {{ sku|KZT|b2b.tracker.license.v1|pricingRate.100|string }} за пользователя в месяц. Если подключены более 250 сотрудников, цена за каждого нового пользователя — {{ sku|KZT|b2b.tracker.license.v1|pricingRate.250|string }} в месяц.

  {% include notitle [kzt](../_pricing/tracker/kzt.md) %}

{% endlist %}



{% note info %}

Если вы хотите подключить к {{ tracker-name }} больше 500 пользователей, [напишите нам]({{ link-500-users }}), чтобы обсудить индивидуальные условия сотрудничества.

{% endnote %}

Чтобы проверить информацию о вашем платежном аккаунте или посмотреть историю платежей, на верхней панели {{ tracker-name }} нажмите ![](../_assets/tracker/tracker-burger.png) → **Биллинг**.

## Расчет стоимости {#sec_calculate}

Правила расчета ежемесячных платежей за использование {{ tracker-name }}:

* {% include [first-month-tarification.md](../_includes/tracker/first-month-tarification.md) %}

* Плата за месяц рассчитывается исходя из максимального количества пользователей, которые одновременно имели доступ к {{ tracker-name }} в течение месяца.

    {% note tip %}

    Если нужно добавить в {{ tracker-name }} новых пользователей и одновременно отозвать доступ у тех, кто больше не работает с {{ tracker-name }}, мы рекомендуем сначала отозвать доступ, а затем добавить новых пользователей. В этом случае количество пользователей с одновременным доступом к {{ tracker-name }} будет меньше.

    {% endnote %}

* Для крупных организаций ежемесячная плата рассчитывается по ступенчатой системе.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-tracker](../_pricing_examples/tracker/rub.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-tracker](../_pricing_examples/tracker/kzt.md) %}

{% endlist %}


