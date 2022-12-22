---
editable: false
---

# Translate API v2, gRPC: TranslationService

A set of methods for the Translate service.

| Call | Description |
| --- | --- |
| [Translate](#Translate) | Translates the text to the specified language. |
| [DetectLanguage](#DetectLanguage) | Detects the language of the text. |
| [ListLanguages](#ListLanguages) | Retrieves the list of supported languages. |

## Calls TranslationService {#calls}

## Translate {#Translate}

Translates the text to the specified language.

**rpc Translate ([TranslateRequest](#TranslateRequest)) returns ([TranslateResponse](#TranslateResponse))**

### TranslateRequest {#TranslateRequest}

Field | Description
--- | ---
source_language_code | **string**<br>The text language to translate from. Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``). <br>Required for translating with glossary. The maximum string length in characters is 3.
target_language_code | **string**<br>Required. The target language to translate the text. Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` en ``). The maximum string length in characters is 3.
format | enum **Format**<br>Format of the text. <ul><li>`PLAIN_TEXT`: Text without markup. Default value.</li><li>`HTML`: Text in the HTML format.</li></ul>
texts[] | **string**<br>Array of the strings to translate. The maximum total length of all strings is 10000 characters. The number of elements must be greater than 0.
folder_id | **string**<br>ID of the folder to which you have access. Required for authorization with a user account (see `yandex.cloud.iam.v1.UserAccount` resource). Don't specify this field if you make the request on behalf of a service account. The maximum string length in characters is 50.
model | **string**<br>Do not specify this field, custom models are not supported yet. The maximum string length in characters is 50.
glossary_config | **[TranslateGlossaryConfig](#TranslateGlossaryConfig)**<br>Glossary to be applied for the translation. For more information, see [Glossaries](/docs/translate/concepts/glossary). 
speller | **bool**<br>use speller 


### TranslateGlossaryConfig {#TranslateGlossaryConfig}

Field | Description
--- | ---
glossary_source | **oneof:** `glossary_data`<br>
&nbsp;&nbsp;glossary_data | **[GlossaryData](#GlossaryData)**<br>Pass glossary data in the request. Currently, only this way to pass glossary is supported. 


### GlossaryData {#GlossaryData}

Field | Description
--- | ---
glossary_pairs[] | **[GlossaryPair](#GlossaryPair)**<br>Array of text pairs. <br>The maximum total length of all source texts is 10000 characters. The maximum total length of all translated texts is 10000 characters. The number of elements must be in the range 1-50.


### GlossaryPair {#GlossaryPair}

Field | Description
--- | ---
source_text | **string**<br>Required. Text in the source language. 
translated_text | **string**<br>Required. Text in the target language. 
exact | **bool**<br> 


### TranslateResponse {#TranslateResponse}

Field | Description
--- | ---
translations[] | **[TranslatedText](#TranslatedText)**<br>Array of the translations. 


### TranslatedText {#TranslatedText}

Field | Description
--- | ---
text | **string**<br>Translated text. 
detected_language_code | **string**<br>The language code of the source text. Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` en ``). 


## DetectLanguage {#DetectLanguage}

Detects the language of the text.

**rpc DetectLanguage ([DetectLanguageRequest](#DetectLanguageRequest)) returns ([DetectLanguageResponse](#DetectLanguageResponse))**

### DetectLanguageRequest {#DetectLanguageRequest}

Field | Description
--- | ---
text | **string**<br>Required. The text to detect the language for. The maximum string length in characters is 1000.
language_code_hints[] | **string**<br>List of the most likely languages. These languages will be given preference when detecting the text language. Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``). <br>To get the list of supported languages, use a [TranslationService.ListLanguages](#ListLanguages) request. The maximum number of elements is 10. The maximum string length in characters for each value is 3.
folder_id | **string**<br>ID of the folder to which you have access. Required for authorization with a user account (see `yandex.cloud.iam.v1.UserAccount` resource). Don't specify this field if you make the request on behalf of a service account. The maximum string length in characters is 50.


### DetectLanguageResponse {#DetectLanguageResponse}

Field | Description
--- | ---
language_code | **string**<br>The text language in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``). <br>To get the language name, use a [TranslationService.ListLanguages](#ListLanguages) request. 


## ListLanguages {#ListLanguages}

Retrieves the list of supported languages.

**rpc ListLanguages ([ListLanguagesRequest](#ListLanguagesRequest)) returns ([ListLanguagesResponse](#ListLanguagesResponse))**

### ListLanguagesRequest {#ListLanguagesRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder to which you have access. Required for authorization with a user account (see `yandex.cloud.iam.v1.UserAccount` resource). Don't specify this field if you make the request on behalf of a service account. The maximum string length in characters is 50.


### ListLanguagesResponse {#ListLanguagesResponse}

Field | Description
--- | ---
languages[] | **[Language](#Language)**<br>List of supported languages. 


### Language {#Language}

Field | Description
--- | ---
code | **string**<br>The language code. Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` en ``). 
name | **string**<br>The name of the language (for example, `` English ``). 


