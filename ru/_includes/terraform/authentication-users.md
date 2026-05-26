{% note warning %}

Управление ресурсами от имени пользовательского аккаунта является менее безопасным, чем использование сервисного аккаунта.

{% endnote %}

Для аутентификации от имени пользовательского аккаунта:

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите](../../cli/operations/install-cli.md).

1. В {{ yandex-cloud }} CLI [создайте](../../cli/operations/profile/profile-create.md) новый профиль или [активируйте](../../cli/operations/profile/profile-activate.md) созданный ранее.

1. Аутентифицируйтесь в зависимости от типа используемого аккаунта: [аккаунта на Яндексе](../../cli/operations/authentication/user.md), [федеративного](../../cli/operations/authentication/federated-user.md) или [локального](../../cli/operations/authentication/local-user.md) пользователя.

1. {% include [export-env-vars](export-env-vars.md) %}

{% include [iam-refresh](iam-refresh.md) %}

{% include [provider-config-example](provider-config-example.md) %}
