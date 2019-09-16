# Аутентификация в API

Для выполнения операций в Яндекс.Облаке через API необходимо аутентифицироваться со своего аккаунта.

{% list tabs %}

- Аккаунт на Яндексе

  Для выполнения операций с аккаунтом на Яндексе необходим [IAM-токен](../iam/concepts/authorization/iam-token.md):

  1. [Получите IAM-токен](../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
  2. {% include [iam-token-usage](iam-token-usage.md) %}

      {% include [iam-token-lifetime](iam-token-lifetime.md) %}

- Сервисный аккаунт

  В этом сервисе есть 2 способа аутентификации с сервисным аккаунтом:

  * С помощью [API-ключей](../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](iam/api-keys-disclaimer.md) %}

      1. [Получите API-ключ](../iam/operations/api-key/create.md).
      2. Полученный API-ключ указывайте при обращении к ресурсам Яндекс.Облака через API. Передайте API-ключ в заголовке `Authorization` в следующем формате:

          ```
          Authorization: Api-Key <API-ключ>
          ```
  * С помощью [IAM-токена](../iam/concepts/authorization/iam-token.md):

      1. [Получите IAM-токен](../iam/operations/iam-token/create-for-sa.md).
      2. {% include [iam-token-usage](iam-token-usage.md) %}

          {% include [iam-token-lifetime](iam-token-lifetime.md) %}

{% endlist %}
