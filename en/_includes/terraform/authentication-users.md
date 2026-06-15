{% note warning %}

It is less secure to manage resources as a user account than as a service account.

{% endnote %}

To authenticate as a user account:

1. If you do not have the {{ yandex-cloud }} CLI yet, [install it](../../cli/operations/install-cli.md).

1. In the {{ yandex-cloud }} CLI, [create](../../cli/operations/profile/profile-create.md) a new profile or [activate](../../cli/operations/profile/profile-activate.md) a previously created one.

1. Authenticate as a [Yandex account](../../cli/operations/authentication/user.md), [federated](../../cli/operations/authentication/federated-user.md) user, or [local](../../cli/operations/authentication/local-user.md) user.

1. {% include [export-env-vars](export-env-vars.md) %}

{% include [iam-refresh](iam-refresh.md) %}

{% include [provider-config-example](provider-config-example.md) %}
