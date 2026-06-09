# Настроить npm

Чтобы сделать настройку:

* для всех проектов, выполните команду:

    `npm config set registry https://registry.yandexcloud.net/npm/<идентификатор_реестра>`

* для одного проекта:

    1. Создайте файл `.npmrc` в корне проекта.
    1. В зависимости от способа аутентификации:

        {% list tabs %}

        - IAM-токен (Base64)

          1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которого вы будете выполнять аутентификацию.
          1. Создайте переменную окружения `NPM_AUTH`:

              ```bash
              export NPM_AUTH=$(echo -n 'iam:<IAM-токен>' | base64)
              ```

              Где `NPM_AUTH` — тело полученного ранее IAM-токена в кодировке [Base64](https://www.base64encode.org/).

          1. Добавьте в созданный ранее файл `.npmrc` следующие строки:

              ```text
              registry=https://registry.yandexcloud.net/npm/<идентификатор_реестра>
              //registry.yandexcloud.net/npm/:_auth=${NPM_AUTH}
              always-auth=true
              ```

        - IAM-токен

          1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которого вы будете выполнять аутентификацию.
          1. Создайте переменную окружения `NPM_AUTH`:

              ```bash
              export NPM_AUTH="<IAM-токен>"
              ```

              Где `NPM_AUTH` — тело полученного ранее IAM-токена.

          1. Добавьте в созданный ранее файл `.npmrc` следующие строки:

              ```text
              registry=https://registry.yandexcloud.net/npm/<идентификатор_реестра>
              //registry.yandexcloud.net/npm/:_authToken=${NPM_AUTH}
              always-auth=true
              ```

        - API-ключ (Base64)

          1. [Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.
          1. Создайте переменную окружения `NPM_AUTH`:

              ```bash
              export NPM_AUTH=$(echo -n 'api_key:<API-ключ>' | base64)
              ```

              Где `NPM_AUTH` — тело созданного ранее [API-ключа](../../../iam/concepts/authorization/api-key.md) в кодировке [Base64](https://www.base64encode.org/).

          1. Добавьте в созданный ранее файл `.npmrc` следующие строки:

              ```text
              registry=https://registry.yandexcloud.net/npm/<идентификатор_реестра>
              //registry.yandexcloud.net/npm/:_auth=${NPM_AUTH}
              always-auth=true
              ```

        {% endlist %}