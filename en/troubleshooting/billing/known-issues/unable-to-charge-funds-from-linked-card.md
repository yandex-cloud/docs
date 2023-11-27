# Resolving issues with deductions from a bank card



## Issue description {#issue-description}

* An email has been received by the owner of the billing account notifying of an error in debiting funds from a bank card.

## Solution {#issue-resolution}

Check the list of bank cards linked to your Yandex ID account under [Payment methods](https://id.yandex.ru/pay) in your account settings.
Here is a list of possible reasons why an error may occur when deducting funds:

* The bank card was previously unlinked from the Yandex ID account. If a card is unlinked from Yandex ID, it becomes unavailable for payment in Yandex Cloud.
* Online payments were disabled on the card linked to the account.
* You exceeded the daily/monthly limit for transactions on the card linked to the account.
* The bank card linked to the account has expired.
* The card linked to the account is blocked by the bank.

{% note info %}

If the problem is not related to deduction of funds from a card already linked to the billing account, but rather with linking a new bank card, read the [article on this issue](couldnt-link-card.md).

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
Provide the following information in the request:


1. The ID of the billing account for which a debiting error notification was received.
   The billing account ID has the format: `d2nXXXXXXXXXXXXXXXXX`. You can find this ID on the [page with the billing account details](https://console.cloud.yandex.ru/billing/accounts).
2. Information about your country of residence.
3. From which country you are trying to pay by a bank card.
4. Whether your card allows online transactions: you can check this in the online banking system or mobile banking app.
5. Bank card mask.


{% note info %}

The bank card mask includes its first six and the last four digits of its number in the format: `1234 56XX XXXX 4321`.
The mask is used to identify the bank that issued the card, the payment system, and the country of issue.
The card mask might also be displayed on the receipt when you shop in stores.
It is safe to provide the card mask because it does not include a full set of data required for payment.

{% endnote %}

For security reasons, do not disclose the following information to third parties:

* Full card number
* Card expiration date
* CVC/CVV code of the card
* One-time SMS passwords
* Details of other card transactions.
