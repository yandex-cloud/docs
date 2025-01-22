# Linking the cloud to another billing account



## Scenario description {#case-description}

You need to change the billing account associated with one or more clouds.

## Solution {#case-resolution}

The relevant sequence of actions depends on the type of billing account you want to link to the cloud:

{% list tabs %}

- Businesses

   To move a cloud from the current account to a **new account of a legal entity**, you need:

   1. [Create a new billing account](../../../billing/operations/create-new-account.md) on behalf of the legal entity owning the current or another Yandex account.
   2. [Send documents and wait for activation](../../../billing/qa/billing-account.md#account-notification) to avoid forced downtime of resources
   3. After the activation, [link your clouds to the new account](../../../billing/operations/pin-cloud.md).

   Be sure to pay off outstanding amounts on the original account, if any.

   Once the clouds are moved, you can grant other accounts access to this cloud.
   To do this, follow these steps:

   1. [Add a user to the cloud](../../../iam/operations/users/create.md#passport-user).
   2. [Assign the relevant role to the user](../../../iam/operations/roles/grant.md#access-to-user).

   You can find the list of roles [here](../../../iam/concepts/access-control/roles.md).

- Individuals

   You can create a new Yandex ID account or a [new billing account within the existing Yandex ID account](../../../billing/operations/create-new-account.md) and [link the cloud to it](../../../billing/operations/pin-cloud.md).

   Be sure to pay off outstanding amounts on the original account, if any.

{% endlist %}

{% note alert %}

In the cloud you want to transfer, assign the `{{ roles-cloud-owner }}` cloud owner role to the user who has the `billing.accounts.owner` or `editor` role for the billing account of the organization you transfer the cloud to. A cloud must have at least one owner. After assigning a second owner, you can revoke this role from yourself.

{% endnote %}


## If nothing helped {#if-issue-still-persists}

If the above actions did not help, [create a request for technical support]({{ link-console-support }}).
Provide the following information in the request:

1. The ID of the cloud you want to transfer to another billing account.
2. Problem description.
