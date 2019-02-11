# Text translation

[!INCLUDE [speechkit-v1-disclaimer.md](../../../_includes/speechkit-v1-disclaimer.md)]

Translates the source text into the specified language.

## Request {#request}

```
POST https://translate.api.cloud.yandex.net/translate/v1/translate
```

### Parameters in the request body

All parameters must be URL-encoded. The maximum size of the POST request body is 30 KB.

| Parameter | Description |
| ----- | ----- |
| `text` | Required parameter.<br/>UTF-8 encoded text to translate.<br/>You can use multiple `text` parameters in a request. |
| `source` | Language of the source text.<br/>Set as a two-letter language code according to [ISO-639-1](https://en.wikipedia.org/wiki/ISO_639-1) (for example, `ru`). If this parameter is omitted, the service tries to detect the source language automatically. |
| `target` | Required parameter.<br/>Translation direction.<br/>Set as a two-letter language code according to [ISO-639-1](https://en.wikipedia.org/wiki/ISO_639-1) (for example `en`). |
| `format` | Text format.<br/>Possible values:<br/><ul><li>`plain` — Text without markup (default value).</li><li>`html` — Text in HTML format.</li></ul> |
| `folderId` | Required parameter.<br/>ID of your folder.<br/>For more information about how to find out the folder ID, see the section [Authorization in the API](../../concepts/auth.md). |

## Response {#response}

The response is returned in JSON format.

```json
{
    "translations": [
        {"text": <text translation>},
        ...
    ]
}
```

## Examples {#examples}

### Sample request

```httpget
export FOLDER_ID=<folder id>
export TOKEN=<IAM-token>
curl -X POST \
     -H "Authorization: Bearer ${TOKEN}" \
     -d "folderId=${FOLDER_ID}&target=en" \
     --data-urlencode "text=привет мир" \
     --data-urlencode "text=доброе утро" \
     "https://translate.api.cloud.yandex.net/translate/v1/translate"
```

### Response example

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

