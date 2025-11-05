{% note warning %}

Управление ресурсами от имени [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport), [локального](../../iam/concepts/users/accounts.md#local) или [федеративного аккаунта](../../iam/concepts/users/accounts.md#saml-federation) пользователя является менее безопасным, чем использование [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

{% endnote %}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

Если вы используете федеративный или локальный аккаунт, аутентифицируйтесь в [CLI](../../cli/):

* [от имени федеративного пользователя](../../cli/operations/authentication/federated-user.md);
* [от имени локального пользователя](../../cli/operations/authentication/local-user.md).

Добавьте аутентификационные данные в переменные окружения:

{% include [terraform-token-variables](../../_includes/terraform-token-variables.md) %}