---
title: How to top up your personal account
description: Follow this guide to top up your personal account.
---

# Top up your personal account

{% include [personal-account-balance](../_includes/personal-account-balance.md) %}

{{ yandex-cloud }} reserves the right to automatically debit your linked card during the current reporting period if your account balance exceeds the established credit limit.


The method for topping up your personal account depends on your legal status.

{% note info %}

A billing cycle runs automatically for [individuals](../payment/billing-cycle-individual.md) as well as [businesses and individual entrepreneurs](../payment/billing-cycle-business.md) if they have a bank card linked to their billing account.

{% endnote %}

You can top up your account in {{ billing-name }} or in the management console widget.

To top up their accounts, users need the following roles:

* `billing.accounts.owner` for the [billing account](../security/index.md#set-role) to top up personal accounts using a credit or debit card.
* `billing.accounts.editor` or higher for the [billing account](../security/index.md#set-role) to top up personal accounts using a bank account.
* `resource-manager.clouds.member` or higher for the [cloud](../../resource-manager/operations/cloud/set-access-bindings.md) to top up personal accounts from the management console.

## Individuals {#individuals}

To top up your personal account:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select a billing account.
  1. Click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**.
  1. In the window that opens, enter the payment amount and click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**.
  1. {% include [individual_payment_methods](../_includes/individual-payment-methods.md) %}

- Management console {#console}

  1. Open the [management console]({{ link-console-main }}).
  1. In the top-right corner, click ![credit-card](../../_assets/console-icons/credit-card.svg).
  1. In the widget that opens, click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**.

      {% include [hide-private-data](../_includes/billing-widget-hide-private-data.md) %}
  1. In the window that opens, enter the payment amount and click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**.
  1. {% include [individual_payment_methods](../_includes/individual-payment-methods.md) %}

{% endlist %}

{% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

Your payment will be processed in real time and completed within 15 minutes.

## Businesses and individual entrepreneurs {#legal-entities}


To top up your personal account:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select a billing account.
  1. Click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**. This button is only available after [switching to paid consumption](activate-commercial.md).
  1. {% include [business_payment_methods](../_includes/business-payment-methods.md) %}
  
- Management console {#console}

  1. Open the [management console]({{ link-console-main }}).
  1. In the top-right corner, click ![credit-card](../../_assets/console-icons/credit-card.svg).
  1. In the widget that opens, click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**. This button is only available after [switching to paid consumption](activate-commercial.md).

      {% include [hide-private-data](../_includes/billing-widget-hide-private-data.md) %}
  1. {% include [business_payment_methods](../_includes/business-payment-methods.md) %}

{% endlist %}
