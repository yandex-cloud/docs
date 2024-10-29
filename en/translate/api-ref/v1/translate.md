---
title: How to translate text
description: Translates the source text into the specified language.
---

# How to translate text

{% include [speechkit-v1-disclaimer.md](../../../_includes/speechkit-v1-disclaimer.md) %}

Translates the source text into the specified language.

When using the Translate API, provide your [authentication](/docs/translate/api-ref/authentication) credentials in the `Authorization` header of each request.

## Request {#request}

```http
POST https://translate.{{ api-host }}/translate/v1/translate
```

### Parameters in the request body {#parameters-in-the-request-body}

All parameters must be URL-encoded. The maximum size of the POST request body is 30 KB.


Parameter | Description
----- | -----
`text` | Required parameter.<br/>UTF-8 encoded text to be translated.<br/>You can use multiple `text` parameters in a request.
`source` | Language of the source text.<br/>Set as a two-letter language code according to [ISO-639-1](https://en.wikipedia.org/wiki/ISO_639-1) (e.g., `en`). If this parameter is omitted, the service tries to detect the source language automatically.
`target` | Required parameter.<br/>Translation direction.<br/>Set as a two-letter language code according to [ISO-639-1](https://en.wikipedia.org/wiki/ISO_639-1) (e.g., `en`).
`format` | Text format.<br/>Possible values:<br/><ul><li>`plain`: Text without markup (default value)</li><li>`html`: Text in HTML format.</li></ul>
`folderId` | Required parameter.<br/>Your folder ID.<br/>



## Response {#response}

The response is returned in JSON format.

```json
{
    "translations": [
        {"text": <translated_text>},
        ...
    ]
}
```


## Examples {#examples}

### Sample request {#sample-request}

```httpget
export FOLDER_ID=<folder_ID>
export TOKEN=<IAM_token>
curl -X POST \
     -H "Authorization: Bearer ${TOKEN}" \
     -d "folderId=${FOLDER_ID}&target=en" \
     --data-urlencode "text=Hello world" \
     --data-urlencode "text=Good morning" \
     "https://translate.{{ api-host }}/translate/v1/translate"
```

### Response example {#response-example}

The response is returned in JSON format.

```json
{
    "translations": [
        {
            "text": "Hello world"
        },
        {
            "text": "good morning"
        }
    ]
}
```

