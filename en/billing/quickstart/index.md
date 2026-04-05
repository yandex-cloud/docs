---
title: Registering an account in the cloud
description: To use {{ yandex-cloud }} services, register and create a billing account. The account is required even if you plan to use only free services.
keywords:
  - how to register in the cloud
  - how to register in {{ yandex-cloud }}
  - "registering in the\_cloud"
  - creating an account in the cloud
---

# Registering an account in {{ yandex-cloud }}

To work with most {{ yandex-cloud }} services, you need a billing account. The account stores information about the payer and payment details. {{ yandex-cloud }} debits your card and invoices you only if you are using the [paid version](../operations/activate-commercial.md).

After creating a billing account, you receive the [_initial grant_](../concepts/bonus-account.md#start) you can use to pay for resources.

New customers registered as a business are eligible for a [_trial period_](../concepts/trial-period.md). The trial period allows you to discover the features of the cloud infrastructure for free with some limitations. To prevent loss of access to your resources after your trial period ends, upgrade to the paid version.

{% include [non-residents-limitations](../../_includes/billing/non-residents-limitations.md) %}

{% list tabs group=customers %}

- Individuals {#individuals}

   {% include [start-for-individuals](../../_includes/billing/billing-account-create-individual.md) %}

- Businesses and individual entrepreneurs {#businesses-entrepreneurs}

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
