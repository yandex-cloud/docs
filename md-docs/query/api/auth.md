[Документация Yandex Cloud](../../index.md) > [Yandex Query](../index.md) > Справочник > [HTTP API](index.md) > Аутентификация

# Аутентификация в API Yandex Query

{% note warning %}

Сервис Yandex Query будет отключен 1 декабря 2026 года и станет недоступен. Подробнее о закрытии сервиса и переходе на другие решения читайте в разделе [Закрытие сервиса Yandex Query](../sunset.md).

{% endnote %}

# Аутентификация в API


Для выполнения операций через API необходимо получить [IAM-токен](../../iam/concepts/authorization/iam-token.md):

* [Инструкция](../../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
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

#### Полезные ссылки {#see-also}

[Аккаунты в Yandex Cloud](../../iam/concepts/users/accounts.md)