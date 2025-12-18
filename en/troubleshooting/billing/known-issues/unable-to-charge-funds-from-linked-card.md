# Resolving issues with debiting funds from a credit/debit card



## Issue description {#issue-description}

A billing account owner received an email notifying of an error in debiting funds from a credit/debit card.

## Solution {#issue-resolution}

Check the list of credit/debit cards added to your Yandex ID account under [**Payment methods**](https://id.yandex.com/pay) in your account settings.


Here is a list of possible reasons why an error may occur when debiting funds:

* The credit/debit card was previously removed from the Yandex ID account. If a card is removed from Yandex ID, you cannot use it for payment within the {{ yandex-cloud }} ecosystem.
* Online payments were disabled on the card added to the account.
* You exceeded the daily or monthly limit for transactions on the card added to your account.
* The credit/debit card added to the account has expired.
* The card added to the account has been blocked by the bank.

{% note info %}

If the problem is not related to debiting funds from a card already added to the billing account, but rather to adding a new credit/debit card, refer to [this article](couldnt-link-card.md).

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the billing account for which the debiting error notification was received. You can find this ID on the [page with the billing account details]({{ link-console-billing }}).
1. Your country of residence.
1. From which country you are trying to use your credit/debit card.
1. Whether your card allows online transactions; you can check this with your bank, either online or through the app.
1. Credit/debit card mask.

{% note info %}

The card mask consists of the first six and last four digits of your card number, formatted as `1234 56** **** 4321`. The mask is used to identify the bank that issued the card, the payment system, and the country of issue. The card mask might also be displayed on the receipt when you shop in stores.

Sharing the card mask is safe: it does not contain the full details required to process a payment.

{% endnote %}

For security reasons, do not disclose the following information to third parties:

* Full card number
* Card expiration date
* CVC/CVV code of the card
* One-time text message passwords
* Details of other card transactions
