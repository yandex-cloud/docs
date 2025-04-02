Для аутентификации от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вы можете использовать [API-ключ](../../iam/concepts/authorization/api-key.md) или [IAM-токен](../../iam/concepts/authorization/iam-token.md), для аутентификации от имени пользовательского аккаунта — только IAM-токен.

Получите данные вашего аккаунта для аутентификации в API {{ translate-name }}:

{% list tabs %}

- API-ключ

  1. Если у вас еще нет сервисного аккаунта, [создайте](../../iam/operations/sa/create.md) его.
  1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../translate/security/index.md#translate-user) `{{ roles-translate-user }}` на каталог.
  1. [Получите идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором создан ваш сервисный аккаунт. Идентификатор каталога должен передаваться в теле каждого запроса в поле `folderId`.
  1. [Создайте](../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ с [областью действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.ai.translate.execute`.
  
      Передавайте полученный ключ в заголовке `Authorization` каждого запроса в формате:

      ```yaml
      Authorization: Api-Key <API-ключ>
      ```

- IAM-токен

  1. [Получите идентификатор любого каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть [роль](../../translate/security/index.md#translate-user) `{{ roles-translate-user }}` или выше. Идентификатор каталога должен передаваться в теле каждого запроса в поле `folderId`.
  1. Получите IAM-токен для [аккаунта на Яндексе](../../iam/operations/iam-token/create.md), [федеративного аккаунта](../../iam/operations/iam-token/create-for-federation.md) или [сервисного аккаунта](../../iam/operations/iam-token/create-for-sa.md).
  
      Передавайте полученный токен в заголовке `Authorization` каждого запроса в формате:

      ```yaml
      Authorization: Bearer <IAM-токен>
      ```

{% endlist %}