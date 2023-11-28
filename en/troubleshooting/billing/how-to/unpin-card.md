# How to unlink a bank card from the billing account



## Scenario description {#case-description}

You need to unlink the bank card from your {{ yandex-cloud }} billing account.

## Solution {#case-resolution}

To unlink a card from the billing account, unlink it from [Yandex ID](https://id.yandex.ru/). Then it will automatically be unlinked from all Yandex services, including Yandex Cloud.

However, if you have [billable resources](../../../billing/operations/check-charges.md), an attempt to debit funds will change the billing account status to `SUSPENDED`, and you will no longer have access to the cloud resources. To learn more about this, see the [public offer](https://yandex.ru/legal/cloud_oferta/), clause 6.11.4.

## If nothing helped {#if-issue-still-persists}

If for some reason this method does not suit you, you will need to disable the unused billing account.
To do this, [create a request for technical support]({{ link-console-support }}).
Provide the following information in the request:

1. Billing account ID.
You can find this ID on the [page with billing account details]({{ link-console-support }}).
1. Description of actions you want to perform with the billing account.
