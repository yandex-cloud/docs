---
editable: false
---

# Метод translate
Переводит текст на указанный язык.
 

 
## HTTP-запрос {#https-request}
```
POST https://translate.api.cloud.yandex.net/translate/v2/translate
```
 
## Параметры в теле запроса {#body_params}
 
```json 
 {
  "sourceLanguageCode": "string",
  "targetLanguageCode": "string",
  "format": "string",
  "texts": [
    "string"
  ],
  "folderId": "string"
}
```

 
Поле | Описание
--- | ---
sourceLanguageCode | **string**<br><p>Язык, на котором написан исходный текст. Указывается в формате <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> (например, <code>ru</code>).</p> <p>Максимальная длина строки в символах — 3.</p> 
targetLanguageCode | **string**<br><p>Обязательное поле. Целевой язык, на который переводится текст. Указывается в формате <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> (например, <code>en</code>).</p> <p>Максимальная длина строки в символах — 3.</p> 
format | **string**<br><p>Формат текста.</p> <ul> <li>PLAIN_TEXT: Текст без разметки. Значение по умолчанию.</li> <li>HTML: Текст в формате HTML.</li> </ul> 
texts[] | **string**<br><p>Обязательное поле. Массив строк для перевода. Максимальная общая длина всех строк составляет 10000 символов.</p> <p>Должен содержать хотя бы один элемент.</p> 
folderId | **string**<br><p>Идентификатор папки, к которой у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> ). Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта.</p> <p>Максимальная длина строки в символах — 50.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
 {
  "translations": [
    {
      "text": "string",
      "detectedLanguageCode": "string"
    }
  ]
}
```

 
Поле | Описание
--- | ---
translations[] | **object**<br><p>Массив переводов.</p> 
translations[].<br>text | **string**<br><p>Переведенный текст.</p> 
translations[].<br>detectedLanguageCode | **string**<br><p>Код языка исходного текста. Указывается в формате <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> (например, <code>ru</code>).</p> 