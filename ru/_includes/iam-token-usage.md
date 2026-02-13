Полученный IAM-токен указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передайте IAM-токен в заголовке `Authorization` в следующем формате:

```yaml
Authorization: Bearer <IAM-токен>
```

Если вы записали IAM-токен в переменную, используйте ее:

```yaml
Authorization: Bearer ${IAM_TOKEN}
```