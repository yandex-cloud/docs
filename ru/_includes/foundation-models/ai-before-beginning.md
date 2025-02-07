# Аутентификация в API {{ foundation-models-full-name }}

Для работы с API {{ foundation-models-full-name }} необходимо выполнить аутентификацию:

{% list tabs group=authentication %}

- Аккаунт на Яндексе или федеративный аккаунт {#yandex-account}

  1. Получите IAM-токен для [аккаунта на Яндексе](../../iam/operations/iam-token/create.md) или [федеративного аккаунта](../../iam/operations/iam-token/create-for-federation.md).
  1. Получите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть хотя бы минимальная роль для работы с нужной моделью:
     * `{{ roles-yagpt-user }}` или выше — для работы с моделями генерации текста..
     * `{{ roles-yaart-user }}` или выше — для работы с {{ yandexart-name }}.
     * `ai.assistants.editor` и `{{ roles-yagpt-user }}` или выше — для работы с {{ assistant-api }}.
     
     Идентификатор каталога понадобится, чтобы получить URI модели.

  1. При обращении к {{ foundation-models-name }} через API в заголовке `Authorization` каждого запроса указывайте IAM-токен:

      ```bash
      Authorization: Bearer <IAM-токен>
      ```

- Сервисный аккаунт {#service-account}

   Для работы с моделями {{ foundation-models-name }} сервисный аккаунт должен иметь хотя бы минимальную соответствующую роль:
     * `{{ roles-yagpt-user }}` или выше — для работы с моделями генерации текста.
     * `{{ roles-yaart-user }}` или выше — для работы с {{ yandexart-name }}.
     * `ai.assistants.editor` и `{{ roles-yagpt-user }}` или выше — для работы с {{ assistant-api }}.
      
   API {{ foundation-models-name }} поддерживает два способа аутентификации с сервисным аккаунтом:

   * С помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md):

      1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md).
      1. Полученный IAM-токен передавайте в заголовке `Authorization` в следующем формате:

         ```bash
         Authorization: Bearer <IAM-токен>
         ```

   * С помощью [API-ключей](../../iam/concepts/authorization/api-key.md).

     {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

      1. [Получите API-ключ](../../iam/operations/api-key/create.md).
      1. Полученный API-ключ передавайте в заголовке `Authorization` в следующем формате:

         ```bash
         Authorization: Api-Key <API-ключ>
         ```

   Не указывайте в заголовках запросов идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт. Однако идентификатор родительского каталога сервисного аккаунта понадобится, чтобы получить URI модели.

{% endlist %}
