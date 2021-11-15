# Credit limit

The credit limit is a negative [personal account balance](../concepts/personal-account.md#balance). The credit limit is the implementation of a postpaid usage model for {{ yandex-cloud }}. In other words, this is the limit after which {{ yandex-cloud }} can:

* Require that you settle your arrears before the reporting period.
* Suspend your use of resources.

The credit limit is not valid unless you select a bank card as the payment method. If you do, you will receive an email notification when you reach your limit, and an attempt will be made to debit your card to cover what you owe.

{% note alert %}

The credit limit amount and the total arrears when you are blocked may be different, since access to resources is not suspended immediately. The fact that you have a credit limit set does not guarantee that you will not spend over your limit.

{% endnote %}

## Credit limit amount {#amount}

The credit limit amount is calculated individually and depends on a combination of factors, including:

- [Billing account type](../concepts/billing-account.md#ba-types).
- Amount for resources consumed.
- Your financial standing.

You can find information about the credit limit amount in the [management console]({{ link-console-billing }}).

## Activating a credit limit {#enable}

The credit limit is activated automatically after you [switch to the paid version](../operations/activate-commercial.md) and the first reporting period ends.

## Using the credit limit {#using}

The credit limit can only be used if you don't have a [grant](../concepts/bonus-account.md) and your [personal account balance](../concepts/personal-account.md#balance) is zero. If you use the credit limit, you go into arrears as your personal account balance falls below zero.

If you are using a bank account to pay for {{ yandex-cloud }} resources, a credit limit will not apply.

## Paying arrears {#using}

The outstanding charges shall be paid within the deadline stipulated in the [agreement](../concepts/contract.md). [The payment method](../payment/payment-methods.md) depends on your legal status.

{% note info %}

We recommend that you track spending on your personal account and [top up the balance so that it is always positive](../operations/pay-the-bill.md). If your personal account balance exceeds the credit limit amount and you fail to pay your arrears before the deadline stipulated in the agreement, {{ yandex-cloud }} reserves the right to change the status of your personal account to [SUSPENDED](../concepts/billing-account-statuses.md). For more information, see the sections [Billing cycle](../payment/billing-cycle-business.md) and [Payment methods](../payment/payment-methods.md).

{% endnote %}

