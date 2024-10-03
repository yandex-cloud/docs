---
title: Registering an account in {{ yandex-cloud }}
description: To use {{ yandex-cloud }} services, create a billing account first. The account is required even if you plan to use only free services.
keywords:
  - how to register in the cloud
  - how to register in the cloud in {{ yandex-cloud }}
  - "registering in the\_cloud"
  - creating an account in the cloud
---

# Registering an account in {{ yandex-cloud }}

To work with most {{ yandex-cloud }} services, you need a billing account. The account stores information about the payer and payment details. {{ yandex-cloud }} debits your card and invoices you only if you are using the [paid version](../operations/activate-commercial.md). While some services, e.g., {{ tracker-name }} or {{ datalens-short-name }}, do not require a billing account, if you create one, you will get an [initial grant](../concepts/bonus-account.md#start) you can use to pay for your resources.

Within a single user account, all payers must contract with the same legal entity and pay in the same currency.

New customers who are legal entities are eligible for a trial period. The [trial period](../concepts/trial-period.md) allows you to discover the features of the cloud infrastructure for free with some limitations. To fully use the resources, you need to switch to the paid version after your trial period ends.

{% include [individual-nonresident](../../_includes/billing/individual-nonresidents.md) %}

{% list tabs group=customers %}

- Individuals {#individuals}

   {% include [start-for-individuals](../../_includes/billing/billing-account-create-individual.md) %}

- Legal entities, individual entrepreneurs, or non-residents of Russia and Kazakhstan {#businesses-entrepreneurs}

   {% include [start-for-legal-entities](../../_includes/billing/billing-account-create-legal-entities.md) %}

{% endlist %}

{% include [account-resources-note](../_includes/account-resources-note.md) %}

{% include [account-roles](../_includes/account-roles.md) %}

### Learn more

- [Billing account](../concepts/billing-account.md)
- [Trial period](../../getting-started/free-trial/concepts/quickstart.md)

### Get started with {{ yandex-cloud }} {#start}

{% include [quickstart-all-no-billing](../../_includes/quickstart-all-no-billing.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
