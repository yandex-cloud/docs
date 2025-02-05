---
title: How to change the payment method in {{ billing-name }}
description: Follow this guide to change the payment method in {{ billing-name }}.
---

# Changing the payment method

The payment method can only be changed for the **{{ ui-key.yacloud_billing.billing.account.create-new.account-type_label_company }}** type billing accounts. You can use wire transfer instead of your bank card for payments.

To change the payment method:

1. Draw up a request to have your payment method changed.

   {% include [change-payment-docs](../_includes/change-payment-docs.md) %}

1. Email your request to [{{ billing-docs-email }}](mailto:{{ billing-docs-email }}). The request will be reviewed within three business days. Your {{ yandex-cloud }} account manager will notify you of the decision.

{% note info %}

Once your card is unlinked from your billing account, you will not be able to link a new one. You will only be able to [top up your billing account](../operations/pay-the-bill.md) by [wiring money in from your bank account (via your bank)](../payment/payment-methods-business.md).

{% endnote %}
