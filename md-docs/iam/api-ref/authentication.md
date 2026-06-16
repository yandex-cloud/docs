# Аутентификация в API Identity and Access Management

# Аутентификация в API


Для выполнения операций через [API](../../glossary/rest-api.md) необходимо получить [IAM-токен](../concepts/authorization/iam-token.md):

* [Инструкция](../operations/iam-token/create.md) для аккаунта на Яндексе.
* [Инструкция](../operations/iam-token/create-for-sa.md) для сервисного аккаунта.
* [Инструкция](../operations/iam-token/create-for-federation.md) для федеративного аккаунта.
* [Инструкция](../operations/iam-token/create-for-local.md) для локального аккаунта.

Полученный IAM-токен указывайте при обращении к ресурсам Yandex Cloud через API. Передайте IAM-токен в заголовке `Authorization` в следующем формате:

```yaml
Authorization: Bearer <IAM-токен>
```

Если вы записали IAM-токен в переменную, используйте ее:

```yaml
Authorization: Bearer ${IAM_TOKEN}
```

#### Полезные ссылки {#see-also}

[Аккаунты в Yandex Cloud](../concepts/users/accounts.md)