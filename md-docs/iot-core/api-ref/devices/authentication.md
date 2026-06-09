# Аутентификация в Devices API {{ iot-name }}

{% note warning %}

Сервис {{ iot-full-name }} больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../sunset.md).

{% endnote %}

# Аутентификация в API


Для выполнения операций через [API](../../../glossary/rest-api.md) необходимо получить [IAM-токен](../../../iam/concepts/authorization/iam-token.md):

* [Инструкция](../../../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
* [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
* [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
* [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.

Полученный IAM-токен указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передайте IAM-токен в заголовке `Authorization` в следующем формате:

```yaml
Authorization: Bearer <IAM-токен>
```

Если вы записали IAM-токен в переменную, используйте ее:

```yaml
Authorization: Bearer ${IAM_TOKEN}
```

#### См. также {#see-also}

[{#T}](../../../iam/concepts/users/accounts.md)