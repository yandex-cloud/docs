# What to do if money takes a long time to arrive on the balance after payment


## Issue description {#issue-description}

* You transferred money to the balance of your billing account, but the payment data does not show up in the console for a long period of time.

## Solution {#issue-resolution}

Funds are automatically credited to the account as soon as {{ yandex-cloud }} receives a confirmation from the bank's payment system.
Payments from legal entities are usually credited to accounts in the first half of the next business day.


Check that the following details in the payment order are correct:

* Payment amount
* Bank details of 
* Your company or individual entrepreneur TIN.
* Account number in the payment purpose
* Contract number in the payment purpose

The payment should be transferred from a [bank account](../../../billing/operations/pay-the-bill.md#organizaciyam-i-ip) opened for the organization or individual entrepreneur the billing account was created for.

You can find the bank details in the [Legal documents](https://yandex.ru/legal/cloud_oferta/?lang=en) section (paragraph **18. Yandex Details**).

{% note alert %}

Funds transfers via bank details are processed only on business days.

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
When creating the request, provide the following information:

1. ID of the billing account to which the payment cannot be received.
   The billing account ID has the format: `d2nXXXXXXXXXXXXXXXXX`. You can find it on the [page with your billing account details]({{ link-console-billing }}).
2. Filled payment order in PDF format with the bank's execution stamp.
