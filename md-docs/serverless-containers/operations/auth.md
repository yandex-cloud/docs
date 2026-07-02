[Документация Yandex Cloud](../../index.md) > [Yandex Serverless Containers](../index.md) > [Пошаговые инструкции](index.md) > Вызов контейнера > Аутентифицироваться при вызове приватного контейнера через HTTPS

# Аутентифицироваться при вызове приватного контейнера через HTTPS

Чтобы [вызвать](invoke.md) приватный контейнер через HTTPS, необходимо аутентифицироваться. Для этого получите:

* [IAM-токен](../../iam/concepts/authorization/iam-token.md):

    * [Инструкция](../../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
    * [Инструкция](../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
    * [Инструкция](../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
    * [Инструкция](../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.

    Полученный IAM-токен передайте в заголовке `Authorization` в следующем формате:

    ```text
    Authorization: Bearer <IAM-токен>
    ```

    IAM-токен действует не больше 12 часов.

* [API-ключ](../../iam/operations/authentication/manage-api-keys.md) для сервисного аккаунта.

    Полученный API-ключ передайте в заголовке `Authorization` в следующем формате:

    ```text
    Authorization: Api-Key <API-ключ>
    ```

    Используйте API-ключи, если у вас нет возможности автоматически запрашивать [IAM-токен](../../iam/concepts/authorization/iam-token.md).