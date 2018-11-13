# Language detection

Detects the language of the source text. The response is returned as the language code.

## Request {#request}

```
POST https://translate.api.cloud.yandex.net/translate/v1/detect
```

### Parameters in the request body

All parameters must be URL-encoded. The maximum size of the POST request body is 30 KB.

| Parameter | Description |
| ----- | ----- |
| `text` | Required parameter.<br/>UTF-8 encoded text to detect the language of. |
| `hint` | List of most probable languages (they will be given priority when detecting the language). The list items are comma-separated. |
| `folderId` | Required parameter.<br/>ID of your folder.<br/>For more information about how to find out the folder ID, see the section [Authorization in the API](../concepts/auth.md). |

## Response {#response}

The response is returned in JSON format.

```json
{
    "language": <text language>
}
```

## Examples {#examples}

### Sample request

```no-highlight
curl -X POST \
     -H "Authorization: Bearer <IAM-token>" \
     -d "text=hello%20world&hint=en,ru&folderId=<folder id>" \
     "https://translate.api.cloud.yandex.net/translate/v1/detect"
```

### Sample response

The response is returned in JSON format.

```json
{
    "language": "en"
}
```

