# Billing accounts

Billing accounts are used to identify users paying for resources in {{ yandex-cloud }}.

A billing account can be linked to multiple clouds and one [personal account](personal-account.md). You can only use the payment method that corresponds to the type of billing account and your [agreement](contract.md).


The relationship between clouds, billing accounts, personal accounts, and payment methods is shown in the diagram below.

![image](../../_assets/billing/cloud-billing-account-svg.svg)

{% include [account_scope.md](../_includes/account-scope.md) %}


{% note info %}

Billing accounts are not used for managing {{ yandex-cloud }} resources.

{% endnote %}

To access the list of billing accounts, navigate to [**{{ billing-name }}**]({{ link-console-billing }}).


## Billing account types {#ba-types}

{% list tabs group=accounts %}

 - Individual account {#individual}
  
   * For residents of Russia and Kazakhstan.
   * The account is created as a paid one.
   * You pay for resources using your [bank card](../payment/payment-methods-individual.md).
   * Your card is debited automatically for the resources you consume. For more information, see [Billing cycle for individuals](../payment/billing-cycle-individual.md).
  
 - Business account {#business}
  
   * For residents of Russia and Kazakhstan and non-residents of Russia and Kazakhstan.
   * Businesses pay for resources they consume by bank transfer from the [corporate bank account](../payment/payment-methods-business.md) or using a [bank card](../payment/payment-methods-card-business.md).
   * Payments for resources are either made based on the [agreement](../concepts/contract.md) against [invoices](bill.md) or debited automatically from the linked bank card. For more information, see [Billing cycle for businesses](../payment/billing-cycle-business.md).
   * Business accounts have access to an additional account registered through the [Partner portal](../../partner/) as their customer's account. Only a legal entity can be a [subaccount](../../partner/terms.md#sub-account). Payment invoices for use of services by subaccounts are always issued to partners.
   * New customers are eligible for a [trial period](trial-period.md).
  
{% endlist %}


## Validity period {#dates}

Billing accounts have no validity period.

However, if {{ yandex-cloud }} services are suspended due to arrears and you fail to pay the outstanding amount within 60 days of suspension, all your data, including the billing account, will be permanently blocked and deleted.

You can [delete a billing account](../operations/delete-account.md) if you no longer plan to use {{ yandex-cloud }} services.

## Billing account ID {#billing-account-id}

Every billing account has an ID. To get a billing account's ID:

{% include [billing-account-id](../../_includes/billing/billing-account-id.md) %}

## Number of billing accounts {#restrictions}

{% include [billing-account-amounts](../_includes/billing-account-amounts.md) %}

{% include [pin-cloud-note](../_includes/pin-cloud-note.md) %}


{% include [billing-account-payers](../_includes/billing-account-payers.md) %}

{% include [billing-account-payers-example](../_includes/billing-account-payers-example.md) %}
