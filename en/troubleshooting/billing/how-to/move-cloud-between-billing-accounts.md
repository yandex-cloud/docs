# How to link the cloud to another billing account



## Case description {#case-description}

You need to change the billing account linked to one or multiple clouds.

## Solution {#case-resolution}

The algorithm depends on the type of billing account you want to link to your cloud:

{% list tabs %}

- Businesses

    To change the current account for your cloud to a new business account, follow these steps:

    1. [Create a new billing account](../../../billing/operations/create-new-account.md) as a business in the current or any other Yandex account.
    1. [Send documents and wait for activation](../../../billing/qa/billing-account.md#account-notification) to avoid forced downtime of resources.
    1. After the activation, [link your clouds to the new account](../../../billing/operations/pin-cloud.md).

    {% note info %}

    Make sure to pay off the outstanding amounts on the old billing account, if any.

    {% endnote %}

    After changing the account for your clouds, you can grant access to your cloud to other accounts.
    To do this, follow these steps:

    1. [Add a user to the cloud](../../../organization/operations/add-account.md#passport-user).
    1. [Assign the relevant role to the user](../../../iam/operations/roles/grant.md#access-to-user).
    
    You can find the list of roles [here](../../../iam/concepts/access-control/roles.md).

- Individuals

    You can create a new Yandex ID account or a [new billing account within the existing Yandex ID account](../../../billing/operations/create-new-account.md) and [link the cloud to it](../../../billing/operations/pin-cloud.md).

    Make sure to pay off the outstanding amounts on the old billing account, if any.

{% endlist %}

{% note alert %}

In the cloud you want to move, assign the `{{ roles-cloud-owner }}` role to the user who has the `billing.accounts.owner` or `{{ roles-editor }}` role for the billing account of the organization you move the cloud to. A cloud must have at least one owner. After assigning a second owner, you can revoke this role from yourself.

{% endnote %}


## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the cloud you want to move to another billing account.
1. Issue description.
