# Аутентификация в API {{ speechsense-full-name }}

Для работы с API {{ speechsense-name }} необходимо [создать](../../iam/operations/sa/create.md) сервисный аккаунт и использовать его для аутентификации:

{% list tabs group=authentication %}

- Сервисный аккаунт {#service-account}

   * С помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md):

      {% note info %}

      {% include [disclamer](../../_includes/iam/iam-token-note.md) %}

      {% endnote %}

      1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md).
      1. Полученный IAM-токен передавайте в заголовке `Authorization` в следующем формате:

          ```
          Authorization: Bearer <IAM-токен>
          ```

   * С помощью [API-ключей](../../iam/concepts/authorization/api-key).

      {% note info %}

      {% include [disclamer](../../_includes/iam/api-keys-disclaimer.md) %}

      {% endnote %}

      1. [Получите API-ключ](../../iam/operations/api-key/create.md).
      1. Полученный API-ключ передавайте в заголовке `Authorization` в следующем формате:

          ```
          Authorization: Api-Key <API-ключ>
          ```

   Не указывайте в запросах идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт.

{% endlist %}
