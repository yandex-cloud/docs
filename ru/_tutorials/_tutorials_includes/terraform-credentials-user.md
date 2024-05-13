{% note warning %}

Управление ресурсами от имени [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport) или [федеративного аккаунта](../../iam/concepts/users/accounts.md#saml-federation) пользователя является менее безопасным, чем использование [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

{% endnote %}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

Если вы используете федеративный аккаунт, [аутентифицируйтесь](../../cli/operations/authentication/federated-user.md) в [CLI](../../cli/) от имени федеративного пользователя.

Добавьте аутентификационные данные в переменные окружения:

{% include [terraform-token-variables](../../_includes/terraform-token-variables.md) %}