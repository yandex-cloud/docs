# Troubleshooting payment issues


## Problem description {#issue-description}

* Funds are not credited to billing account for a long time after the payment;
* You are unable to top up your account through the {{ yandex-cloud }} mobile app or credit card.

## Solution {#issue-resolution}

Usually, funds are automatically credited to the account as soon as {{ yandex-cloud }} receives payment confirmation from the bank.


{% list tabs %}

- Bank transfer

  1. Check the current bank account from which the payment was made.
  Payment must be made from a billing account which is [bound to legal entity](../../../billing/operations/pay-the-bill).


  
  1. Make sure that the following data is correctly specified in the invoice:

  * Payment amount;
  * Bank details of {{ yandex-cloud }};
  * Nebius Israel account number;
  * Payment invoice ID.


- Payment by card

  1. Check the bank card balance and information about debit operations. The possible reason for the failure when debiting funds can be indicated there.
  It is possible that there are not enough funds on the card or the limits for the amount of daily/monthly debiting of funds set in your bank's mobile application have been exceeded.
  1. Check whether online transactions are allowed for the card.
  This can be checked in the online banking system or your bank's mobile application.
  1. Check the status and expiration date of the card in the online banking or mobile application of your bank.
  2. Check if the card can be charged by any other transactions on the Internet.

{% endlist %}

## If the problem remains {#if-issue-still-persists}

If the above steps did not help solve the problem, [create a technical support request]( {{ link-console-support }}).
To display a list of data that you will need to inform the technical support team, select the payment type used in your billing account on the tab below.

{% list tabs %}

- Bank transfer

    When creating a request, specify the following information:

    * ID of the billing account that does not receive funds after making the payment 
    * A completed invoice with the bank's mark on its execution.

- Payment by card

    When creating a request, specify the following information:

    * ID of the billing account that does not receive funds after making the payment.
    This ID can be found [on the billing account data page]({{ link-console-billing }});

    * Information about which country you are a resident of;
    * From which country is the attempt to pay by bank card;
    * Are online payment transactions allowed for your card;
    * Are there any write-offs on the card for any other transactions on the Internet;
    * Date and time of payment;
    * Have the funds been debited from the bank card as a result of the payment;
    * Mask of bank card.

    {% note warning %}

    The bank card mask is the first six and last four digits of its number in the format `1234 56XX XXXX 4321`.
    It is also necessary to identify the bank that issued the card, payment system and the country, where card was issued.
    The card mask is usually prins in the receipts from online and offline stores.

    It is safe to report the card mask, since you do not transmit the full set of data required to make a payment.
    For security reasons, the following data should never be disclosed to third parties:

    * Full card number;
    * Information about the validity period of the card;
    * Last name and first name of the cardholder;
    * CVC/CVV code of the card;
    * One-time passwords from SMS;
    * Information about other charges or other operations on bank card.

    {% endnote %}

{% endlist %}
