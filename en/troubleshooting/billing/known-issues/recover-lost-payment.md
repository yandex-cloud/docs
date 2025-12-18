# Money fails to appear on the account for some time after you make a wire transfer as a business



## Issue description {#issue-description}

After transferring money to your billing account from a bank account for businesses, the payment data does not show up in the console for a while.

## Solution {#issue-resolution}

Funds are automatically credited to your account as soon as {{ yandex-cloud }} receives payment confirmation from your bank. Payments from legal entities are usually credited to accounts by early afternoon of the next business day.



Check that the following details are correctly specified in your payment order:

* Payment amount.
* Bank details of .
* Your company or individual entrepreneur TIN.
* Account number in the payment purpose description.
* Agreement number in the payment purpose description.

Funds should be transferred from a [bank account](../../../billing/operations/pay-the-bill.md#organizaciyam-i-ip) of the organization or individual entrepreneur owning the billing account.

You can find the bank details in [Yandex Legal documents]({{ billing-oferta-url }}) (paragraph **18. Yandex Details**).

{% note alert %}

Funds transfers via bank account details are processed only on business days.

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the billing account that cannot receive the payment.  You can find it on the [page with your billing account details]({{ link-console-billing }}).
1. Completed PDF payment order stamped by your bank as executed.
