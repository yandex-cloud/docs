# Committed volume of services


{% include [cvos-term](../_includes/cvos-term.md) %}

{% note info %}

The agreement only provides for a discount on a certain volume of services, but does not guarantee such availability in data centers.

{% endnote %}

## Discount amount {#amount}

The amount of the guaranteed discount depends on the amount of service resources that you plan to use and the CVoS validity period. The longer the CVoS validity period, the greater the discount. For more information about pricing rules for all services, see the [Pricing](/prices) page. If you have any questions, we'll help you calculate the benefits of committing to a certain volume of resources. Email us at [cloud-sales@yandex-team.ru](mailto:cloud-sales@yandex-team.ru).

## Purchase and validity period {#how-to-enable}

You can view the available offers and purchase a CVoS in {{ billing-name }} under **{{ ui-key.yacloud_billing.billing.account.switch_offers }}**.

When [purchasing a CVoS](../operations/purchase-cvos.md), you yourself should choose the following:
* Validity period: 6 months or 1 year.
* Start date: The next calendar day or desired date.



You can view the information on CVoS usage and its expiration in {{ billing-name }}.

{% note info %}

{{ yandex-cloud }} services not covered by a CVoS are billed based on standard prices. For more information about pricing rules for all services, see the [Pricing](/prices) page.

{% endnote %}

## Usage and payment {#how-to-pay}

After purchasing the CVoS, the discount on the use of services is applied automatically.

During the selected validity period, you must pay for the CVoS even if you don't use any {{ yandex-cloud }} services. The [payment method](../payment/index.md) depends on your legal status ([billing account type](../concepts/billing-account.md#ba-types)).

See details of using and paying for your CVoS below.

![image](../../_assets/billing/cud-scheme.svg)

1. You can purchase a CVoS for 6 months or 1 year. The CVoS is valid from the date you selected when purchasing it.
1. The CVoS validity period is verified throughout the entire billing period.

   2.1. If the validity period expired (the current date > the CVoS expiration date), [standard prices](/prices) apply to {{ yandex-cloud }} service usage.

   2.2. If the validity period hasn't expired (the current date < the CVoS expiration date), the terms of the agreement apply to {{ yandex-cloud }} service usage. Go to step 3.

1. Your personal account is charged hourly for the [amount](#formula) pursuant to the agreement, regardless of whether you use any {{ yandex-cloud }} services. Go to step 4.

1. The volume of services used is verified throughout the entire billing period:

   4.1. If the actual volume is less than or equal to the CVoS, the amount is only charged pursuant to the agreement. To calculate the amount charged, use one of the following [formulas](#formula).

   {{ yandex-cloud }} services not covered by a CVoS are billed based on standard prices. Go to step 5.

   4.2. If the actual volume exceeds the CVoS, the difference between the total volume and the CVoS will be additionally charged based on [standard prices](/prices). Go to step 5.

1. At the beginning of the next billing period, your personal account balance and payments for the services are reviewed. Depending on your [billing account type](../concepts/billing-account.md#ba-types), you may get an invoice. For more information, see [Billing cycle for individuals](../../billing/payment/billing-cycle-individual.md) and [Billing cycle for businesses and individual entrepreneurs](../../billing/payment/billing-cycle-business.md).

## Charged amount {#formula}

The amount charged for the CVoS is determined using the following formulas:

{% list tabs group=charges %}

- Amount charged per hour {#hour}

   ![image](../../_assets/billing/cud-hour-amount.svg)

- Amount charged per day {#day}

   ![image](../../_assets/billing/cud-day-amount.svg)

- Amount charged per month {#month}

   ![image](../../_assets/billing/cud-month-amount.svg)

{% endlist %}

In a leap year, the amount calculated for one additional calendar day in February will be added to the annual amount.

The total amount charged depends on whether any {{ yandex-cloud }} services that are not covered by the CVoS terms were used during the billing period. For more information, see [How to pay for resources](../payment/index.md).

## Changes and extensions {#how-to-update}

According to the agreement, you may not change the terms of the purchased CVoS, extend it, or cancel it.

However, you can purchase a new CVoS if you have any offers available in {{ billing-name }}. For detailed instructions, see [Purchase a CVoS](../operations/purchase-cvos.md).

## Services that you can purchase a CVoS for {#cvos-services}

Prices for services that you can purchase a CVoS for:
* [{{ compute-name }}](../../compute/pricing.md#cvos)
* [{{ mkf-name }}](../../managed-kafka/pricing.md#cvos)
* [{{ mch-name }}](../../managed-clickhouse/pricing.md#cvos)
* [{{ mmy-name }}](../../managed-mysql/pricing.md#cvos)
* [{{ mos-name }}](../../managed-opensearch/pricing.md#cvos)
* [{{ mpg-name }}](../../managed-postgresql/pricing.md#cvos)
* [{{ mrd-name }}](../../managed-redis/pricing.md#cvos)
* [{{ ydb-name }}](../../ydb/pricing/dedicated.md#cvos)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}