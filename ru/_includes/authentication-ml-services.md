# Аутентификация в API

Для выполнения операций через API необходимо аутентифицироваться со своего аккаунта:

{% list tabs group=authentication %}

- Аккаунт на Яндексе или федеративный аккаунт {#yandex-account}

  1. Получите IAM-токен для [аккаунта на Яндексе](../iam/operations/iam-token/create.md) или [федеративного аккаунта](../iam/operations/iam-token/create-for-federation.md).
  1. {% include [iam-token-usage](iam-token-usage.md) %}

- Сервисный аккаунт {#service-account}

  В этом сервисе есть 2 способа аутентификации с сервисным аккаунтом:
  * С помощью [IAM-токена](../iam/concepts/authorization/iam-token.md):

      1. [Получите IAM-токен](../iam/operations/iam-token/create-for-sa.md).
      1. {% include [iam-token-usage](iam-token-usage.md) %}

  * С помощью [API-ключей](../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](iam/api-keys-disclaimer.md) %}

      1. [Получите API-ключ](../iam/operations/api-key/create.md).
      1. Полученный API-ключ указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передайте API-ключ в заголовке `Authorization` в следующем формате:

          ```
          Authorization: Api-Key <API-ключ>
          ```

{% endlist %}
