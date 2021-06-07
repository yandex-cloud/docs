# Pricing

By default, all company employees can use {{ tracker-full-name }} for free in [<q>Read only</q>](enable-tracker.md#readonly) mode. Grant [{{ tracker-name }} full access](enable-tracker.md#access) so that your employees can use all of its features.

## Pricing {#sec_price}

The cost of using {{ tracker-name }} is based on the number of users with full access to the platform. You don't have to pay for {{ tracker-name }} if you have a small team. You can subscribe up to 5 employees to {{ tracker-name }} for free.

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

For more information about how to pay for {{ tracker-name }}, see the [Billing service documentation](../billing/index.yaml).

## Cost calculation {#sec_calculate}

How the monthly {{ tracker-name }} subscription fee is calculated:

- The monthly fee is based on the maximum number of users who simultaneously had access to {{ tracker-name }} during the month.

    {% note tip %}

    If you want to add new users to {{ tracker-name }} while simultaneously revoking access for those who no longer use {{ tracker-name }}, we recommend revoking access for old users first and then adding new users. This will give you the lowest number of users with simultaneous access to {{ tracker-name }}.

    {% endnote %}

<!-- - If you accidentally granted access to {{ tracker-name }} to a user or team that won't use {{ tracker-name }}, you can revoke their access within 30 minutes. In this case, the users in question will not be considered when calculating the monthly subscription fee.
-->

- For large companies, the monthly fee is calculated on a progressive scale.

{% if region == "ru"%}

> For example, these rates were in effect in January:

- The subscription fee for the first 100 users: {{ sku|RUB|b2b.tracker.license.v1|pricingRate.6|string }}.

- The subscription fee for next 150 users: {{ sku|RUB|b2b.tracker.license.v1|pricingRate.100|string }}.

- The subscription fee for all users beyond 250 persons mentioned above: {{ sku|RUB|b2b.tracker.license.v1|pricingRate.250|string }}.

The number of employees who had full access to {{ tracker-name }} changed in January:

- 245 employees had full Tacker access for 14 days.

- The next 7 days saw 270 employees with access to Tracker.

- Finally, during the last 10 days there were 260 employees with access to Tracker.

During the month, the maximum number of users with access to {{ tracker-name }} at the same time was 270.

This means that the following formula will be used to calculate the subscription fee for 270 users:

```
100 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.6|string }} + 150 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.100|string }} + 20 × {{ sku|RUB|b2b.tracker.license.v1|pricingRate.250|string }}
```

{% endif %}

