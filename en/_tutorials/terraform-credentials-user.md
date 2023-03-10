{% note warning %}

Managing resources on behalf of the user's [Yandex account](../iam/concepts/index.md#passport) or a [federated account](../iam/concepts/index.md#saml-federation) is less secure than on behalf of the service account.

{% endnote %}

{% include [cli-install](../_includes/cli-install.md) %}

{% include [default-catalogue](../_includes/default-catalogue.md) %}

If you use a federated account, [log in](../cli/operations/authentication/federated-user.md) to CLI on behalf of the federated user.

Add the credentials to the environment variables:

{% include [terraform-token-variables](../_includes/terraform-token-variables.md) %}
