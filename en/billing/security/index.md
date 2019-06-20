# Access management

### Access to Billing {#billing}

{% include [yandex-account](../_includes/yandex-account.md) %}

### Access to billing account {#billing-account}

Access to [billing accounts](../concepts/billing-account.md) of the Billing system is provided by the service[Yandex.Cloud IAM](../../iam/).

Once you create a billing account, you are automatically assigned the _Owner_ role. The _Owner_ role lets you perform any action from your billing account:

* Activate the [trial period](../trial/activation.md).
* Activate the [paid version](../operations/activate-commercial.md).
* [Monitor spending](../operations/check-diagram.md) and [view service usage details](../operations/check-charges.md).
* [Enable the credit limit](../concepts/credit-limit.md).
* [Change your billing account data](../operations/change-data.md).
* [Change a bank card](../operations/pin-card.md).

{% note info %}

You cannot change the owner or grant another user access to your billing account.

{% endnote %}
