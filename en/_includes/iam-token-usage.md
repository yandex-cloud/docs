Specify the received IAM token when accessing {{ yandex-cloud }} resources via the API. Provide the IAM token in the `Authorization` header in the following format:

```yaml
Authorization: Bearer <IAM_token>
```

If you have saved your IAM token to a variable, use the latter:

```yaml
Authorization: Bearer ${IAM_TOKEN}
```