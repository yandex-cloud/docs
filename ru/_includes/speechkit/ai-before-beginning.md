Для работы с API {{ speechkit-name }} необходимо аутентифицироваться со своего аккаунта:

{% list tabs %}

- Аккаунт на Яндексе

  1. [Получите IAM-токен](../../iam/operations/iam-token/create.md).
  1. Получите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роли `{{ roles-speechkit-stt }}`, `{{ roles-speechkit-tts }}` или выше.
  1. {% include [iam-token-usage](../iam-token-usage-speechkit-v3.md) %}

- Федеративный аккаунт


   1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-federation.md).
   1. Получите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль роли `{{ roles-speechkit-stt }}`, `{{ roles-speechkit-tts }}` или выше.
   1. {% include [iam-token-usage](../iam-token-usage-speechkit-v3.md) %}

- Сервисный аккаунт

  {{ speechkit-name }} поддерживает два способа аутентификации с сервисным аккаунтом:

   * С помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md):

      1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md).
      1. Полученный IAM-токен передавайте в заголовке `Authorization` в следующем формате:

          ```
          Authorization: Bearer <IAM-токен>
          ```
         
   * С помощью [API-ключей](../../iam/concepts/authorization/api-key).

     {% include [api-keys-disclaimer](../iam/api-keys-disclaimer.md) %}

      1. [Получите API-ключ](../../iam/operations/api-key/create.md).
      1. Полученный API-ключ передавайте в заголовке `Authorization` в следующем формате:

          ```
          Authorization: Api-Key <API-ключ>
          ```

   Не указывайте в запросах идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт.

{% endlist %}
