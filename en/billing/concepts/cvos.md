# Committed volume of services

{% include [cvos-term](../_includes/cvos-term.md) %}

{% note info %}

The agreement only provides for a discount on a certain volume of services within a region, but doesn't guarantee such availability in data centers.

{% endnote %}

## Discount amount {#amount}

The amount of the guaranteed discount depends on the amount of service resources that you plan to use and the CVoS validity period. The longer the CVoS validity period, the greater the discount. To learn about the benefits of purchasing a CVoS, email us at [cloud-sales@yandex-team.ru](mailto:cloud-sales@yandex-team.ru). To find out the current prices and pricing rules, go to the [Pricing](https://cloud.yandex.com/prices) page.


## Purchase and validity period {#how-to-enable}

To enable a CVoS, contact your account manager or [support]({{ link-console-support }}).

When purchasing a CVoS, you need to select:
* Validity period: 1 or 3 years.
* Start date: The next calendar day or desired date.




Information about CVoS usage and its expiration is displayed in the management console.

{% note info %}

Standard prices apply to {{ yandex-cloud }} services that aren't covered by the CVoS terms. For more information about pricing rules for all services, see the [Pricing](https://cloud.yandex.com/prices) page.

{% endnote %}

## Usage and payment {#how-to-pay}

After purchasing the CVoS, the discount on the use of services is applied automatically.

During the selected validity period, you must pay for the CVoS even if you don't use any {{ yandex-cloud }} services. The [payment method](../payment/index.md) depends on your legal status ([billing account type](../concepts/billing-account.md#ba-types)).

See details of using and paying for your CVoS below.

![image](../../_assets/billing/cud-scheme.svg)

1. You can purchase a CVoS for 1 or 3 years. The CVoS is valid from the date you selected when purchasing it.
1. The CVoS validity period is verified throughout the entire billing period.

   2.1. If the validity period expired (the current date > the CVoS expiration date), [standard prices](https://cloud.yandex.com/prices) apply to {{ yandex-cloud }} service usage.

   2.2. If the validity period hasn't expired (the current date < the CVoS expiration date), the terms of the agreement apply to {{ yandex-cloud }} service usage. Go to step 3.

1. Your personal account is charged hourly for the [amount](#formula) pursuant to the agreement, regardless of whether you use any {{ yandex-cloud }} services. Go to step 4.

1. The volume of services used is verified throughout the entire billing period:

   4.1. If the actual volume is less than or equal to the CVoS, the amount is only charged pursuant to the agreement. To calculate the amount charged, use one of the following [formulas](#formula).

   Funds for the use of {{ yandex-cloud }} services that aren't covered by the CVoS terms are charged at the standard prices. Go to step 5.

   4.2. If the actual volume exceeds the CVoS, the difference between the total volume and the CVoS is additionally charged at the [standard prices](https://cloud.yandex.com/prices). Go to step 5.

1. At the beginning of the next billing period, your personal account balance and payment for the services used are verified: depending on the [billing account type](../concepts/billing-account.md#ba-types), you may be issued an invoice or the linked bank card may be debited. For more information, see [Billing cycle for individuals](../../billing/payment/billing-cycle-individual.md) and [Billing cycle for businesses and individual entrepreneurs](../../billing/payment/billing-cycle-business.md).

## Charged amount {#formula}

The amount charged for the CVoS is determined using the following formulas:

{% list tabs %}

- Amount charged per hour

   ![image](../../_assets/billing/cud-hour-amount.svg)

- Amount charged per day

   ![image](../../_assets/billing/cud-day-amount.svg)

- Amount charged per month

   ![image](../../_assets/billing/cud-month-amount.svg)

{% endlist %}

The total amount charged depends on whether any {{ yandex-cloud }} services that are not covered by the CVoS terms were used during the billing period. For more information, see [How to pay for resources](../payment/index.md).


## Services that you can purchase a CVoS for {#cvos-services}

Services that you can purchase a CVoS for:
* {{ mch-name }}
* {{ mmg-name }}
* {{ mes-name }}
* {{ mgp-name }}
* {{ mmy-name }}
* {{ mpg-name }}
* {{ mrd-name }}
* {{ mkf-name }}
* {{ ydb-name }}

