{% note warning %}

Managing resources under a user's [Yandex account](../../iam/concepts/users/accounts.md#passport) or [federated account](../../iam/concepts/users/accounts.md#saml-federation) is less secure than under a [service account](../../iam/concepts/users/service-accounts.md).

{% endnote %}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

If you use a federated account, [authenticate](../../cli/operations/authentication/federated-user.md) with the CLI on behalf of the federated user.

Add the credentials to the environment variables:

{% include [terraform-token-variables](../../_includes/terraform-token-variables.md) %}