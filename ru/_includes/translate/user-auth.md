1. Получите IAM-токен для [аккаунта на Яндексе](../../iam/operations/iam-token/create.md) или [федеративного аккаунта](../../iam/operations/iam-token/create-for-federation.md), необходимый для аутентификации. Передавайте полученный токен в заголовке `Authorization` каждого запроса в формате:

    ```yaml
    Authorization: Bearer <IAM-токен>
    ```

1. [Получите идентификатор любого каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть [роль](../../translate/security/index.md) `{{ roles-translate-user }}` или выше. Идентификатор каталога должен передаваться в теле каждого запроса в поле `folderId`.
