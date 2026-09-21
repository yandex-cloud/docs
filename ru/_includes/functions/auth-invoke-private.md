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
