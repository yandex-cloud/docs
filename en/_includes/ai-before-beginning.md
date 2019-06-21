To try the examples in this section:

1. [On the billing page](https://console.cloud.yandex.com/billing), make sure that the [payment account](../billing/concepts/billing-account.md) has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a payment account, [create one](../billing/quickstart/index.md#create_billing_account).
1. Make sure you have installed the [cURL](https://curl.haxx.se) utility that is used in the examples.
1. [Get the ID of any folder](../resource-manager/operations/folder/get-id.md) that your account is granted the `editor` role or higher for.
1. [Get an IAM token](../iam/operations/iam-token/create.md) for your Yandex account.

To perform these operations on behalf of the [service account](../iam/concepts/users/service-accounts.md):

1. [Assign the ](../iam/operations/sa/assign-role-for-sa.md) `editor` role or a higher role to the service account for the folder where it was created.
1. Do not specify the folder ID in the request: the service uses the folder where the service account was created.
1. Choose the authentication method: get an [IAM token](../iam/operations/iam-token/create-for-sa.md) or [API key](../iam/operations/api-key/create.md).

