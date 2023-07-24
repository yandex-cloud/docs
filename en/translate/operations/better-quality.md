# How to improve the accuracy of translations

To increase the accuracy of translations:

* [Specify the source language](#with-source-language). Some words are written the same in different languages, but have different meanings. If the model detects the wrong source language, these words are translated differently.
* [Specify your translation glossary](#with-glossary). A word can be translated different ways. For example, the English word <q>oil</q> can be translated to Russian as <q>масло</q> or <q>нефть</q>. You can use a glossary to indicate the proper translation of a word or phrase. [Learn more about glossaries](../concepts/glossary.md).

## Getting started {#before-you-begin}

{% include [curl](../../_includes/curl.md) %}

{% include [ai-before-beginning](../../_includes/translate/ai-before-beginning.md) %}

{% include [bash-windows-note](../../_includes/translate/bash-windows-note.md) %}

## Specify the source language {#with-source-language}

Words are sometimes written the same in different languages, but are translated differently. For example, the word <q>angel</q> in English means a spiritual being, while in German it means a fishing rod. If the text you provide contains such words, {{ translate-short-name }} may detect the wrong source language.

To avoid mistakes, specify the source language in the `sourceLanguageCode` field:

{% list tabs %}

- Bash

    ```json
    {
        "folderId": "<folder_ID>",
        "texts": ["angel"],
        "targetLanguageCode": "ru",
        "sourceLanguageCode": "de"
    }
    ```

    Where:

    * `folderId`: Folder ID received [before starting](#before-begin).
    * `texts`: Text to translate as a list of strings.
    * `targetLanguageCode`: Target language in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format. You can get the language code with a [list of supported languages](../../translate/operations/list.md).
    * `sourceLanguageCode`: Source language.

    Save the request body in a file (for example, `body.json`) and pass the file using the [translate](../api-ref/Translation/translate)method:

    {% include [translate-file](../../_includes/translate/translate-file.md) %}

    Where `IAM_TOKEN`: IAM token received [before starting](#before-begin).

    This returns a translation from the correct language:

    ```json
    {
        "translations": [
           {
               "text": "fishing rod"
           }
        ]
    }
    ```

{% endlist %}

## Specify your translation glossary {#with-glossary}

A word can be translated different ways. For example, the English word <q>oil</q> can be translated as <q>масло</q> or <q>нефть</q>. To improve the accuracy of translations, use a [glossary](../concepts/glossary.md) of your terms and phrases with a single translation.

Specify the glossary in the `glossaryConfig` field. Currently, you can only pass a glossary as an array of text pairs.

In the `sourceLanguageCode` field, specify the source language. This field is required when you use glossaries:

{% list tabs %}

- Bash

    ```json
    {
       "sourceLanguageCode": "tr",
       "targetLanguageCode": "ru",
       "texts": [
           "cırtlı çocuk spor ayakkabı"
       ],
       "folderId": "<folder_ID>",
       "glossaryConfig": {
           "glossaryData": {
               "glossaryPairs": [
                   {
                       "sourceText": "spor ayakkabı",
                       "translatedText": "sneakers"
                   }
               ]
           }
       }
    }
    ```

    Where:

    * `sourceLanguageCode`: Source language in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format. You can get the language code with a [list of supported languages](../../translate/operations/list.md).
    * `targetLanguageCode`: Target language.
    * `texts`: Text to translate as a list of strings.
    * `folderId`: Folder ID received [before starting](#before-begin).

    Save the request body in a file (for example, `body.json`) and pass the file using the [translate](../api-ref/Translation/translate)method:

    {% include [translate-file](../../_includes/translate/translate-file.md) %}

    Where `IAM_TOKEN`: IAM token received [before starting](#before-begin).

    The response will contain a translation based on terms in your glossary:

    ```json
    {
        "translations": [
            {
                "text": "Children's sneakers with velcro"
            }
        ]
    }
    ```

    Without the glossary, the translation would be:

    ```json
    {
        "translations": [
            {
                "text": "Children's sport shoes with velcro"
            }
        ]
    }
    ```

{% endlist %}

## Checking words for typos {#with-speller}

Misspelled words may be translated incorrectly or transliterated. For example, the word <q>hellas</q> is translated as <q>эллада</q>. If the same word is misspelled, let's say as <q>helas</q>, it will be translated as <q>хелас</q>. To check spelling, use the `speller` parameter:

{% list tabs %}

- Bash

    ```json
    {
      "sourceLanguageCode": "en"
      "targetLanguageCode": "ru",
      "texts": [
        "helas"
        ],
      "folderId": "<folder_ID>",
      "speller": true
    }
    ```

    Where:

    * `sourceLanguageCode`: Source language in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format. You can get the language code along with a [list of supported languages](../../translate/operations/list.md).
    * `targetLanguageCode`: Target language.
    * `texts`: Text to translate as a list of strings.
    * `folderId`: Folder ID received [before starting](#before-begin).
    * `speller`: Parameter that enables a spelling check.

    Save the request body to a file (for example, `body.json`) and submit the file using the [translate](../api-ref/Translation/translate) method:

    {% include [translate-file](../../_includes/translate/translate-file.md) %}

    Where `IAM_TOKEN` is the IAM token received [before starting](#before-begin).

    The response will contain a translation of the word checked for spelling:

    ```json
    {
        "translations": [
            {
                "text": "эллада"
            }
        ]
    }
    ```

    If no spelling check is enabled (`"speller": false`), the word will be translated as follows:

    ```json
    {
        "translations": [
            {
                "text": "хелас"
            }
        ]
    }
    ```

{% endlist %}