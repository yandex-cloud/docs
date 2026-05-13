# Аутентификация в API


Для выполнения операций через [API](../../glossary/rest-api.md) необходимо получить [IAM-токен](../../iam/concepts/authorization/iam-token.md):

* [Инструкция](../../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
* [Инструкция](../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
* [Инструкция](../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
* [Инструкция](../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.

Полученный IAM-токен указывайте при обращении к ресурсам Yandex Cloud через API. Передайте IAM-токен в заголовке `Authorization` в следующем формате:

```yaml
Authorization: Bearer <IAM-токен>
```

Если вы записали IAM-токен в переменную, используйте ее:

```yaml
Authorization: Bearer ${IAM_TOKEN}
```

#### См. также {#see-also}

[Аккаунты в Yandex Cloud](../../iam/concepts/users/accounts.md)