Полученный IAM-токен указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передайте IAM-токен и ID каталога в заголовках `Authorization` и `x-folder-id` в следующем формате:

```
Authorization: Bearer <IAM-TOKEN> 
x-folder-id <folder-id>
```