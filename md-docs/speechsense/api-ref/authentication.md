# Аутентификация в API Yandex SpeechSense

Для работы с API SpeechSense необходимо [создать](../../iam/operations/sa/create.md) сервисный аккаунт и использовать его для аутентификации:

{% list tabs group=authentication %}

- Сервисный аккаунт {#service-account}

   * С помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md):

      {% note info %}

      У IAM-токена короткое [время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) — не более  12 часов. Поэтому такой способ подойдет для приложений, которые будут запрашивать IAM-токен автоматически.

      {% endnote %}

      1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md).
      1. Полученный IAM-токен передавайте в заголовке `Authorization` в следующем формате:

          ```yaml
          Authorization: Bearer <IAM-токен>
          ```

   * С помощью [API-ключей](../../iam/concepts/authorization/api-key.md).

      {% note info %}

      Используйте API-ключи, если у вас нет возможности автоматически запрашивать [IAM-токен](../../iam/concepts/authorization/iam-token.md).

      {% endnote %}

      1. [Получите API-ключ](../../iam/operations/authentication/manage-api-keys.md#create-api-key) с заданной [областью действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.speech-sense.use`.
      1. Полученный API-ключ передавайте в заголовке `Authorization` в следующем формате:

          ```yaml
          Authorization: Api-Key <API-ключ>
          ```

   Не указывайте в запросах идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт.

{% endlist %}