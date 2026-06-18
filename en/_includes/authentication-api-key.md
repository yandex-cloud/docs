The _API key_ is a secret key only used for simplified authorization of [service accounts](../iam/concepts/users/service-accounts.md) with the {{ yandex-cloud }} API.

[Guide](../iam/operations/authentication/manage-api-keys.md) to obtaining an API key for service accounts.

Use the API key you obtained when accessing {{ yandex-cloud }} resources via the API. Include the API key in the `Authorization` header, formatted as follows:

```yaml
Authorization: Api-Key <API_key>
```

If you have saved the API key to a variable, use the latter:

```yaml
Authorization: Api-Key ${API_KEY}
```
