Полученный IAM-токен указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передайте IAM-токен в заголовке `Authorization` в следующем формате:

```
Authorization: Bearer <IAM-TOKEN>  x-folder-id <folder-id>
```