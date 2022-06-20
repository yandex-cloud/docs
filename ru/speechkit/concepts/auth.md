---
title: Аутентификация в API {{ speechkit-full-name }}
description: "Для выполнения операций через API {{ speechkit-full-name }} необходимо аутентифицироваться со своего сервисного, федеративного или Яндекс аккаунта. Полученный IAM-токен указывайте при обращении к ресурсам Yandex Cloud через API в формате — Authorization: Bearer <IAM-TOKEN>"
---

{% include [authentication-ml-services](../../_includes/authentication-ml-services.md) %}

Если вы используете API v3, в каждом запросе также передавайте в заголовке `x-folder-id` с [идентификатором каталога](../../resource-manager/operations/folder/get-id.md).

```
Authorization: Bearer <IAM-токен> 
x-folder-id <идентификатор каталога>
```

#### См. также {#see-also}

* [Какие роли необходимы для выполнения операций](../security/index.md).