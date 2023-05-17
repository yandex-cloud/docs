# Billing threshold

The billing threshold is a negative [personal account balance](../concepts/personal-account.md#balance). The billing threshold is the implementation of a postpaid usage model for {{ yandex-cloud }}. In other words, this is the limit after which {{ yandex-cloud }} can:
* Require that you settle your arrears before the reporting period.
* Suspend your use of resources.

Your billing threshold is valid for 1 month.

The billing threshold is only valid when you select a bank card as your payment method. If you do, when you reach your threshold, an attempt will be made to debit your card to cover what you owe.

{% note alert %}

The billing threshold amount and the total arrears when you are blocked may be different, since access to resources is not suspended immediately. The fact that you have a billing threshold does not guarantee that you will not spend over your threshold.

{% endnote %}


## Billing threshold amount {#amount}

The billing threshold amount is calculated individually and depends on a combination of factors, including:
- [Billing account type](../concepts/billing-account.md#ba-types).
- Amount for resources consumed.
- Your financial standing.

You can find information about the billing threshold amount in the [management console]({{ link-console-billing }}).

## Enabling a billing threshold {#enable}

The billing threshold is enabled automatically after the [paid version is activated](../operations/activate-commercial.md) and the first reporting period ends.

{% note info %}

The billing threshold cannot be disabled and is valid until [the billing account is deleted](../operations/delete-account.md).

{% endnote %}

## Using a billing threshold {#using}

The billing threshold can only be used if you don't have a [grant](../concepts/bonus-account.md) and [your personal account balance](../concepts/personal-account.md#balance) is zero. If you use the billing threshold, you go into arrears as your personal account balance falls below zero.

If you are using a bank account to pay for {{ yandex-cloud }} resources, a billing threshold will not apply.


## Paying arrears {#arrears}

The outstanding charges shall be paid within the deadline stipulated in the [agreement](../concepts/contract.md). The [payment method](../payment/index.md) depends on your legal status. You cannot use [grants](bonus-account.md) to pay off arrears.

{% note info %}

We recommend that you track spending on your personal account and [top up the balance so that it is always positive](../operations/pay-the-bill.md). If your personal account balance exceeds the billing threshold amount and you fail to pay your arrears before the deadline stipulated in the agreement, {{ yandex-cloud }} reserves the right to change the status of your personal account to [SUSPENDED](../concepts/billing-account-statuses.md).

{% endnote %}

For more information, see the following sections:
* For individuals
   * [Paying by bank card](../payment/payment-methods-individual.md)
   * [Billing cycle](../payment/billing-cycle-individual.md)

* Businesses and individual entrepreneurs:
   * [Bank account transfers](../payment/payment-methods-business.md)
   * [Paying by bank card](../payment/payment-methods-card-business.md)
   * [Billing cycle](../payment/billing-cycle-business.md)
