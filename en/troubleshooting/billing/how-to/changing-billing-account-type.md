# How to change the billing account type



## Case description {#case-description}

* You need to change the type of your billing account from `individual` to `business`.
* You need to change the type of your billing account from `business` to `individual`.

## Solution {#case-resolution}

You cannot change the type of an existing billing account; however, you can transfer your resources to a new billing account.

Choose the account type you need in the tab below.

{% list tabs %}

- Business

    1. [Create a new billing account](../../../billing/operations/create-new-account.md) as a business in the current Yandex ID account or federated account.
    1. [Submit the documents and wait for verification](../../../billing/qa/billing-account.md#account-notification) of the new billing account to avoid downtime of your cloud resources.
    1. After verification and activation of the new billing account, link all existing clouds to it [following this guide](../../../billing/operations/pin-cloud.md).
    Make sure to pay off the outstanding amounts on the old billing account, if any.

    Once the clouds are moved, you can grant access to this cloud to other accounts. To do this, follow these steps:

    1. [Add a user to the cloud](../../../organization/operations/add-account.md#passport-user).
    1. [Assign the relevant role to the user](../../../iam/operations/roles/grant.md).

    You can find the list of roles [here](../../../iam/concepts/access-control/roles.md).

- Individual

    You can [create a new billing account](../../../billing/operations/create-new-account.md) within the current Yandex ID account and [link your cloud to it](../../../billing/operations/pin-cloud.md).
    Make sure to pay off the outstanding amounts on the old billing account, if any.

    After the transfer, you will be able to grant access to the cloud to other accounts. To do this, follow these steps:

    1. [Add a user to the cloud](../../../organization/operations/add-account.md#passport-user).
    1. [Assign the relevant role to the user](../../../iam/operations/roles/grant.md).

    You can find the list of roles [here](../../../iam/concepts/access-control/roles.md).

{% endlist %}

## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Billing account ID. You can find this ID on the [page with the billing account details]({{ link-console-billing }}).
1. What you exactly need to do with your billing account.
