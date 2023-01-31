# How to improve the accuracy of translations

To increase the accuracy of translations:

* [Specify the source language](#with-source-language). Some words are written the same in different languages, but have different meanings. If the model detects the wrong source language, these words are translated differently.
* [Specify your translation glossary](#with-glossary). A word can be translated different ways. For example, the English word <q>oil</q> can be translated to Russian as <q>масло</q> or <q>нефть</q>. You can use a glossary to indicate the proper translation of a word or phrase. [Learn more about glossaries](../concepts/glossary.md).

## Before you begin {#before-you-begin}

{% include [curl](../../_includes/curl.md) %}

{% include [ai-before-beginning](../../_includes/translate/ai-before-beginning.md) %}

## Specify the source language {#with-source-language}

Words are sometimes written the same in different languages, but are translated differently. For example, the word <q>angel</q> in English means a spiritual being, while in German it means a fishing rod. If the text you pass contains such words, {{ translate-short-name }} may detect the wrong source language.

To avoid mistakes, specify the source language in the `sourceLanguageCode` field:

```json
{
    "folderId": "b1gvmob95yysaplct532",
    "texts": ["angel"],
    "targetLanguageCode": "ru",
    "sourceLanguageCode": "de"
}
```

Save the request body in a file (for example, `body.json`) and pass the file using the [translate](../api-ref/Translation/translate) method:

{% include [translate-file](../../_includes/translate/translate-file.md) %}

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

## Specify your translation glossary {#with-glossary}

A word can be translated different ways. For example, the English word <q>oil</q> can be translated as <q>масло</q> or <q>нефть</q>. To improve the accuracy of translations, use a [glossary](../concepts/glossary.md) of your terms and phrases with a single translation.

Specify the glossary in the `glossaryConfig` field. Currently, you can only pass a glossary as an array of text pairs.

In the `sourceLanguageCode` field, specify the source language. This field is required when you use glossaries:

```json
{
    "sourceLanguageCode": "tr",
    "targetLanguageCode": "en",
    "texts": [
        "cırtlı çocuk spor ayakkabı"
    ],
    "folderId": "b1gvmob95yysaplct532",
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

Save the request body in a file (for example, `body.json`) and pass the file using the [translate](../api-ref/Translation/translate) method:

{% include [translate-file](../../_includes/translate/translate-file.md) %}

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
