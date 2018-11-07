# Payment methods for businesses

Legal entities can pay for the resources consumed based on the [contract](../concepts/contract.md) and [payment invoice](../concepts/bill.md).

## Issuing a payment invoice {#payment-amount}

[!INCLUDE [bill-note](../_includes/bill-note.md)]

## Payment invoice amount {#payment-sum}

[!INCLUDE [bill-amount](../_includes/bill-amount.md)]

![](../_assets/formula.png)

  ---  

**[!TAB Example 1]**

<br/>The personal account balance at the beginning of the billing period is 0 rubles.
<br/>It has not been topped up during the entire billing period (0 rubles).
<br/>The grant amount is 1,000 rubles.
<br/>The credit limit is 1,000 rubles.
<br/>At the end of the billing period, the credit limit has not been reached and the amount of resources consumed is 1,400 rubles.
<br/>Total amount: 1400 - (0 + 0 + 1000) = 400 (rubles).
<br/>At the beginning of the next billing period, you will be issued a payment invoice for the amount you have actually spent (in this case, 400 rubles).

**[!TAB Example 2]**

<br/>The personal account balance at the beginning of the billing period is 0 rubles.
<br/>It has not been topped up during the entire billing period (0 rubles).
<br/>The grant amount is 1,000 rubles.
<br/>The credit limit is not enabled.
<br/>By the end of the billing period, the amount of resources consumed is 800 rubles.
<br/>The grant amount at the end of the billing period is 200 rubles. The personal account balance has not changed.
<br/>At the beginning of the next billing month, no payment invoice will be generated.

**[!TAB Example 3]**

<br/>The personal account balance at the beginning of the billing period is 0 rubles.
<br/>It has not been topped up during the entire billing period (0 rubles).
<br/>The grant amount is 1,000 rubles.
<br/>The credit limit is 1,000 rubles.
<br/>In the middle of the billing period, the established credit limit has been reached and the amount of resources consumed is 2,000 rubles.
<br/>Total amount: 2000 - (0 + 0 + 1000) = 1000 (rubles).
<br/>In the middle of the billing period, you may be issued a payment invoice for the amount actually spent (in this case, 1,000 rubles).

  ---    

## Payment {#payment}

You can pay the received payment invoice by bank transfer at any bank or by using an online banking system.

Before you pay, make sure the following details in the payment order are entered correctly:

- Payment amount
- Bank details of Yandex.Cloud LLC
- Your company's TIN or sole proprietor's TIN
- [Personal account number](../concepts/personal-account.md#id) in the Details of Payment field
- [Contract number](../concepts/contract.md) in the Details of Payment field.

How fast the funds will be credited to your personal account depends on the bank performing the transaction.

> [!NOTE]
> 
> The payment invoice must be paid from a bank account opened for the business (organization or sole proprietor) that the billing account was registered for.

## Payment terms  {#limits}

Bills must be paid within the deadline stipulated in the [ agreement]( ../concepts/contract.md) . How fast the funds will be credited to your personal account depends on the bank performing the transaction.

> [!NOTE]
>
> We recommend that you independently monitor the spending of funds on your personal account and [top up the balance so that it is always positive](../operations/pay-the-bill.md). If the personal account balance drops to zero or exceeds the maximum amount of the credit limit, Yandex.Cloud reserves the right to change the status of your billing account to [Suspended](../concepts/billing-account.md#conditions). For more information, see [Billing cycle](../payment/billing-cycle-business.md).

