# Resolving an issue with linking a bank card to a billing account


## Issue description {#issue-description}

* You cannot link a card via the Yandex Cloud mobile app
* You cannot link a card via the Management console web interface
* When trying to link a bank card, you see the `Couldn't link card` message.

## Solution {#issue-resolution}

{% list tabs %}

- Management console

   During the card linking process, Yandex Cloud debits a small amount of money (about ₽10) from the card and immediately returns it.
   Here is a list of possible reasons why there might be issues linking bank cards to the billing account:

   * You disabled online payments for the card you are trying to link.
   * You exceeded the daily/monthly limit for transactions on the card being linked to the account.
   * The bank card being linked to the account has expired.
   * The funds on the card you are trying to link are insufficient for the operation.
   * The card being linked to the account is blocked by the bank.

   Please also check the list of installed extensions that can change the content of web pages in your browser (for example, ad blockers).
   Such plugins can affect the display of 3-D Secure pages where you provide of a one-time SMS password when making a payment.

- Mobile app

   It is currently not possible to link a new bank card to the billing account from the Yandex Cloud mobile app. Our developers are already aware of this problem and will fix it soon.
   Add a card in the Yandex Cloud management console web interface and then try to make a payment via the mobile app.

{% endlist %}

{% note info %}

If your question relates to debiting funds from a card already linked to the billing account, see the solution [in our other article](unable-to-charge-funds-from-linked-card.md).

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
When creating a request, make sure to include the following information:

1. ID of the billing account to which you cannot link a bank card.
   The billing account ID has the format: `d2nXXXXXXXXXXXXXXXXX`. You can find this ID on the [page with the billing account details](https://console.cloud.yandex.ru/billing/accounts).
2. Information about your country of residence.
3. From which country you are trying to pay by a bank card.
4. Whether online payments are allowed for your card: you can check this in your online banking system or your bank's mobile app.
5. If this card can be used for other online transactions.
6. Date and time of payment
7. If funds were debited from the bank card as a result of the payment.
8. Bank card mask.

{% note info %}

The bank card mask includes its first six and the last four digits of its number in the format: `1234 56XX XXXX 4321`.
The mask is used to identify the bank that issued the card, the payment system, and the country of issue.
The card mask might also be displayed on the receipt when you shop in stores.
It is safe to provide the card mask because it does not include a full set of data required for payment.

{% endnote %}

Keep in mind that, for security reasons, you should not provide the following information to any third parties:

* Full card number
* Card expiration date
* Cardholder's surname and first name
* CVC/CVV code of the card
* One-time SMS passwords
* Details of other card transactions.
