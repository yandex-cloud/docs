# Resolving payment issues


## Issue description {#issue-description}

* The funds fail to appear on your billing account for some time after you have made a payment.
* You are unable to top up your account using the {{ yandex-cloud }} mobile app.

## Solution {#issue-resolution}

In most cases, funds are automatically credited to your account as soon as Yandex receives payment confirmation from your bank. Payments from legal entities are usually credited to accounts by early afternoon of the next business day.

{% list tabs %}

- Wire transfer

    1. Check the account you used when making your payment. The payment should originate from a bank account opened for the organization or individual entrepreneur the billing account was created for. For more details, see [this guide](../../../billing/operations/pay-the-bill.md#organizaciyam-i-ip).

    1. Make sure the following details are correctly specified in your payment order:

    * Payment amount.
    * Bank details of the legal entity Yandex Cloud operates under (OOO Yandeks Oblako).
    * Your company or individual entrepreneur TIN.
    * Billing account number in the payment details (should look like `LSO-***********-**`).
    * Agreement number in the payment details (should look like `******/**`).

- Credit or debit card
    
    Make sure to check the following:

    1. Card balance and transaction history: the possible reason for the transaction failure may appear there. Common issues include insufficient funds or exceeding daily/monthly spending limits set in your bank’s mobile app.
    1. Confirm that your card is enabled for online transactions; this can be verified in your bank's online member area or mobile app.
    1. Card status and expiration date (you can also check this in the member area or mobile app).
    1. Whether the card works for other online transactions.

{% endlist %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}).
To help our support team resolve your issue quickly, select your payment method below to see what information you will need to provide.

{% list tabs %}

- Wire transfer

    Provide the following information in your ticket:

    1. The ID of the billing account where the funds fail to appear. You can find this ID on the [page with the billing account details]({{ link-console-billing }}).
    1. A completed payment order stamped by your bank as processed.

- Credit or debit card

    Provide the following information in your ticket:

    1. The ID of the billing account where the funds fail to appear. You can find this ID on the [page with the billing account details]({{ link-console-billing }}).
    1. Your country of residence.
    1. The country from which you are trying to make a payment with your credit/debit card.
    1. Whether your card allows online transactions.
    1. Whether the card works for other online transactions.
    1. Date and time of payment.
    1. Whether the funds were debited from the credit/debit card as a result of the payment.
    1. Bank card mask.

    {% note info %}

    The card mask consists of the first six and last four digits of your card number, formatted as `1234 56** **** 4321`. The mask is used to identify the bank that issued the card, the payment system, and the country of issue. The card mask might also be displayed on the receipt when you shop in stores.

    Sharing the card mask is safe: it does not contain the full details required to process a payment.

    {% endnote %}

    For security reasons, do not disclose the following information to third parties:


    * Full card number.
    * Card expiration date.
    * Cardholder's first name and last name.
    * CVC/CVV code.
    * One-time text message passwords.
    * Details of other card transactions.


    {% endnote %}

{% endlist %}
