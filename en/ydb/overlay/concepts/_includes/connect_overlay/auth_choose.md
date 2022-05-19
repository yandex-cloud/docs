To prepare data for authenticating in the {{ ydb-short-name }} {{ yandex-cloud }} database for the selected mode, follow these steps:

{% list tabs %}

- Access Token

  * In Access Token mode, an [IAM token {{ yandex-cloud }}](../../../../iam/concepts/authorization/iam-token.md) is used. For information about how to get it, see [Getting an IAM token for a Yandex account](../../../../iam/operations/iam-token/create.md).

- Refresh Token

  * In Refresh Token mode, an [OAuth token of a user account on Yandex](../../../../iam/concepts/authorization/oauth-token.md) is used. You can get it from the [link]({{ link-cloud-oauth }}).

- Service Account Key

  * In Service Account Key mode, a file with [an authorized key](../../../../iam/concepts/authorization/key.md) [of a service account](../../../../iam/concepts/users/service-accounts.md) is used.

      [Create](../../../../iam/operations/sa/create.md) a service account. Assign it the `viewer` or `viewer` + `editor` role depending on the access to the DB in the selected folder to be provided.

      [Create an authorized key](../../../../iam/operations/authorized-key/create.md) of the service account and save it to a file.

- Metadata

  * In Metadata mode, a [service account](../../../../iam/concepts/users/service-accounts.md) is used, which is linked to the VM where you run your application or {{ ydb-short-name }} CLI commands or to the {{ sf-full-name }} function where you execute your application code.

      [Create](../../../../iam/operations/sa/create.md) a service account and assign it the `viewer` or `viewer` + `editor` role depending on the access to the DB in the selected folder to be provided.

      Link the service account [to the VM](../../../../compute/operations/vm-connect/auth-inside-vm#link-sa-with-instance.md) or [the {{ sf-full-name }}](../../../../functions/operations/function/function-create.md) function.

{% endlist %}

For information about how to use the generated artifacts, see [Client side authentication configuration](#client-config) below in this article.
