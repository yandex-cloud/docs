# Payment receipt for individuals

In accordance with Russian Federal Law No. [FZ-54 "On the use of cash registers"](http://base.garant.ru/12130951/), after you pay for resources with a bank card, you will receive a payment receipt by email.

A payment receipt is a primary accounting document confirming the transfer of funds using a bank card.

We recommend that you keep all your payment receipts, as this will help you if any problems with payments occur.

## Payment receipt amount {#bill-amount}

The payment receipt amount is equal to the amount debited from the bank card linked to your account.

The total debited amount depends on whether you have used your [grant](../concepts/bonus-account.md) and topped up your [personal account](../concepts/personal-account.md#balance) during the reporting period.

The amount charged is calculated using the formula:
<br/> ![image](../_assets/formula.png)

  {% list tabs %}

- Example 1

  <br/>The personal account balance at the beginning of the reporting period is 0 rubles.
  <br/>The balance has not been topped up during the entire reporting period (0 rubles).
  <br/>The grant amount is 1,000 rubles.
  <br/>The credit limit is 2,000 rubles.
  <br/>In the middle of the reporting period, the established credit limit has been reached and the amount for resources consumed is 3,000 rubles.
  <br/>Total amount: 3000 - (0 + 0 + 1000) = 2000 (rubles).
  <br/>In the middle of the reporting period, 2,000 rubles will be debited from the linked bank card. A payment receipt will also be generated for 2,000 rubles.

- Example 2

  <br/>The personal account balance at the beginning of the reporting period is 0 rubles.
  <br/>The balance has not been topped up during the entire reporting period (0 rubles).
  <br/>The grant amount is 1,000 rubles.
  <br/>At the end of the reporting period, the amount for consumed resources is 800 rubles.
  <br/>The grant amount at the end of the reporting period is 200 rubles. The personal account balance has not changed.
  <br/>At the beginning of the next reporting month, no funds will be debited from the linked bank card. No payment receipt will be generated.

- Example 3

  <br/>The personal account balance at the beginning of the reporting period is 0 rubles.
  <br/>The balance has not been topped up during the entire reporting period (0 rubles).
  <br/>The grant amount is 1,000 rubles.
  <br/>The credit limit is 2,000 rubles.
  <br/>At the end of the reporting period, the amount for consumed resources is 2,300 rubles. The credit limit has not been reached and the grant has been fully spent.
  <br/>Total amount: 2300 - (0 + 0 + 1000) = 1300 (rubles).
  <br/>At the beginning of the next reporting period, 1,300 rubles will be debited from the linked bank card. A payment receipt will also be generated for 1,300 rubles.

  {% endlist %}

## Payment receipt details {#parameters}

| Name | Description |
| ----- | ----- |
| Recipient name | Name of the payment recipient company. |
| TIN | TIN of the payment recipient company. |
| Receipt date | Receipt closing date and time. |
| No. | Unique receipt number. |
| Shift No. | Shift number. |
| Service name | Information about the services provided. |
| VAT | Tax rate. |
| VAT amount | The amount of taxes paid for all lines of the receipt. |
| Total | The amount, in rubles, the receipt was generated for, with VAT. |
| Payment method | Settlement type and payment method. |
| CR No. | Registration number of the cash register. |
| FMD No. | Number of the fiscal memory device. |
| FD No. | Number of the fiscal document. |
| FA | Fiscal attribute of the document. |
| Recipient's email address | E-mail address of the payment recipient. |
| Payer's email address | Email address of the payer. |
| FTS website | Website of the Federal Tax Service of Russia where you can check out the fiscal attributes. |

