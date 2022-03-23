Полученный IAM-токен указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передайте в запросе следующие параметры: 
* в заголовке `Authorization` укажите [IAM-токен](../iam/concepts/authorization/iam-token.md);
* в заголовке `x-folder-id` укажите [идентификатор каталога](../resource-manager/operations/folder/get-id.md).

```
Authorization: Bearer <IAM-токен> 
x-folder-id <идентификатор каталога>
```