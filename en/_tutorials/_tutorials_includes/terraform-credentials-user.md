{% note warning %}

Managing resources under a user's [Yandex account](../../iam/concepts/users/accounts.md#passport), [local account](../../iam/concepts/users/accounts.md#local), or [federated account](../../iam/concepts/users/accounts.md#saml-federation) is less secure than under a [service account](../../iam/concepts/users/service-accounts.md).

{% endnote %}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

If you use a federated or local account, get authenticated in the [CLI](../../cli/):

* [As a federated user](../../cli/operations/authentication/federated-user.md)
* [As a local user](../../cli/operations/authentication/local-user.md)

Add your credentials to the environment variables:

{% include [terraform-token-variables](../../_includes/terraform-token-variables.md) %}