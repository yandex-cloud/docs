# Resolving issues with adding a credit/debit card to the billing account



## Issue description {#issue-description}

* You cannot add a card via the {{ yandex-cloud }} mobile app.
* You cannot add a card via the [management console]({{ link-console-settings }}) web UI.
* When trying to add a credit/debit card, you see the `Couldn't link card` error message.

## Solution {#issue-resolution}

{% list tabs %}

- Management console

    When adding a card, {{ yandex-cloud }} debits a small amount of money (about ₽10) from the card and immediately returns it.

    Here is a list of possible reasons why there might be issues while adding credit/debit cards to the billing account:

    * You disabled online payments for the card you are trying to add.
    * You exceeded the daily or monthly limit for transactions on the card you are trying to add to your account.
    * The credit/debit card you are trying to add to the account has expired.
    * The funds on the card you are trying to add are insufficient for the operation.
    * The card is blocked by your bank.

    You might also want to check the list of installed extensions that can change the content of web pages in your browser (such as ad blockers). Such plugins can affect the display of 3-D Secure pages where you provide a one-time SMS password when making a payment.

- Mobile app

    Currently, you cannot add a new credit/debit card to the billing account from the {{ yandex-cloud }} mobile app. We are already aware of this problem and will fix it soon.

    Link your card in the [{{ yandex-cloud }} management console]({{ link-console-main }}) web UI instead, and then make a payment through your mobile app.

{% endlist %}

{% note info %}

If your question relates to debiting funds from a card already added to the billing account, see how you can fix it in [this article](unable-to-charge-funds-from-linked-card.md).

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the billing account to which you cannot add a credit/debit card. You can find this ID on the [page with the billing account details]({{ link-console-billing }}).
1. Your country of residence.
1. The country from which you are trying to make a payment with your credit/debit card.
1. Whether online payments are allowed for your card: you can check this in your online banking system or your bank's mobile app.
1. Whether the card works for other online transactions.
1. Date and time of payment.
1. Whether the funds were debited from the credit/debit card as a result of the payment.
1. Credit/debit card mask.

{% note info %}

The card mask consists of the first six and last four digits of your card number, formatted as `1234 56** **** 4321`. The mask is used to identify the bank that issued the card, the payment system, and the country of issue. The card mask might also be displayed on the receipt when you shop in stores.

Sharing the card mask is safe: it does not contain the full details required to process a payment.

{% endnote %}

Please note that, for security reasons, you should not disclose the following information to any third parties:

* Full card number
* Card expiration date
* Cardholder's first name and last name
* CVC/CVV code
* One-time text message passwords
* Details of other card transactions
