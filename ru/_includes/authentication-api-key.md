_API-ключ_ — секретный ключ, используемый только для упрощенной аутентификации [сервисных аккаунтов](../iam/concepts/users/service-accounts.md) в API {{ yandex-cloud }}.

[Инструкция](../iam/operations/authentication/manage-api-keys.md) по получению API-ключа для сервисного аккаунта.

Полученный API-ключ указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передайте API-ключ в заголовке `Authorization` в следующем формате:

```yaml
Authorization: Api-Key <API-ключ>
```

Если вы записали API-ключ в переменную, используйте ее:

```yaml
Authorization: Api-Key ${API_KEY}
```
