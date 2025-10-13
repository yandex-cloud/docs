* `Service account`: To provide the [IAM token](../../../iam/concepts/authorization/iam-token.md) issued for the [service account](../../../iam/concepts/users/service-accounts.md) attached to the MCP server.
* `Access token`: To provide the specified access token. In the **Token** field, specify the token you need.

    * `{{ lockbox-short-name }} secret`: If the access token is stored in a {{ lockbox-full-name }} [secret](../../../lockbox/concepts/secret.md).

        Specify the secret details: In the **Secret** field, select the {{ lockbox-full-name }} secret you need; in the **Version** and **Secret key** fields, select the [version](../../../lockbox/concepts/secret.md#version) and secret key containing the access token.

        {% note info %}

        When using a {{ lockbox-full-name }} secret, additionally [assign](../../../iam/operations/sa/assign-role-for-sa.md) the `lockbox.payloadViewer` [role](../../../lockbox/security/index.md#lockbox-payloadViewer) for the secret to the service account attached to your MCP server.

        {% endnote %}

    * `Text`: To provide the access token unencrypted.

        {% note alert %}

        It is not safe to provide an access token as plain text.

        {% endnote %}

* `Without authorization`: To skip authentication.