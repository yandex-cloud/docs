# Аутентификация в API {{ yagpt-name }}

Для работы с API {{ yagpt-name }} необходимо аутентифицироваться со своего аккаунта:

{% list tabs %}

- Аккаунт на Яндексе или федеративный аккаунт

  1. Получите IAM-токен для [аккаунта на Яндексе](../../iam/operations/iam-token/create.md) или [федеративного аккаунта](../../iam/operations/iam-token/create-for-federation.md).
  1. Получите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
  1. При обращении к {{ yagpt-full-name }} через API в каждом запросе передавайте полученные параметры:

     * в заголовке `Authorization` указывайте IAM-токен;
     * в заголовке `x-folder-id` указывайте идентификатор каталога.

     ```
     Authorization: Bearer <IAM-токен> 
     x-folder-id: <идентификатор_каталога>
     ```

- Сервисный аккаунт

   Для работы с {{ yagpt-full-name }} сервисный аккаунт должен иметь роль `{{ roles-yagpt-user }}` или выше. {{ yagpt-full-name }} поддерживает два способа аутентификации с сервисным аккаунтом:

   * С помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md):

      1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md).
      1. Полученный IAM-токен передавайте в заголовке `Authorization` в следующем формате:

         ```bash
         Authorization: Bearer <IAM-токен>
         ```

   * С помощью [API-ключей](../../iam/concepts/authorization/api-key).

     {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

      1. [Получите API-ключ](../../iam/operations/api-key/create.md).
      1. Полученный API-ключ передавайте в заголовке `Authorization` в следующем формате:

         ```bash
         Authorization: Api-Key <API-ключ>
         ```

   Не указывайте в заголовках запросов идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт.

{% endlist %}
