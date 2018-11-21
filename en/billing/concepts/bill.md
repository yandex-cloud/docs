# Payment invoice

A payment invoice is a document issued for you to pay for the resources consumed. A payment invoice is issued within your [billing account](billing-account.md) and contains aggregate data on all the services used within a single cloud.

The relationship between the bill, billing account, and cloud is shown in the diagram below.

![](../_assets/1-1-cloud.png)

## Issuing a payment invoice {#agregate}

[!INCLUDE [bill-note](../_includes/bill-note.md)]

## Payment invoice amount {#payment-amount}

[!INCLUDE [bill-amount](../_includes/bill-amount.md)]

<br/>![](../_assets/formula.png)

  ---  

**[!TAB Example 1]**

<br/>The personal account balance at the beginning of the billing period is 0 rubles.
<br/>The balance has not been topped up during the entire billing period (0 rubles).
<br/>The grant amount is 1,000 rubles.
<br/>The credit limit is 1,000 rubles.
<br/>At the end of the billing period, the credit limit has not been reached and the amount of resources consumed is 1,400 rubles.
<br/>Total amount: 1400 - (0 + 0 + 1000) = 400 (rubles).
<br/>At the beginning of the next billing period, you will be issued a payment invoice for the amount you have actually spent (in this case, 400 rubles).

**[!TAB Example 2]**

<br/>The personal account balance at the beginning of the billing period is 0 rubles.
<br/>The balance has not been topped up during the entire billing period (0 rubles).
<br/>The grant amount is 1,000 rubles.
<br/>The credit limit is not enabled.
<br/>By the end of the billing period, the amount of resources consumed is 800 rubles.
<br/>The grant amount at the end of the billing period is 200 rubles. The personal account balance has not changed.
<br/>At the beginning of the next billing month, no payment invoice will be generated.

**[!TAB Example 3]**

<br/>The personal account balance at the beginning of the billing period is 0 rubles.
<br/>The balance has not been topped up during the entire billing period (0 rubles).
<br/>The grant amount is 1,000 rubles.
<br/>The credit limit is 1,000 rubles.
<br/>In the middle of the billing period, the established credit limit has been reached and the amount of resources consumed is 2,000 rubles.
<br/>Total amount: 2000 - (0 + 0 + 1000) = 1000 (rubles).
<br/>In the middle of the billing period, you will be issued a payment invoice for the amount actually spent (in this case, 1,000 rubles).

  ---    

## Payment {#payment}

Bills must be paid within the deadline stipulated in the [ agreement]( ../concepts/contract.md) . Payment is made by bank transfer. For more information, see [Payment methods for businesses](../payment/payment-methods-business.md).

[!INCLUDE [payment-bill-note](../_includes/payment-bill-note.md)]

## Payment invoice details {#parameters}

| Name | Description |
| ----- | ----- |
| Payment invoice number | Unique payment invoice ID |
| Payment invoice date | The date of payment invoice generation in Yandex's accounting system |
| Customer | Billing account owner |
| Phone number | Phone number of the billing account owner |
| Name of the product, work, or service | Information about the services rendered |
| Total | Total amount for all lines of the bill, excluding VAT, in rubles |
| Total VAT % | The amount of accrued taxes for all lines of the bill, in rubles |
| Total amount payable | The total amount by all lines lines of the bill, including VAT, in rubles |
| Due and payable | The total amount for all lines of the bill, including VAT, in rubles |

## VAT accounting {#nds}

[!INCLUDE [nds](../_includes/nds.md)]

