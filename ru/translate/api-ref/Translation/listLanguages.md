---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Метод listLanguages
Получает список поддерживаемых языков.
 

 
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
languages[].<br>code | **string**<br><p>Код языка. Указывается в формате <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> (например, ``en``).</p> 
languages[].<br>name | **string**<br><p>Название языка (например, ``English``).</p> 