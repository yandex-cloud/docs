Get the authorization data for your account:

{% list tabs %}

- User's Yandex account

   1. On the [**Billing**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
   1. [Get an IAM token](../../iam/operations/iam-token/create.md), which is required for authentication.
   1. [Get the ID of any folder](../../resource-manager/operations/folder/get-id.md) that your account is granted the `{{ roles-translate-user }}` role or higher for.

- Service account

   1. Select the authentication method:
      * Get an [IAM token](../../iam/operations/iam-token/create-for-sa.md) used in the examples.
      * [Create an API key.](../../iam/operations/api-key/create.md) Pass the API key in the `Authorization` header in the following format:

         ```
         Authorization: Api-Key <API key>
         ```
   1. [Assign the service account](../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-translate-user }}` role or a higher role for the folder where it was created.

      Do not specify the folder ID in your requests, as the service uses the folder where the service account was created.

- Federated account

   1. [Authenticate with the CLI as a federated user](../../cli/operations/authentication/federated-user.md).
   1. Use the CLI to get an [IAM token](../../iam/concepts/authorization/iam-token.md) required for authentication:

      ```bash
      yc iam create-token
      ```
   1. [Get the ID of any folder](../../resource-manager/operations/folder/get-id.md) that your account is granted the `{{ roles-translate-user }}` role or higher for.

{% endlist %}

