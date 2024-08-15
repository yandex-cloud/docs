---
editable: false
sourcePath: ru/_api-ref/ai/translate/api-ref/Translation/listLanguages.md
---

# Метод listLanguages
Получает список поддерживаемых языков.

При работе с API Translate отправляйте данные для [аутентификации](/docs/translate/api-ref/authentication) в заголовке `Authorization` каждого запроса.
 
## HTTP-запрос {#https-request}
```
POST https://translate.api.cloud.yandex.net/translate/v2/languages
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "folderId": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Идентификатор каталога, к которому у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> ). Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта.</p> <p>Максимальная длина строки в символах — 50.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "languages": [
    {
      "code": "string",
      "name": "string"
    }
  ]
}
```

 
Поле | Описание
--- | ---
languages[] | **object**<br><p>Список поддерживаемых языков.</p> 
languages[].<br>code | **string**<br><p>Код <a href="/docs/translate/concepts/supported-languages">языка</a> (например, ``en``).</p> 
languages[].<br>name | **string**<br><p>Название языка (например, ``English``).</p> 