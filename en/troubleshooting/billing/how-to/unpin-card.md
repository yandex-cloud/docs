# How to remove a credit/debit card from a billing account



## Case description {#case-description}

You need to remove a credit/debit card from your {{ yandex-cloud }} billing account.

## Solution {#case-resolution}

To remove a credit/debit card from a billing account, you actually need to remove it from [Yandex ID](https://id.yandex.ru/), and this will automatically unlink it from all Yandex services, including {{ yandex-cloud }}.

However, if you have [billable resources](../../../billing/operations/check-charges.md), an attempt to debit funds will change your billing account status to `SUSPENDED`, making {{ yandex-cloud }} resources unavailable to you. To learn more, see [our Public Offer Agreement]({{ billing-oferta-url }}), clause 6.11.4.

## If nothing helped {#if-nothing-worked}

If for some reason this solution does not suit you, you will need to deactivate the unused billing account. To do this, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Billing account ID: You can find it on the [page with the billing account details]({{ link-console-support }}).
1. What you need to do with your billing account.
