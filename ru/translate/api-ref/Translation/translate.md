---
editable: false
sourcePath: ru/_api-ref/ai/translate/api-ref/Translation/translate.md
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
  "folderId": "string",
  "model": "string",
  "glossaryConfig": {
    "glossaryData": {
      "glossaryPairs": [
        {
          "sourceText": "string",
          "translatedText": "string"
        }
      ]
    }
  },
  "speller": true
}
```

 
Поле | Описание
--- | ---
sourceLanguageCode | **string**<br><p><a href="/docs/translate/concepts/supported-languages">Язык</a>, на котором написан исходный текст (например, ``ru``).</p> <p>Обязательно при переводе с глоссарием.</p> <p>Максимальная длина строки в символах — 3.</p> 
targetLanguageCode | **string**<br><p>Обязательное поле. <a href="/docs/translate/concepts/supported-languages">Язык</a>, на который переводится текст (например, ``en``).</p> <p>Максимальная длина строки в символах — 3.</p> 
format | **string**<br><p>Формат текста.</p> <ul> <li>PLAIN_TEXT: Текст без разметки. Значение по умолчанию.</li> <li>HTML: Текст в формате HTML.</li> </ul> 
texts[] | **string**<br><p>Обязательное поле. Массив строк для перевода. Максимальная общая длина всех строк составляет 10000 символов.</p> <p>Должен содержать хотя бы один элемент.</p> 
folderId | **string**<br><p>Идентификатор каталога, к которому у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> ). Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта.</p> <p>Максимальная длина строки в символах — 50.</p> 
model | **string**<br><p>Не используйте это поле, пользовательские модели пока не поддерживаются.</p> <p>Максимальная длина строки в символах — 50.</p> 
glossaryConfig | **object**<br><p>Глоссарий для применения при переводе. Дополнительные сведения см. в разделе <a href="/docs/translate/concepts/glossary">Глоссарии</a>.</p> 
glossaryConfig.<br>glossaryData | **object**<br>Передать содержимое глоссария в запросе. В настоящее время поддерживается только этот способ передачи глоссария.<br>
glossaryConfig.<br>glossaryData.<br>glossaryPairs[] | **object**<br><p>Обязательное поле. Массив текстовых пар.</p> <p>Максимальная общая длина всех исходных текстов 10000 символов. Максимальная общая длина всех переведенных текстов 10000 символов.</p> <p>Количество элементов должно находиться в диапазоне от 1 до 50.</p> 
glossaryConfig.<br>glossaryData.<br>glossaryPairs[].<br>sourceText | **string**<br><p>Обязательное поле. Текст на языке оригинала.</p> 
glossaryConfig.<br>glossaryData.<br>glossaryPairs[].<br>translatedText | **string**<br><p>Обязательное поле. Текст на языке перевода.</p> 
speller | **boolean**<br>Параметр, который включает проверку орфографии.

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
translations[].<br>detectedLanguageCode | **string**<br><p>Код <a href="/docs/translate/concepts/supported-languages">языка</a> исходного текста (например, ``en``).</p> 