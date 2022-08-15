To use the examples, install [cURL](https://curl.haxx.se) and get the authorization data for your account:

{% list tabs %}

- User's Yandex account

   
   1. [On the billing page]({{ link-console-billing }}), make sure that the [payment account](../billing/concepts/billing-account.md) is in `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
   1. [Get an IAM token](../iam/operations/iam-token/create.md), which is required for authentication.
   1. [Get the ID of any folder](../resource-manager/operations/folder/get-id.md) that your account is granted the `editor` role or higher for.

- Service accounts

   1. Select the authentication method:
      * Get an [IAM token](../iam/operations/iam-token/create-for-sa.md) used in the examples.
      * [Create an API key](../iam/operations/api-key/create.md). Pass the API key in the `Authorization` header in the following format:

         ```
         Authorization: Api-Key <API key>
         ```
   1. [Assign the service account the](../iam/operations/sa/assign-role-for-sa.md) `editor` role or a higher role for the folder where it was created.

      Don't specify the folder ID in your requests: the service uses the folder where the service account was created.

- Federated account

   1. [Authenticate with the CLI as a federated user](../cli/operations/authentication/federated-user.md).
   1. Use the CLI to get an [IAM token](../iam/concepts/authorization/iam-token.md) required for authentication:

      ```bash
      yc iam create-token
      ```
   1. [Get the ID of any folder](../resource-manager/operations/folder/get-id.md) that your account is granted the `editor` role or higher for.

{% endlist %}

