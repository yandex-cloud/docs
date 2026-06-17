# Аутентификация в API Yandex Cloud

Для выполнения операций через [API](../../glossary/rest-api.md) можно использовать [IAM-токен](../../iam/concepts/authorization/iam-token.md) или [API-ключ](../../iam/concepts/authorization/api-key.md). Любой из этих способов аутентификации подходит для работы с [Prometheus](../../monitoring/operations/prometheus/index.md).

## IAM-токен {#iam-token}

_IAM-токен_ — уникальная последовательность символов, которая выдается пользователю после прохождения аутентификации.

Как получить IAM-токен:

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

## API-ключ {#api-key}

_API-ключ_ — секретный ключ, используемый только для упрощенной аутентификации [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md) в API Yandex Cloud.

[Инструкция](../../iam/operations/authentication/manage-api-keys.md) по получению API-ключа для сервисного аккаунта.

Полученный API-ключ указывайте при обращении к ресурсам Yandex Cloud через API. Передайте API-ключ в заголовке `Authorization` в следующем формате:

```yaml
Authorization: Api-Key <API-ключ>
```

Если вы записали API-ключ в переменную, используйте ее:

```yaml
Authorization: Api-Key ${API_KEY}
```

{% note info %}

Чтобы выполнять операции записи в лог-группу, задайте для API-ключа [область действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.logging.write`.

{% endnote %}

#### Полезные ссылки {#see-also}

[Аккаунты в Yandex Cloud](../../iam/concepts/users/accounts.md)