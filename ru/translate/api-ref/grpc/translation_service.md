---
editable: false
sourcePath: ru/_api-ref-grpc/translate/api-ref/grpc/translation_service.md
---

# TranslationService

Набор методов для сервиса Yandex Translate.

| Вызов | Описание |
| --- | --- |
| [Translate](#Translate) | Переводит текст на указанный язык. |
| [DetectLanguage](#DetectLanguage) | Определяет язык текста. |
| [ListLanguages](#ListLanguages) | Получает список поддерживаемых языков. |

## Вызовы TranslationService {#calls}

## Translate {#Translate}

Переводит текст на указанный язык.

**rpc Translate ([TranslateRequest](#TranslateRequest)) returns ([TranslateResponse](#TranslateResponse))**

### TranslateRequest {#TranslateRequest}

Поле | Описание
--- | ---
source_language_code | **string**<br>Язык, на котором написан исходный текст. Указывается в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) (например, `` ru ``). <br>Обязательно при переводе с глоссарием. Максимальная длина строки в символах — 3.
target_language_code | **string**<br>Обязательное поле. Язык, на который переводится текст. Указывается в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) (например, `` en ``). Максимальная длина строки в символах — 3.
format | enum **Format**<br>Формат текста. <ul><li>`PLAIN_TEXT`: Текст без разметки. Значение по умолчанию.</li><li>`HTML`: Текст в формате HTML.</li></ul>
texts[] | **string**<br>Массив строк для перевода. Максимальная общая длина всех строк составляет 10000 символов. Количество элементов должно быть больше 0.
folder_id | **string**<br>Идентификатор каталога, к которому у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс `yandex.cloud.iam.v1.UserAccount`) . Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта. Максимальная длина строки в символах — 50.
model | **string**<br>Не используйте это поле, пользовательские модели пока не поддерживаются. Максимальная длина строки в символах — 50.
glossary_config | **[TranslateGlossaryConfig](#TranslateGlossaryConfig)**<br>Глоссарий для применения при переводе. Дополнительные сведения см. в разделе [Глоссарии](/docs/translate/concepts/glossary).
speller | **boolean**<br>Параметр, который включает проверку орфографии.

### TranslateGlossaryConfig {#TranslateGlossaryConfig}

Поле | Описание
--- | ---
glossary_source | **oneof:** `glossary_data`<br>
&nbsp;&nbsp;glossary_data | **[GlossaryData](#GlossaryData)**<br>Передать содержимое глоссария в запросе. В настоящее время поддерживается только этот способ передачи глоссария. 


### GlossaryData {#GlossaryData}

Поле | Описание
--- | ---
glossary_pairs[] | **[GlossaryPair](#GlossaryPair)**<br>Массив текстовых пар. <br>Максимальная общая длина всех исходных текстов 10000 символов. Максимальная общая длина всех переведенных текстов 10000 символов. Количество элементов должно находиться в диапазоне от 1 до 50.


### GlossaryPair {#GlossaryPair}

Поле | Описание
--- | ---
source_text | **string**<br>Обязательное поле. Текст на языке оригинала. 
translated_text | **string**<br>Обязательное поле. Текст на языке перевода. 


### TranslateResponse {#TranslateResponse}

Поле | Описание
--- | ---
translations[] | **[TranslatedText](#TranslatedText)**<br>Массив переводов. 


### TranslatedText {#TranslatedText}

Поле | Описание
--- | ---
text | **string**<br>Переведенный текст. 
detected_language_code | **string**<br>Код языка исходного текста. Указывается в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) (например, `` en ``). 


## DetectLanguage {#DetectLanguage}

Определяет язык текста.

**rpc DetectLanguage ([DetectLanguageRequest](#DetectLanguageRequest)) returns ([DetectLanguageResponse](#DetectLanguageResponse))**

### DetectLanguageRequest {#DetectLanguageRequest}

Поле | Описание
--- | ---
text | **string**<br>Обязательное поле. Текст, язык которого требуется определить. Максимальная длина строки в символах — 1000.
language_code_hints[] | **string**<br>Список наиболее вероятных языков. Этим языкам будет отдаваться предпочтение при определении языка текста. Указывается в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) (например, `` ru ``). <br>Чтобы получить список поддерживаемых языков, используйте запрос [TranslationService.ListLanguages](#ListLanguages). Максимальное количество элементов — 10. Максимальная длина строки в символах для каждого значения — 3.
folder_id | **string**<br>Идентификатор каталога, к которому у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс `yandex.cloud.iam.v1.UserAccount`) . Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта. Максимальная длина строки в символах — 50.


### DetectLanguageResponse {#DetectLanguageResponse}

Поле | Описание
--- | ---
language_code | **string**<br>Язык текста в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) (например, `` ru ``). <br>Чтобы получить название языка, используйте запрос [TranslationService.ListLanguages](#ListLanguages). 


## ListLanguages {#ListLanguages}

Получает список поддерживаемых языков.

**rpc ListLanguages ([ListLanguagesRequest](#ListLanguagesRequest)) returns ([ListLanguagesResponse](#ListLanguagesResponse))**

### ListLanguagesRequest {#ListLanguagesRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Идентификатор каталога, к которому у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс `yandex.cloud.iam.v1.UserAccount`) . Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта. Максимальная длина строки в символах — 50.


### ListLanguagesResponse {#ListLanguagesResponse}

Поле | Описание
--- | ---
languages[] | **[Language](#Language)**<br>Список поддерживаемых языков. 


### Language {#Language}

Поле | Описание
--- | ---
code | **string**<br>Код языка. Указывается в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) (например, `` en ``). 
name | **string**<br>Название языка (например, `` English ``). 


