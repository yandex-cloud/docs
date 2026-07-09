Выберите способ аутентификации:

{% list tabs group=registry_auth %}

- IAM-токен {#iam-token}

    Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../iam/operations/iam-token/create-for-sa.md), от имени которого вы будете выполнять аутентификацию.

    {% note info %}

    [Время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше {{ iam-token-lifetime }}.

    {% endnote %}

- API-ключ {#api-key}

    [Создайте](../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.

    {% note info %}

    [Время жизни](../../iam/concepts/authorization/api-key.md#scoped-api-keys) API-ключа ограничивается вручную при создании.

    {% endnote %}

{% endlist %}
