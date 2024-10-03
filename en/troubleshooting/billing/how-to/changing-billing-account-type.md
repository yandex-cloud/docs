# How to change the billing account owner


## Issue description {#case-description}

* You need to change the type of your billing account (from "individual" to "legal entity")
* You need to change the type of your billing account (from "legal entity" to "individual").

## Solution {#case-solution}

You cannot change the type of an existing billing account, but you can transfer your resources to a new billing account.

Choose your desired account type in the tab below.

{% list tabs %}

- Businesses and individual entrepreneurs

   1. [Create a new billing account](../../../billing/operations/create-new-account.md) on behalf of a legal entity on the current Yandex ID account or federated account.
   2. [Submit the documents and wait for verification](../../../billing/qa/billing-account.md#account-notification) of the new billing account to avoid undesired downtime of your cloud resources.
   3. After verification and activation of the new billing account, link all existing clouds to it [following the guide](../../../billing/operations/pin-cloud.md).
      Do not forget to pay off outstanding amounts on the old billing account, if any.

   Once the clouds are moved, you can grant other accounts access to this cloud. To do this, follow these steps:

   1. [Add a user to the cloud](../../../iam/operations/users/create.md#passport-user).
   2. [Assign the relevant role to the user](../../../iam/operations/roles/grant.md#access-to-user).

   You can find the list of roles [here](../../../iam/concepts/access-control/roles.md).

- Individuals

   You can [create a new billing account](../../../billing/operations/create-new-account.md) within the current Yandex ID account and [link your cloud to it](../../../billing/operations/pin-cloud.md).
   Do not forget to pay off outstanding amounts on the old billing account, if any.

   After the transfer, you will be able to grant access to the cloud to other accounts. To do this, follow these steps:

   1. [Add a user to the cloud](../../../iam/operations/users/create.md#passport-user).
   2. [Assign the relevant role to the user](../../../iam/operations/roles/grant.md#access-to-user).

   You can find the list of roles [here](../../../iam/concepts/access-control/roles.md).

{% endlist %}

## If nothing helped {#if-issue-still-persists}

If these actions did not help, [create a request for technical support]({{ link-console-support }}).
When creating the request, make sure to specify:

1. Billing account ID.
   You can find this ID on the [page with billing account details]({{ link-console-support }}).
2. What exactly needs to be done with the billing account.
