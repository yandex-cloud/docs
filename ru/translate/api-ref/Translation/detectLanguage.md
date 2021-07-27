---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Метод detectLanguage
Определяет язык текста.
 

 
## HTTP-запрос {#https-request}
```
POST https://translate.api.cloud.yandex.net/translate/v2/detect
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "text": "string",
  "languageCodeHints": [
    "string"
  ],
  "folderId": "string"
}
```

 
Поле | Описание
--- | ---
text | **string**<br><p>Обязательное поле. Текст, язык которого требуется определить.</p> <p>Максимальная длина строки в символах — 1000.</p> 
languageCodeHints[] | **string**<br><p>Список наиболее вероятных языков. Этим языкам будет отдаваться предпочтение при определении языка текста. Указывается в формате <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> (например, ``ru``).</p> <p>Чтобы получить список поддерживаемых языков, используйте запрос <a href="/docs/translate/api-ref/Translation/listLanguages">listLanguages</a>.</p> <p>Максимальное количество элементов — 10. Максимальная длина строки в символах для каждого значения — 3.</p> 
folderId | **string**<br><p>Идентификатор каталога, к которому у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> ). Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта.</p> <p>Максимальная длина строки в символах — 50.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "languageCode": "string"
}
```

 
Поле | Описание
--- | ---
languageCode | **string**<br><p>Язык текста в формате <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> (например, ``ru``).</p> <p>Чтобы получить название языка, используйте запрос <a href="/docs/translate/api-ref/Translation/listLanguages">listLanguages</a>.</p> 