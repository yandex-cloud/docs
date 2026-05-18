Создайте переменные окружения в зависимости от способа аутентификации:

{% list tabs group=registry_auth %}

- IAM-токен {#iam-token}

  1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../iam/operations/iam-token/create-for-sa.md), от имени которого вы будете выполнять аутентификацию.
  1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:

      ```bash
      export REGISTRY_USERNAME="iam"
      export REGISTRY_PASSWORD="<IAM-токен>"
      ```

      Где:

      * `REGISTRY_USERNAME` — способ аутентификации.
      * `REGISTRY_PASSWORD` — тело полученного ранее IAM-токена.

  {% note info %}

  [Время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше {{ iam-token-lifetime }}.

  {% endnote %}

- API-ключ {#api-key}

  1. [Создайте](../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.
  1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:

      ```bash
      export REGISTRY_USERNAME="api_key"
      export REGISTRY_PASSWORD="<API-ключ>"
      ```

      Где:

      * `REGISTRY_USERNAME` — способ аутентификации.
      * `REGISTRY_PASSWORD` — тело созданного ранее [API-ключа](../../iam/concepts/authorization/api-key.md).

  {% note info %}

  [Время жизни](../../iam/concepts/authorization/api-key.md#scoped-api-keys) API-ключа ограничивается вручную при создании.

  {% endnote %}

{% endlist %}