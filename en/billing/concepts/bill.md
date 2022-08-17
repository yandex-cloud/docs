# Payment invoice

A payment invoice is a document issued for you to pay for the resources consumed. A payment invoice is issued within your [billing account](billing-account.md) and contains aggregate data on all the services used within a single cloud.

The relationship between the payment invoice, billing account, and cloud is shown in the diagram below.

![image](../../_assets/billing/1-1-cloud.png)

## Issuing an invoice {#agregate}

A payment invoice is generated automatically and issued at the beginning of the following reporting period under the conditions below:

* The selected payment method is [Transfer from your bank account](../payment/payment-methods-business.md).
* [The total invoice amount](#payment-amount) is greater than zero.

An invoice is only sent to the [billing account](billing-account.md) owner's email address. You cannot change the email address but you can configure message forwarding. For more information, see [Yandex Mail Help]{% if lang == "ru" %}(https://yandex.ru/support/mail/web/preferences/filters/forwarding.html){% endif %}{% if lang == "en" %}(https://yandex.com/support/mail/web/preferences/filters/forwarding.html){% endif %}.

{% note info %}

{{ yandex-cloud }} reserves the right to issue a payment invoice during the current reporting period if you exceed your established billing threshold.

{% endnote %}

## Invoice amount {#payment-amount}

{% include [bill-amount](../_includes/bill-amount.md) %}

![image](../../_assets/billing/formula.png)

{% list tabs %}

{% if region == "ru" %}

- Example 1

  The personal account balance at the beginning of the reporting period is 0 rubles.
  The balance has not been topped up during the entire reporting period (0 rubles).
  The grant amount is 1000 rubles.
  The billing threshold is 1000 rubles.
  At the end of the reporting period, the billing threshold has not been reached and the amount for resources consumed is 1400 rubles.
  Total amount: 1400 - (0 + 0 + 1000) = 400 (rubles).
  At the beginning of the next reporting period, you will be issued a payment invoice for the amount you have actually used (in this case, 400 rubles).

- Example 2

  The personal account balance at the beginning of the reporting period is 0 rubles.
  The balance has not been topped up during the entire reporting period (0 rubles).
  The grant amount is 1000 rubles.
  The billing threshold is not enabled.
  By the end of the reporting period, the amount for resources consumed is 800 rubles.
  The grant amount at the end of the reporting period is 200 rubles. The personal account balance has not changed.
  At the beginning of the next reporting month, no payment invoice will be generated.

- Example 3

  The personal account balance at the beginning of the reporting period is 0 rubles.
  The balance has not been topped up during the entire reporting period (0 rubles).
  The grant amount is 1000 rubles.
  The billing threshold is 1000 rubles.
  In the middle of the reporting period, the established billing threshold has been reached and the amount for resources consumed is 2000 rubles.
  Total amount: 2000 - (0 + 0 + 1000) = 1000 (rubles).
  In the middle of the reporting period, you will be issued a payment invoice for the amount actually used (in this case, 1000 rubles).

{% endif %}

{% if region == "kz" %}

- Example 1

  The balance of the personal account at the beginning of the reporting period is 0 tenge.
  The balance was not topped up during the entire reporting period (0 tenge).
  The grant amount is 1000 tenge.
  Your billing threshold is 1000 tenge.
  As of the end of the reporting period, you have not used up your billing threshold, and the amount for resources consumed is 1400 tenge.
  Total amount: 1400 - (0 + 0 + 1000) = 400 tenge.
  At the beginning of the next reporting period, you will receive an invoice for the amount you have actually spent, which is 400 tenge.

- Example 2

  The balance of the personal account at the beginning of the reporting period is 0 tenge.
  The balance was not topped up during the entire reporting period (0 tenge).
  The grant amount is 1000 tenge.
  The billing threshold is not enabled.
  As of the end of the reporting period, the amount for resources consumed was 800 tenge.
  The grant amount as of the end of the reporting period is 200 tenge. The personal account balance has not changed.
  At the beginning of the next reporting month, no payment invoice will be generated.

- Example 3

  The balance of the personal account at the beginning of the reporting period is 0 tenge.
  The balance was not topped up during the entire reporting period (0 tenge).
  The grant amount is 1000 tenge.
  Your billing threshold is 1000 tenge.
  In the middle of the reporting period, you used up your billing threshold, and the amount for resources consumed was 2000 tenge.
  Total amount: 2000 - (0 + 0 + 1000) = 1000 tenge.
  In the middle of the reporting period, you will receive a payment invoice for the amount actually spent, which is 1000 tenge.

{% endif %}

{% endlist %}

## Making payment {#payment}

Invoices must be paid before the deadline stipulated in the [agreement](../concepts/contract.md). Payment is made by bank transfer. For more information, see [Payment methods for businesses](../payment/payment-methods-business.md).

{% include [payment-bill-note](../_includes/payment-bill-note.md) %}

## Invoice details {#parameters}

{% include [bill-requisites](../_includes/bill-requisites.md) %}

## Taxes and fees {#nds}

{% include [nds](../_includes/nds.md) %}