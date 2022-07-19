# Detect the language

To detect the language of a text, use the [detectLanguage](../api-ref/Translation/detectLanguage) method.

## Before you start {#before-you-begin}

{% include [ai-before-beginning](../../_includes/ai-before-beginning.md) %}

## Detect the language of a phrase {#simple-example}

In this example, we will detect the language that the phrase <q>Hello, world</q> is written in.

To detect the language of the text, pass it in the [detectLanguage](../api-ref/Translation/detectLanguage) request body:

```bash
export FOLDER_ID=b1gvmob95yysaplct532
export IAM_TOKEN=CggaATEVAgA...
export TEXT="Hello, world"
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d "{\"folderId\": \"${FOLDER_ID}\", \"text\": \"${TEXT}\"}" \
    "https://translate.api.cloud.yandex.net/translate/v2/detect"
```

The service responds with the language code of the source text. The language code is specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format:

```json
{
    "languageCode": "en"
}
```

## Specify the most likely languages {#specify-language}

Some words are spelled the same in different languages. For example, the English word <q>hand</q> is also written as <q>hand</q> in German, Swedish, and Dutch. If the text you transmit contains words like this, {{ translate-short-name }} may detect the wrong source language.

To avoid mistakes, you can use the `languageCodeHints` field to specify which languages should be given priority when determining the language of the text:

```json
{
    "folderId": "b1gvmob95yysaplct532",
    "languageCodeHints":["ru", "de"],
    "text": "hand"
}
```

Save the request body in a file (for example, `body.json`) and pass it using the [detectLanguage](../api-ref/Translation/detectLanguage) method:

```bash
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d '@body.json' \
    "https://translate.api.cloud.yandex.net/translate/v2/detect"

{
    "languageCode": "de"
}
```

