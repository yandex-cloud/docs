1. Получите IAM-токен для [аккаунта на Яндексе](../../iam/operations/iam-token/create.md), [федеративного](../../iam/operations/iam-token/create-for-federation.md) или [локального](../../iam/operations/iam-token/create-for-local.md) аккаунта. Идентификатор каталога должен передаваться в теле каждого запроса в поле `folderId`.

 Передавайте полученный токен в заголовке `Authorization` каждого запроса в формате:

    ```yaml
    Authorization: Bearer <IAM-токен>
    ```

1. [Получите идентификатор любого каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть [роль](../../translate/security/index.md) `{{ roles-translate-user }}` или выше. Идентификатор каталога должен передаваться в теле каждого запроса в поле `folderId`.
