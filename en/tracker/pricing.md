---
title: Pricing for Yandex Tracker
description: "The cost of using Tracker is based on the number of users with full access to the platform. You don't have to pay for Tracker if you have a small team. You can subscribe up to 5 employees to Tracker for free."
---
# Pricing policy for {{ tracker-full-name }}

By default, all company employees can use {{ tracker-full-name }} for free in [<q>Read only</q>](access.md#readonly) mode. Grant [full access](access.md) to {{ tracker-name }} so that your employees can use all of its features.

You can find the FAQ for payments in [{#T}](payment.md).

## Pricing {#sec_price}

The {{ tracker-name }} service cost is based on the number of users with [full access to the platform](access.md). Your monthly payment is debited from the [billing account](billing-account.md) linked to {{ tracker-name }}.

{% note tip %}

You don't have to pay anything for {{ tracker-name }} if you only have a small team since {{ tracker-name }} is free of charge for up to 5 employees.

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

If you want to provide access to {{ tracker-name }} for more than 500 users, [contact us]({{ link-500-users }}) to discuss individual business terms.

{% endnote %}

To check your billing account balance or view your payment history, on the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

## Cost calculation {#sec_calculate}

How the monthly {{ tracker-name }} subscription fee is calculated:

* The monthly fee is based on the maximum number of users who simultaneously had access to {{ tracker-name }} during the month.

    {% note tip %}

    If you want to add new users to {{ tracker-name }} while simultaneously revoking access to {{ tracker-name }} for other users, we recommend revoking access for old users first and then adding new users. This will give you the lowest number of users with simultaneous access to {{ tracker-name }}.

    {% endnote %}

{% if audience == "draft" %} - If you accidentally granted access to {{ tracker-name }} to a user or team that won't use {{ tracker-name }}, you can revoke their access rights within 30 minutes. In that case, they won't be included when calculating the monthly subscription fee.
{% endif %}

* For large companies, the monthly fee is calculated on a progressive scale.

> For example, these rates were in effect in January:
>
>* For the first 100 users — {% if region == "ru"%}{{ sku|RUB|b2b.tracker.license.v1|pricingRate.6|int|string }}{% endif %}{% if region == "kz"%}{{ sku|KZT|b2b.tracker.license.v1|pricingRate.6|int|string }}{% endif %}{% if region == "int"%}{{ sku|USD|b2b.tracker.license.v1|pricingRate.6|string }}{% endif %} per user per month.
>
>* For the next 150 users — {% if region == "ru"%}{{ sku|RUB|b2b.tracker.license.v1|pricingRate.100|int|string }}{% endif %}{% if region == "kz"%}{{ sku|KZT|b2b.tracker.license.v1|pricingRate.100|int|string }}{% endif %}{% if region == "int"%}{{ sku|USD|b2b.tracker.license.v1|pricingRate.100|string }}{% endif %} per user per month.
>
>* For all users over 250 — {% if region == "ru"%}{{ sku|RUB|b2b.tracker.license.v1|pricingRate.250|int|string }}{% endif %}{% if region == "kz"%}{{ sku|KZT|b2b.tracker.license.v1|pricingRate.250|int|string }}{% endif %}{% if region == "int"%}{{ sku|USD|b2b.tracker.license.v1|pricingRate.250|string }}{% endif %} per user per month.
>
>The number of employees who had full access to {{ tracker-name }} changed in January:
>
>* 245 employees had full Tacker access for 14 days.
>
>* The next 7 days saw 270 employees with access to {{tracker-name}}.
>
>* Finally, during the last 10 days there were 260 employees with access to {{tracker-name}}.
>
>During the month, the maximum number of users with access to {{ tracker-name }} at the same time was 270.
>
>That means the following formula will be used to calculate the subscription fee for 270 users:
>
>{% if region == "ru" %}
>
>```
>100 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.6|int|string }} + 150 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.100|int|string }} + 20 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.250|int|string }}
>```
>
>{% endif %}
>
>{% if region == "kz" %}
>
>```
>100 × {{ sku|KZT|b2b.tracker.license.v1|pricingRate.6|int|string }} + 150 × {{ sku|KZT|b2b.tracker.license.v1|pricingRate.100|int|string }} + 20 × {{ sku|KZT|b2b.tracker.license.v1|pricingRate.250|int|string }}
>```
>
>{% endif %}
>
>{% if region == "int" %}
>
>```
>100 × {{ sku|USD|b2b.tracker.license.v1|pricingRate.6|string }} + 150 × {{ sku|USD|b2b.tracker.license.v1|pricingRate.100|string }} + 20 × {{ sku|USD|b2b.tracker.license.v1|pricingRate.250|string }}
>```
>
>{% endif %}

