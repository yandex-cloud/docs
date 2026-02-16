---
title: How to create a new billing account in {{ billing-name }}
description: Follow this guide to create a new billing account.
---

# Creating a new billing account

Cloud members can create one or more [billing accounts](../concepts/billing-account.md).

{% list tabs group=customers %}

- Individuals {#individuals}

   {% include [start-for-individuals](../../_includes/billing/billing-account-create-individual.md) %}

- Businesses and individual entrepreneurs {#businesses-entrepreneurs}

   {% include [start-for-legal-entities](../../_includes/billing/billing-account-create-legal-entities.md) %}

   {% note info %}
   
   Businesses also have access to a [subaccount](../../partner/terms.md#sub-account) registered through the [Partner portal](../../partner/operations/pin-cloud.md) as their customer's account. Payment invoices for use of services by subaccounts are always issued to partners.
   
   {% endnote %}

{% endlist %}

{% include [account-resources-note](../_includes/account-resources-note.md) %}

## What's next? {#what-is-next}

After creating a billing account you can start using {{ yandex-cloud }} services. You can link one or more clouds to your billing account. Both new and existing clouds can be linked. You cannot unlink a cloud from a billing account. Instead, you can relink it to a different billing account.
For more operations with your billing account, see the following guides:

* [{#T}](change-data.md)
* [{#T}](get-data.md)
* [{#T}](pin-cloud.md)
* [{#T}](change-organization.md)
* [{#T}](../../partner/operations/pin-cloud.md)
* [{#T}](delete-account.md)
